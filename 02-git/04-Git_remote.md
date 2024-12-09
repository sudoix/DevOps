![42-git_remote](../.gitbook/assets/42-git_remote.png)


### Git remote

In Git, a remote is a repository that is stored on a remote server. It allows you to collaborate with other developers on a project and to share your changes with others.

`git remote` allows you to add a remote repository to your local repository. The remote repository can be any repository that is hosted on a remote server. For example, `github.com`, `bitbucket.org` and `gitlab.com` are two popular remote repositories.

In Git, origin is a commonly used name for the default remote repository. It is automatically set up when you clone a repository from a remote source.

To view the details of the origin remote repository, you can use the following command:

```bash
$ git remote -v
```

```bash
$ git remote show origin
```

### git remote add

The `git remote add` command is used to add a new remote repository to your local Git repository. Here is the syntax of the command:

```bash
$ git remote add <remote_name> <remote_url>
```
For example, to add a remote repository hosted on GitHub with the name origin, you would use the following command:

```bash
$ git remote add origin https://github.com/username/project.git
```

### git conflict

A Git conflict occurs when there are conflicting changes in different branches or when merging branches. It happens when Git is unable to automatically merge the changes because they overlap or contradict each other.

When a conflict occurs, Git marks the conflicting lines in the affected files with special markers that look like this:

```bash
<<<<<<< HEAD
Code from the current branch
=======
Code from the branch being merged
>>>>>>> branch-name

```

You will need to manually resolve the conflict by editing the affected files and choosing which changes to keep. Once you have resolved the conflict, you need to stage the changes and commit them.

