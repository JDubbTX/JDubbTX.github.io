---
layout: post
title:  "RPG CiCd - Part 2 - Local Development Setup"
date:   2023-05-14 20:18:07 -0500
categories: VSCode IBM i Setup SSH
---

## LOCAL IBM i development setup

There are a few hurdles to overcome to achieve local rpgle / clle development.  This blog post will help you though those hurdles.  The outcome is that changes you make on your local PC pushed to an IFS directory and compiled, while also being synchronized with online source/version control, such as Github, Bitbucket, Gitlab, etc.  

> To start, we will work on the IBM i development partition where source will be built. 

### You need a home directory

You need to have a home directory on your development IBM i partition.  It doesn't matter how you add it, there are several ways.  If we assume you can't SSH, you can always do it with a CRTDIR command in the greenscreen.

![Please, not more greenscreen!](/assets/images/CRTDIR.png)

### Set default shell to Bash

If you haven't done it yet, follow instructions in [this link](https://ibmi-oss-docs.readthedocs.io/en/latest/troubleshooting/SETTING_BASH.html) to set Bash as your default shell.  For historical reasons, IBM i has ksh (kornshell) as the default shell.  Most folks prefer Bash. Most open source examples you find on the web use Bash.  The absolute easiest way to do it is to run the following command in ACS Run SQL Scripts tool:

```SQL
CALL QSYS2.SET_PASE_SHELL_INFO('*CURRENT', '/QOpenSys/pkgs/bin/bash')
```

> The next few steps will be done on your local PC.  Windows steps are pictured, but the process isn't any different on a Mac.

### VSCODE and Git setup

#### Install VSCODE

Go to the [Visual Studio Code download page] and install it on your machine.  Once installed, it will notify you when there are updates and prompt you to update it, quite seamlessly.   It usually only takes a few seconds.

#### Install GIT (local)

VSCODE automatically prompts you to download and install it the first time you click on the the **source control** view in the activity bar.  After GIT install and reload of VSCODE, you should see the **Open Folder** and **Clone Repository** buttons in the **source control** view.

![Downloading GIT](/assets/images/VSCODE_Install_GIT.gif) 

![Install GIT](/assets/images/VSCODE_Install_GIT_2.gif)

#### Install VSCODE extensions

There are a multitude of extensions available for VSCODE.  They are available to install in the [Visual Studio Code Marketplace](https://marketplace.visualstudio.com/VSCode), or you can access the same marketplace from within the VSCODE in the extensions sidebar view:
   ![Install IBM i Development Pack](/assets/images/InstallIBMiDevelopmentPack.jpg)

Here are the essential ones for IBM i development.

*  [IBM i Development Pack](https://marketplace.visualstudio.com/items?itemName=HalcyonTechLtd.ibm-i-development-pack) This will install 13 extesions, all helpfull for developming on IBM i, including the Code for IBM i extension.

*  [GitLense](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) This gives you full visibility to your git repository, both locally and remote.

4. Log in to your IBM i with the Code for IBM i extension.

5. [Configure your Settings](/_posts/2023-05-18-VSCODE-Settings-for-IBM-i-development.markdown)

### Create a project

There are two approaches to getting a project to sync to online source control.  The easiest approach is to create a blank project online, then clone it locally.  In this tutorial, we will use gitlab, but the same concept applies if you are using Github, Bitbucket, and the like.

1. Log into your Gitlab account and create a new project.  Think of a good name for your project.  This will end up being the directory name where the source is stored.  For this tutorial we will call it "My First IBM i Project".

![CiCd pipeline](/assets/images/Gitlab_Create_New_Project.gif)

2. Copy the project SSH clone URL and clone it

5. Set your deploy IFS target directory - do this in the IFS 
6. Set up your 

### Setting up your IBM i profile
The first work we need to do is to set up your IBM i profile for open source development
1. Setting your path
2. etc. (WIP)

### Git your code in shape
1. WIP

### More Setting up VSCODE
1. WIP

### Compiling code from a local repo
1. WIP
