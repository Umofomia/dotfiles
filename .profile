# shellcheck shell=sh disable=SC1090,SC1091

export EDITOR="/usr/local/bin/mate -w"
export LESS=-RF
export PASSWORD_STORE_GENERATED_LENGTH=16
export GPG_TTY="$(tty)"

export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export NVM_DIR="${HOME}/.nvm"

export PATH="${JAVA_HOME}/bin:${HOME}/.rbenv/bin:/opt/homebrew/opt/python/libexec/bin:${PATH}:${HOME}/bin"

# Set aliases
alias battery='pmset -g batt'
alias cutt='cut -c-${COLUMNS}'
alias dotfiles='git --git-dir="${HOME}/.dotfiles.git" --work-tree="${HOME}"'
alias kb='cd /Volumes/Keybase/private/claw'
alias kbs='cd /Volumes/Keybase/private/claw,dublidu'
alias ll='ls -ahlFG'

eval "$(/opt/homebrew/bin/brew shellenv)"

# Lists all files tracked by the dotfiles repository.
# Inspired by the function mentioned in https://mitxela.com/projects/dotfiles_management
dotls() {
  (
    cd "${HOME}" &&
      for dotfile in $(dotfiles ls-files); do
        printf "%b\t%s\t%b\n" \
          "$(
              # Get the git status short format with color
              dotfiles -c color.status=always status -s -- "${dotfile}" |
                # Extract the column containing the two-character status code
                sed 's/^\( *[^ ]\{1,\}\).*/\1/' |
                # Default to two spaces when status is not present
                awk 'END { print NR ? $0 : "  " }'
            )" \
          "~/${dotfile}" \
          "$(
              # Yellow foreground color
              tput setaf 3
            )$(
              # Output the last commit subject of the file
              dotfiles log -1 --format="%s" -- "${dotfile}"
            )$(
              # Reset color
              tput sgr0
            )"
      done
  ) |
    ~/.dotfiles/script/colorcolumn -F"\t"
}

lock() { /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend; }
screensaver() { /System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine; }

# Lists TCP ports open for listening
openports() {
  sudo -v &&
    printf "%6s %6s %s\n" PORT PID COMMAND &&
    sudo lsof -iTCP -sTCP:LISTEN -n -P |
      awk 'NR>1 {print $9, $2}' |
      # Omit host specification that appears before the port
      sed 's/^[^ ]\{1,\}://' |
      while read port pid; do
        printf "%6s %6s %s\n" \
          ${port} \
          ${pid} \
          "$(
            # Look up the full command corresponding to the PID
            ps -p ${pid} -o command= |
              # Omit leading dash that indicates process was invoked as a login shell
              sed 's/^-//'
          )"
      done |
      sort -nu |
      cutt
}

groot() {
  git rev-parse --is-inside-work-tree >/dev/null && cd "$(git rev-parse --show-toplevel)" || return
}

[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
eval "$(pyenv init -)"

# Include any locally defined profile.
[ -r ~/.dotfiles/local/profile ] && . ~/.dotfiles/local/profile
