# Directory: /usr/share/cachyos-fish-config/
# CUSTOM ALIASES

alias webssh="ssh -p 22 harsh@192.168.122.78"
alias update="sudo pacman -Syyu"
alias pacin="sudo pacman -S $1"
alias pipin="pip install $1"
alias pip3in="pip3 install $1"
alias pipun="pip uninstall $1"
alias pip3un="pip3 uninstall $1"
alias ipa="ip a | awk '{print $2}' | grep 192.168 | sed -n '1p' | cut -d '/' -f 1"
alias pwdc="pwd | xclip -sel c"
alias pyhs="python -m http.server"


# CUSTOM FUNCTIONS

function amazon
  set S $(printf '%s' "$argv" | tr ' ' '+')
  brave --guest "https://www.amazon.in/s?k=$S"
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

