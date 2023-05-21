---
layout: post
title:  "Code for IBM i - Setup"
date:   2023-05-18 10:18:07 -0500
categories: VSCode IBM i Setup SSH
---
This post explains some Code for IBM i settings that I find helpful.

### Connection Settings
Find these settings by right clicking on your connection and selecting "Connection Settings"

#### Features
* Quick Connect - faster is better.
* Enable SQL - Use this if your QCCSID setting is NOT 65535.  If it is, just leave it unchecked.  To check this, you can run `DSPSYSVAL QCCSID` from 5250, or `system dspsysval qccsid` from an ssh session.

*Checking QCCSID system value from an SSH session - NOT 65535, YAY*  
![QCCSID from SSH Session](/assets/images/QCCSID.jpg)

* Show description of libraries in User Library List view
![Show description next to libraries](/assets/images/Settings-lib-desc.jpg)

* Support EBCDIC streamfiles
  I don't really use this.  Streamfile source shoult be UTF-8, but if you converted source from file members, they may be 
* Errors to ignore
  I don't use this, but I can see how this could be helpful.
* Auto Save for Actions
  I do like to keep this checked.  Its very frustraqting when you forget to hit save and have to go back and do it again.

#### Source Code
* Source ASP
  I haven't needed to use this - you need it if your development IBM i lpar has an Auxilary Storage Pool.
* Source file CCSID
  You probably don't need to change this from \*FILE.  The instructions say to only change it if you have a source file that is 65535.  You can check this in an SSH session with `cl dspfd LibName/FileName | grep CCSID`.
  ![Checking file CCSID](/assets/images/FileCCSID.jpg)
* Enable Source Dates
  I do keep this checked, since I work in source members from time to time.
* Source date tracking mode
  Use Diff mode - it works better.
* Source Dates in Gutter
  This is a personal preference - I find myself going back and forth on this one.  If you refer to source dates a bunch, you probably want them in the gutter, otherwise, leave it unchecked.
  ![Source Dates in Gutter](/assets/images/SourceDatesInGutter.png)
* Read only mode
  There are situations where this would be useful - perhaps a connection with filters to source files that you don't have authority to modify.

#### Terminals
These settings are all about the tn5250 greenscreen terminal integrated into the Code for IBM i extension.  For the most part these can be left as is. 
* 5250 encoding
  Take the default unless you know what you are doing.
* 5250 Terminal Type
  Take the default unless you know what you are doing.
* Set Device Name for 5250
  You probably don't need to check this.
* Not sure why you would need to enter a connection string.  Take the default unless you know what you are doing.

#### Debugger
* Debug Port
  Change this only if needed
* Update Production Files
  I normally keep this one checked
* Debug trace
  Leave unchecked
* Debug Securely
  Check it if required by your organization
#### Temporary Data
* Temporary Library
  This is an important one.  This must be the name of a library that you have write access to.  If you are using PUB400.com, it can be only one of the 2 libraries that you were given.
* Temporary IFS Directory
  I have never needed to change this from /tmp
* Clear Temporary Data Automatically
  Keep this one checked
* Sort IFS Shortcuts Automatically
  This is a personal preference.  How do you want your IFS shortcuts sorted?




