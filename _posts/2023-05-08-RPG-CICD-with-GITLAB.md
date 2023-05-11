### ILE CiCd Pipeline with Gitlab

This will be the first of a series of blog posts about using GITLAB to build a full CICD pipeline for building, testing, linting, and deploying RPG code.

![image CiCd](/_images/CiCd.gif)

### What is CiCd?
The Ci in CiCd stands for Continuous Integration.  This usually means integrating automated tools into your build and test process.  Emphasis on the word 'automated'.  No lever pulling or button pushing.

The Cd in CiCd stands for Continuous Delivery, or Continuous Deployment.  It really stands for both but CiCdCd seems silly to say.

There are several CiCd tools out there.  Jenkins, Bamboo, CircleCi, Github actions are other tools.  We will talk about Gitlab since there aren't many examples for CiCd pipelines for IBM i with Gitlab out there.

### Whats the Goal ?
By the end of this series of blog posts, you will
1) Have a Git Repo on your local PC
2) Have an IFS home directory on an IBM i LPAR where you can deploy and build code - basically do development.
3) Have a remote Git repo set up in Gitlab that will stay in sync with your code
4) Have a protected 'main' branch in your repo.  Protected just means you don't work directly on the branch, when you set out to do work, you create a 'feature' branch off of 'main' where you will do your coding, compiling, maybe some debugging, unit test, etc while still in the development phase.
5) When you feel like your code is ready, you merge your changes on the feature branch back to 'main', which automatically initiates the pipeline.
9) As you are coding you are doing test driven development, meaning you write code for the application you are supporting, but you are also writing code that 'tests' each unit of work that you do.  The code for these unit tests are part of a test suite that will run automatically when you merge your code back to 'main'.
6) The pipeline will include a series of automated jobs:
   a) Automated build of your code changes, and additionally create a save file "package" that you can deploy to multiple targets.
   b) Apply RPG linting rules and stop the pipeline if any of them are broken
   c) Run automated unit tests and stop the pipeline if any tests fail
   d) Deploy the package to an IBM i partition, unpack it, and copy the objects to a target library.

### Why Gitlab
When coding CiCd with Gitlab, you put in logic to run jobs that run in Gitlab Runners.  Gitlab runners can run in kubernetes, linux servers, or windows servers.  One thing a gitlab runner can't run on is IBM i, due to the fact that Gitlab Runner code is written in GO, which doesn't not have a runtime on IBM i at the time of this writing.  Jenkins works better with IBM i because it is JAVA based, and its runner code can run natively on IBM i.

So why would you choose to use Gitlab for CiCd with IBM i? 
1) Gitlab has been gaining marketshare and is more modern?  If you use Gitlab, you can start using words like Kubernetes in your every day.
2) Your organization may use GITLAB already and you would like them to think you are just as cool.
3) Seriously, a whole lot of shops are choosing GITLAB right now, and perhaps we should look at what it takes to stay relevant in the IBM i space.

### Prerequisit knowlege - stuff you should know before hand
* You should probably know a bit about GIT before you attempt this.  If you have never used GIT, its time you did.  If you don't know the difference between GIT and GITHUB - stop right now.  Read some Git tutorials, watch some Youtube, make yourself a free github or gitlab account, figure out how to stage, commit, push, pull and merge.  You'll be better off if you know these things before you attempt to do CiCd.  If you have used turnover or Aldon before in your IBM i exploits, you can probably grasp it.  In fact, Aldon LMi is basically CiCd for traditional IBM i code.  At least thats what the folks at Rocket will tell you.
* You need to use a modern editor.  No PDM / SEU users here.  If you love SEU, go back in your corner.  I can't help you.  I will be useing VSCODE and its excellent Code for IBM i extension, but you could also use RDi with source code management (eGit) features installed.

### Prerequisit Software
Yeah, your going to have to have an open source environment set up.  A sandbox, if you will.  Your sandbox will consist of:

1) A login to an IBM i development partition at 7.3 or above that has the SSH daemon enabled and the following open source packages installed:
   
    * Bob
    * Git

If you don't have an IBM i partition to play around on, you can create a free account at PUB400.COM.  PUB400 has all required open source packages installed, but the unfortunate thing is that certain commands that are important to the deployment part of the pipeline are not allowed with the free account.

This blog post will not go into details about setting up open source on IBM i and installing open source package dependencies.  For help with that, you are encouraged to [read the documentation](https://www.ibm.com/support/pages/getting-started-open-source-package-management-ibm-i-acs) and ask for help on the [IBM i Open Source Ryvver forum](http://ibm.biz/ibmioss-chat-join) if you get stuck.

2) Gitlab - If you don't have access or ability to host a self managed Gitlab installation, you can create a free account at gitlab.com.  Creating an account does not require credit card entry, but running ci/cd on gitlab.com's runners does.  The good news is that you will not be charged unless you purchase more than the free 400 minutes of ci/cd compute quota - which is pretty generous.  If you run out of minutes, you will just not be able to run any more ci/cd jobs until the next month, or you buy more.  If you are using your company's self-managed gitlab, you will need maintainer access to a sandbox project.

The next blog post will describe the process of setting up a local, git-enabled development environment on your pc and sync it with gitlab.
