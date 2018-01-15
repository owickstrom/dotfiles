#!/usr/bin/env runhaskell

{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified System.Info as I
import System.FilePath
import System.Directory
import Dotfiles.Core
import Dotfiles.Print
import Dotfiles.Symlink
import Dotfiles.Packages
import Dotfiles.PostInstall
import Dotfiles.Process

getPackageManager :: IO PackageManager
getPackageManager =
  let byProgram = [("apt-get", APT), ("yum", Yum), ("pacman", Pacman)]
      tryFindProgram [] = fail "No package manager found!"
      tryFindProgram ((program, pm) : ps) = do
        exists <- catchAssert $ run_ "which" [program]
        if exists then return pm else tryFindProgram ps
  in tryFindProgram byProgram

getOs :: IO OS
getOs = do
  case I.os of
    "darwin" -> return OSX
    "linux" -> Linux `fmap` getPackageManager
    _ -> fail "Could not detect operating system!"

createConfig :: IO Config
createConfig = do
  home <- getHomeDirectory
  os' <- getOs
  return Config {
    os = os',
    root = home </> ".dotfiles",
    backupRoot = home </> ".dotfiles.old"
  }

printConfig :: Config -> IO ()
printConfig (Config os' root' backupRoot') = do
  info $ "Operating System: " ++ show os'
  info $ "Dotfiles directory: " ++ show root'
  info $ "Backup directory: " ++ show backupRoot'

main :: IO ()
main = do
  header "Configuration"
  config <- createConfig
  printConfig config

  header "Symlinks"
  symlinkDotfiles config
  symlinkConfigFiles config

  header "Install Packages"
  installPackages config

  header "Post Install"
  postInstall config

