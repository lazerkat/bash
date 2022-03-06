# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Command to print a color prompt containing:
# - A dot indicating if the last command ran successfully
# - The hostname
# - The current directory
# - The > character marking the start of user input
__color_prompt() {
  local EXIT="$?"
  PS1=""

  local bold_green='\[\e[01;32m\]'
  local bold_red='\[\e[01;31m\]'
  local bold_blue='\[\e[01;34m\]'
  local bold_cyan='\[\e[01;36m\]'
  local reset='\[\e[0m\]'

  # Red if exit code non-zero, otherwise green.
  if [ $EXIT != 0 ]; then
    PS1+="${bold_red}"
  else
    PS1+="${bold_green}"
  fi

  PS1+="• ${bold_cyan}\h ${bold_blue}\w ${bold_cyan}>${reset}"
}

# Only show the last 3 parts of the path
PROMPT_DIRTRIM=3

# Check for whether this is a color prompt
case "$TERM" in
  xterm-*color|screen-*color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
  PROMPT_COMMAND=__color_prompt
else
  PS1="• \h \w >"
fi

unset color_prompt

# Ask to confirm on deletion and overwrite
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Enable color output for common commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
