#!/usr/bin/env ruby
require 'yaml'
require 'English'

class Cleaner
  def initialize
    @pictures_pull_dir = "/home/coda/sites/gandi-clients/watershedplatforms.com/htdocs/wp-content/blogs.dir/4"
    @pictures_push_dir = "/home/coda/sites/csk/udb/assets/images"
    @exported_posts = "./_posts"
    @all_the_files = `ls #{@exported_posts}`.split("\n")

    for file in @all_the_files do
      next if file[-3..-1] != ".md"
      puts "Working on File: #{file}"
      yamlized = find_yaml( load_file( file ) )
      split_the_content = yamlized[1].split("\n")
      while split_the_content[0] == "# " || split_the_content[0] == ""; split_the_content.shift; end
      @publish_year = file[0..3]
      first_para = split_the_content[0] =~ /^\[\!\[/ ? split_the_content[3] : split_the_content[0] 
      clean_yaml = clean_the_yaml( yamlized[0], first_para )
      clean_contents = clean_the_content( split_the_content ).join("\n")
      write_it( file, clean_yaml + clean_contents )
    end
  end

  def load_file( file )
    source_file = File::read(@exported_posts + "/" + file)
  end

  def find_yaml( file )
    yaml_pattern = /\A(---\s*\n.*?\n?)^(---\s*$\n?)/m
    if file =~ yaml_pattern
      yaml_block = YAML.load($1)
      entry_block = $POSTMATCH
    else
      yaml_block = {}
      entry_block = file
    end
    return [yaml_block, entry_block]
  end 

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
          entry_block[p_index] = "#{pict_line}({{ site.url }}{{ site.root }}{{ site.images_dir }}/{{ page.date | date: \"%Y\" }}/#{picture_to_copy})](#{full_pict_ref})"
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

  def write_it( file, final_content )
    file = @exported_posts + "/" + file
    if File.writable?( file )
      File::open file, 'w' do |f|
        f.write final_content
      end
    end
  end
end

Cleaner.new