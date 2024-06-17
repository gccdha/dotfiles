#! /bin/sh

RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE_BOLD='\033[1;34m'
RESET='\033[0m'



prompt() {
  printf "$1"
  read -p "(y/n): " response
  case "$response" in
    [yY]|[yY][eE][sS]) return 1 ;;
    [nN]|[nN][oO]) return 0;;
    *) printf "${YELLOW}Invalid Response!${RESET}\n"; return prompt "$1" ;;
  esac
}

cd /home/realram/.dotfiles

if prompt "Would you like to run '${BLUE_BOLD}git add -A${RESET}'?"; then
  git add -A
else
  git add -u
fi

if ! prompt "Would you like to use the date as the commit message?"; then
  git commit -m "build at $(date +"%Y-%m-%d at %H:%M")"
else
  commit=""
  read -p "Commit message: " commit
  git commit -m "$commit"
fi

git push

sudo nixos-rebuild switch --flake .#

