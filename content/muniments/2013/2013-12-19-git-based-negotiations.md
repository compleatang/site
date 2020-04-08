---
categories:
- Gitlaw
comments: true
date: "2013-12-19T00:00:00Z"
summary: One of the impetuses for developing legal_markdown was that text based documents,
  backed by git or another version control system could be a powerful tool for legal
  practice. But how that would work, in actuality, is still theoretical. This is a
  concept piece about how git backed negotiation could potentially work.
meta: true
published: true
tags:
- gitlaw
- legal markdown
title: Git Based Negotiations - A Concept Piece
---

Yesterday, I was having a conversation with a fellow [github lawyer](https://github.com/dpp/lawyersongithub) about git-based contract negotiations (gitgotiations...?). Indeed, this has been on my mind for a while and was one of my motivating, longer term reasons for thinking that some kind of text-based [legal document format](https://github.com/compleatang/legal-markdown) was necessary.

For the production of many documents, lawyers need not worry too much about what goes into repos as it is only the final version of the document which is shared publicly. That final document is likely to be a redacted .pdf so there is no need to worry about the history of the memo, filing, or whatnot.

But, if lawyers were to utilize git for negotiation they would need to be careful about what their commit history looked like, because opening up one's history of thinking about a document could reveal too much to another party one was seeking to contract with. Although I'm generally all for openness there is a time and a place for that, and transaction negotiation is not the time and place to necessarily be open and transparent.

This piece is meant simply to think through a concept that outlines my thoughts on how a negotiation backed by git *could* work. Of course, this would need to be tested to determine its feasibility, the problems and holes it may present to practitioners, etc. As a sidenote, if anyone is interested in conducting some mock negotiations on GitHub to try to identify where the sticking points are in this, I'm 100% game.

## Scenario

Two parties are negotiating a contractual relationship. Both parties have lawyers who understand how git works and use text-based documents to draft their contracts. In theory, this would work with Word based documents with something like [catdoc](http://vitus.wagner.pp.ru/software/catdoc) and some gitattribute [magic](http://git-scm.com/book/en/Customizing-Git-Git-Attributes), but those are still problematic to diff and people would already use Word's track changes for worse or better.

## Overview

The party initiating the contract, Party A, speaks to its lawyers who modify one of their templates to reflect the preliminary terms and parties which the Party A passes along to its lawyers. That portion is practice, but after that is when this concept begins to differ from current practice.

After Party A's lawyers develop the Draft 0 of the proposed contract, they then open their repository for this matter to opposing counsel. When they open this repository, however, they only give allow opposing counsel to access one branch. This branch could be called "external," but because of git defaults it is likely to be the "master" branch. For the purposes of this piece I will refer to the "master" branch as the "external" branch, but of course they could be named whatever make sense to the counsel in question. The reason for only allowing opposing counsel to see one of the two branches is to hide the internal work from opposing counsel. Another way that Party A's lawyers could do this is using a submodule, but theoretically using submodules rather than branches seems more complicated to me.

Once Party A's lawyers open up the repository to Party B's lawyers, then Party B's lawyers make their own internal branch and perform their review. Then the negotiation takes place via a series of pull requests between the parties until the master branches of both parties have no differences. At that point, the parties have agreed on all the terms of the contract and it can be signed by the parties.

## Steps Prior to Negotiation -- Party A

All of Party A's work prior to opening up the repo to Party B's lawyers should be encapsulated in a branch which will be restricted to that Party and its lawyers only and will not be opened to opposing counsel. This will keep internal discussions or changes that may reveal the Party's position in a branch which opposing counsel cannot see. Git offers (at least) three commands which could be used in this workflow.

The first command is `git checkout master && git merge --squash internal`. What this command will do is to first switch to the master branch and then merge in the work from the internal branch. The most important part of the command is the `--squash` switch. When git merges the changes from the internal branch into the master branch, counsel will not want all of the commits to be shown, but what it will want is the final document (likely with comments redacted if they have been put into the document along the way) 'squashed' down. Without the `--squash` switch, then the merge would bring in all of the commits during the workflow. That is very unlikely to be what Party A's lawyers want to do as it will very likely reveal some positioning or other things that the counter Party's lawyers could use in their negotiation.

The second command, and the one that I would personally start with, is `git checkout master && git rebase --interactive internal`. This command is a more powerful version of the `git merge --squash` command. Rebasing is slightly different than merging, but for the purposes of this piece, those are largely immaterial. If you want to see a deeper discussion of rebasing, Scott Chacon's [Git book](http://git-scm.com/book/en/Git-Branching-Rebasing) is the best place to start. What this command will do is to bring up an editor so that the lawyer rebasing the internal branch onto the master branch will be able to pick and choose which commits are brought into the rebase and which are not. In addition, with an interactive rebase such as this, one can also squash down the commits as with `merge --squash` command.

The third command, and probably the least optimal command to use at this stage in the process is `git checkout master && git cherry-pick --no-commit ..internal && git commit`. [Cherry-picking commits](http://git-scm.com/docs/git-cherry-pick) is, to be honest, not exactly what should happen at this point. Cherry-picking commits is probably more likely to be used later in the process but it *could* potentially be used at this point. Fundamentally, what the command does is to switch to the master branch and to bring in all of the changes from the internal branch which are not currently in the master branch. The key with this command is the `--no-commit` switch. This tells git to apply the changes from the internal branch but to not make a commit for those (which is the default behavior). In this way, the command works very similarly to the above commands. Unlike with the merge and rebase commands, with this command the counsel merging the changes from the internal branch would have to explicitly commit on the master branch once the changes have been applied.

So, to summarize, here are the steps that Party A's lawyers took:

1. Initialize a blank repository for this matter (`git init MATTER`).
2. Create branch "internal" and switch to using that branch (`git checkout -b internal`).
3. Drop template into internal branch.
4. Work on internal branch until satisfied.
5. Checkout master branch (`git checkout master`).
6. Combine the work into one final commit within the master branch via one of the three commands above.

Once the lawyers for Party A are satisfied that the Draft 0 is ready to share with the lawyers for the counter party, they simply open up the master branch of the repo to Party B's lawyers.

## Steps Prior to Negotiation -- Party B

In this scenario, Party B's lawyers are simply responding to the draft contract submitted by Party A's lawyers. This is, of course, a simplified scenario to illustrate the point. In actuality, Party B and Party A could both have a starting contract they are interested in having as the basis for the final contract, but for the purposes of this exercise that adds unnecessary complexity. So let us stay with Party B simply responding to the initial draft produced by Party A.

When Party A's lawyers open the repo to Party B, then Party B's lawyers will clone Party A's master branch (which is all they can see). After cloning the master branch, Party B's lawyers will immediately create their own "internal" branch. They would then conduct their review of the contract based on that "internal" branch. The commands used by Party B here follow the sequence above:

1. Clone Party A's repo (`git clone SERVER:REPO`).
2. Create an internal branch (`git checkout -b internal`).
3. Do work.

Once the parties are ready then the negotiation would begin. I can think, conceptually at least, of a couple of ways in which the negotiation could be conducted. The first way would be to conduct a negotiation by breaking the negotiation into pieces and negotiating each piece. The second way would be to conduct the negotiation as a whole. The former is probably better for complex transactions, especially when there are teams of lawyers working on different pieces of the transactions. The latter is probably better for simple negotiations where the pieces negotiation is overly complex. Let's think through these in order.

## Negotiation by Pieces

Once Party B has noted (via its internal branch) the areas of the Draft 0 of the contract it has objections to, it would then classify these into issues. For each of the issues Party B wishes to address within the negotiation process, it would create a new branch off of Party B master branch. This is somewhat analogous to forming a topic branch in normal git flow.

From each of the issue branches, Party B's lawyers could make the modifications to the contract they are interested in and send a pull request to Party A's lawyers. If the changes are agreeable to Party A, then those can be immediately merged into the master branch of both parties. Where changes require dialogue between the parties, that dialogue could happen within the comments on the web hosted repo, on email, over the phone, in person, however. In this instance, since the changes have been discreetly identified they can easily be merged into the master branch of both parties, changed by either party, or rejected as needed.

This cycle could then be repeated as many times as necessary until both parties agree. So to summarize these steps:

1. Party B: creates issue branches for each of the issues it has with the contract (`git checkout master && git checkout -b ISSUE_A`).
2. Party B: counter proposes language for each of the issues within the issue branch in question.
3. Party B: sends pull requests to Party A for each of the issues.
4. Both parties: merge the issue branch into their master branches as issues are agreed in the direction of Party B's counter proposed language (`git checkout master && git merge ISSUE_A && git branch --delete ISSUE_A`).
5. Both parties: delete the issue branch from both repos as issues are agreed in the direction of Party A's originally proposed language (`git checkout master && git branch --delete ISSUE_A`).
6. Both parties: work from the issue branch as the language goes back and forth (`git checkout ISSUE_A`).
7. Rinse and repeat as necessary.

When all of the topic branches have been merged into both masters or deleted without merging, then the negotiation is complete. Both parties should do a quick diff of the masters to ensure that there are no discrepancies. Thereafter the contract is ready for signature and execution.

## Negotiation by Cycles

Once Party B has noted (via its internal branch) the areas of the Draft 0 of the contract it has objects to, and it has refactored those provisions into its counter-proposed language, it would then `git merge --squash`, `git rebase --interactive`, or `git cherry-pick --no-commit` those changes into its master branch. Once it has brought in its changes wholesale, it would send a pull request for the entire master branch to Party A.

Thereafter Party A would work up its counterproposal via its internal branch after merging in the changes from Party B's master to Party A's internal. When it was ready with a counterproposal it would `git merge --squash`, `git rebase --interactive`, or `git cherry-pick --no-commit` those changes into its master branch and send a pull request to Party B.

This cycle would then continue until both parties were satisfied. So to summarize these steps:

1. Party B: works on its counter proposal via its internal branch.
2. Party B: brings in the changes to its master branch and sends pull request.
3. Party A: merges Party B's master into its internal branch (`git checkout internal && git merge SERVER:REPO master`).
4. Party A: works on its changes and brings those into its master via one of the three reductive commands above.
5. Rinse and repeat as necessary.

When both of the parties have no further changes to the text, then the negotiation is complete. As with the prior methodology, both parties should perform a diff of the two masters to ensure that there are no discrepancies before the contract is fully ready for signature and execution.

## Conclusions

The advantage of the negotiation by cycles workflow is that there is less branching and moving pieces to worry about. Indeed it is rather similar to how negotiations are conducted at present but with an overlay of git which will retain all of the internal work as well as the communication between the clients (which to be fair both methodologies will do). The advantage of the negotiation by pieces workflow, though is that proposals and counterproposals which may contain numerous discrete issues to be addressed within a complex negotiation, are not separated out into pieces as they are in the previous negotiation workflow.

Finally, when the parties have agreed to the substance of the contract, the lawyers for both parties can produce two distinct pieces of work. The first is the final contract which will be signed and executed as required for the jurisdiction in which it is being performed. The second would be an internal archive of the entire repo. This archive provides the "legislative history" of the contract and could illuminate some of the parties' intent if the contract were ever to be litigated. Of course, the admission of the repo archive would be subject to the rules of evidence at the time one of the parties sought to have it admitted, but that would be a discussion for another time.

Happy Hacking!

~ # ~