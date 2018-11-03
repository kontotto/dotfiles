#!/bin/bash

set -eux

has() {
  which "$1" >/dev/null 2>&1
}

DOTPATH=~/.dotfiles

dotfiles_download() {
  if has "curl" || has "wget"; then
    local tarball="https://github.com/kontotto/dotfiles/archive/master.tar.gz"
    if has "curl"; then
      curl -L "$tarball"
    elif has "wget"; then
      wget -O - "$tarball"
    fi | tar xvz

    mv -f dotfiles-master "$DOTPATH"
  else
    die "curl or wget required"
  fi
}

dotfiles_deploy() {
  if [ ! -d $DOTPATH ]; then
    log_fail "$DOTPATH: not found"
    exit 1
  fi
  cd "$DOTPATH"
  make deploy
}

dotfiles_install() {
	vim +"GoInstallBinaries"
}

dotfiles_download
dotfiles_deploy
dotfiles_install
