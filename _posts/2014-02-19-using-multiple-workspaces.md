---

layout:    post
title:     How I Use Multiple Workspaces
published: true
comments:  true
meta:      true
category:  Linux for Lawyers
tags:      [linux, gnome, workspaces]
excerpt:   "Multiple workspaces took me some getting used to, but now I find them indispensable. Here's how I use them."

---

When I first moved to Linux from Windows in Ubuntu 11.10, I was confused about multiple workspaces. I thought, coming from a Windows background, that they would be overkill and require significant resources from my very old at that time laptop. My laptop then was about a 5 year old Dell that Windows Vista barely worked on. One of the huge reasons I decided to try Linux at all was the way that it was reported to be able to handle older hardware with style and grace. That said, I am always paranoid about what processes are running at any time and have for years always kept a close eye on system resource allocation (like since about Windows 3 years). Apps which are resource hogs get uninstalled or somehow sandboxed. Apps which I do not think I will need regularly get uninstalled with a vengeance. OS components I do not want get uninstalled -- to the extent the OS will still work if I uninstall them.

Coming from a Windows background, and being generally a fairly linear unitask thinker, I failed to see the benefit in multiple workspaces. I tend to keep only a few applications opened at any one time in Windows so why would I need multiple workspaces I thought. Then I installed my first version of Gnome Shell.

One of Gnome Shell's biggest achievements as far as I'm concerned is dynamic workspaces. The basic idea is that the desktop system creates one workspace and then if you need additional ones you can either open an application in that workspace (more on this in a moment) or you can move an application to a new workspace. The desktop system will automatically create and delete workspaces based on what you are using at any one time. It is a clutter killer (which I adore) but also extraordinarily functional.

## Workspaces for Different Portions of the Computing Brain

I have -- for the most part -- quadroned off how I interact with my computer into a quadrons.

1. The first quadron is my terminal workspace. I use Guake and have written about my terminal setup [here](http://coda.caseykuhlman.com//entries/2014/on-shells.html). Guake is not its own workspace, as it resides "above" all my workspaces and whenever I need it, it is a simple `F12` away. In this quadron is where I install, uninstall apps, generally work "on" my computer.
2. The second quadron is my media workspace. This is generally my workspace number 3 (or my bottom workspace in Gnome's vertical configuration of workspaces). I have set up all my media players to open in this window. So from my primary workspace I simply slide down two workspaces if I want to change the album that is playing or do something that I cannot easily do from either media keys or the panel in Gnome.
3. The third quadron is my reference workspace. This is the workspace where I keep all the things that I need on a regular basis but do not want cluttering my primary workspace. This is the first workspace below my primary workspace. These are, for the most part, Chrome windows which I open as `--apps` which allows me to open them with no decoration (which are nothing but wasted pixels if I only want to see what X site says). In this workspace I traditionally keep open four Chrome windows: [Evernote](https://evernote.com/); my Google Calendar; my Google Drive; and my [Redbooth](https://redbooth.com). Evernote is my filing cabinet more or less and I use it for tons of different things. They have been quite public that they will not make a desktop application for Linux (which I would use relentlessly) but their web app is not bad. It used to be a resource hog but has improved (or else my new laptop is just better able to handle it). Redbooth is the Project Management Interface we use at Watershed for years now. It handles all our tasks, etc. so I need to have this open. We use Google Drive a lot for Watershed so it is helpful to see the feed rather than simply using a file browser as the feed gives me a view of what attorneys are working on quickly. With the exception of Evernote, I'm quite happy keeping these as webapps. Even when I'm in Somaliland where bandwidth is limited, all of these webapps are extremely efficient in their bandwidth usage so once they are loaded they simply Ajax call their way through the day which saves me bandwidth and also still let's me keep everything in sync.
4. The fourth quadron is my primary workspace. Unless I'm deep in work on a complex task requiring multiple pdf windows or something, I keep two applications running in this workspace. I keep my primary chrome window here which always has my personal and work gmails up and whatever else I happen to be reading or writing or working on in Chrome. I also keep my Sublime window open at all times. I code in Sublime, write memos in Sublime, draft contracts in Sublime, draft laws in Sublime, generally Sublime is my "work" hub for documents. If I need to open pdf or doc or odt files I generally will pull them up from Sublime rather than opening a file browser.

## Keyboard Shortcuts for Workspace Bliss

Keyboard shortcuts. Oh how I love them. So easy to setup. Go to Keyboard in your Applications menu and then click on Shortcuts. For workspace and windows stuff, go to the Navigation sub-tab. Here's the shortcuts I use:

* Move window one workspace down: Alt+Super+Up
* Move window one workspace up: Alt+Super+Down
* Move to workspace up: Ctrl+Super+Up
* Move to workspace down: Ctrl+Super+Down

That's It! That is really all you need. Move a window up or down, and move your viewer up or down. While you are in here, do yourself a favour and go to Custom Shortcuts, Add a Shortcut, nautilus (as the command), Super+E (or whatever shortcut you fancy). Now you are a shortcut away from your file browser no matter where you are.

## Automatic Workspace Management

I lurve automating things. With Gnome Shell it is very easy to ensure that (most) of my windows open in the specific place that I want them to. Gnome Shell extensions are lovely little applets which open up the possibilities of what you can do with your desktop. I should publish a list of the ones I use, but for now, only this [one](https://extensions.gnome.org/extension/16/auto-move-windows/) is relevant. It is an extension which automatically moves windows to a specific workspace. That's it. So whenever I open Spotify, I have set it to open in Workspace 3. Boom! Just that simple. To set up the extensions you will need to have gnome-tweak-tool installed:

```bash
$ sudo apt-get install gnome-tweak-tool
```

Then you go to the above link and push the button to install. After that open tweak and go to the Extensions tab to turn it on. You can also go to "Installed Extensions" in the gnome extensions site to turn on extensions, but generally Tweak Tool is better. Also there will be a link in Tweak Tool Extensions tab to the Extension settings. Click there. Then you will see a place to "Add rule" click there, then click the program you want and the workspace you want.

If you prefer the old school version (as I do) then you can use dconf tool.

```bash
$ sudo apt-get install dconf-editor
```

Then from dconf you go to: `org -> gnome -> shell -> extensions -> auto-move-windows`. Once you get there then you type in the correct APPLICATION.desktop file and the workspace. So the string should look something like this: `['spotify.desktop:3', 'xnoise.desktop:3']`. That's it. Then whenever you open the application it will open in the correct place.

Happy Hacking!

~ # ~