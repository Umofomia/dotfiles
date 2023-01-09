# Clyde's Dotfiles

## Setup

```sh
git clone --bare git@github.com:Umofomia/dotfiles.git "${HOME}/.dotfiles.git"
alias dotfiles='git --git-dir="${HOME}/.dotfiles.git" --work-tree="${HOME}"'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

## File structure

* `.dotfiles.git` - Hosts the bare git repository; not actually part of the repository, but is created locally to track the repository's local metadata.
* `.github` - Hosts the README file so that it can be displayed in GitHub [without ending up in the home directory](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes).
