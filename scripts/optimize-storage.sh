#! /bin/sh

RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE_BOLD='\033[1;34m'
RESET='\033[0m'



prompt() {
  printf "$1"
  read -p "(y/n): " response
  case "$response" in
    [yY]|[yY][eE][sS]) return 1;;
    [nN]|[nN][oO]) return 0;;
    *) printf "${YELLOW}Invalid Response!${RESET}\n"; return 0;;
  esac
}


if ! prompt "This script will delete ${RED}ALL${RESET} previous derivations! Would you like to continue?"; then
  printf "Optimising Store..."
  sudo nix-collect-garbage -d
  sudo nix-store --optimise -v
else
  printf "Exiting..."
fi



