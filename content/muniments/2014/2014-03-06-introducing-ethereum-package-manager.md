---
categories:
- virtual automatic contracts
comments: true
date: "2014-03-06T00:00:00Z"
summary: This is a proposal for a package manager which will help in the assembly,
  development, and deployment of virtual automatic contracts within the Ethereum ecosystem.
meta: true
published: true
tags:
- ethereum
- epm
- virtual automatic contracts
title: A Proposal for @ethereumproject Provisions, Contracts, and Packages
---

Lately on my "regular" blog I have been doing a decent amount of writing [about](http://blog.caseykuhlman.com//entries/2014/structuring-automatic-virtual-contracts.html) [virtual](http://blog.caseykuhlman.com//entries/2014/the-latent-natural-synergies-between-cryptocurrencies-opendata-development.html) [automatic](http://blog.caseykuhlman.com//entries/2014/automatic-virtual-contracts-for-humanitarian-relief.html) [contracts](http://blog.caseykuhlman.com//entries/2014/irl-links-with-virtual-automatic-contracts.html). It has been fun to think through the possibilities of virtual automatic contracts and how those could really work in developing countries.

## Background and Introduction

Earlier this week I had the distinct pleasure of attending the [Ethereum](https://www.ethereum.org/) meetup in Amsterdam to learn more about how virtual automatic contracts (or as they call them smart contracts) work within the Ethereum blockchain. For those that may not know, Ethereum is a derivative of Bitcoin but focused on being a platform for virtual automatic contracts. Although loosely based on Bitcoin's blockchain technology, it is meant as an expansion of that technology into a larger system. Here is how Ethereum describes itself.

> Ethereum is a platform and a programming language that makes it possible for any developer to build and publish next-generation decentralized applications.

> Ethereum can be used to codify, decentralize, secure and trade just about anything: voting, domain names, financial exchanges, crowdfunding, company governance, contracts and agreements of most kind, intellectual property, and even smart property thanks to hardware integration.

The idea is to build a scripting language and combine that with the "permanence" of blockchain technology and allow "contracts" within the sandboxed blockchain to take decisions (based on their code) and to interact with other contracts (again based on their code). This combination of a scripting language and blockchain technology opens up an amazing range of possibilities. For now, this technology is very much pre-alpha stage, but there is a LOT of momentum behind it and getting 25 people or so at a meetup in Amsterdam shows they are doing a fabulous amount of PR work to spread the word about what they are doing.

At the meetup there was a lot of talk about lawyer|coders (or coder|lawyers, not sure which). As I'm pretty sure 99% of the room were mainly coders or financial tech people, the concept of a coder|lawyer was mentioned almost with a laugh in the room (or at least with a sly smile). Well, we are out there. The advantage which coder|lawyers have over either coders or lawyers is that we understand to a large extent how contracts work in the real world but also understanding what computers can do. This gives us a special place within the virtual automatic contracts world. If you are a lawyer and a hacker I would encourage you to read the [Ethereum Whitepaper](https://github.com/ethereum/wiki/wiki/%5BEnglish%5D-White-Paper) and think about participating.

## Why an Ethereum Package Manager

In any open source ecosystem a range of products to hack on the system needs to be developed. A method of testing applications (or contracts in the Ethereum system) needs to be developed. A method of simulating applications || contracts needs to be developed. A method of compiling applications || contracts needs to be developed. An easy method of deploying applications || contracts needs to be developed. There is a whole range of infrastructure systems which need to be in place for the system to really function.

One of the most vital aspects of the ecosystem's infrastructure is some sort of a package manager that will assist in pulling packages from other sources and doing other things to assist in the development and deployment of packages.

Nearly every open source ecosystem I know of has various package managers that automate a lot of different aspects of the ecosystem (depending on what the ecosystem needs, etc.). Ruby has Rubygems and Bundler. Node has NPM. Python has Pip. ZSH has antigen. OSX has Homebrew. VIM has Vundle. Sublime has Sublime Package Manager. You get the idea.

I have started coding out an Ethereum Package Manager -- [EPM](https://github.com/watershedlegal/epm) -- because I think it will very soon be necessary if anyone is going to build anything more than a simple, isolated contract. One of the things that struck me during the Ethereum meetup this week was that there is going to be a lot of boilerplate redundancy within contracts.

For example, at the beginning of nearly every contract will be a check to ensure that the contract has enough currency to pay the network for running itself. The way that Ethereum is structured is that contracts need to pay the network for two different things: (1) they pay for the amount of storage they are using, (2) they pay for the number of computing cycles they use. Storage is paid for when the contract deploys onto the network (or when it changes its storage allocation as I understand it). But computing cycles are paid for as they are used. Contracts can hold their own value in credits which are then paid to the network (or other sources depending on the contract's code) on each computing cycle. This means that a contract, if it is running low on funds, does not want to be in a position of executing part of its code and then running low on credit. This will leave the contract in a weird state and generally F up your system. The only part that lawyer|coders need to understand is to build in a small IF statement check at the beginning of the contract to make sure that it does not run unless the contract has enough credits to run the entire script. This is some of the boilerplate that will be required for the Ethereum virtual automatic contracts and nearly every single contract will have this boilerplate.

Another example will be the self-amendment terms of the contract. Note how I used the lawyer word "terms" there but one could equally use the coder term "settings" as I'm referring to the same thing. On a technical level, Ethereum contracts are able to modify their own code. This is equal parts wonderful and utterly terrifying (although the utterly terrifying concern is probably deferred until our contracts get better by an exponential amount). Until we need to worry about sentient bots that can send war drones to kill those that we don't like using the Ethereum blockchain and its IRL connections, we simply need to be worried about the terms under which the contract can amend itself. At times we will want to restrict the contract so that it cannot amend itself full stop. At times we will want to restrict the contract so that only amendments sent via a particular Ethereum address (be that either some master contract "above" this contract on a hierarchy tree or a human with an Ethereum address) will be actionable. At times we will want to restrict the contract so that only amendments sent via a particular set of Ethereum addresses (usually this would be after some sort of a voting mechanism was executed by those other set of Ethereum nodes) will be actionable. There may be other iterations but it is likely that these are the three main iterations. Again, this is boilerplate and should be written into any contract.

Lawyers work with boilerplate via Word templates. [Don't get me](https://github.com/rmoc/rmoc.github.io/blob/master/about/index.md) [started on Word](https://github.com/compleatang/legal-markdown). Coders work with boilerplate via packages or generators. If Ethereum is going to be easy for lawyer|coders to utilize, then we will need some sort of a system which allows us to work with boilerplate. I'm hoping that EPM will be at least one way to do that.

## Three Functions of Ethereum Package Manager

I've tentatively structured the Ethereum Package Manager to conduct primarily three functions. First, Ethereum Package Manager will serve as an easy way to pull, push, and upgrade your boilerplate. Second, Ethereum Package Manager will simplify your contract development sequence by simplifying the commands to lint, test, simulate, compile, and deploy your contracts. Third, Ethereum Package Manager will provide an (opt out) mechanism for users to support the Ethereum infrastructure with tips. In this sense, EPM is a bit larger than some other package managers in scope.

## Package Management Functions

EPM will allow you to pull, push, and upgrade boilerplate. This will be necessary so that boilerplate provisions can be structured in such a way that the community can achieve consensus on best practices. Also it will simplify the deployment of standardized contracts to the Ethereum blockchain. For example, if a lawyer|coder was tasked with building a decentralized autonomous guild and it needed to pull bounty contracts for some aspects of the guild's operations, then EPM could be used to pull those contracts which best suit the system the lawyer was trying to build. These could be kept in proprietary git repositories or on Github (obviously with a preference for the latter) and pulled into the system in the amounts and with the constants as needed for eventual deployment of the organization.

## Package Development Functions

EPM will provide a simplified way to work with your contracts. After EPM is used to pull in standardized provisions && || standardized contracts. Then the lawyer|coder will want to edit, lint, test, simulate, and compile those contracts (or system of contracts) before deploying them to the Ethereum blockchain. EPM in combination with other systems will simplify this.

## Infrastructure Support Functions

The last primary function EPM will provide is a mechanism to support those developing EPM, testing suites, simulators (which are really REPLs I guess), compilers, etc. While it is always great to give to a community, it is even better to be able to do what you love and pay the bills. This is always the difficulty with open source systems and a modest tip mechanism is, I hope, not overly controversial. How it will work is that within the configuration files, EPM will place the addresses of the infrastructure tools it knows you are using along with an equalized percentage of tip across those tools. These can be changed globally or per project and can also be taken out completely if the lawyer|coder cannot afford to send tips or does not agree with the system (hey, I never pay Kiva every time I make a new loan because I'm a freeloader like that.) In the configuration file will be three lines: the address to send the tip to, the percentage of the deployment tip, and the (optional) message to send with the tip. Then when the contract is deployed, the deployer will tell EPM the total amount of tip to be sent to the infrastructure system. EPM will then distribute this based upon the configuration files.

## Status of EPM

This is simply an idea at this point. The TODO includes everything. I am hoping to have some amount of this functionality deployed by the end of next week. In any event, Ethereum is not yet launched and is only working off the testnet so there is still some time.

## Ethereum Packages

In order for EPM to be most beneficial to the community, the community should agree on certain conventions as to how packages, contracts, and individual contract provisions will be structured. These are my thoughts on the matter, and I welcome all input and thoughts on the matter. For now, I would recommend that EPM be fairly stupid and simply pull in lines of boilerplate, mash those together than then let the human work out any problems that the assembled mass creates. Later, it will be good to have some standardization within the contract provision system so that EPM can be smarter about how it pulls in and combines provisions. It will take a while for the Ethereum ecosystem to reach that point, so for now the conventions I'm proposing below would be fairly rudimentary in nature.

### Ethereum Contract Files: XXXX.ethereum-contract

Ethereum contract files should be written in a single language which one of the compilers can parse. There should not be portions of the contract file written in one of the compiler languages and another portion written in another of the compiler languages. Ethereum contract files should be fully composed contracts which can be compiled and deployed with minimal user interaction (perhaps adding some addresses or constants to the script before compilation and deployment). Ethereum contract files should reside in a git repository (for now).

### Ethereum Provision Files: XXXXX.ethereum-provision

Ethereum provision files should be written in a single compiler language, and should reside in a git repository, but need not be fully complete contracts. Indeed, most provisions should not be complete contracts and instead should only provide a single unit of functionality to the contract. EPM will be built so that it can pull various XXXX.ethereum-provision files from various git repos and assemble those into a guess at what the final, assembled contract will look like. For example, if one lawyer|coder writes the definitive contract amount check provision (see above) and puts that on Github then others can instantly pull that provision into the contract.

Alternatively, I've thought about breaking prefaces and postfaces and substantive provisions out into their own files so that the package manager will know that prefaces go before the substantive provisions and postfaces go after the substantive provisions. However, after reflection it seems that such a system would be more restrictive than what is laid out above and at this point it would be more beneficial to have the system remain neutral as to where lawyer|coders place certain provisions within their contracts.

The general idea with ethereum-provision files would be to allow people to pull in different types of provisions into a cohesive contract to be edited, tested, and deployed quickly and simply. As the ecosystem develops, I would hope that this will allow the quickest deployment of contracts onto the system for users (predominantly for lawyer|coders who are more the former than the latter).

## Ethereum Package Manager Configuration

EPM will work based on configuration files and contract definition files. There are two configuration files that any instance of EPM will work with. Residing in `~/.epm/config.toml` will be the global configuration file. It will be in TOML format. A local configuration file will also be used only in the context of the current working directory. This is how many package managers operate and it will allow the user to set global defaults as well as per project configuration. The details for the EPM configuration are in the [README](https://github.com/watershedlegal/epm).

In addition, in order to define contracts, in the project root will live various XXXXXX.ethereum-definition files (not sure that name will stick and other ideas would be welcome). These will be simple text files and will tell EPM where the contract provisions (or contract) resides that it will pull in and build. Within the contract definition file (which would be somewhat analogous to a Gemfile or your .zshrc or .vimrc file if you were using antigen or vundle) a user will be able to note an entire repository (in which case EPM will pull in all the files in that repository), a single file within a repository, or even a range of lines from a single file within a repository. Since EPM will know where the repository is and since repositories are version controlled, this will allow EPM to update the boilerplate down the road in case certain best practices change, security flaws within contracts are determined, or simply because things have changed.

## Questions, Feedback, Thoughts

Feel free to add any comments, questions, or feedback below, or, better, drop an issue on [Github](https://github.com/watershedlegal/epm/issues). As I said above, I'll be working on this over the coming week and hope to have something moderately useful within a week or two.

Happy Hacking!

~ # ~