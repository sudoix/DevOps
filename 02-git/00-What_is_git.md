![38](../assets/38-git.png)

# Git

Git is a distributed version control system that allows multiple developers to collaborate on a project. It tracks changes to files and directories over time, allowing you to revert to previous versions if needed. Git provides features like branching and merging, which make it easier to work on different features or bug fixes simultaneously. It also allows you to work offline and then synchronize your changes with a remote repository when you have an internet connection.

Git was created by `Linus Torvalds`, the same person who created the Linux operating system. He initially developed it in 2005 to manage the source code of the Linux kernel.

Git is a widely used version control system that offers several benefits:

* Easy Collaboration: Git allows multiple developers to work on the same project simultaneously. It enables easy collaboration by providing features like branching, merging, and conflict resolution.

* Version control: Git tracks changes to your codebase, allowing you to easily revert to previous versions if needed. It provides a complete history of all changes made, including who made them and when.

* Branching and merging: Git allows you to create branches to work on new features or experiments without affecting the main codebase. Once the changes are ready, you can merge them back into the main branch.

* Backup and recovery: By using Git, your codebase is stored both locally and remotely. This provides an additional layer of backup, making it easier to recover from accidental code loss or hardware failures.

* Code sharing: Git provides platforms like GitHub, GitLab, and Bitbucket that allow you to easily share your code with others. These platforms also provide additional collaboration features like issue tracking and code reviews.

Git is a distributed VCS widely used for managing source code. It allows multiple developers to work on a project simultaneously and tracks changes to files over time. Some popular platforms that use Git include `GitHub`, `GitLab`, and `Bitbucket`.

To use Git, you can use it in `command line`, `code editor` and `graphical interface`

## Install git

**Linux (Ubuntu)**

Open a terminal and run the following command to install Git on Ubuntu:

```
sudo apt update
sudo apt-get install git
```
Once the installation is complete, you can run `git --version` in the terminal to verify that Git was installed successfully.

**macOS**

Git can be installed on macOS through various methods. One way is to use the Homebrew package manager. If you don't have Homebrew installed, you can install it by following the instructions at [brew](https://brew.sh/)

```
brew install git
```

**Windows**

good luck :)

Download and install Git on your machine. You can find the official Git installation for your operating system at [git download](https://git-scm.com/downloads)

Changing the default branch name from "master" to "main" in Git is a way to promote inclusive language and remove potentially offensive terms associated with slavery and oppression. The terminology used in Git, like "master" and "slave," has been considered problematic and exclusionary.

### At the core of the branching model

At the core, the development model is greatly inspired by existing models out there. The central repo holds two main branches with an infinite lifetime:

`master`
`develop`

The master branch at origin should be familiar to every Git user. Parallel to the master branch, another branch exists called develop.

We consider origin/master to be the main branch where the source code of HEAD always reflects a production-ready state.


sources:
https://nvie.com/posts/a-successful-git-branching-model/
https://www.gitkraken.com/learn/git/git-flow
