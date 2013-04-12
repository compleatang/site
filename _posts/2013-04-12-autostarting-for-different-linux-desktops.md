---

layout:    posts
title:     Autostarting Different Programs in Different Desktops
published: true
category:  linux for lawyers
tags:      [linux, gnome, unity]
excerpt:   "One of the most obvious appeals of Linux to me is the insane levels of customization you can achieve. I mainly use Gnome Shell as my desktop environment, but since I use Ubuntu I keep Unity on my machine. This is how I start different programs when logging into different desktops."
comments:  true

---

# Autostarting Different Programs in Different Desktops

One of the most obvious appeals of Linux to me is the insane levels of customization you can achieve. I mainly use Gnome Shell as my desktop environment, but since I use Ubuntu I keep Unity on my machine. I'm not a hater of Unity or Gnome as many Linux users (who can be quite vitriolic in their statements as to desktop environments). I *mostly* use Gnome, but since Ubuntu has some interesting things going on with Unity sometimes I like to drop into Unity to see what I'm missing.

There is a problem at least in Ubuntu 12.10 running both desktops. To use Gnome Shell one *should* install the `gdm` package in order to get the full Gnome desktop experience - including the Gnome lock screen which is beautiful. GDM stands for Gnome Desktop Manager. It is an alternative to `lightdm` which Ubuntu installs by default and which Unity uses. When you switch to gdm I found out that just after installing it you should logout of Unity before restarting your machine. But I didn't do that.

The result of installing gdm and then restarting your machine is that the X server (which runs most of the linux desktops and lies in the stack underneath both gdm and lightdm) doesn't start correctly for "both" Unity and Shell. It is something to do with the way that dm loads the XSessions and it is beyond my understanding. In any event the problem for me was that while gdm made Shell work as it should out of the box, Unity would not load when I logged into Unity desktop.

So I built a small autostart script that for Unity that will load Unity after logging into the Ubuntu desktop. This was straight-forward. But the problem I had is that I didn't want the script to try to load Unity when I logged into Gnome. But, as usual with linux, with a bit of Googling I came across the key. In X session desktop scripts (which are the main way to start/run programs) you can define which desktop environment they should show up in. This means that when you put the script into the autostart folder (~/.config/autostart) you can mark the script to ... `OnlyShowIn=GNOME;` or `OnlyShowIn=UNITY;` or `NotShowIn=GNOME;` or `NotShowIn=UNITY;`. You can add multiple environments for the desktop script to be shown or hidden in after the semicolons. 

This is helpful for showing or hiding certain programs/scripts in your menus in different desktop environments but also when you put it in the scripts in your autostart folder you can tell linux to only load the programs when you log into certain desktop environments. I tested the script and it didn't work at first. The problem was because gdm wasn't loading Unity, the autoload scripts I marked to only load in Unity weren't triggering. Even though gdm sent me to Unity, the desktop environment wasn't loading correctly. So I had to change the script from `OnlyShowIn=UNITY;` to `NotShowIn=GNOME;`. This meant that when the desktop environment saw that it was not in Shell it triggered the script for Unity. It isn't ideal as the autoload scripts that are linked to Unity don't run *after* the Unity reload script runs, but it is a decent enough work around for the amount that I use Unity (minimal). 

This is very powerful as you usually want Gnome Shell and Unity to load the different sugar packages such as applets, indicators, etc., that help you define the environment you are working in. This is reason 7 million why Linux is awesome. In any event, here's the script I use to reload the Unity desktop after I log into Unity.

```
[Desktop Entry]
Type=Application
Exec=unity
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Unity-Reset
NotShowIn=GNOME;
```

I saved that in ~/.config/autostart and voila all (mostly) working as it should. 

Happy Hacking!

~ # ~