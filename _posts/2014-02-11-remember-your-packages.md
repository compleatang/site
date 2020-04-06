---

layout:    post
title:     Remembering Your Packages
published: true
comments:  true
meta:      true
category:  Linux for Lawyers
tags:      [linux, packages]
excerpt:   "What programs (packages) do I use? This is a perennial problem. It is always easy to remember those packages you use all the time but what about those packages that you do not but you want them there when you need them. Here is a three step system for ensuring that you never forget to reinstall packages you want when you upgrade your system or reinstall you operating system."

---

What programs (packages) do I use? This is a perennial problem. It is always easy to remember those packages you use all the time but what about those packages that you do not but you want them there when you need them. Here is a three step system for ensuring that you never forget to reinstall packages you want when you upgrade your system or reinstall you operating system.

## Step 1 -- Build an Install Script

I have slowly been speaking about the parts of my installation script over the course of most of my Linux for Lawyers series. I have written about how to use [Dropbox as a settings repository](http://coda.caseykuhlman.com//entries/2014/dropbox-as-a-settings-repository.html) and to automatically pull those settings in when you reinstall your system and I have also written about setting up your [shell environment](http://coda.caseykuhlman.com//entries/2014/on-shells.html). The system that I use depends in large part on a fairly detailed installation script that I use after installing or reinstalling a Linux operating system. So I keep my packages in that install script.

My install script contains a long list of the packages which I have installed previously. This is held in an array in shell scripting format. Then the install script builds a function which is creatively called `install_a_bunch`. Shell scripting is not terribly easy to follow along with, but what the function essentially does is to first check if the packages I'm trying to install are already installed. Based on the return of the sudo apt-get --qq --dry-run call, it parses the packages into three buckets. The first bucket contains those packages which are not installed and can be found in the repositories. The second bucket contains those packages which are already installed. The third bucket contains those packages which cannot be found in the repositories. The final thing the function does is to install those packages which are in the first bucket.

```bash
pkgs=( alacarte audacity blueman chromium-browser cifs-utils conky ..[REDACTED].. zotero-standalone zsh )

function install_a_bunch() {
  rqst_pkgs=("${@}")
  pkgs_inst=( )
  for pkg in "${rqst_pkgs[@]}"; do
    echo "checking for package: $pkg"
    sudo apt-get -qq --dry-run install $pkg &>/dev/null
    if [ $? != 100  ]; then
      dpkg -s $pkg 2>/dev/null | grep -q installed
      if [ $? == 1 ]; then
        pkgs_inst=( "${pkgs_inst[@]}" "${pkg}" )
        echo "$pkg: not installed, will install it."
      else
        echo "$pkg: already installed."
      fi
    else
      echo "$pkg: cannot find in the repos, try checking the apt repositories"
    fi
  done
  if [[ ! ${#pkgs_inst[@]} == 0 ]]; then
    sudo apt-get install -y ${pkgs_inst[@]}
  else
    echo "nothing to install"
  fi
}
install_a_bunch "${pkgs[@]}"
```

Linux package managers are decentralized things. This means that you can add and remove other package repositories besides the ones that come pre-installed with the system. In Ubuntu this is done with the add-apt-repository command. The third bucket was put in because many of the packages / programs I use are installed not from the standard repositories but from specialized repositories. In Ubuntu, many packages that are in the standard Ubuntu repositories may be a ways behind the package's latest stable release so it is often necessary to add other repositories which point to the latest stable releases rather than using the standard Ubuntu releases. For example, as of this writing, LibreOffice version 4.1.2 is what is sourced from the standard repositories while version 4.2.0 is sourced from the LibreOffice repositories. For that package and others, I will use the specialized repository rather than the standard repository.

## Step 2 -- Setup Your Shell to Log Repositories and Packages

Once you have an install script ready to go, then the next step is to set up your shell with shortcuts that you can use to both add a repository and install packages while also logging what you are adding into the install script.

```bash
function install()
{
  packages=$@
  sudo apt-get install ${=packages} && echo "$packages" >> ~/.installd
}
apt_pref_compdef install  "install"
function add-repo()
{
  repos=$@
  sudo add-apt-repository -y ppa:${=repos} && echo "sudo add-apt-repository -y ppa:$repos" >> ~/.installd
  sudo apt-get update
}
```

The first function above, `install`, is used so that when I'm copying and pasting from a site which tells me to do a sudo apt-get install that I just can copy the install and whatever packages I'm to install. The function will do a sudo apt-get install of the packages and then will log those packages in the install script. The line after the install function is a compdef function which enables tab completion in zsh.

The second function above, `add-repo`, is a corollary of the install function. It performs an add-apt-repository call and then logs that in the install script. Finally it performs a sudo apt-get update which you always want to do after you add a repository so that the Ubuntu list of packages gets updated with the packages from the new repository.

## Step 3 -- Keep It Organized

The logging functions above will put new repositories and packages at the end of your install script (note, adding onto the end of a text file in shell is super easy with the `echo "BLAH" >> FILE` call). Then every once in a while I just organize the script. I cut and paste the repositories into the proper place in my install script and then I use ruby to organize the packages.

If you have ruby installed on your computer then from shell you type `irb`. This will load the interactive ruby console. After that, here is what I do (note the $ below is the cursor):

```ruby
$ a = %w(_CUT_AND_PASTE_THE_PACKAGES_FROM_PKGS_IN_INSTALL_SCRIPT_)
$ a << %w(_CUT_AND_PASTE_THE_PACKAGES_FROM_THE_BOTTOM_OF_INSTALL_SCRIPT_)
$ a.flatten.sort.uniq.join(' ')
$ exit
```

Then just copy the output from the final ruby call there into your packages array in the install script and delete the packages from the bottom. Then you are all set. You have all your packages logged and up to date.

Happy Hacking!

~ # ~