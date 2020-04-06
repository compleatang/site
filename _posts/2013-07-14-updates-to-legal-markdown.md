---

layout:    post
title:     Recent Updates to Legal Markdown Gem
published: true
comments:  true
meta:      true
category:   legal markdown
tags:      [ruby, legal markdown]
excerpt:   "Had some time this weekend and have dug pretty deep into my legal_markdown gem. Mostly the changes should be transparent to users. Now that I feel that am getting a better handle on Ruby, I wanted to refactor the code quite a bit. There were a couple of motivations for this. First, I wanted to put the code more inline with common rubyisms and software construction methods. Second, I wanted to make the gem more flexible. It was fairly straightforward as previously conceived. There was only one class, no modules, and all the functionality resided in one huge file. Third, speed. Although most lmd files will be quite tiny and any modern computer can parse them and refactor them into md files within milliseconds, faster is always > slower. "

---

Had some time this weekend and have dug pretty deep into my [legal_markdown](https://github.com/compleatang/legal-markdown) gem. Mostly the changes should be transparent to users. Now that I feel that am getting a better handle on Ruby, I wanted to refactor the code quite a bit. There were a couple of motivations for this. First, I wanted to put the code more inline with common rubyisms and software construction methods. Second, I wanted to make the gem more flexible. It was fairly straightforward as previously conceived. There was only one class, no modules, and all the functionality resided in one huge file. Third, speed. Although most lmd files will be quite tiny and any modern computer can parse them and refactor them into md files within milliseconds, faster is always > slower.

### Refactor into Multiple Modules and Classes

I started the refactor by building two modules. First there is the main LegalMarkdown module which operates as the overall wrapper for the system. I wanted it to be a module so that other code (predominantly [RMOC](https://github.com/compleatang/rmoc), which is upcoming once I release legal_markdown 1.0) can pull in the gem functionality in a more efficient and modular way. The LegalMarkdown module has a simple controller to direct the actions of the gem. For now it is fairly rudimentary, one of my next steps will be to utilize Ruby's OptionsParser now that the functionality of the gem is becoming more complicated.  So the module operates as the parent of the gem, and has one method which controls what the gem does when the module is called. For now there are two modules which live directly "under" LegalMarkdown. The first module automatically builds the YAML front matter for users. This functionality has existed since v0.1.4 and I have to refactor that code in the coming times. The second module abstracted the LegalToMarkdown functionality into its own module.

Similarly with the top level module, I abstracted LegalToMarkdown a bit. The entry point to the module is a controller file which determines how the module will perform. The file contains two methods. One of which controls the lmd -> md functionality and another which controls the lmd -> json functionality. There is probably too much logic in this file right now and I likely should abstract some of it to the LegalMarkdown controller which sets everything up to run a parsing incident more efficiently, but it is still a work in progress. To run the parsing incident I abstracted out the previous gem functionality into a couple of other files based on the steps required to parse a file. This is, perhaps, not optimal, but it is what makes sense to me.

The first step to any parsing incident is to load and parse the input file. This content is an "thing" in ruby so it made sense that the content to be parse would be put in a class. When I call Class.new, Ruby will load the file, parse it, integrate the proper submodules of LegalToMarkdown module and get everything "ready" for the LegalToMarkdown controller to run the remainder of the parsing incident. Again, I'm not sure if this optimal software design as I'm still learning, but it seems to make sense to my and I can "visualize" where everything is at any point in the process.

The rest of the process I abstracted into modules under LegalToMarkdown so that they can be integrated on a case by case basis depending on what the file needs to actually do. For instance if the file does not have a leaders block then there is no need to run that code. Similarly if the file does not have any mixins or optional clauses there is no need to run that code. It took me a while to figure out how to properly pull in the modules based on the conditions of the content.  I still don't feel that I fully understand `extend self` and `self.extend` and `include Module` but in any event, when extending a class with a module what ended up working based on the new design was to call `self.extend LegalToMarkdown::Module` from a method in the class which parses the conditions to determine the correct modules to integrate.

The portion of the code dealing with mixins was integrated into its own Module under the LegalToMarkdown module.  Similarly the methods which parse leaders (structured headers) has been put into a different module under the LegalToMarkdown module. The last module I built deals with some particularities required for the `--to-json` feature. So at the end of the day, the structure of the gem currently looks like this.

> module LegalMarkdown

> ->  module LegalToMarkdown

> -> ->    class FileToParse

> ->->    module Mixin

> ->->    module Leaders

> ->->    module BuildJason

> ->  module MakeYAMLFrontmatter

Again, feedback on the structure is very much welcome as I'm still learning how to think about software design.

### Testing Suite

I know, I know. You are supposed to have tests for what you do. How else will you know if it is working or not? I'm still learning! In any event, I took some time to build a testing suite. It was actually quite easy. And it greatly simplifies the development process. Thankfully, [@twolfson](https://github.com/twolfson) posted an issue on the github repo which sent me in the correct direction. He said I should build a bunch of simple flat files that represent the input and expected output. This is more or less what I had been doing, although I was not doing it systematically and was just doing it chaotically.  Everything I read said that I should start out with testing using Ruby's included test suite rather than RSpec or other more intricate, and capable, test possibilities. So that is currently the basis for the suite. Later, when I'm more comfortable with the process I may switch to RSpec but for now Test::Unit is working just fine.

One of the things that was important with a process oriented gem like legal_markdown is that when I test things there is a certain sequence in which I want the tests to run. So when I built the lmd files I simply numbered them. Then in the test controller I can simply glob the files, sort the resulting array and then it will always run the tests in a particular order that I want the files to be parsed. This allows me to check the operation of the gem in a particular sequence. That assists in understanding exactly where the problems. After building the lmd files then I ran those through the gem and tweaked a few things in the output markdown files (mostly which were bugs that I needed to work on). Boom, I had a working test suite.

The basic philosophy for testing is to build these benchmark files. Then the test suite pulls the lmd files, puts them in order, then runs them one by one through the gem and outputs a temp file. Lastly, the test suite compares the temp file output to the benchmark file to ensure they are the same. Later when I add additional functionality or need to test different things, I can simply build a single lmd file that tests for what I need, output that to a md file as a benchmark, number it in the correct order in which I want the test to run and everything else will be taken care of.

Once I had the test suite built. Then I had to work on the Rakefile to build the testing task. I integrated the github repo with [Travis](https://travis-ci.org) so that it will perform the tests for me on different versions of ruby. Generally I can test the gem quite quickly in 1.9.3 which is primarily what I use for development on my laptop. I run these tests after each piece of code after each piece of code that I've changed during the deeper refactor (below). The advantage of Travis is that it will run the tests on other versions of Ruby very quickly. But to use Travis, and to make running the tests more simple on my machine, I needed to build a rake task that would control the tests. It was very easy after a bit of googling and stack overflowing I had the answer within five minutes. I need to understand how to use rake better, but one thing at a time. For now, here's what the Rakefile looks like:

{% highlight ruby %}

require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

task :default => [:test]

{% endhighlight %}

It is very rudimentary for most, but it was cool for me to be able to type `rake` into the command line (or if I was feeling verbose `bundle exec rake`) and have it run the tests. Plus now Travis runs all the tests on the versions of Ruby which I specify in the .travis.yml file.

### Deeper Refactoring

Along with Travis, I also integrated the repo with [Code Climate](https://codeclimate.com). Both of these tools are free for open source projects and make their money (as Github does) by providing the same, or similar, services for closed source project. I absolutely love this business model. Code Climate looks at your code and analyzes the complexity and redundancy of the code basis. Digging into its analysis of my code basis is teaching me a lot about coding and how to think about coding.  For anyone that is reaching the advanced beginner stage of learning to code this is a fantastic tool.

When I first integrated with Code Climate it gave me a rounding "F" and my GPA was 0.2. This was eye opening. It was one of the impetuses for my major refactor discussed above. After I parsed everything out into modules, etc. I also had to take a look at the methods and simplify those. Previously I had been thinking of methods as a way to control the flow of the code. So each of logical steps and substeps of the code were built as methods. It worked. But it is suboptimal for reasons I'm still learning. The basic jist is that I needed to greatly simplify what I was doing with my methods. So, mainly in the Leaders module I worked hard to refactor the code so that each method was more simple.

Still, though, the code base is quite complex. I'm up to a GPA of 1.5 but I have a decent amount of work to do. Some of the complexity it appears to me is inevitable. There are a ton of complexities in what the gem is trying to do. There are ton of switches and branches depending on what the input is. In order to provide the functionality that I want, I'm still trying to figure out how to simplify the code base as much as possible. There appears a tension in what I'm trying to accomplish with the gem and the complexity of the codebase. However, this is hardly the most complex piece of code ever written. Much to learn; much to learn.

### To Json Feature

Some background. I started building legal_markdown because I wanted it to be a simple tool that could provide a basis for a new way of thinking about and creating legal documents. Yet, how to integrate with a ruby gem for non-technical, non-command line users, was a big concern. The average lawyer likely has never looked at the command line. Or at least, not since 1986. So it is fine that I have built in a command line option, but that is only the beginning. The next step was to integrate the gem into a sublime package. I use this package on a daily basis and it makes using the gem dead simple. Users can install sublime, install Package control, install the legal markdown package and go. Still there is the ruby requirement, but at least that is a surmountable obstacle.

The problem with working with lmd files in sublime is primarily that it is not a very elegant solution for reading and annotating documents. Currently if I want to read a lmd file, it is damn easy. I simply run the Legal Markdown to Markdown command in sublime and then run the Preview Markdown command from the Markdown Preview package and it opens automatically in the browser. Two commands. It is not bad, but it could be better.

These are some of the concerns behind [RMOC](https://github.com/compleatang/rmoc). To read and annotate files will require a more complex structure than simple markdown is capable of providing. There are a couple of options for richer file formats than simple text based format such as markdown. For now, the primary "rich" format that legal_markdown will support is JSON. As I stated in this [issue](https://github.com/compleatang/legal-markdown/issues/2) , JSON is readily available for all major programming/scripting languages; generally parses faster and is easier to work with than xml (the other major option); and also integrates with databases very well.

In addition, I've been a fan for a while of what the team building [Substance](http://substance.io) is doing. So, I've built the to-json feature of legal_markdown so that it outputs in a format which will fully integrate with Substance. Then when I build the Read component of RMOC I can simply use a lot of their code to build the reading and annotating portion of RMOC.

Building the feature was not really troublesome. Once you have a good idea of how to work with hashes in ruby then it is really a simple matter to build JSON documents. You simply assemble the code into one large hash and then dump that hash into a JSON.

## Lessons Learned

* Classes = things. Files are things. A file is a Class. Functionality goes in modules
* Modules are ways to keep blocks of code so that they can be integrated when necessary
* Methods should have a singular function
* Nested hashes area  bit troublesome when the keys are id's and you only know the values rather than the keys. Have to loop through each_value and work the search that way. Also, Enumerable::detect is good for this.
* Don't be afraid of tests. They aren't that complex.

Happy Hacking!

~ # ~