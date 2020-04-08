---
categories:
- legal markdown
comments: true
date: "2013-04-19T00:00:00Z"
summary: Finally had a chance to update my legal markdown package for Sublime. The
  package is built to fill a couple of holes in the system that I use. Click through
  to see the details.
meta: true
published: true
tags:
- legal markdown
- sublime
- pandoc
title: Sublime Legal Markdown Package Updated
---

Finally had a chance to update my [legal markdown package](https://github.com/compleatang/Legal-Markdown-Sublime) for Sublime. The package is built to fill a couple of holes in the system that I use. 

As background, I use Sublime as my main IDE both for coding and for my legal work. I use a word processor, but only to review client documents and to do a final review on documents that I build. All the documents that build, I do so in Sublime. I write regular memos in regular markdown and pandoc them to ODT, double check the formating and output to PDF (and docx if the client needs it) using Libre's [multiformat save extension](http://extensions.libreoffice.org/extension-center/multisave-1). I draft laws, regulations, contracts, and corporate governance documents in `lmd` format, use legal_markdown package to push them (interstitially to normal markdown and then via pandoc) to ODT. 

The system worked fine, but I did have to pull down my [Terra terminal](http://www.webupd8.org/2013/03/terra-terminal-update-brings-improved.html), cd to the proper directory and run the pandoc command -- after converting the `lmd` file in Sublime to normal markdown. So I knew I wanted to combine some of the better aspects of the various pandoc - sublime integrations (there are at least three that I know of) with the legal_markdown preprocessing.

I've now pushed the result. One of the differences in my implementation of pandoc integration (beyond the preprocessing by the legal_markdown gem obviously) is to utilize a document type definitional system. Basically, I wanted to be able to define different output document types and to pre-establish all of the pandoc options for these in my user settings file for the package. Then, when I wanted to export the `lmd` file I just wanted a quick panel to show up where I could choose the export document type and let the package and pandoc take care of adding the correct mix of settings. 

I think it works fine. Basically in the user settings, you add "build-format" keys and for each key you add a document type name (what will show up in the quick panel) key. Then inside this key you add whatever pandoc options you want. There are four main options that the package will use: "from" (pandoc's reader options), "to" (pandoc's writer options), "file-output" (triggers pandoc's -o flag), and "options" (which you can use for general options such as --normalize -S flags which are technically writer options but I think of them as general options). Each of the fields (except for the "file-output" field) should be an array. The "file-output" field should be either "true" or deleted. If it is deleted then the package will replace the currently active buffer with pandoc's output. Usually, for this package's purpose you will almost always want to have it asa true.

Lastly, I wanted the package to automatically open a file for me. In other words when I'm converting a `lmd` file to `odt` I want to switch over to libreoffice to review the file. So the package also adds an optional field to each document type called "open-file-after-build". This field is a simple command that you will call to open the file. The package will fill in the file that is outputted by pandoc after the command. So you **do not** need to type "libreoffice $FILE" into the settings file, you simply need to type "libreoffice" into the settings file and the package will take care of the rest. 

I have not tested the auto open in OSX or Windows so if anyone else has those boxes and can test it, that would be fantastic. I'm happy to work to make it cross platform compatible as much as I can.

Still have a bit more work to go on the package as you can see from the roadmap but it is now one step closer to where I'd like it to be.

Happy Hacking!

~ # ~