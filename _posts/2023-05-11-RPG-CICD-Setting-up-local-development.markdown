---
layout: post
title:  "RPG CiCd - Part 2 - Local Development Setup"
date:   2023-05-14 20:18:07 -0500
categories: VSCode IBM i Setup SSH
---
There are a few hurdles to overcome to achieve local rpgle / clle development.  This blog post will help you though those hurdles.

### You need a home directory
You need to have a home directory on your development IBM i partition.  It doesn't matter how you add it, there are several ways.  If we assume you can't SSH, you can always do it with a CRTDIR command in the greenscreen.

![Please, not more greenscreen!](/assets/images/CRTDIR.png)

### Set default shell to Bash
If you haven't done it yet, follow instructions in [this link](https://ibmi-oss-docs.readthedocs.io/en/latest/troubleshooting/SETTING_BASH.html) to set Bash as your default shell.  For historical reasons, IBM i has ksh (kornshell) as the default shell.  Most folks prefer Bash. Most open source examples you find on the web use Bash.  The absolute easiest way to do it is to run the following command in ACS Run SQL Scripts tool:

```SQL
CALL QSYS2.SET_PASE_SHELL_INFO('*CURRENT', '/QOpenSys/pkgs/bin/bash')
```

### VSCODE setup
1. Install VSCODE
   Go to the [Visual Studio Code download page] and install it on your machine.  Once installed, it will notify you when there are updates and prompt you to update it, quite seamlessly.   It usually only takes a few seconds.
2. Install extensions to VSCODE
   There are a multitude of extensions available for VSCODE.  They are available to install in the [Visual Studio Code Marketplace](https://marketplace.visualstudio.com/VSCode), or you can access the same marketplace from within the VSCODE in the extensions sidebar view:
   ![Install IBM i Development Pack](/assets/images/InstallIBMiDevelopmentPack.jpg)

   Here are the essential ones we will need.
   *  [IBM i Development Pack](https://marketplace.visualstudio.com/items?itemName=HalcyonTechLtd.ibm-i-development-pack) This will install 13 extesions, all helpfull for developming on IBM i, including the Code for IBM i extension.
   *  [GitLense](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) This gives you full visibility to your git repository, both locally and remote.
3. Log in to your IBM i with the Code for IBM i extension.
4. etc. (WIP)

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
