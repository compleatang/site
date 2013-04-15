---

layout:    post
title:     My (Current) Transactional Documents Work Flow
published: true
category:  legal markdown
tags:      [legal markdown, thoughts]
excerpt:   "This is an outline of my basic workflow, as of the date of this article and mostly for posterity's sake. There isn't much to it really, but it greatly depends on if I'm writing a memo or building a contract (my, and probably every other transactional attorney's, most frequent tasks). This post will cover my basic workflow when I'm building contracts."
comments:  true
meta:      true

---

While it varies, I generally will have two meetings with a client before I will build the initial draft of the contract. 

In the first meeting, I will try to ferret out what the client is trying to achieve. This is generally an overview meeting. Mostly, Somalis do not like doing too much in any one meeting -- especially if they do not know you well. So I try to keep the goals of what I need to achieve in these meetings realistic and limited. During this meeting, I try to give them an idea of in which direction we are likely to take the transaction in terms of what types of contract(s) are going to be involved to facilitate and integrate the transaction. I also usually try to give the client a few of the key, and usually poignant, decisions that they will have to make so that they can mull it over between the first and second meetings.

In the second meeting, I will ask a lot more specific questions. This meeting is all about the details. Prior to the meeting I will have planned out the transaction documents and forked the appropriate templates of whatever documents will be required for the transaction. I use the specific forks of the primary templates as the basis of my checklist for the transaction. This is easy when building templates in legal_markdown form and sublime. I have been building (but haven't open sourced it yet) a small script that automates this process for me. In my contract templates I just type `...?ASK?...` or `...?CONFIRM?...` and then the script finds these and builds them into a checklist specific to the transaction. 

I know a lot of transactional attorneys like to build checklists based on the type of transaction. I have a few of those, but I find that usually I spend more time deleting irrelevant items and overall they are inefficient for me. I prefer to build questions into my document templates and then to build my checklist for the transaction based on the document templates that I'm going to use. 

For example, this week I've been working on two different joint venture agreements. They are very different from one another and are based on two different templates (one of which is a fork of the main JV template that I have built). For me, it is more efficient to pull my checklists from each of the templates than it would be to fork a main joint venture checklist and then adapt that for each type of transaction. 

> In other words, the key is to integrate your checklist building with your template building. This has many distinct advantages, not the least of which are precision and efficiency. 

The script that builds the checklists for me in sublime produces a list of questions. These provide me with the base the agenda of the second, more detail oriented, meeting with the client. Usually I print the checklist as I find that Somalis usually find a screen in the room either disrespectful or disorienting. So I usually just write my answers on the printed checklist. 

After that second meeting, I build the first drafts of the documents necessary for the transaction. As I said earlier, I build my templates into a main repo and then fork the necessary templates from the main repo into the repo for the client. When I build templates I fill them with mixins, optional clauses, and questions. All I have to do after the second meeting is to fill in the answers to the questions that I have by replacing all the `...?QUESTIONS?...` with the answers. Usually this just means filling in the YAML front matter of the template. 

Once I have finished answering the questions, entering the mixins and selecting or deselecting the optional clauses (all of which I do in the YAML front matter), I simply save the legal_markdown file && pandoc it based on my contract template .odt. Then I open the .odt in libreoffice where I do a final read through of the contract, tweak the styles if necessary, and save as .pdf / .doc / .odt or whatever the client needs to review the document. All of these steps (minus the final review in libreoffice) I perform from sublime. I build the templates there, I massage the YAML front matter there, I pandoc from there, and I open the .odt file from there. It is basically a full scale contracts IDE for me. 

After the client has reviewed the documents I will sometimes edit in Sublime, but if the changes are marginal then I find it more efficient to make the changes in Libreoffice and voila. Done. 