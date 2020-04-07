---
categories:
- virtual automatic contracts
comments: true
date: "2014-04-09T00:00:00Z"
excerpt: Last night I gave a talk at the Amsterdam Ethereum Meetup. Here are my prepared
  notes. I did not cover all these topics, but the majority of them I covered in the
  talk.
meta: true
published: true
tags:
- ethereum
- virtual automatic contracts
title: Iterating over the Traditional - Legal Approaches to Smart Contract Development
---

## Audio Talk is Here

<iframe width="800" height="450" src="//www.youtube.com/embed/wnFqOfR5a7I" frameborder="0" allowfullscreen></iframe>

## Introduction

![slide 1]({{ site.url }}{{ site.root }}{{ site.images_dir }}/{{ page.date | date: "%Y" }}/ethereum-talk-slides-1.png)

### Who am I?

My name is Casey Kuhlman and I'm an American lawyer. Currently, I'm running a small law firm with our headquarters in Somalia. In particular, we work mainly in the north of Somalia which is a self-declared independent state of Somaliland. I've been in Somaliland for coming up on six years now and my practice has a wide focus on law building, corporate governance work, compliance work, and corporate transactions. For the past few years I have spent most of my time building, reviewing, negotiating, and amending contracts for clients which range from international organizations to international NGOs to international companies all the way down to individuals. I live in Somaliland for some of the year and I live here in Holland for some of the year because my wife is also a lawyer and she works down at the International Criminal Court in the Hague. At this point, part of our business is continuing in the Somali region and another portion of our business is starting to work with clients in the blockchain sector to develop systems of contracts and the like.

I first became interested in blockchain technology last summer when the main money transmitter company in the Somali region faced a threat that their bank account in the UK with Barclays was going to be closed due to compliance concerns within Barclays. If that company would have closed its operations, that would have drastically affected our business. We have an incorporated entity in the US which allows us to receive wire transfers to our US bank account and then we transmit those to our headquarters in Somaliland via this money transfer company so that we can pay our operating expenses. That concern led me to some of the thought documents about the (currently latent) power of blockchain technology to reduce remittance expenses. Over time, it was probably inevitable that when Ethereum started percolating through the community that I would become interested.

### What is this talk about?

What I'm here to talk about today is how Ethereum looks from the eyes of one lawyer who works in a place which many would say has an immature rule of law. I would not necessarily say that, but it has been said by others many times that the Somali region is a libertarian's paradise.

It seems to me that it should be a testament to the power of the Ethereum idea at how much community involvement there has been in this idea. That is utterly fantastic. However, within any community there must be a balance of different perspectives. To date, it seems from my persective that we have a great amount of developer interest in Ethereum. Indeed, how many here tonight would identify as developers? And how many would identify as lawyers? And how many would identify as both? That is more or less what I expected after reviewing the RSVP list on the meetup site. So this talk is meant to somewhat balance the perspectives and provide one lawyer's perspective.

### The BareBones of It All.

One of the things which I like best about living in a developing country is that it strips away most of the superficial layers in the systems which run our modern world. I have had the chance to learn about environmental interference with microwave transmission of internet data because when our internet goes down I want to know why. I have learned about supply line resiliency when I buy a gas cooker but the ship bringing a year's supply of gas sinks in the harbor because it hasn't been dredged in however many years.

All these systems which we take for granted in more developed countries, systems which just work, we do not often have a reason to learn about them. But in developing countries when there is a shock to a system which that system is not resilient to, then you have to learn about the system when you have to cook with deforesting charcoal instead of efficient gas.

The same thing has applied to my law practice. I am forced in my daily practice to strip back all of the superficial layers of the legal systems which I originally learned about and dig into the mechanics of the system to find what works and what does not.

So in this talk, I have tried to distill out three rules which I always think through (maybe not always consciously) when I am building, reviewing, or negotiating contracts. Along the way I'm hoping to be able to point out why I am very excited for the future of blockchain technology, and especially the smart contracts ecosystem which the Ethereum community is building.

## Rule 1: Use Your Funnels

![slide 2]({{ site.url }}{{ site.root }}{{ site.images_dir }}/{{ page.date | date: "%Y" }}/ethereum-talk-slides-2.png)

Developers understand stacks, so let us start with a stack in the software engineering sense of that word. In a stack you have:

* software that moves around memory references and does other fundamental things very close to a processor's core;
* software higher up in the stack that makes information so that it can be added, modified, and changed;
* and software higher up in the stack still that makes things look pretty.

Developers work on different portions of the stack at different times in order to accomplish different things.

In law we also have a stack, but I think it is better to think in terms of a funnel than a stack. In a legal funnel you have:

* things which prohibit certain actions
* things which compel certain actions

If we were to plot these "things" as a measure of the AMOUNT of actions they can PROHIBIT or COMPEL against the SPECIFICITY of those actions then we would build a graph that looks like this:

