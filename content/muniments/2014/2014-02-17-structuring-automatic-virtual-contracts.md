---
categories:
- law
comments: false
date: "2014-02-17T00:00:00Z"
summary: EAutomatic contracts have been occupying a great deal of my free mental energies
  for the past few weeks since I first learned that there are platforms in the works
  that will allow for such things to happen. My thoughts on this are quite nascent,
  as is the technology, but here are my early observations.
meta: true
published: true
tags:
- bitcoin
- ethereum
- virtual contracts
- automatic contracts
title: How I Would Structure Automatic Virtual Contracts
---

Automatic contracts have been occupying a great deal of my free mental energies for the past few weeks since I first learned that there are platforms in the works that will allow for such things to happen. My thoughts on this are quite nascent, as is the technology, but here are my early observations.

## Introduction

Automatic virtual contracts are, essentially, small computer scripts which are linked to virtual currency wallets. The basic idea is that a financial transaction and the terms and conditions governing the transaction collapse into a singular instrument -- or script.

An example will probably make this easier to visualize. You and I want to make a contract, say, for me to deliver to you X widgets at Y time at Z price. Perhaps you don't trust that I will be able to deliver to you the widgets at the time. Perhaps I don't trust that you will be able to pay me for the widgets when I have delivered them.

In a traditional contract scenario, we would overcome this lack of trust in a couple of ways. Either we would put the money into an escrow account controlled -- likely -- by one of our banks. Or you would execute a Letter of Credit from your bank (which really only addresses the latter of the trust issues). Or we would just trust each other based on our reputations or our past business dealings.

Virtual automatic contracts overcome the trust issues in roughly the same ways. One of the key differences is that the computers act as the intermediaries rather than a large, stable financial institution such as a bank. While it is true that many people who operate in the global marketplace do have banks, it is also true that there are significant numbers who do not have or do not want bank accounts. Virtual automatic currencies would offer these individuals (as well as the banked individuals) a mechanism to operate in the global economy just as effectively and (perhaps more) efficiently than those individuals who are banked.

The analogous transaction to the escrow scenario would probably follow a sequence such as: I offer you the contract by sending you the script; you accept the contract by transferring the cost of the contract (or part of it) to a virtual currency "account" which is controlled solely by the script; we both "push" the script out into the network which verifies all of the aspects of the contract; when I deliver and you certify delivery the script automatically transfers the virtual currency to an "account" which I control from the "account" controlled solely by the script.

The analogous transaction to the letter of credit scenario or to the "just trust me" scenario would probably follow a sequence such as: I offer you the contract by sending you the script; you accept the contract by placing your "account" details into a field on the script; we both "push" the script out to into the network which verifies all of the aspects of the contract; when I deliver and you certify delivery the script automatically transfers the virtual currency to an "account" which I control from your "account". There are a few varietals of this script which could be developed which would (1) verify you have enough currency to pay for the delivery upon the occurrence of one or more events along the trajectory of completion of the contract and (2) structure payment schemes besides a one off payment upon delivery to other schemes staggered throughout the contract's trajectory and based upon the occurrence of one or more events.

Beyond being able to have some amount of trust in complex commercial transactions for unbanked individuals, there are numerous other benefits to virtual automatic currencies which would extend to both unbanked and banked individuals.

## Speed and Transaction Costs

Banks are slow. Escrow and letters of credit are costly. International wire transfers are slow and costly. Automatic virtual currencies would collapse this. Currently transaction costs in the bitcoin network for instance are on the order of 10%-50% of the costs for accepting credit cards. In low margin industries which have a lot of transactions this is a significant reduction in transaction costs.

In addition, bitcoin transactions are fast. Even getting money into your bank from a bitcoin transaction is not very slow. Most payment providers in the developed world will give you the money to your account that evening after you have developed a history with them. If you and I were both to keep some not trivial amount of our working and operating capital in bitcoin already then the payment speed dividend increases dramatically because the real time sink in the network at this point is moving from the virtual currency (bitcoin) to a "fiat" currency and depositing that fiat currency into your bank account.

