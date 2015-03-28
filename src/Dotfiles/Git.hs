module Dotfiles.Git where

import Dotfiles.Print
import Dotfiles.Process

initSubmodules :: IO ()
initSubmodules = do
  run_ "git" ["submodule", "update", "--init"]
  success "Git submodules initialized!"
