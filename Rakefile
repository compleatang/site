require 'jekyll'
require 'tmpdir'

PROD_REPONAME = ""

# call with rake publish
desc "Generate and publish blog"
namespace :publish do
  message = "Site updated at #{Time.now.utc}"
  repo_dir = `pwd`.strip
  # need to make this responsive to dirty dirs only
  system "git add . && git commit -m #{message.shellescape} &>/dev/null"
  # system "git push github master"
  # system "git push wsl master"
  Jekyll::Site.new(Jekyll.configuration({
    "source"      => ".",
    "destination" => "_site/htdocs"
  })).process
  Dir.mktmpdir do |tmp|
    Dir.chdir tmp
    system "git clone ssh+git://119629@git.dc0.gpaas.net/blog.caseykuhlman.com.git ." 
    system "git rm -rf . &>/dev/null"
    system "cp #{repo_dir}/_site/* . -R"
    system "git add . &>/dev/null"
    system "git commit -m #{message.shellescape} &>/dev/null"
    system "git remote add origin  git+ssh://119629@git.dc0.gpaas.net/blog.caseykuhlman.com.git"
    system "git push origin master"
    system "ssh 119629@git.dc0.gpaas.net 'deploy blog.caseykuhlman.com.git master'"
  end
end