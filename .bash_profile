[ -r ~/.profile ] && source ~/.profile

# Source .bashrc when macOS Terminal starts bash as a login shell
[ "${OSTYPE}" != "${OSTYPE#darwin}" ] &&
  shopt -q login_shell &&
  [ -r ~/.bashrc ] &&
  source ~/.bashrc
