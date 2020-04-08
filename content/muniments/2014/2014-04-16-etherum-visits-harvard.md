---
categories:
- virtual automatic contracts
comments: true
date: "2014-04-16T00:00:00Z"
summary: My reactions to Ethereum's unveiling at a bastion of American legal and technological
  thought.
meta: true
published: true
tags:
- virtual contracts
- virtual currency
title: What the Esteemed (and Very Smart) Law Professors Missed at the HLS Ethereum
  Talk
---

## Introduction

Yesterday a [very interesting event](http://cyber.law.harvard.edu/events/luncheon/2014/04/difilippi) happened. And I had the pleasure to listen in. [Primavera De Filippi](https://cyber.law.harvard.edu/people/pdefilippi) talked [Ethereum](https://ethereum.org) at a Berkman luncheon.

For those who do not know Berkman is a center at Harvard University. For those who do not know Harvard, welcome to earth. Berkman is officially the Berkman Center for Internet and Society. It is a joint research center housed in Harvard's Law School with the following mission:

> The Berkman Center's mission is to explore and understand cyberspace; to study its development, dynamics, norms, and standards; and to assess the need or lack thereof for laws and sanctions. We are a research center, premised on the observation that what we seek to learn is not already recorded. Our method is to build out into cyberspace, record data as we go, self-study, and share. Our mode is entrepreneurial nonprofit.

For more, see [here](https://cyber.law.harvard.edu/about).

Primavera's talk had a lovely title, `Ethereum: Freenet or Skynet?` and it really was a bit of an exploration of the ideas underlying this topic. Primavera first popped up on my radar on the Ethereum Skype group a couple of weeks ago, and I have read [some](http://www.wired.com/2014/03/decentralized-applications-built-bitcoin-great-except-whos-responsible-outcomes/) of [her work](http://www.wired.com/2014/01/its-time-to-take-mesh-networks-seriously-and-not-just-for-the-reasons-you-think/) on Wired, which I would highly recommend. 

Her talk involved a quite fair introduction to Ethereum and what the community is trying to build. What was most interesting about listening to the live audio stream of the event was the questions which were asked by the Professors, researchers, and whomever else was in the room. The video of the talk is online and I would definitely encourage anyone within the Ethereum community to take a listen. 

For those who are not familiar with it, Ethereum is a decentralized blockchain network (similar in nature, but distinct from, Bitcoin). Ethereum is touted as a mechanism which allows developers|lawyers to develop and deploy smart contracts which operate autonomously. Officially, there is the Ethereum boilerplate:

> Ethereum is a platform and a programming language that makes it possible for any developer to build and publish next-generation distributed applications. Ether, Ethereum's internal currency, powers its applications and acts as a 'token of exchange' on the decentralized network. Ethereum can be used to codify, decentralize, secure and trade just about anything: voting, domain names, financial exchanges, crowdfunding, company governance, contracts and agreements of most kind, intellectual property, and even smart property thanks to hardware integration.

I had specific reactions to three of the veins of questioning which were raised during the question section of the discussion. 

## Enforcement or Administration?

A great proportion of the questions had to due with enforcement. And most of these questions sort of miss the point. This is exactly why I recommended at my previous talk that the Ethereum community does a slight pivot from the self-enforcing contracts verbiage to self-administering contracts. Enforcement is a term which gets lawyers all aflutter -- and rightly so. 

Ethereum could never really be self-enforcing until its blockchain becomes ubiquitous. Perhaps then it could be actually self-enforcing, but until such a time the limitations of the Ethereum blockchain mean that there is not actually much that Ethereum could do outside the context of the blockchain. Indeed, to a lawyer, enforcement connotes outside intervention in a private transaction. While Ethereum could build such things as Judges as a Service (JaaS...? A term, perhaps coined by [Joris Bontje](https://twitter.com/mids106)) which would have outside determinative impact of a smart contract, those systems would not actually do the enforcing. They would predominantly do the interpretation. JaaS *will indeed* have a dramatic impact on such an ecosystem, but the main roles which such services would play would be to interpret whether real world events met the metrics established in the proof of work, proof of effort, or proof of XYZ that are contained within the smart contract's algorithm.

Indeed, we are a way from this:

This pedantic difference between the term "enforcement" and the term "administration" to lawyers is mostly why I prefer the latter to the former. Indeed, it is not only the isolation of the Ethereum blockchain which leads me to prefer the former term, but also it is the very nature of Ethereum. Ethereum contracts pay for computing cycles. Well, technically, the users of the contracts pay, but that nuance is still being worked out. What this means is that there is an incentive to build very small, single-use contracts and then to link those contracts together so that a user only pays for the computing cycles the user need in order to determine some outcome. Why is this even relevant? Because Ethereum will really shine as a business intelligence layer within a value stack of large organizations. It is less interesting to me whether an Ethereum contract and actually move money around than it is for Ethereum systems of contracts to be able to calculate the movement of value within the system based on a complex set of inputs, calculations, and outputs. 

Think, for example, of a community based recycling system (which I'm working on a client with to outline how this could work on Ethereum). In such a system, recycled goods would be collected from individual households by individual contractors, brought to a community based "collection center" where they are resold back into the value chain. All of the individuals involved (whether as contractors who pick up the goods or individuals who give their goods or marketers of the system) have a certain cost to the ecosystem and bring certain benefits. The overall revenue which such a system receives should then be distributed within the ecosystem based on a calculation of the overall cost to the system of individual participants and overall benefit which individual participants bring to the system. Try calculating that in Excel or Sage! But Ethereum smart contracts could do that. If they had knowledge of the overall revenue stream they could perform a complex series of calculations where individual contracts have inputs, actions, and outputs and because these contracts can talk to one another they can "act" such that everyone within the ecosystem can have transparency for where all of the value is going. 

The key in the above scenario is not exactly moving the money around, it is in producing a ledger and profit-loss sheet for the system. Whether money is performed by a human or a payroll system with an API hook to the accountant contract is largely immaterial to understanding the real *value* that self-administering contracts can bring. 

The above presents what I think is a very interesting possibilities and when we talk about Ethereum as being self-enforcing it gets lots of people off on a tangent about pulling computers out of smart cars so they cannot talk to the blockchain rather than thinking through what value the blockchain system could bring. By talking about self-administering contracts we can -- to a certain degree -- avoid this tangent. 

## The Relationship to the State

This is a long, tough question to answer. And no one will likely get it right for the foreseeable future. How do we strike the right balance between public rights of *all* and the private rights of *me*? Who knows. We humans have been struggling with that question since we started thinking. 

The other major portion of the questions were focused on the relationship that the Ethereum ecosystem may have to states. One of the most interesting veins of discussion was about whether blockchain technology would be more or less efficient than the state at enforcing contracts.

This is an important question which I have been considering at length over the course of the most recent weeks. One of the sub-veins of discussion had to do with the links between smart contracts and court enforcement. I was asked this a lot after my last talk at the most recent [Amsterdam Ethereum Meetup](http://www.meetup.com/Amsterdam-Ethereum-Meetup/). For the time being, I am recommending to clients that if they want 'real world' enforcement for the time being that they should build a normal contract and add the Ethereum contract as an addendum to that normal contract. This would force the court to either enforce -- or ignore -- such a contract but it would have the benefit of having some real world enforcement if such was essential.

Such a design, admittedly, would not really address the question of efficiency of administration of contracts (by which I mean determining whether specific metrics within a contract have been met in the real world rather than actually taking a house away from someone because someone has determined that it was sold). One of the important points which I wish would have been raised by the law professors is that most contracts that go to court, go to court because there is a question about the meaning of some terms. Contracts which are clear but only need to determine if some event happened or not predominantly settle or are arbitrated. Contracts that go to a court are -- for the most part -- those that are not clearly worded. Ethereum is drastically more efficient that the state with regard to this particular metric. Why?

Contracts as code mean that contracts cannot be ambiguous as to their meaning. Certainly there can be differences of opinion as to whether a particular metric was satisfied in the real world (What does it mean if I promise to give my best efforts to achieve a certain outcome -- such clauses are popular in employment contracts?). Certainly there could be bugs. Certainly slight differences in code structure can lead to drastically different outcomes (Does shipping you a good to the wrong address mean "I shipped it"? Yes. Does it mean "I shipped it to you"? No.). But what contracts as code cannot be is ambiguous. We will always know -- determinatively -- what the outcomes will be (as long as we know what the inputs are). After all it is just code. This addresses what I suspect are a large proportion of contractual disputes that end up on court. 

As to the overall efficiency of the state enforcing contracts, I'm skeptical. One of the questioners raised land property rolls. The argument basically boiled down to -- we have built these systems; therefore they are more efficient. That may be true and this particular moment but it avoids the more interesting question, which is whether in the long run the current systems used by the state to *track* property rights (and to be honest this is, ultimately the state's roll unless someone comes to them and tells them that their property rights are being violated -- in which case the state will send its police to a house and kick out the squatters). The State is not going anywhere, and I -- for one -- am not anarchic. The State can bring value to blockchain ecosystems without ending up at a authoritarian dystopia because the State is simply a collection of humans and we humans live in a tension between the devils and angels that sit on all of our shoulders. But setting up blockchain technology in opposition to state systems is wrongheaded. Why couldn't the State use a blockchain system to track property in the short or medium term. It could keep the human (police) element of the enforcement, but blockchain technologies are very powerful, decentralized systems which are cheaper, faster, and more resilient than what the state could actually build (because central points of failure will always be central points of effort for attackers).

## Freenet or Skynet?

Overall, I think Primavera did a quite good job at exploring the possibilities on both sides of this false choice. Indeed, these are not the only two choices and as with most things in live, the likely result will be somewhere between the two. 

We humans are constantly in a struggle between competing ideas, visions, histories, and norms. The very nature of this competition (which underlies our philosophies of democracy, markets, the scientific process, and free speech rights, among many other things) keeps us somewhere in between a utopic and dystopic future. Not to mention the impetus for nearly all of all our greatest art. The tension between these ideals is likely to always exist as long as we humans exist.

While both of the extremes are interesting on an analytical and strategic level to discuss, discussion of these two ends of a spectrum presents discussants with a false choice. The reality of the development of any system is rarely either of the extremes and usually ends up somewhere betwixt the tween. Ethereum, as with most technology, is a value neutral proposition. It is just code. It can be used for good ends or foul ends, but the code is the code. Like the HoneyBadger, it doesn't give a fuck. 

What Ethereum will allow us to do, and some of the participants and Primavera herself did a good job of exploring, is to explore different normative bases for ideas. How would contracts work if we wanted to code forgiveness? Mercy? I have no idea, but these ideas are worth exploring. As I said in my most recent talk, the possibility of exploring, studying, and utilizing different normative bases for transactions could be exceedingly powerful for us as humans. This is why I'm spending time contributing in my own small way to the Ethereum ecosystem. The possibilities are there, it is up to the humans to figure out what we will do with it.

Happy Hacking!

~ # ~