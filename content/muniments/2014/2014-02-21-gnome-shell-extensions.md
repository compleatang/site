---
categories:
- Linux for Lawyers
comments: true
date: "2014-02-21T00:00:00Z"
summary: There are two great things about Gnome Extensions. First, what you can do
  with them. Second, the user experience of installing them via a very slick webapp.
meta: true
published: true
tags:
- linux
- gnome
- extensions
title: Gnome Shell Extensions -- Those Little Bundles of Joy
---

I have yet to really get into any of the desktop interfaces other than Gnome. I've tried KDE and Unity. I'd like to try Elementary, but probably on an old laptop I'm going to set up for my in laws rather than my primary machine. Since about Gnome Shell 3.2, though, I've done little more than take tours around other desktop interfaces.

In case you did not know, one of the greatest things about Linux is that you can do this. You can explore different desktop interfaces and find the one that works for you. Gnome works for me. It may not work for you. You may prefer another flavor. That's awesome! Because Linux successfully compartmentalizes different aspects of the computer it is *nearly* trivial to change desktop interfaces without having to reinstall the entire Operating System. Especially if you are using one of the major distributions to provide the underlying portions of the operating system.

## The Extensions I Use

I currently use sixteen extensions:

[Alternate Activities Menu](https://extensions.gnome.org/extension/766/alternative-activities/) has a nice workspace indicator. I do not really use one of its killer features which is to semi control the other extensions and to "remember" which applications are open in which workspaces (the latter because I'm anally retentive enough to always know where things are).

[AppIndicator Support](https://extensions.gnome.org/extension/615/appindicator-support/) is one of my favorite extensions right now. I have used some variety of this extension since shell 3.2, but this is the best in class for my (not) money. This extension does a great job of letting me customize where application indicators (tray icons, whatever they are called today) go -- either in the top panel or in the bottom message tray (the former I see much more often than the latter). This allows me to put things that I don't want to visually clutter my panel into the message tray where I don't really need to see them but every once in a while.

[Audio Input Switcher](https://extensions.gnome.org/extension/768/audio-input-switcher/) | [Audio Output Switcher](https://extensions.gnome.org/extension/751/audio-output-switcher/) are two great little tools that give me a quick way to switch what audio input | output I'm using from the system menu which is always the top right corner of the panel.

[Automove Windows](https://extensions.gnome.org/extension/16/auto-move-windows/) I spoke about this in my post on desktops. It does what it says and automatically moves windows to the specified workspace when you open them. It does not lock them into the workspace so you can move them around after they are opened, but it is nice to know that Spotify always opens in the Third Workspace or however you set it up.

[Autohide Battery](https://extensions.gnome.org/extension/595/autohide-battery/) does what it says and hides the battery icon from the panel when the battery is fully charged.

[Caffeine](https://extensions.gnome.org/extension/517/caffeine/) this is a great little extension which stops the screensaver and lock screen from being triggered. You can set it up to always turn on upon the occurrence of certain events. For example, I keep chromium on my system and then link Caffeine to always turn on when chromium is open. So if I want to watch videos on my computer I just use chromium rather than chrome which is my daily driver for browsing, and then I do not have to worry about the screensaver turning on. It's the little things.

[Calculator](https://extensions.gnome.org/extension/111/calculator/) when you press the Super (Windows) key in Gnome you go to the activities overview. This extension puts a wee little calculator there which you can use. I'm using it less and less.

[Coverflow Alt-Tab](https://extensions.gnome.org/extension/97/coverflow-alt-tab/) makes Alt-Tabbing beautiful in Gnome.

[Hide Top Bar](https://extensions.gnome.org/extension/545/hide-top-bar/) this is utterly an essential extension for me. I do not like having wasted pixels *always* used at the top of my screen. If I want to see the panel I'm happy to scroll my mouse there or hit Super. Otherwise, leave me alone and let me focus on the task at hand. This is another extension which I have used various flavors of since I started using Gnome and I've resisted upgrading shells until I knew that an extension of this variety was working in the next version.

[Media Player Indicator](https://extensions.gnome.org/extension/55/media-player-indicator/) is another long-standing (for me) and very popular extension. It puts a summary of whatever media is playing (or open but not playing) into your system menu so you can control or see different things. It has always been good eye candy for the panel and in the latest version of Shell it has collapsed into the system menu which brightens that up a bit.

[MediaKeys to MPRIS2](https://extensions.gnome.org/extension/695/mediakeys-to-mpris2/) transmits my function F8 into a next song for Spotify and other apps.

[Message Tray on bottom right corner](https://extensions.gnome.org/extension/732/message-tray-on-bottom-right-corner/) over time, Gnome has changed how you get to the message tray. I like being able to fling my mouse at the bottom right corner and having the message tray pop up rather than Super+m. This is a nice to have but not essential extension for me because I care what is going on in the message tray only a couple of times a day.

[Pomodoro](https://extensions.gnome.org/extension/53/pomodoro/) timer. Must have.

[Project Hamster Extension](https://extensions.gnome.org/extension/425/project-hamster-extension/) how I track my billable and non-billable time fluctuates over time. Have tried many different solutions and I'm here now. Not sure if will stick but have been enjoying it for about a month now. Has a good autocomplete feature and looks a hell of a lot nicer than other applications. Being designed for Gnome specifically makes it appealing as well.

[User themes](https://extensions.gnome.org/extension/19/user-themes/) allow me to have different themes for Gnome Shell to make it look, act, and feel different ways. I used Elegance Colors but there are tons of flavors available. This extension has been a must have since the very first version of Shell.

## Installing, Uninstalling, Enabling, Disabling Extensions

If you are in gnome and a user of normal variety, do this:

```bash
$ sudo apt-get install gnome-tweak-tool
```

You will be much happier thereafter. Tweak tool allows you to turn extensions on or off and also lets you get to the extension preferences and options interface which you will need from time to time.

However, you can also get to these things from the [gnome extensions web app](https://extensions.gnome.org/) which is a brilliant tool. From there you can install, uninstall, enable, disable, and go to the preferences for any extension you have installed. It interacts with your desktop in a way which I really like, but could see how some paranoids would hate -- luckily because Gnome is open source those paranoids can see what information the web app is gathering from your desktop. The interface is simple and a very good way to try out different extensions to see the ones that are good for you!

Happy Hacking!

~ # ~