Those are two huge advantages. For me, the seller, I would receive the value almost instantly upon certification of the delivery by the buyer. For both of us, reducing the transaction costs (which are traditionally priced into the overall transaction and either shared between the seller and the buyer or just paid for by the buyer) will be reduced and thus the cost to the buyer for the widgets should be reduced.

## Uncertainty and Ambiguity

One of the things that is most promising aspects to automatic virtual contracts, but also perhaps one of the most difficult aspects in contracting generally, is their ability to reduce uncertainty and ambiguity within the contract.

Automatic virtual contracts are computer scripts. Computer scripts do not like ambiguity. Indeed, computers are mostly too dumb to handle ambiguity. Presumably, it will be the role of the cryptography network supporting the contract's dissemination and execution to ensure that there is a lack of ambiguity. It is unlikely that simple transactions such as the one I've been using here will have any significant level of ambiguity to the contract whether it is virtual or traditional -- but for other types of contracts or bylaws (think trust establishment documents or a corporation's bylaws operating as virtual automatic contracts) where ambiguity could potentially be higher this is a bigger concern.

Reducing contractual ambiguity is usually the lawyer's job when drafting or reviewing a contract or other instrument. In a virtual automatic contract network, though, reducing ambiguity would likely be a three prong effort shared between the lawyer, the coder (who will likely be the same in coming generations), and the network. This would put more eyeballs on the problem. Also, programming is very different than drafting a contract because the computer needs precision. This will force lawyers|coders to develop contractual instruments which rely upon verification metrics for various parts of the contract which will inherently reduce its ambiguity.

When it comes to scripting, the scripting language itself handles whether a comma should be in a given location or not; there is no argument over whether to include an Oxford comma in an array; there is no argument over whether a defined term is an operative method or not. The nature of computers and scripting languages reduces these typical ambiguities into a binary determination: it is, or it is not. Judges may have to learn how to read computer scripts, but it is likely that they will have less of a role in determining whether A set of words and punctuation should yield B result or C result as that will be handled by the language and the network. This will reduce ambiguity throughout the entire commercial network -- a very good thing if you ask any business person you know.

I'm using uncertainty here as analogous to risk generally, or "all the other stuff surrounding the contract". On a simple contract which I have been using as an example in this post, there will be uncertainty for me that you will not find a better price on the widgets and just send them back to me after I have delivered them; there will be uncertainty for you that I will deliver the widgets at the quality specified. Admittedly, automatic virtual contracts cannot be a panacea to address these uncertainties because there are no real strong answers here. However, a few things could be done to address them. If we know that my widgets weigh Q grams, and we have access to a postal or courier's API then we can check that I have sent Q grams * X widgets (plus some packaging weight) to you -- thereby reducing your uncertainty. Of course this wouldn't address the quality of the widgets. That would be nearly impossible to overcome unless we could easily agree to a level of precision that a computer could check.

One potential way to address this uncertainty is by placing some third party "referee" into the system. These people could operate similar to how insurance adjusters worked in prior economies. They would largely be independent contractors who would work for the network and could be used to certify that I have delivered X widgets to you at Y time and they meet the quality standards we agreed to in the contract. Once the referee certifies the delivery to the network, then the script would automatically execute whatever was next in the series of events (likely, paying me). Potentially in international shipping government customs investigators (married with APIs) could also have a role in such a system. The big take away here is that wherever there is a subjective determination that some event has taken place, any way to build that into an API framework or utilization of a neutral referee would work to reduce the uncertainty. This is not necessarily transformative, indeed such systems are in place today in various capacities. The biggest difference here is that the referees could work independently and be certified and paid by the network itself so they would only have an interest in ensuring the validity of the contract rather than one party or the other succeeding (or course they could always be paid off by one side to say yes or no, but we'll likely always have to live with that uncertainty).

## Summation

This post has examined an extremely simple contract, which is where the ecosystem will have to begin. But once the ecosystem matures a bit the possibilities here for reducing commercial transaction friction and further decentralizing while also globalizing economies is utterly fascinating. A good friend and I are working on a business proposal which would leverage these types of transactions so hopefully there will be more on the horizon to this end.

~ # ~