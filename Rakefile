require 'jekyll'
require 'tmpdir'

PROD_REPONAME = ""

namespace :site do
  desc "Generate blog files"
  task :generate do
    Jekyll::Site.new(Jekyll.configuration({
      "source"      => ".",
      "destination" => "_site/htdocs"
    })).process
  end

  # call with rake site:publish
  desc "Generate and publish blog"
  task :publish => [:generate] do
    message = "Site updated at #{Time.now.utc}"
    system "git checkout -- _config.yml"
    system "git add . && git commit -m #{message.shellescape} &>/dev/null"
    # system "git push github master"
    # system "git push wsl master"
    repo_dir = `pwd`.strip
    Dir.mktmpdir do |tmp|
      Dir.chdir tmp
      system "git clone ssh+git://119629@git.dc0.gpaas.net/blog.caseykuhlman.com.git ." 
      system "git rm -rf * &>/dev/null"
      system "cp #{repo_dir}/_site/* . -R"
      system "git add . &>/dev/null"
      system "git commit -m #{message.shellescape} &>/dev/null"
      system "git remote add origin  git+ssh://119629@git.dc0.gpaas.net/blog.caseykuhlman.com.git"
      system "git push origin master"
      system "ssh 119629@git.dc0.gpaas.net 'deploy blog.caseykuhlman.com.git master'"
    end
  end
end