module Dotfiles.Packages (installPackages) where

import Control.Monad
import Dotfiles.Core
import Dotfiles.Print
import Dotfiles.Process

isAlreadyInstalled :: OS -> PackageID -> IO Bool
isAlreadyInstalled OSX pkg = catchAssert $ run_ "brew" ["ls", pkg]
-- TODO!
isAlreadyInstalled _ _ = return False

isNotInstalled :: OS -> PackageID -> IO Bool
isNotInstalled os' pkg = do
  isInstalled <- isAlreadyInstalled os' pkg
  return $ not isInstalled

packages :: OS -> [PackageID]
packages (Linux APT) = ["git", "terminator", "tmux", "tmuxinator", "tmate", "curl", "wget", "irssi", "htop", "net-tools"]
packages (Linux Yum) = ["git", "tmux", "curl", "wget", "vim-enhanced", "irssi", "ctags", "pandoc"]
packages (Linux DNF) = ["git", "tmux", "curl", "wget"]
packages (Linux Pacman) = ["git", "tmux", "curl", "wget", "vim", "irssi", "ctags", "base-devel", "pandoc"]
packages (Linux Nix) = []
packages OSX = ["bash", "bash-completion", "git", "tmux", "ctags-exuberant", "reattach-to-user-namespace"]

toInstallFor :: OS -> IO [PackageID]
toInstallFor os' = filterM (isNotInstalled os') (packages os')

runInstaller :: OS -> [PackageID] -> IO ()
runInstaller (Linux APT) pkgs = run_ "sudo" $ ["apt-get", "-y", "install"] ++ pkgs
runInstaller (Linux DNF) pkgs = run_ "sudo" $ ["dnf", "install", "-y"] ++ pkgs
runInstaller (Linux Yum) pkgs = run_ "sudo" $ ["yum", "install"] ++ pkgs
runInstaller (Linux Pacman) pkgs = run_ "sudo" $ ["pacman", "-S"] ++ pkgs
runInstaller (Linux Nix) pkgs = run_ "nix-env" $ "-i" : pkgs
runInstaller OSX pkgs = run_ "brew" $ "install" : pkgs

installPackages :: Config -> IO ()
installPackages (Config os' _ _) = do
  pkgs <- toInstallFor os'
  unless (null pkgs) $ runInstaller os' pkgs
  success "Packages installed successfully!"
