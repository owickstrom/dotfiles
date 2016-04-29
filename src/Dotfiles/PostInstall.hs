{-# LANGUAGE QuasiQuotes, FlexibleContexts #-}
module Dotfiles.PostInstall (postInstall) where

import System.FilePath
import System.Process
import System.Directory

import Data.Maybe
import Control.Monad
import Dotfiles.Core
import Dotfiles.Process
import Dotfiles.Print

remapCapsLockToCtrl :: Config -> IO ()
remapCapsLockToCtrl (Config _ root' _) = do
  run_ "osascript" [root' </> "lib" </> "remap-capslock-to-ctrl.scpt"]
  success "Caps Lock mapped to CTRL!"

postInstall :: Config -> IO ()
postInstall c@(Config OSX _ _) = do
  remapCapsLockToCtrl c
postInstall (Config (Linux _) _ _) =
  warning "TODO: Implemented post install for Linux!"
