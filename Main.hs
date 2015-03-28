{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.FilePath
import System.Directory
import Dotfiles.Core
import Dotfiles.Print
import Dotfiles.Symlink
import Dotfiles.Git
import Dotfiles.Packages
import Dotfiles.PostInstall

createConfig :: IO Config
createConfig = do
  home <- getHomeDirectory
  return Config {
    os = OSX,
    root = home </> ".dotfiles",
    backupRoot = home </> ".dotfiles.old"
  }

main :: IO ()
main = do
  header "Git Submodules"
  initSubmodules

  header "Symlinks"
  config <- createConfig
  symlinkDotfiles config

  header "Install Packages"
  installPackages config

  header "Post Install"
  postInstall config

