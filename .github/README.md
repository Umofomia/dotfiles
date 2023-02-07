# Clyde's Dotfiles

My dotfiles are set up as a bare git repository whose working directory is the user home directory (`~`) and whose git metadata is managed in `~/.dotfiles.git`.
It is inspired by the set up described by [this article](https://www.atlassian.com/git/tutorials/dotfiles) which was inspired by [this Hacker News comment](https://news.ycombinator.com/item?id=11071754) by [StreakyCobra](https://news.ycombinator.com/user?id=StreakyCobra).

## Setup

A self-contained setup script is available to automatically clone the repository and check out the files on a new machine.

* Using `wget`:

    ```sh
    wget -O - https://raw.githubusercontent.com/Umofomia/dotfiles/master/.dotfiles/script/setup | sh
    ```

* Using `curl`:

    ```sh
    curl https://raw.githubusercontent.com/Umofomia/dotfiles/master/.dotfiles/script/setup | sh
    ```

## File structure

The `.dotfiles.git` directory hosts the bare git repository.
It is not part of the repository, but is used to track the repository's git metadata.

Because this repository is configured as a bare git repository, its files are placed relative to where they would be located in the user home directory.

Files are also located within the following directories:

* `.dotfiles` - Hosts configuration that other dotfiles can refer to.

  * `local` - Dotfiles may reference files in this directory to include configuration that is specific to the local machine.
    Files in this directory should not be checked into this repository.
    If version control is desired for these files, it is suggested that this directory be managed as a separate git repository (which doesn't need to be bare like this one).

  * `script` - Executable scripts that dotfiles may make use of.
    Also includes the `setup` script that installs this repository's dotfiles.

* `.github` - Hosts the README file so that it can be displayed in GitHub [without ending up in the home directory](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes).
