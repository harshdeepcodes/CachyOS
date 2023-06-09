# Directory: /usr/share/cachyos-fish-config/


## Source from conf.d before our fish config
source /usr/share/cachyos-fish-config/conf.d/done.fish


## Set values
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

## Export variable need for qt-theme
if type "qtile" >> /dev/null 2>&1
   set -x QT_QPA_PLATFORMTHEME "qt5ct"
end

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Enable Wayland support for different applications
if [ "$XDG_SESSION_TYPE" = "wayland" ]
    set -gx WAYLAND 1
    set -gx QT_QPA_PLATFORM 'wayland;xcb'
    set -gx GDK_BACKEND 'wayland,x11'
    set -gx MOZ_DBUS_REMOTE 1
    set -gx MOZ_ENABLE_WAYLAND 1
    set -gx _JAVA_AWT_WM_NONREPARENTING 1
    set -gx BEMENU_BACKEND wayland
    set -gx CLUTTER_BACKEND wayland
    set -gx ECORE_EVAS_ENGINE wayland_egl
    set -gx ELM_ENGINE wayland_egl
end

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
  source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end


## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## Useful aliases
# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles

# Common use
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias rmpkg="sudo pacman -Rdd"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias upd='/usr/bin/update'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                                   # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'          # List amount of -git packages

# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Help people new to Arch
alias apt='man pacman'
alias apt-get='man pacman'
alias please='sudo'
alias tb='nc termbin.com 9999'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"


## Run fastfetch if session is interactive
if status --is-interactive
   fastfetch
end

# CUSTOM ALIASES

alias update="sudo pacman -Syyu"
alias pacin="sudo pacman -S $1"
alias pipin="pip install $1"
alias pip3in="pip3 install $1"
alias pipun="pip uninstall $1"
alias pip3un="pip3 uninstall $1"
alias ipa="ip a | awk '{print $2}' | grep 192.168 | sed -n '1p' | cut -d '/' -f 1"
alias pwdc="pwd | xclip -sel c"
alias pyhs="python -m http.server"
alias clsradio="mpv --no-video https://live.musopen.org:8085/streamvbr0"
alias lofiradio="mpv --no-video https://www.youtube.com/c/LofiGirl"
alias adbbkp="adb backup -apk -shared -all -f backup.ab"
alias gitc="git clone $1"

## CUSTOM FUNCTIONS

function amazon
  set S $(printf '%s' "$argv" | tr ' ' '+')
  brave --guest "https://www.amazon.in/s?k="$S""
end

function bpsh
  set S $(printf '%s' "$argv")
  echo "#!/bin/bash" > $S && vim $S
end

function bppy
  set S $(printf '%s' "$argv")
  echo "#!/bin/python" > $S && vim $S
end

function anonyt
  set S $(printf '%s' "$argv" | tr ' ' '+')
  brave --guest "https://www.youtube.com/results?search_query=$S"
end


function ytmusic
        set S $(printf '%s' "$argv" | sed -e 's/ /+/g')
        set LINK "https://www.youtube.com$(curl -s "https://vid.puffyan.us/search?q=$S" | grep -s -Eo "/watch\?v=.{11}" | sed -n '1p')"
        set TITLE $(wget -qO- "$LINK" | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)(?: - youtube)?\s*<\/title/si')
        echo "

---X---X---X---X---X---X---X---X---

$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)$(tput setaf 3) "$TITLE" $(tput sgr 0)$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)

$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0) $(tput setaf 1)$(tput setab 7) "$LINK" $(tput sgr 0) $(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)

---X---X---X---X---X---X---X---X---

"
        mpv --no-video "$LINK"
end

function ytmax
        set S $(printf '%s' "$argv" | sed -e 's/ /+/g')
        set LINK "https://www.youtube.com$(curl -s "https://vid.puffyan.us/search?q=$S" | grep -s -Eo "/watch\?v=.{11}" | sed -n '1p')"
        set TITLE $(wget -qO- "$LINK" | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)(?: - youtube)?\s*<\/title/si')
        echo "

---X---X---X---X---X---X---X---X---

$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)$(tput setaf 3) "$TITLE" $(tput sgr 0)$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)

$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0) $(tput setaf 1)$(tput setab 7) "$LINK" $(tput sgr 0) $(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)

---X---X---X---X---X---X---X---X---

"
        mpv "$LINK"
end

function ytuhd
        set S $(printf '%s' "$argv" | sed -e 's/ /+/g')
        set LINK "https://www.youtube.com$(curl -s "https://vid.puffyan.us/search?q=$S" | grep -s -Eo "/watch\?v=.{11}" | sed -n '1p')"
        set TITLE $(wget -qO- "$LINK" | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)(?: - youtube)?\s*<\/title/si')
        echo "

---X---X---X---X---X---X---X---X---

$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)$(tput setaf 3) "$TITLE" $(tput sgr 0)$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)

$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0) $(tput setaf 1)$(tput setab 7) "$LINK" $(tput sgr 0) $(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)

---X---X---X---X---X---X---X---X---

"
        mpv --ytdl-format="bestvideo[ext=mp4][height<=?2160]+bestaudio" "$LINK"

end

function ytfhd
        set S $(printf '%s' "$argv" | sed -e 's/ /+/g')
        set LINK "https://www.youtube.com$(curl -s "https://vid.puffyan.us/search?q=$S" | grep -s -Eo "/watch\?v=.{11}" | sed -n '1p')"
        set TITLE $(wget -qO- "$LINK" | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)(?: - youtube)?\s*<\/title/si')
        echo "

---X---X---X---X---X---X---X---X---

$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)$(tput setaf 3) "$TITLE" $(tput sgr 0)$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)

$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0) $(tput setaf 1)$(tput setab 7) "$LINK" $(tput sgr 0) $(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)

---X---X---X---X---X---X---X---X---

"
        mpv --ytdl-format="bestvideo[ext=mp4][height<=?1080]+bestaudio" "$LINK"

end


function ythd
        set S $(printf '%s' "$argv" | sed -e 's/ /+/g')
        set LINK "https://www.youtube.com$(curl -s "https://vid.puffyan.us/search?q=$S" | grep -s -Eo "/watch\?v=.{11}" | sed -n '1p')"
        set TITLE $(wget -qO- "$LINK" | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)(?: - youtube)?\s*<\/title/si')
        echo "

---X---X---X---X---X---X---X---X---

$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)$(tput setaf 3) "$TITLE" $(tput sgr 0)$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)

$(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0) $(tput setaf 1)$(tput setab 7) "$LINK" $(tput sgr 0) $(tput setab 1)$(tput setaf 7) ▶ $(tput sgr 0)

---X---X---X---X---X---X---X---X---

"
        mpv --ytdl-format="bestvideo[ext=mp4][height<=?720]+bestaudio" "$LINK"

end
