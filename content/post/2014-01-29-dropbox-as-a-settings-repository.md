---
categories:
- linux for lawyers
comments: false
date: "2014-01-29T00:00:00Z"
excerpt: I keep all my program and operating system settings in Dropbox which allows
  me to easily reinstall a new system completely automated. Here's how I do it.
meta: true
published: true
tags:
- backups
- cloud-sync
- linux
title: Using Dropbox as a Settings Repository
---

As I said in my previous post, the main way in which I used Dropbox is as a repository for all my settings. Almost the entirety of this will also work with OSX for the record, save for program settings locations in OSX are different than in Linux -- they are usually in ~/Library/Application\ Settings.

## How Linux (Usually) Stores Settings

One of the most brilliant things about Linux systems is how Linux desktops (for the most part) store your application settings. On Windows, these are usually stored in databases which makes them difficult to sync and store. But on POSIX systems generally, and Linux in particular, settings for applications are largely stored in files. Indeed, usually files are simple text files rather than anything which is truly difficult to handle.

There are two main implications for the operating system utilizing files rather than databases for application settings. The first is that you can move the files around to where **you** want them to be rather than where the *developers* think they should be and then you can fake the computer into thinking the files are really where the program is looking for them at. The second implication is that it is terribly easy to set your settings up to be cloud synced which means that you can always pull them in when you have a new machine or setup.

## The Importance of Installation Scripts

One of the major things which Linux has showed me is how to create a fungible system. I use Ubuntu which is on a six month release cycle. This means that every six months or so I will completely format my hard drive and start from scratch.

In the 90's I had a friend in college who used to format his hard drive all the time. He would take like one weekend every quarter and do this. It was ridiculous. At that time he was running Windows I'm pretty sure so I had no idea why he would do it so often. Perhaps he was not on Windows and had figured out back then what I know now which is that if you set things up correctly, formatting your hard drive and reinstalling everything can happen smoothly, resiliently and easily.

At this point when I update my Ubuntu release and format my hard drive the first thing I do after logging in is download and run one script. That script is a master script which runs all sorts of smaller scripts. It takes about an hour or maybe three to download and install everything depending on the bandwidth of my connection -- but even in Hargeisa where the bandwidth is awful it runs in about three hours. When it is finished, I have only a few things to do (like turn on a few extensions for Ubuntu-GNOME and maybe change my wallpaper) and my system will look and act **exactly** as it did before the new installation. I will write more about this process later. Suffice it to say for this post that my Dropbox bootstrap script is a huge part of that.

## Setting up a Dropbox Bootstrap Script

Given all the above, about two years ago I realized that what I needed to do was to put all of my non-data non-music non-document non-video files that I would need to make my system look and feel the same across installations in my Dropbox. Dropbox works exceedingly well for this. In Linux most programs look for their configuration file in one of a few places.

* Some programs look for a file in the home folder which is usually the name of the program + rc. So for example, the program htop which is a great program for seeing the processes that are currently running and a whole lot more stores its settings in ~/.htoprc.
* Some programs look for a set of files within ~/.config/PROGRAM_NAME/FILES.
* Some programs, particularly desktop (as in GNOME, Unity, Elementary, etc.) files and menus, in a various directories under ~/.local/share/STUFF.
* Some programs make a folder in your home directory and put files under there. Usually these are in a folder called something like ~/.PROGRAM_NAME. For example, filezilla a popular FTP program puts its configuration files under ~/.filezilla

If you do not know in Linux terms, the `~` in the above is a 'contraction' for `/home/USER`. This is standard across POSIX systems and is a highly utilized shorthand.

Since programs have different methods of placing their configuration files, setting up your own cloud sync for program settings will require that you look around in your home folder. If you are doing this, it is important to understand that when a file has a `.` in the beginning of it on Linux that is a hidden file and it will not show up in Nautilus unless you press `ctrl+h` (for Hidden). If you are in terminal -- which I highly recommend everyone to learn at least the basics of -- then you will not see hidden files when you type `ls` (LiSt files) unless you add the `-a` (for All) switch to make the command `ls -a`.

