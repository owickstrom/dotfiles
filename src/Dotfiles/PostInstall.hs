{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes      #-}
module Dotfiles.PostInstall (postInstall) where

import           System.Directory
import           System.FilePath
import           System.Process

import           Control.Monad
import           Data.Maybe
import           Dotfiles.Core
import           Dotfiles.Print
import           Dotfiles.Process

remapCapsLockToCtrl :: Config -> IO ()
remapCapsLockToCtrl (Config _ root' _) = do
  run_ "osascript" [root' </> "lib" </> "remap-capslock-to-ctrl.scpt"]
  success "Caps Lock mapped to CTRL!"

enableWakelock :: Config -> IO ()
enableWakelock Config{} = do
  run_ "systemctl" ["--user", "enable", "wakelock.service"]
  success "Wakelock enabled!"

postInstall :: Config -> IO ()
postInstall c@(Config OSX _ _) = do
  remapCapsLockToCtrl c
postInstall c@(Config (Linux _) _ _) =
  enableWakelock c