![not the greatest diagram I've ever created]({{ site.url }}{{ site.root }}{{ site.images_dir }}/{{ page.date | date: "%Y" }}/ethereum-talk-funnel.png)

When we think about building a contract we have to internally build this funnel for ourselves. Part of this funnel, the part I call the COMPLIANCE FUNNEL is out of our control as the parties to an individual contract. Those things are required by living or operating in a certain geographical jurisdiction and|or by operating in a particular sector. The rest of this funnel, the part I call the CONTRACTING FUNNEL is in our control.

The proportion of the entire funnel which is a compliance funnel and which is a contracting funnel will differ based on time, geography, and subject matter.

### Why Funnels Help?

These funnels help us build contracts because they allow us to write fewer words. Think through in your favorite programming language the first time that someone coded a web server for that language. Unless it is an ultramodern language which had web services in a 0.0.1 release, it is likely that the first time a webserver was built in the language that it contained a huge amount of code. And the second time it was built it was able to use some functionality from some sort of a standard library. And the third time it was built it was able to use some functionality from a low level, third-party library built on top of the standard library. And eventually we have a situation where frameworks, low level, and standard libraries all work together so that I can say:

```ruby
require 'sinatra'
require 'haml'

get '/' do
  haml :index
end
```

For those that do not know, this is a very simple web application using Ruby's Sinatra framework. Underneath these five lines of code are an entire framework of code, from Sinatra, from other third party libraries, and from Ruby's Standard Library that allow me to have a web application in five lines of code.

Funnels are like that. They allow us lawyers to develop contracts with less "code" than if we needed to code the entire stack. The first person who "coded" an employment contract had to build out tons of if|then statements into the contract. Over time, as employment laws and commercial norms develop those two areas can reduce the length and complexity of any individual contract because that individual contract is able to rely upon the standards from the law and commercial norms just as a Sinatra application relies on the stack developed by the framework.

### Why is This Important for Ethereum?

The first thing I want to point out is that while many lawyers and clients tend to want to "avoid" laws, they do provide a valid function -- just as frameworks do in the coding world. This function simplifies the nature of specific contract building greatly. Ethereum gives us a chance to re-envision our commercial relationship with "the law". In a way which is not currently possible in the "real world".

The second thing I want to point out is that Ethereum gives us an opportunity to develop, test, and perfect different ideas of how contracts and relationships (which I'm going to talk a bit more about in a minute) should work. If I want to develop a dynamic web application I have a vast array of choices. Do I want to do it in: Node, Ruby, Python, PHP, .Net? Do I want to do it in Express, Sinatra, Twisted, Wordpress, Drupal, or some other framework? All of these choices are there and available for me to use. They all have their proclivities, predilictions, advantages, and disadvantages. I choose which is best for me, program on top of it and try to use its advantages while minimizing its disadvantages. I see Ethereum playing out in a similar way where different legal ideas, norms, and contractual structures are held either off the blockchain in open source repositories or on the blockchain.

The third thing I want to point out is that in order for Ethereum to be able to leverage frameworks, contracts on the blockchain will need to be able to operate together in a fundamental way while contracts residing off the blockchain in open source repositories can have their own way of interacting with each other. So when we think through what should be on the blockchain or off the blockchain in repositories it is important to think through this. It is like the difference between referencing a Google hosted jQuery library where I only need to specify a particular version and using a node library which I will need to connect to an API and perhaps another point.

![slide 3]({{ site.url }}{{ site.root }}{{ site.images_dir }}/{{ page.date | date: "%Y" }}/ethereum-talk-slides-3.png)

## Rule 2: Keep Contracts Social

At their core contracts are a set of rules that provide for an interaction between different entities with divergent goals, capabilities, and resources. Building contracts, as with coding, is both an art and a science. The science part of contracting is largely making sure that for this particular instance that the funnel is properly aligned and the contract is built so that the funnel is workable. The social side of contracting is predominantly where the art comes into play.

![slide 4]({{ site.url }}{{ site.root }}{{ site.images_dir }}/{{ page.date | date: "%Y" }}/ethereum-talk-slides-4.png)

As I said, I work in Somalia and Somaliland much of the time. There we have a predominance of oral agreements. I am not a fan of oral agreements, but I have come to respect their cost effective nature. The reason that I have a problem with oral agreements is that they suffer from a memory bias and are not precise.

Written contracts, on the other hand are a way to balance precision against many other concerns which exist within complex social systems. Written contracts give us an ability to have both precision and individuality in the face of complexity. This is a powerful idea when you think about it.

One of the challenges for contract developers in the traditional contract development space is how do we work through the interests and incentives of the parties to craft a contract which is designed to succeed while also providing our clients with appropriate safeguards in cases where it does not succeed.

Most contracts, most of the time, are not breached. And those that are breached are often breached in a way which does not require a court to enforce. It is only a minuscule amount of contracts which have to go to court in order to be enforced.

Why? Well, I suspect that for most people most of the time, that when they agree to do something they will follow through on that or will be prepared to face the consequences for not following through on that promise. We are social creatures and it makes sense in a social construct that our promises will be vital for our future ability to conduct whatever activities we want to conduct.

Because of our nature inclination to think that we will follow through on our promises, we tend to not even want to have specific breach clauses in our contracts. In my own practice, when I ask people why they have gone into a multimillion dollar business with only an oral agreement this is what I'm often told. That trust is so vital to the daily workings of the business and demanding or requesting a written contract at the beginning would start the venture off on the wrong foot. My clients who work in the more developed world understand that trust is all well and good but it is also good to work through the process of building a written contract for the venture.

This topic is one area in which I may differ from many in who are also into blockchain technology because I feel that trust between individual humans is something to be lauded not to be avoided. While I understand fully the reasoning behind the trust-less movement, I think that organizations work best when there are trust-less backstops in combination with trust between individual actors within the organization. I agree with those who advocate for less trust within the system that having tension within the system is good because it forces the system to be adapted to diverse parties. However, I feel that tension within the system can easily become friction within the system if the contract is not properly designed.

In my opinion, this is one of the most difficult areas which the Ethereum community will need to work out. My main concerns with respect to keeping contracts social if they live on the blockchain are:

Verifying offer and acceptance should be integral to the process. As I understand it right now, contracts seem to be deployable to the blockchain based on only one party. That is a unilateral agreement, which is fine, but it is something that we should look at carefully because unilateral agreements have difficulties. Unilateral agreements can work, but they do not work as well as contracts which are bilateral or multilateral agreements between entities -- each of which maintaining its own position. Certainly Ethereum contracts can be designed as multilateral contracts, but the default setting of Ethereum contracts -- at this point -- is essentially unilateral. If the blockchain defaulted to multisignature deployment and allowed single signatory deployment of contracts to the blockchain, I would be much more comfortable than the current situation. From a legal point of view this will be difficult in the real world which mostly requires affirmative showing of both an offer and acceptance in order to have a valid contract. In the real world we do this by drafting, reviewing, and signing contracts. But, the contracts that I've seen on Ethereum are not currently designed in this way. In my opinion this is an area which should be a core part of the protocol rather than left to contract designers because it is utterly fundamental.

On the other side of the coin, Ethereum will allow us as a community to design different interactivity points which can provide a trust-less base but also develop trust by the community involved in the contract. For example, the concepts of DAO's are likely, if properly conceived and structured, to really build real trust within a community. The automatic administration of contracts which can redistribute value within a network are a way to build trust within the humans in the network because of the automatic way in which smart contracts will work.

One of the most exciting aspects of Ethereum is that the nature of how contracts are administered (which I prefer over the more difficult word enforce) is most advantageous when there is a simple transfer of value. Since contracts can only live on the blockchain and talk to other contracts on the blockchain and/or transmit value within entities on the blockchain, this constrains how contract designers think through incentives and outcomes. I'm hopeful that by constraining how contracts are administered and by opening up the funnels, that a variety of new incentive structures with different outcomes can be crafted. This could allow for a great expansion of innovation within contracting which is relatively stagnate and where innovation amounts to using word A instead of word B rather than fundamentally looking at incentives, outcomes, and parties to realign interactions between entities in different and interesting ways.

![slide 5]({{ site.url }}{{ site.root }}{{ site.images_dir }}/{{ page.date | date: "%Y" }}/ethereum-talk-slides-5.png)

## Rule 3: Define the Decision Space

This rule is often overlooked by professional contract lawyers, and I think that is to their detriment. This applies to all contracts, but it is more interesting to think about in the terms of multilateral contracts -- in particular organizational governance contracts. What do I mean by decision spaces? I tend to think of organizations in terms of ven diagrams of duties. Each individual node within the organization has particular duties which are unique to that individual node and also most nodes will have duties which are shared with other nodes.

![slide 6]({{ site.url }}{{ site.root }}{{ site.images_dir }}/{{ page.date | date: "%Y" }}/ethereum-talk-slides-6.png)

In traditional contracting these decision spaces are used to define what, for example, a board does vis a vis what the managers do vis a vis what the shareholders do. It works with many other types of contracts as well and I almost always keep this in mind when I'm reviewing or drafting any type of contract.

This is the area among these three topics where I think that Ethereum will be the most transformative. At this point the decision space concept is not very well defined where it likely should be, for example in employment or consulting contracts. Mostly these contracts have an overview of the decision space allocation between the parties which lacks specifics. In traditional contracts this is needed so that the lawyers to not have to do an amendment to the contract. But in Ethereum changes to decision spaces will likely be nominal. Because contracts can be linked together you can have events -- such as a new department built, or a new hire for a new position, or a change in by laws -- which will be events that can "bubble up through the DOM" of the organization.

![slide 7]({{ site.url }}{{ site.root }}{{ site.images_dir }}/{{ page.date | date: "%Y" }}/ethereum-talk-slides-7.png)

## Conclusion

In conclusion, I just wanted to say that although many lawyers get a bad name and that many people have had bad experiences with lawyers that not all of us are jerks. Some lawyers, indeed, are jerks, but Internet Explorer 6 was a jerk of a program. This is important because those of us lawyers who have been doing contracts for a while should be participating in the development of the Ethereum ecosystem by bringing to the table the lessons that we've learned along the way. This has been my entry into that lexicon by laying out three rules which I always try to keep in mind when I'm working with any contract: use your funnels, keep contracts social, and define the decision space.

Happy Hacking!

~ # ~