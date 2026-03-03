#!/bin/sh
#
# Ruby - install modern Ruby version via rbenv

if test ! $(which rbenv)
then
  echo "  Installing rbenv for you."
  brew install rbenv > /tmp/rbenv-install.log
fi

# Get the dotfiles directory (parent of ruby/)
cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

# Get the Ruby version from .ruby-version file
RUBY_VERSION=$(cat $DOTFILES_ROOT/.ruby-version)

# Check if the specified Ruby version is installed
if ! rbenv versions | grep -q "$RUBY_VERSION"; then
  echo "  Installing Ruby $RUBY_VERSION..."
  rbenv install $RUBY_VERSION
  rbenv global $RUBY_VERSION
  echo "  Ruby $RUBY_VERSION installed and set as global version"
else
  echo "  Ruby $RUBY_VERSION is already installed"
  rbenv global $RUBY_VERSION
fi

# Rehash rbenv
rbenv rehash

echo "  Current Ruby version: $(ruby -v)"
