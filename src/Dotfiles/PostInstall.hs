{-# LANGUAGE QuasiQuotes, FlexibleContexts #-}
module Dotfiles.PostInstall (postInstall) where

import System.FilePath
import System.Process
import System.Directory
import Text.Regex.PCRE.Heavy

import Data.Maybe
import Control.Monad
import Dotfiles.Core
import Dotfiles.Process
import Dotfiles.Print

remapCapsLockToCtrl :: Config -> IO ()
remapCapsLockToCtrl (Config _ root' _) = do
  run_ "osascript" [root' </> "lib" </> "remap-capslock-to-ctrl.scpt"]
  success "Caps Lock mapped to CTRL!"


isInstalled :: String -> Bool
isInstalled s = not $ null $ scan [re|Versions installed\\: [a-zA-Z0-9.]+|] s

isCabalPackageInstalled :: String -> IO Bool
isCabalPackageInstalled pkg = do
  output <- lines `fmap` run "cabal" ["info", pkg]
  return $ any isInstalled output

installGhcMod :: IO ()
installGhcMod = do
  isInstalled <- isCabalPackageInstalled "ghc-mod"
  if isInstalled then info "ghc-mod is already installed."
  else do
    echo "Updating cabal..."
    run_ "cabal" ["update"]
    echo "Installing ghc-mod..."
    run_ "cabal" ["install", "ghc-mod"]
    success "ghc-mod installed successfully!"

installNvm :: Config -> IO ()
installNvm (Config _ root' _) = run_ (root' </> "lib" </> "install-nvm.sh") []

postInstall :: Config -> IO ()
postInstall c@(Config OSX _ _) = do
  remapCapsLockToCtrl c
  installGhcMod
  installNvm c
postInstall (Config (Linux _) _ _) =
  warning "TODO: Implemented post install for Linux!"
