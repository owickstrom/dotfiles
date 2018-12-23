#!/usr/bin/env bash

function is_us {
  setxkbmap -query | grep -q "layout:\s\+us"
}

function set_se {
  echo -e "Switching to $(tput bold)$(tput setaf 5)Swedish$(tput sgr0) keyboard layout."
  setxkbmap se
}

function set_us {
  echo -e "Switching to $(tput bold)$(tput setaf 2)US American$(tput sgr0) keyboard layout."
  setxkbmap us
}

(is_us && set_se) || set_us

echo "Remapping keys."
xmodmap "$HOME/.Xmodmap"

echo "Done!"
