module Dotfiles.Core where

import qualified System.FilePath as FP

type PackageID = String
data PackageManager = APT | Yum | Pacman
data OS = Linux PackageManager | OSX

data Config = Config { os :: OS,
                       root :: FP.FilePath,
                       backupRoot :: FP.FilePath }
