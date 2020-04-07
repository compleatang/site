---
categories:
- linux for lawyers
comments: true
date: "2014-01-28T00:00:00Z"
excerpt: Backup your files. Everyone knows it. Even those who know very, very little
  about computers understand that you should back things up. But no one does. Let's
  talk quickly about the options which Linux has for backing up your files..
meta: true
published: true
tags:
- backups
- cloud-sync
- linux
title: Cloud Sync and Backup Options -- Overview
---

Backup your files. Everyone knows it. Even those who know very, very little about computers understand that you should back things up. But no one does. Let's talk quickly about the options which Linux has for backing up your files.

Cloud sync is not terribly new, but it has definitely been mainstreamed within the past year or two. Increasingly, bar associations have been distributing ethics opinions on how lawyers should keep their client's data safe. So far, no bar association that I know of has said outright that lawyers within their jurisdiction cannot keep their client files backed up to the cloud. I certainly know many lawyers who are skeptical about cloud backup and as a result do not do it.

Yet not using the cloud comes with a limitation, because cloud syncing is damn powerful. You have the ability to access your files from anywhere. You have the ability to very simply and quickly reconstitute your data after getting a new computer, formating an existing system, or when you are on a system which is not your main system.

I use three cloud syncing systems (two commercial providers and one that I have built for Watershed) and a physical external hard drive to back up my data. Everything that is important to me -- literally everything -- is put onto at least one of the proprietary cloud syncing services as well as my own, secure cloud server which I completely control, as well as my external hard drive. I have my data in different data centers, on different continents, and on different types of drives. It would take nuclear annihilation of the human species for me to lose anything more than a few file updates.

Having your data in more than one place requires that you understand the security structure of that data. For this reason my external hard drive does not travel with me -- because despite my previous advice it is not encrypted. For this reason I have a highly secure server hosted within Watershed's cloud that serves to only accept our git repositories and our partner's backups. I'll get to how we structure that process in a later post.

## How I Structure My Cloud Syncing System

I use two commercial cloud sync providers, but I do not use them for the same thing. That would be a waste of the free space cloud providers offer. Personally, I use Dropbox and Google Drive. I use Dropbox as, well, a dropbox but the main way I use Dropbox is as a repository for all my configuration files. In an upcoming post, I'll walk through my Dropbox bootstrapping system, but it is very similar in nature to the system by [Mackup](https://github.com/lra/mackup). The basic idea is that I copy folders and files into specific spots on my Dropbox and then symlink to those. I use Google Drive for all my client and internal Watershed documents. Both of my Dropbox and Google Drive are then backed up on a daily basis to Watershed's server and to my external hard drive in the office.

There is no reason to backup one cloud provider into another either by putting one inside the other or by symlinking between them. Not only would it be a waste of valuable space, but also it *could* create an infinite loop where one or both systems were constantly updating. Since both of these services at least count versions of files against your data caps, if you tried to back up one system to another you would likely have so many versions of some files that you could creep up on your data cap quickly.

I find Dropbox to be faster for smaller files and Google Drive to be faster for larger files. I have no benchmarks for this, it is simply how it feels. Which makes this distribution of effort important.

## Rsync -- Still Crazy After All These Years

Where cloud sync providers are amazing is in how fast they can update your cloud with your files. It is grand. But you don't actually always want things to be instant. Sometimes you want to go slow. When I'm in Somaliland for instance where bandwidth can be limited I do not want to necessarily take valuable bandwidth that I may need to do research or check facebook by allowing cloud sync services to update too frequently.

This is why my backups to Watershed's servers and my on-site external drive are performed on a daily basis. I set my backups to run via rsync on a cron job so I never need to worry about them. What I love about posix systems is how simple they make it to build a small script and what I love about linux is how easy it is to set up a cron job to run the small scripts on whatever basis you want the script to run. These two concepts in combination with rsync makes for a completely hassle free system. If you do not have rysnc on your system then simply `sudo apt-get install rysnc` or install it from your app store.

First, I built a backupjobs script in my `~/.bin` folder:

{{< highlight bash >}}
#!/bin/bash

USER==`who am i | awk '{print $1}'`
BASIS=/home/$USER
EXTERNAL_HD=/media/$USER/MediaHD
GANDI_DRIVE=#REDACTED -- THIS IS THE CLOUD DRIVE
IS_GANDI_THERE=`nmap $REDACTED -PN -p ssh | awk '{print $2}'|grep open`
IS_EXTERNAL_HD_MOUNTED=`mount 2> /dev/null | grep "$EXTERNAL_HD" | cut -d' ' -f3`