The key to the whole system is creating `symlinks` (symbolic link) within your user folder. Symbolic links are what makes the programs *think* they are looking at a file in one place when they are *really* looking at a file in another location. Files which are really symlinks look, act, and feel almost exactly as if they were actually in the place where the symlink resides rather than in the place where they actually are.

Once you have found the files that you want to have synced to the cloud it is a rudimentary process to set them up. The basic flow is as follows:

1. Copy the files into your cloud sync folder.
2. Create a *from* the new location in the cloud sync folder *to* the previous location where the program will really look for it.

It is truly just that simple. If you want to symlink directories there is the added step of checking to see if a directory is made within the cloud sync folder and making the directory within the cloud sync folder if it is not. But that is the only added step. If you create a symlink directory, it operates -- for all intents and purposes -- just as a normal directory does. It has files inside of it and programs can look inside of the directory at the files just as they normally would.

## Wrapping it All up in an Executable Script

To automate this process is very straight forward. You simply want to create an executable script and put it in your cloud sync folder. Then you simply call that script whenever you like. Here is what I did.

```bash
$ touch ~/Dropbox/bootstrap
$ chmod +x ~/Dropbox/bootstrap
```

The first line creates a bootstrap file within my Dropbox folder; the second line makes it executable. At this point the file is simply blank. So then one needs to put something into the script to make it work. Here's excerpts from my bootstrap file.

```bash
#!/usr/bin/env zsh
#^jist /home/coda/Dropbox/bootstrap -u 4950102

if [ ! -d ~/Dropbox/Dot-Files ]; then
  mkdir Dropbox/Dot-Files/
fi

function file_boot {
  if [ -f $1 ]; then
    if [[ ! -L $1 && ! -e $2 ]]; then
      cp $1 $2
    fi
    rm $1
    ln -s $2 $1
  elif [ -e $2 ]; then
    ln -s $2 $1
  fi
}

function dir_boot {
  if [ -d $1 ]; then
    if [[ ! -L $1 && ! -e $2 ]]; then
      cp $1 $2 -R
    fi
    rm -rf $1
    ln -s $2 $1
  elif [ -e $2 ]; then
    ln -s $2 $1
  fi
}

echo "First the dot files."
file_boot ~/.face ~/Dropbox/Camera\ Uploads/0000.gravatar.jpeg
file_boot ~/.gitconfig ~/Dropbox/Dot-Files/gitconfig
file_boot ~/.gitattributes ~/Dropbox/Dot-Files/gitattributes
file_boot ~/.config/gtk-3.0/bookmarks ~/Dropbox/Dot-Files/gtk-bookmarks
file_boot ~/.installd ~/Dropbox/Dot-Files/installd-workers
file_boot ~/.rvmrc ~/Dropbox/Dot-Files/rvmrc-workers
file_boot ~/.vimrc ~/Dropbox/Dot-Files/vimrc-workers
file_boot ~/.npmrc ~/Dropbox/Dot-Files/npmrc-workers
file_boot ~/.zshrc ~/Dropbox/Dot-Files/zshrc-workers

echo "Then come the config directories."
dir_boot ~/.ssh ~/Dropbox/Ssh
dir_boot ~/.bin ~/Dropbox/Binary\ Files

echo "Thereafter we take care of the menus and desktop."
dir_boot ~/.config/autostart ~/Dropbox/Autostart\ -\ .config/
dir_boot ~/.config/menus ~/Dropbox/Menus\ -\ .config
dir_boot ~/.local/share/gnome-shell/extensions ~/Dropbox/Gnome-shell\ -\ .local-share/
dir_boot ~/.local/share/applications ~/Dropbox/Menus\ -\ .local-share-applications
dir_boot ~/.local/share/desktop-directories ~/Dropbox/Menus\ -\ .local-share-directories
dir_boot ~/.config/elegance-colors ~/Dropbox/Elegance\ -\ .config
dir_boot ~/.icons ~/Dropbox/Icons

echo "Finally come the \"other\" working directories."
dir_boot ~/.cheat ~/Dropbox/Cheat-Sheats
dir_boot ~/.config/libreoffice ~/Dropbox/Libreoffice\ -\ .config
dir_boot ~/.conky ~/Dropbox/Conky
dir_boot ~/.filezilla ~/Dropbox/Filezilla
dir_boot ~/.fonts ~/Dropbox/Fonts
dir_boot ~/.gconf/apps/guake ~/Dropbox/Guake\ -\ .gconf\ -\ apps

echo "All done! Dotfiles built!"
```

