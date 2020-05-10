# Contributing to Mia-Platform Helm Charts Library

Welcome! 🥳 We hope you will successfully start to contribute to this project after reading this little guide.  
In trying to keep this document short and on point it will show to you the goals, the commit and coding
style of the project that you have to follow in your future contributions.  
If you find something amiss, well you have found yourself a nice little first issue to work on if you want 🙂

## The Project Goal

This project is not aiming to make cath’all Helm Charts, but its aiming to give users ready for production,
with minimal configurations, Helm Charts for tipical tools you want to have in your kubernetes cluster.  
Our experiences are mostly with GKE (Google Kubernetes Engine) clusters and a minimal interaction with
OKE (Oracle Container Engine for Kubernetes) and EKS (Amazon Elastic Kubernetes Service) so something is surely missing
and can be improved.  

## What You Can Do

Basically anything you want to add better standard settings, improve the security of the deployment,
improve the High Availability configurations, add integration with tracing, service
mesh, and metrics, improve documentations, etc.

## Commit Style

This project is following the guidelines of [Conventional Commit] for the commit messages, so you are encouraged to read
them first and trying to follow them as much as possible, we can always fix them during the Merge Request process.

### Revert

If the commit reverts a previous commit, it should begin with `revert:`, followed by the header of the reverted commit.
In the body it should say: `This reverts commit <hash>.`, where the hash is the SHA of the commit being reverted.

### Type

Must be one of the following:

- **ci**: Changes to our CI configuration files and scripts
- **docs**: Documentation only changes (add new sections, fixing typos, etc)
- **feat**: A new feature
- **fix**: A bug fix
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **style**: Changes that do not affect the templates features (indentation, formatting, missing quotes, etc)
- **test**: Adding missing tests or correcting existing tests

## Coding Style

The project contains an [`.editorconfig`](/.editorconfig) file for setting up your editor if you have installed the
appropriate [plugin].

[Conventional Commit]: https://www.conventionalcommits.org (A specification for adding human and machine readable meaning to commit messages)
[plugin]: https://editorconfig.org/#download (EditorConfig is a file format and collection of text editor plugins for maintaining consistent coding styles between different editors and IDEs.)
