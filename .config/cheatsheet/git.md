---
title: Git
date: 2020-11-25 18:28:43
background: bg-[#d7593e]
tags:
  - github
  - gitlab
  - version
  - VCS
categories:
  - Linux Command
intro: This cheat sheet summarizes commonly used Git command line instructions for quick reference.
plugins:
  - copyCode
---

## Getting Started

### Create a Repository

Create a new local repository

```sh
$ git init [project name]
```

Clone a repository

```sh
$ git clone git_url
```

Clone a repository into a specified directory

```sh
$ git clone git_url my_directory
```

### Make a change 

Show modified files in working directory, staged for your next commit

```sh
$ git status
```

Stages the file, ready for commit

```sh
$ git add [file]
```

Stage all changed files, ready for commit

```sh
$ git add .
```

Commit all staged files to version history

```sh
$ git commit -m "commit message"
```

Commit all your tracked files to version history

```sh
$ git commit -am "commit message"
```

Discard changes in working directory which is not staged

```sh
$ git restore [file]
```

Unstage a staged file or file which is staged

```sh
$ git restore --staged [file]
```

Unstage a file, keeping the file changes

```sh
$ git reset [file]
```

Revert everything to the last commit

```sh
$ git reset --hard
```

Diff of what is changed but not staged

```sh
$ git diff
```

Diff of what is staged but not yet committed

```sh
$ git diff --staged
```

Apply any commits of current branch ahead of specified one

```sh
$ git rebase [branch]
```

### Configuration

Set the name that will be attached to your commits and tags

```sh
$ git config --global user.name "name"
```

Set an email address that will be attached to your commits and tags

```sh
$ git config --global user.email "email"
```

Enable some colorization of Git output

```sh
$ git config --global color.ui auto
```

Edit the global configuration file in a text editor

```sh
$ git config --global --edit
```

### Working with Branches

List all local branches

```sh
$ git branch
```

List all branches, local and remote

```sh
$ git branch -av
```

Switch to my_branch, and update working directory

```sh
$ git checkout my_branch
```

Create a new branch called new_branch

```sh
$ git checkout -b new_branch
```

Delete the branch called my_branch

```sh
$ git branch -d my_branch
```

Merge branchA into branchB

```sh
$ git checkout branchB
$ git merge branchA
```

Tag the current commit

```sh
$ git tag my_tag
```

### Observe your Repository

Show the commit history for the currently active branch

```sh
$ git log
```

Show the commits on branchA that are not on branchB

```sh
$ git log branchB..branchA
```

Show the commits that changed file, even across renames

```sh
$ git log --follow [file]
```

Show the diff of what is in branchA that is not in branchB

```sh
$ git diff branchB...branchA
```

Show any object in Git in human-readable format

```sh
$ git show [SHA]
```

### Synchronize

Fetch down all the branches from that Git remote

```sh
$ git fetch [alias]
```

Merge a remote branch into your current branch to bring it up to date

```sh
$ git merge [alias]/[branch]
# No fast-forward
$ git merge --no-ff [alias]/[branch]
# Only fast-forward
$ git merge --ff-only [alias]/[branch]
```

Transmit local branch commits to the remote repository branch

```sh
$ git push [alias] [branch]
```

Fetch and merge any commits from the tracking remote branch

```sh
$ git pull
```

Merge just one specific commit from another branch to your current branch

```sh
$ git cherry-pick [commit_id]
```

### Remote

Add a git URL as an alias

```sh
$ git remote add [alias] [url]
```

Show the names of the remote repositories you've set up

```sh
$ git remote
```

Show the names and URLs of the remote repositories

```sh
$ git remote -v
```

Remove a remote repository

```sh
$ git remote rm [remote repo name]
```

Change the URL of the git repo

```sh
$ git remote set-url origin [git_url]
```

### Temporary Commits

Save modified and staged changes

```sh
$ git stash
```

List stack-order of stashed file changes

```sh
$ git stash list
```

Write working from top of stash stack

```sh
$ git stash pop
```

Discard the changes from top of stash stack

```sh
$ git stash drop
```

### Tracking path Changes

Delete the file from project and stage the removal for commit

```sh
$ git rm [file]
```

Change an existing file path and stage the move

```sh
$ git mv [existing-path] [new-path]
```

Show all commit logs with indication of any paths that moved

```sh
$ git log --stat -M
```

### Ignoring Files

```
/logs/*

# "!" means don't ignore
!logs/.gitkeep

/# Ignore Mac system files
.DS_store

# Ignore node_modules folder
node_modules

# Ignore SASS config files
.sass-cache
```

A `.gitignore` file specifies intentionally untracked files that Git should ignore

## Git Tricks

### Rename branch

- #### **Renamed** to `new_name`
  ```sh
  $ git branch -m <new_name>
  ```
- #### **Push** and reset
  ```sh
  $ git push origin -u <new_name>
  ```
- #### **Delete** remote branch
  ```sh
  $ git push origin --delete <old>
  ```
  {.marker-timeline}

### Log

Search change by content

```sh
$ git log -S'<a term in the source>'
```

Show changes over time for specific file

```sh
$ git log -p <file_name>
```

Print out a cool visualization of your log

```sh
$ git log --pretty=oneline --graph --decorate --all
```

### Branch 

List all branches and their upstreams

```sh
$ git branch -vv
```

Quickly switch to the previous branch

```sh
$ git checkout -
```

Get only remote branches

```sh
$ git branch -r
```

Checkout a single file from another branch

```sh
$ git checkout <branch> -- <file>
```

### Rewriting history

Rewrite last commit message

```sh
$ git commit --amend -m "new message"
```

Amend the latest commit without changing the commit message.

```sh
$ git commit --amend --no-edit
```

See also: [Rewriting history](https://www.atlassian.com/git/tutorials/rewriting-history)

### Git Aliases

```cmd
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
```

See also: [More Aliases](https://gist.github.com/johnpolacek/69604a1f6861129ef088)

## Advanced Git

### Submodules

Create a new submodule within your repository:

```sh
$ git submodule add <repository_url> <path>
```

Clone a repository and initialize its submodules:

```sh
$ git clone --recursive <repository_url>
```

Update all the submodules in your repository to the latest commit of their respective branches:

```sh
$ git submodule update
```

Pull the latest changes from the remote repositories of the submodules and update them in your main repository:

```sh
$ git submodule update --remote
```

Remove a submodule from your repository:

```sh
$ git submodule deinit <path>
$ git rm <path>
$ git commit -m "Removed submodule"
```

### Cherry-picking

Cherry-picking allows you to apply a specific commit from one branch to another branch.

```sh
$ git cherry-pick <commit_hash>
```

### Reflog

Display the reflog, showing the history of HEAD and branch movements:

```sh
$ git reflog
```

Find the hash of the lost commit or branch using the reflog and then checkout to that hash to restore it:

```sh
$ git checkout <commit_or_branch_hash>
```
