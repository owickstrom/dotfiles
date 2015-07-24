module Dotfiles.PostInstall (postInstall) where

import System.FilePath
import System.Process
import System.Directory
import Text.Regex
import Data.Maybe
import Control.Monad
import Dotfiles.Core
import Dotfiles.Process
import Dotfiles.Print

remapCapsLockToCtrl :: Config -> IO ()
remapCapsLockToCtrl (Config _ root' _) = do
  run_ "osascript" [root' </> "lib" </> "remap-capslock-to-ctrl.scpt"]
  success "Caps Lock mapped to CTRL!"

installedVersion :: Regex
installedVersion = mkRegex "Versions installed\\: [a-zA-Z0-9.]+"

test :: Regex -> String -> Bool
test r s = isJust $ matchRegex r s

isCabalPackageInstalled :: String -> IO Bool
isCabalPackageInstalled pkg = do
  output <- lines `fmap` run "cabal" ["info", pkg]
  return $ any (test installedVersion) output

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

makeVimProc :: Config -> IO ()
makeVimProc  (Config _ root' _) =
  run_ "make" ["--directory=" ++ dir]
  where dir = root' </> "vim" </> "bundle" </> "vimproc.vim"

installNvm :: Config -> IO ()
installNvm (Config _ root' _) = run_ (root' </> "lib" </> "install-nvm.sh") []

postInstall :: Config -> IO ()
postInstall c@(Config OSX _ _) = do
  remapCapsLockToCtrl c
  installGhcMod
  installNvm c
  makeVimProc c
postInstall (Config (Linux _) _ _) =
  warning "TODO: Implemented post install for Linux!"