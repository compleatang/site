---

layout:    post
title:     Migrating underWater desert Blogging to Jekyll
published: true
comments:  true
meta:      true
category:  ruby
tags:      [ruby, jekyll, blogging]
excerpt:   "Thoughts and tips on how I migrated from Wordpress to Jekyll."

---

Wordpress is a great system. A really great system, actually. Especially for non-technical users. It also requires a huge amount of overhead for what most people use it for. Also, it is not nearly as fast and reliable as I would like it to be. So I decided that my blog needed to move from Wordpress to Jekyll. I had been using the same blog theme for about four years now so I also wanted to refactor that. Here's what I did to migrate it.

### Step 1: Install Ben Balter's Migrate to Jekyll Plugin

First, I downloaded Ben's migrate [plugin](https://github.com/benbalter/wordpress-to-jekyll-exporter) for Wordpress. Then I unzipped that into my plugins directory in my Wordpress install (which I deploy from my workstation using git), enable the plugin and click Tools -> Export to Jekyll. Then the server will chew on it for a while and spit out a decent zip. The zip file has the templates (which I didn't use as I was rebuilding them from scratch and didn't care what the old ones looked like), the posts, and the pages you have on your blog. 

There were a few annoyances with the output, though. These annoyances are not any problem with the Exporter which worked as I expected it would. They were mainly annoyances with a lot of rust that is within the code/database of my blog. That rust was one of the main reasons that I wanted to switch to Jekyll. Since Jekyll is simply plain text files it is much simpler to iterate over the files and make the changes. 

### Step 2: Build the Jekyll Deploy How I Wanted it to Look

Next, I worked on the layouts, includes, html files, config, rakefile and put everything how I wanted it to be. This was simple web design and there are lots of tutorials which were quite helpful in this endeavour. Once the Jekyll deployment looked and acted how I wanted it to, it was time to chew on the files.

### Step 3: Build a Ruby Script to Reformulate the Posts How I Wanted

The first problem that I had with the export was that the yaml frontmatter was loaded with a lot of crap that I neither needed nor wanted for the Jekyll. So I thought I would build a small ruby script that would clean the YAML Frontmatter. Here's the part of the script that does that. 

{% highlight ruby %}
  def clean_the_yaml( yaml_block, first_para )
    new_yaml = {}
    new_yaml["layout"] = "post"
    if yaml_block["title"] != "" && yaml_block["title"]
      yaml_block["title"].gsub!("\"", "\'")
      if yaml_block["title"] =~ /\A"/
        new_yaml["title"] = yaml_block["title"]
      else
        new_yaml["title"] = "\"" + yaml_block["title"] + "\""
      end
    else
      new_yaml["title"] = ""
    end
    new_yaml["published"] = "true"
    new_yaml["comments"] = "true"
    new_yaml["meta"] = "true"
    if yaml_block["categories"]
      new_yaml["category"] = yaml_block["categories"].first.downcase 
    else
      new_yaml["category"] = yaml_block["category"] || "unclassified"
    end
    new_yaml["tags"] = yaml_block["tags"] if yaml_block["tags"]
    if yaml_block["excerpt"]
      new_yaml["excerpt"] = yaml_block["excerpt"].gsub("\n", "")
      new_yaml["excerpt"] = new_yaml["excerpt"][2..-1].strip if new_yaml["excerpt"][0] == ">"
    else
      new_yaml["excerpt"] = first_para.gsub("\"", "'")
    end
    if new_yaml["excerpt"][0] == "\""
      new_yaml["excerpt"][1..-2].gsub!("\"", "'")
    else
      new_yaml["excerpt"].gsub!("\"", "'")
    end
    new_yaml["excerpt"] = "\"" +  new_yaml["excerpt"].strip unless new_yaml["excerpt"][0] == "\""
    new_yaml["excerpt"] = new_yaml["excerpt"] + "\"" if new_yaml["excerpt"][-1] != "\"" || new_yaml["excerpt"].length == 1
    final_yaml = "---\n\n"
    new_yaml.each{ | head, val | final_yaml << head + ": " + val.to_s + "\n" }
    final_yaml << "\n---\n\n"
  end
{% endhighlight %}

That prt of the script mainly strips out the old rust from the YAML front matter and ensures that all my punctuation will not get in the way of Jekyll doing its job. For instance, I had lots of colons in my titles and these are a problem with YAML if you do not escape them or put the string in double quotes. Also I wanted all the posts to have some sort of a excerpt so if I did not have an excerpt in the Wordpress, I built the script to import the first paragraph and then escaped it and guarded against problems with punctuation in the paragraphh.

