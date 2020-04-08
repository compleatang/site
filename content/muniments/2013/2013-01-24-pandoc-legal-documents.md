---
categories:
- legal markdown
comments: true
date: "2013-01-24T00:00:00Z"
summary: Lately, I have been writing a lot in markdown. It is a freeing way to write
  documents because you focus more on the words than the tools around you in the wordprocessing
  interface. You pick your favorite environment to write -- for me it is Sublime Text
  -- and then you write. But, clients and courts do not read Github Flavored Markdown.
meta: true
published: true
tags:
- legal markdown
- thoughts
title: Pandoc for Legal Documents
---

Lately, I have been writing a lot in markdown. It is a freeing way to write documents because you focus more on the words than the tools around you in the wordprocessing interface. You pick your favorite environment to write -- for me it is Sublime Text -- and then you write. But, clients and courts do not read Github Flavored Markdown. 

This is where [Pandoc](http://johnmacfarlane.net/pandoc/index.html) comes into play. Pandoc is one of the many markdown renderers / translators available. You can think of it like a swiss army knife for changing document types. The thing that makes Pandoc quite interesting, for my purposes as a lawyer, is that it when you translate your markdown into an .odt file (or .docx for those who like completely bloated, prorietary things) you can establish exactly how the end document will look. 

What you do is first output some markdown text into an .odt file. Then you go into LibreOffice and modify the styles so that they are appropriate. I have templates setup for most of the documents I create and I simply linked the main styles that I use in my markdown to the ones in the template .ott files. I created multiple Pandoc .odt templates (which Pandoc calls reference files) to more or less mirror my .ott files. 

In Sublime, I [forked](https://github.com/compleatang/sublimetext-Pandoc) the excellent Pandoc plugin to modify it so that I could build custom templates and added a few other goodies so that Pandoc would play nicer with .odt files (which were not included in the original version). Using the forked Pandoc plugin I can simply output my markdown files to the appropriate reference file. I use the SideBarEnhancements plugin to right click on the newly created .odt and open in Libre to finalize everything. Mainly this entails dropping in my citations from Zotero and making sure that the styling is fine and everything is looking as it should. Save the new .odt file in GDrive. Output the .pdf to GDrive. Close the task on Teambox. Email the client. Done. 

One of the most annoying things about using a wordprocesser and doing research is the new lines that pdf copy places on your clipboard. Since Python is a relatively straightforward language and not *that* different from Ruby for simple text manipulation, and since Sublime offers a very easy to understand API, it was quite easy -- even for a beginner such as I -- to [build a plugin](https://github.com/compleatang/sublimetext-pastepdf) that will allow me to ctrl+alt+v and thus strip the newlines so that the text block pastes as a single text block. 

Because Pandoc has inline footnoting, when I'm writing I simply drop in a marker quickly where I need to reference things. When Pandoc translates the markdown into an .odt file it builds the footnotes with the markers I need (usually pinpoints). Then I can simply inserting the citations from Zotero. When I was doing some research the other day I realized that FastCase does not have a translator for Zotero so I started working on one. It will be coming soon. And more about integrating Zotero and LibreOffice for legal research will accompany that. 

For legal documents, particularly client focused documents, you don't really need that much formatting. Indeed the less the better. Really you need only a handfull of styles within the document. Using a system such as this to force the proper styling techniques you can easily roll branding rules for your small firm and also let lawyers focus on the text rather than another Format Paste. 

Admitedly, collaboration is still imperfect. A huge percentage of lawyers still are on Word and so the .doc and .docx formats and awful Calibri are not going away anytime soon. There is no simple way, when you need to track changes and integrate comments into a document, to utilize some of the tools that make writing so much more enjoyable on a text processor. Luckily, however, using these techniques allows me to limit my time in a word processor -- even a quite nice one like LibreOffice. 

~ # ~