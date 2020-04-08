---
categories:
- Linux for Lawyers
comments: true
date: "2014-02-13T00:00:00Z"
summary: Working with PDFs in Linux is not perfect. There is no one program to rule
  them all as Adobe has done with Acrobat in Windows and OSX. But there are good,
  viable solutions which can do almost everything that Acrobat will do.
meta: true
published: true
tags:
- pdfs
- linux
title: Working with PDFs in Linux
---

PDFs are the bane of every lawyer's existence. It is unfortunate that we break free of our addiction to PDFs and this is the thought behind my RMOC project. Until that is a viable option for working with PDFs, here is my suite of **free** PDF tools that can be used in the stead of the overly engineered Acrobat.

## Reading PDFs

Most any distro will contain a PDF reader. By default Ubuntu installs Evince which is lightweight and works as a viewer. Evince still has not implemented any highlight or annotate functions, but that is OK for me since I only use PDFs to read and then copy whatever I need into Sublime Text -- which is where I create 99% of my documents. One of my partners likes to use Okular which has highlighting and annotating features to it. The problem is that Okular runs on KDE a different desktop environment from what I use (Gnome) and Okular does not integrate with GTK (the Gnome Toolkit for Desktop Applications) this means that installing Okular requires a ton of packages that I would never use but for within Okular. In the past I have tried it but have found that -- for me -- it is a too-much solution. Installing Okular is straightforward:

```bash
sudo apt-get install okular
```

Then you are all set to go.

## Extracting PDFs

Sometimes I prefer reading PDFs on Android with [ezPDF Reader](https://play.google.com/store/apps/details?id=udk.android.reader) as its interface is nice. I generally will do this on my tablet. Then I simply save the PDF in my Dropbox which will sync to my desktop. After that, I forked a command line tool (I think from [here](http://blog.hartwork.org/?p=612)) for python which extracts the notes that I added to the document into a command line tool which I can then copy and paste into Sublime.

To use the extractor, you need to have a few packages installed first:

```bash
sudo apt-get install poppler-data poppler-utils python-poppler
```

Then you will need to paste the following script into your ~/.bin folder (or anywhere else that is in your path). I called this ~/.bin/extractpdfs but of course you can call it anything.

```python
#!/usr/bin/env python
#^jist /home/coda/.bin/extractpdfs -u 8666561

import poppler
import sys
import urllib
import os

def main():
  input_filename = sys.argv[1]
    # http://blog.hartwork.org/?p=612
  document = poppler.document_new_from_file('file://%s' % \
    urllib.pathname2url(os.path.abspath(input_filename)), None)
  n_pages = document.get_n_pages()
  all_annots = 0

  for i in range(n_pages):
        page = document.get_page(i)
        annot_mappings = page.get_annot_mapping ()
        num_annots = len(annot_mappings)
        if num_annots > 0:
            for annot_mapping in annot_mappings:
                if  annot_mapping.annot.get_annot_type().value_name != 'POPPLER_ANNOT_LINK':
                    all_annots += 1
                    #print 'page: {0:3}, {1:10}, type: {2:10}, content: {3}'.format(i+1, annot_mapping.annot.get_modified(), annot_mapping.annot.get_annot_type().value_nick, annot_mapping.annot.get_contents())
                    print 'page: {0:3}: {3}'.format(i+1, annot_mapping.annot.get_modified(), annot_mapping.annot.get_annot_type().value_nick, annot_mapping.annot.get_contents())

  if all_annots > 0:
    print str(all_annots) + " annotation(s) found"
  else:
    print "no annotations found"

if __name__ == "__main__":
    main()
```

If you just want to use the script as is then you can simply call the following from the command line.

```bash
wget -O $FILE https://gist.github.com/compleatang/8666561/raw/79ee25d3d1a4c6f1ed7c0e9de1db951d947e3b17/extractpdfs
```

What this script does is to extract the annotations into a text output on the command line. I could not figure out how to extract the highlights because of the weird way that highlighting works and because poppler is not currently set up for that. There is a ruby gem called pdf-reader that I have worked with a bit that I *think* would work for extracting highlights but I have not had the time to work with it in detail.

The output of calling the `extractpdfs $PDF_FILE` will look something like this:

page:  24: why did she not want to go thru her records...?
page:  26: make a chart detailing her claims, his payments, and the amounts she says she is borrowing?
page:  28: use this figure as illustrative for making the chart.
page:  31: fix this.

## OCR-ing PDFs

When you get actual paper the first thing most lawyers *should* do is to scan and OCR (optical character recognition -- or make the scan so that you can search and copy and paste the text) the document. I use gscan2pdf to do this. It is a straight forward gui application what will ocr and clean up your pdf documents.

```bash
sudo apt-get install gscan2pdf
```

I have used a lot of the OCR gui's available for Ubuntu and for my money gscan is the best. Cleaning up PDFs and OCRing them is just a click or two away.

The difficulty that sometimes arises is that open source OCR technology is quite a bit behind proprietary technology. On Windows there are a couple of really good OCR technologies and on OSX there are also, but those vendors ignore Linux for the most part. Given how much I use OCR I would happily pay for a Linux native solution which is not Abby's per page basis, but I have not found one that I believe will work for me. So for now, I am left with the open source solutions. Gscan will integrate with the major OCR technologies on Linux and when you go to OCR your document you can choose which one you want to use. It will not be perfect, especially if you have a bad scane, but it will be a decent 80% solution that is 100% free.

## Modifying PDFs

Splitting PDFs, combining PDFs, deleting pages from PDFs, rearranging PDFs is most simple on Linux than it is with Adobe if you ask me. I use a great package called pdfmod which lets me do all of these things.

```bash
sudo apt-get install pdfmod
```

Once you have it installed it is very straightforward to split, combine, delete pages, add pages, and rearrange pages in your PDFs. Basically the package does just what you want it to do, you can drag and drop all the pages to correctly order your PDF's; you can drag in pages from other windows; you can click on pages and press delete to remove them. It is very straight forward.

## Summary

Working with PDFs in Linux is not 100% ideal and the programs to work with PDFs are not cohesive as you may get with Adobe in windows or osx. However, it is imminently manageable with some combination of Evince, Gscan2PDF and PdfMod you can get to almost a complete solution.

Happy Hacking!

~ # ~