# STEP 1 - BACKUP to GANDI IF GANDI'S THERE
if [[ "$IS_GANDI_THERE" ]] ;then
  rsync -rtpovclHzs --progress --delete --ignore-existing $BASIS/Dropbox $GANDI_DRIVE
  rsync -rtpovclHzs --progress --delete --ignore-existing $BASIS/Insync/caseykuhlman@gmail.com $GANDI_DRIVE/GDocs
  rsync -rtpovclHzs --progress --delete --ignore-existing $BASIS/Insync/caseykuhlman@watershedlegal.com $GANDI_DRIVE/GDocs
  rsync -rtpovclHzs --progress --delete --ignore-existing $BASIS/sites/ $GANDI_DRIVE/Coding
fi

# STEP 2 - BACKUP to EXTERNAL HD IF IT'S THERE
if [[ "$IS_EXTERNAL_HD_MOUNTED" ]] ;then
  #rsync -rtpovclHzs --progress --delete --ignore-existing $BASIS/Dropbox $EXTERNAL_HD
  rsync -rtpovclHzs --progress --delete --ignore-existing $BASIS/Insync/caseykuhlman@gmail.com $EXTERNAL_HD/GDocs
  rsync -rtpovclHzs --progress --delete --ignore-existing $BASIS/Insync/caseykuhlman@watershedlegal.com $EXTERNAL_HD/GDocs
  rsync -rtpovclHzs --progress --delete --ignore-existing $BASIS/sites/ $EXTERNAL_HD/Coding
  rsync -rtpovclHzs --progress --delete --ignore-existing $EXTERNAL_HD/Photos $GANDI_DRIVE
fi

# STEP 3 - NOTIFICATIONS
## REDACTED
{{< / highlight >}}

The script is fairly straight forward. The first section of the script simply sets up defaults which I can use throughout the rest of the script. The second section then checks if Watershed's cloud server is available and if so, it rsync's the designated folders into the server. rsync has an absolute ton of options which allow it to do a great variety of things. If you want to understand what each of the switches I have set up do (switches mean the `-rtpovclHzs --progress --delete --ignore-existing` portion of the script) then simply go to your terminal and type `man rsync`. If you are too lazy to read all of the man page -- and I don't blame you because it is long and I've been working through this for a while now, then you can simply copy the switches and know that they will make a mirror online of the current state of your data. This is not a backup setup, it is a mirroring setup. The major difference between the two being if you delete something locally it will be deleted on the remote server. If that is not what you want then you would simply delete the `--delete` switch.

There is one minor gotcha with rsync. If you look at the difference between the last two rsync calls within the `Step 2` section you should see a very small difference. What is different is that in the final call there is a slash at the end of the reference which does not exist in the previous one, in other words the difference is `$BASIS/sites/` and `$BASIS/Insync/caseykuhlman@watershedlegal.com`. To rysnc the latter means to copy the directory (and anything inside of it based on the `-r` switch earlier in the command) so that there will be a `caseykuhlman@watershedlegal.com` directory within the destination. To rsync the former means to copy everything inside of the directory so that there will not be a `sites` folder inside the destination.

The last major thing that I have on the script is a notification system which sends me a [Pushover](https://pushover.net) alert whenever the script has run. Since I run the script each night, if I do not wake up to a notification then I know that it has not run. I have yet to not have that happen except for when my computer is off or I'm in transit but usually it is fine as everything will get backed up the next day. The notifications tell me whether it has backed up to the onsite external and/or the server so I quickly can tell what has happened.

## Automating rsync with cron

Cron jobs are amazing. This will be quite quick as it is very very straight forward. The script I showed above is saved as ~/.bin/backupjobs. (Note after you save a script do not forget to make it executable by running `chmod +x` on your system.) Then all I have to do is add the following line to my crontab by running `crontab -e` (for edit) from my terminal

```bash
42 03 * * * /home/coda/.bin/backupjobs
```

Cron is a bit confusing at first, but here is what is happening. The first field is the minutes, so this job is to run at 42 minutes. The second field is the hours, so this job is to run at 03 hours, or 0342. The third field is the day of the month (in other words if you wanted to run monthly jobs you would set this to run on a particular day of the month -- maybe the 1st or the 15th or whatever), the * in the field means every day of the month. The next field is the month of the year, so this job is to run every month of the year and every day of the month. The final field is the day of the week. So the last three fields having a * means that the script should run at 0342 every day. The final portion is simply the script that the cronjob is supposed to run.

That's it. Now everything is automated. I save files in my Dropbox or Google Drive or other folders during the day and at night my rsync and cron jobs back those up automatically to my onsite external and Watershed's servers. Voila. Completely automated, nuclear attack (but not nuclear annihilation) proof system.

Happy Hacking!

~ # ~