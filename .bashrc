HISTCONTROL=ignorespace:ignoredups:erasedups
HISTFILESIZE=10000
HISTSIZE=10000
shopt -s histappend

# Temporary function for setting CDPATH so we can make use of local variables
# that are only used within the function.
__set_cdpath__() {
  local cdpaths path

  for cdpaths in ~/.dotfiles/cdpaths ~/.dotfiles/local/cdpaths; do
    if [ -r "${cdpaths}" ]; then
      while IFS= read -r path; do
        if [ -z "${CDPATH}" ]; then
          CDPATH="${path}"
        else
          case ":${CDPATH}:" in
            *":${path}:"*)
              # Path already exists in CDPATH.
              ;;
            *)
              CDPATH="${CDPATH}:${path}"
              ;;
          esac
        fi
      done <"${cdpaths}"
    fi
  done

  # Undefine the function after it has run.
  unset -f "${FUNCNAME[0]}"
}
__set_cdpath__

# Temporary function for exporting prompt variables so we can make use of
# local variables that are only used within the function.
__set_bash_prompts__() {
  # Define the colors we'll be using.
  # They are wrapped within \[ and \] to indicate to bash that they are
  # non-printing characters so the prompt display width can be properly
  # calculated.
  local reset='\[\e[0m\]'
  local green='\[\e[0;32m\]'
  local yellow='\[\e[0;33m\]'
  local cyan='\[\e[0;36m\]'
  local dark_gray='\[\e[0;90m\]'

  export PS1="${dark_gray}[${cyan}\\u@\\h${DARK_GRAY}:${green}\$(dirs)${yellow}\$(__git_ps1)${dark_gray}]\\\$ ${reset}"
  export PS2="${dark_gray}> ${reset}"
  export PS4="${dark_gray}+ ${reset}"

  # Undefine the function after it has run.
  unset -f "${FUNCNAME[0]}"
}
__set_bash_prompts__

command -v brew >/dev/null 2>&1 &&
  [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ] &&
  source "$(brew --prefix)/etc/profile.d/bash_completion.sh"

[ -r ~/.fzf.bash ] && source ~/.fzf.bash

command -v rbenv >/dev/null 2>&1 &&
  eval "$(rbenv init -)"

# Include any locally defined bashrc.
[ -r ~/.dotfiles/local/bashrc ] && source ~/.dotfiles/local/bashrc