The second thing I had to overcome was the way the exporter handled images embedded in the text was not really how I wanted it. I am not sure if the exporter was made to export images or not, but I think because I run a multisite deployment -- and because Wordpress handles multisite files much differently than single site files -- that the images were a problem. 

When I looked on my machine in the Blogs.dir for the Blog I was exporting I saw another problem which was that Wordpress saves a lot of different versions of the same file. This was going to be a problem when I tried to import the photos into the Jekyll asset pipeline I built. 

I was used to the ruby `system` command but there was a problem when I tried to drop the return of the system command into a variable. And then I came upon my new favorite rubyism: backticks. These were great. They work just like backticks in bash/zsh scripting so they were quite intuitive. They run a system command and throw the result of that into a string variable -- which you can split, strip, do whatever you need. This let me build a `find` command that I could use to get over the multiple files issue.

I also needed to reformulate *how* the images were called within the text. Wordpress puts a caption (which I almost always used) and the exporter used the reference link syntax that I don't particularly prefer in markdown. So I wanted to reform that part of the source posts. Here's the part of the script that did that.

{% highlight ruby %}
def clean_the_content( entry_block )
  pictures_pattern = /\A(\[\!\[(.*?)\])(.*?\z)/
  file_pattern = /\A\s*\[\]:(.*?\/(.*?))\z/
  delete_lines = []
  for para in entry_block do
    if para[pictures_pattern]
      pict_line = $1
      caption = $2
      rest_of_it = $3
      picture_to_copy = false
      next if rest_of_it[/\A\(\{\{/]
      p_index = entry_block.index para
      delete_lines << entry_block[p_index + 1] if entry_block[p_index + 1][/\A#{caption}/]
      if entry_block[(p_index + 5)] =~ file_pattern
        full_pict_ref = $1.strip
        picture_to_copy = $2.split("/").last
        delete_lines << entry_block[p_index + 5]
        picture_to_copy = copy_over_pictures( picture_to_copy )
      end
      if picture_to_copy
        entry_block[p_index] = "#{pict_line}({{ site.url }}{{ site.root }}{{ site.images_dir }}/{{ page.date | date: \"%Y\" }}/#{picture_to_copy})][#{full_pict_ref}]"
      end
    end
  end
  delete_lines.each{ | line | entry_block.delete( line ) }
  return entry_block
end

def copy_over_pictures( picture_name )
  location = `find #{@pictures_pull_dir} -name '#{picture_name}*' -type f | sort -nr`
  if location != ""
    location = location.split("\n").first.strip  
    picture_name = location.split("/").last
    if `ls #{@pictures_push_dir}/#{@publish_year}` == ""; `mkdir #{@pictures_push_dir}/#{@publish_year}`; end
    `cp #{location} #{@pictures_push_dir}/#{@publish_year}/#{picture_name}`
    return picture_name
  else
    `echo "Error importing to #{@publish_year} the file: #{location}/#{picture_name}" >> cleaner-errors.log`  
    return false
  end
end
{% endhighlight %}

That was it. Just a few regexs and a few deletes and a few system commands. 

### Step 4. Put it all Together && See What We Have

After I built the script and tested it on a few of the more recent posts I needed to run it on the entire directory of posts. I kept the posts in a separate directory out of the repo so if anything got screwed up with the script I could just re run it. I ended up having to do that a couple of times as I had to tweak my original version of the script a bit to arrive at what is presented above. 

```
rm -rf _posts && cp ~/Downloads/jekyll-export/_posts . -R && git add _posts && ./cleaner.rb
```

One of the first things I realized was that I needed to add the `_posts` dir to the the repo again as when you run jekyll it will `git ls-files`. So I ran the above command until I was happy with the results and then I finally ran this command.

```
rm -rf _posts && cp ~/Downloads/jekyll-export/_posts . -R && git add _posts && ./cleaner.rb && rake site:publish
```

That was it! The full cleaner script can be found in [this gist](https://gist.github.com/compleatang/5401492). If you want to use it, download it into the root of Jekyll, `chmod +x cleaner.rb` and you will be all set.

### Lessons Learned.

* Testing of scripts is huge. I still don't really know how to do this but I tested it with sample data and was prepared for things to go wrong.
* Backticks. FTW.

~ # ~
