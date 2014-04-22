require 'jekyll'
require 'shellwords.rb'

PROD_REPONAME = ""

task :default => [:publish]

namespace :site do
  desc "Generate blog files"
  task :generate do
    message = "Site updated at #{Time.now.utc}"
    system "git checkout -- _config.yml"
    system "git add ."
    system "git commit -m #{message.shellescape}"
    system "git push github master"
    system "git push wsl master"
    Jekyll::Site.new(Jekyll.configuration({
      "source"      => ".",
      "destination" => "_site/htdocs"
    })).process
  end

  # call with rake site:publish
  desc "Generate and publish blog"
  task :publish => [:generate] do
    Dir.chdir "_site"
    system "git add ."
    message = "Site updated at #{Time.now.utc}"
    system "git commit -m #{message.shellescape}"
    system "git push origin master"
    system "ssh 119629@git.dc0.gpaas.net 'deploy blog.caseykuhlman.com.git master'"

  end
end
