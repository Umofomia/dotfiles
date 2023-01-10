# Clyde's Dotfiles

## Setup

Using `wget`:

```sh
wget -O - https://raw.githubusercontent.com/Umofomia/dotfiles/master/.dotfiles/setup | bash
```

Using `curl`:

```sh
bash <(curl https://raw.githubusercontent.com/Umofomia/dotfiles/master/.dotfiles/setup)
```

## File structure

* `.dotfiles` - Hosts supplementary files that dotfiles can refer to.
* `.dotfiles.git` - Hosts the bare git repository; not actually part of the repository, but is created locally to track the repository's local metadata.
* `.github` - Hosts the README file so that it can be displayed in GitHub [without ending up in the home directory](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes).
