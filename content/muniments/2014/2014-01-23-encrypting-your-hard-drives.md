---
categories:
- Linux for Lawyers
comments: true
date: "2014-01-23T00:00:00Z"
summary: On why Linux is grand -- this post discusses why you should encrypt your
  hard drives.
meta: true
published: true
tags:
- linux
- encryption
title: Linux 4 Lawyers -- Encrypting your hard drives
---

I encrypt my hard drives because it is the right thing to do. I don't need an ethics opinion from my bar association to understand that it is a bad thing to have a bunch of client stuff on an unencrypted drive that is constantly moving around.

\[WAIT, what're you talking about?\]

OK. So let us take a step back. There are a bunch of ways in which you can secure data. There are physical security measures like having a guard at your office, keeping computers in safes, chaining computers to desks and other such physical security measures. I'm not going to talk about those as they do not apply to anyone I know. I hope the data center which hosts my servers have some of them, but for most normal lawyers these are overkill.

There are also non-physical security measures like putting a password on a file, on a directory, or on your operating system. All of these are well and good, but here is the dirty little secret that most people don't really know -- if someone gets access to your hard drive they can still get at a lot of that data. If someone has physical access to your hard drive then they can simply mount it onto their computer. Once your hard drive is mounted onto their system then the password from your OS and most of your other non-physical security measures are mooted by the fact that they will have root access to your hard drive.

The easiest way to solve this problem is to encrypt your entire drive (or a partition). In Ubuntu, this is super simple. All you have to do is to tell Ubuntu to encrypt the entire drive when you are running the install script for Ubuntu. Voila. Totally encrypted drive.

Personally I use one password for the encryption unlock which is *only* used for this purpose. I use a separate password for my OS login; I use neither of these passwords anywhere else on the internet. Indeed, these are the only two passwords which I really need to remember. The remainder of my passwords live in a KeePass database which in turn resides in my Dropbox account. They are all very long and very arbitrary which keeps them as secure as possible. I change them frequently and use two-step authentication everywhere I can. Yet none of that would matter if I did not have my hard drive encrypted and someone gained possession of my hard drive. Then all of my client data would be completely compromised and there is nothing I could do about it.

I am sure that Windows and OSX have solutions for this as well. I'm also sure that neither is nearly as easy as it is on Ubuntu. Linux guys get security in a way that others don't. So whatever OS you are on, encrypt your hard drives and make sure that you can remote wipe any phones or tablets (which Android makes very easy and I'm sure iOS does as well).

Happy Hacking.

~ # ~