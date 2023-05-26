# Directory: /usr/share/cachyos-fish-config/
# CUSTOM ALIASES

alias webssh="ssh -p 22 harsh@192.168.122.78"
alias update="sudo pacman -Syyu"
alias pacin="sudo pacman -S $1"
alias pipin="pip install $1"
alias pip3in="pip3 install $1"
alias ipa="ip a | awk '{print $2}' | grep 192.168 | sed -n '1p' | cut -d '/' -f 1"
alias pwdc="pwd | xclip -sel c"
alias pyhs="python -m http.server"


# CUSTOM FUNCTIONS

function amazon
  set S $(printf '%s' "$argv" | tr ' ' '+')
  brave --guest "https://www.amazon.in/s?k=$S"
end

function bashbp
  set S $(printf '%s' "$argv")
  echo "#!/bin/bash" > $S && vim $S
end

function anonyt
  set S $(printf '%s' "$argv" | tr ' ' '+')
  brave --guest "https://www.youtube.com/results?search_query=$S"
end
