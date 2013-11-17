source "$HOME/.profile"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM

# Add built cabal binaries to path
[[ -s "$HOME/.cabal/bin" ]] && export PATH="$PATH:$HOME/.cabal/bin/"