Let's walk through the script. The first line is called a shebang. It tells the computer in what scripting language the script should be run in. I chose to run this in zsh as that is my normal shell. The other major shell language, bash, could be used but there are some minor differences in the functions that would need to be worked out.

For most of my executable scripts, I make sure they are on Github's Gist system so that I can easily remember and retrieve them. `jist` is a command line gem written in ruby that makes it easy to post, retrieve and update your Gists. I usually make a caseybang(tm) reminding myself what the code for the gist is by putting the second line as a jist line. Then I simply can copy and execute this from the command line. Largely it can be ignored.

The next section looks in the Dropbox folder to see if there is a Dot-Files directory. If it is not there then the script will make one. I have one there, but this is just for resiliency in the off chance that something weird happens during an upgrade. After that there are two functions which are built, file_boot and dir_boot. They do more or less what they sound like. One bootstraps individual files and one bootstraps directories.

[Note, in the following paragraphs the **first** ($1 in the script) means the local or normal place on the hard drive -- where the program will look for the file or directory; the **second** ($2 in the script) means the cloud sync location.]

What the function does is asks some questions. First it asks whether the first ($1) exists as a file (-f) or directory (-d) depending on whether the file_boot or dir_boot function is being called.

If it exists then the function will then ask if the first ($1) is a symlink AND whether the second ($2) exists. This usually means that I have added a file or directory to the script and it needs to bring it into my Dropbox. If this test is satisfied then the function will copy the first to the second. But if the first exists and is not a link AND the second exists then we are in a different world. This usually means that I'm reinstalling a system so we do not want to copy in the file (or directory) to the cloud sync folder as it will then overwrite my existing settings with the default settings (which is usually when this test is satisfied). After either copying over or not, depending on the test, the function will then remove the first ($1) and create a symlink from the second to the first.

If the first ($1) does not exist (in other words the initial test was not satisfied), but the second ($2) exists then the function will create a symlink from the second to the first.

That is it. It is very straight-forward. It took some massaging to get the functions correct, but once I realized the flow then it was straight-forward to create the tests and actions.

After the script establishes the function then it simply lists the files and directories to symlink. I've put a redacted version of my complete list above to show the different locations and how I organize it. Some highlights include, autostarting settings. I keep my autostart settings in Dropbox so when I install a new system the same programs autostart. Try that in windows. Also my menus are the same across systems -- even for programs which I have manually placed into the desktop. Try that in windows. My desktop themes, icons, and extensions are also there so that my desktop will look and feel almost the same even when Gnome-Shell upgrades. Try that in windows.

As I go along and add or remove programs which I want to add their settings to the dropbox folder then I simply add a new line into the appropriate section of the script by adding `file_boot LOCAL_LOCATION SYNC_LOCATION` or dir_boot depending on whether it is a file or directory I'm bootstrapping. After adding the line, I save the file and then execute the script. Voila, the file is copied into my Dropbox and symlinked to.

When I'm installing my next update and format my harddrive, one of the first things I do in my install script is to begin downloading my dropbox. Then later in the script when it is all downloaded, I simply execute this script from the main install script which symlinks everything in and deletes the defaults which Ubuntu install wizard sets up. Voila, everything as it was before.

## Improvements

This script could be improved by pulling out the ~/Dropbox portion into a variable and putting that variable at the top of the script for those who may use the script in a different system or have their dropbox folder in a different location. Other than that if you have improvements definitely let me know, but all in all it is quite straightforward.

At any rate, hope this is somewhat useful.

Happy Hacking

~ # ~