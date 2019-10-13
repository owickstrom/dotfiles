module Dotfiles.Core where

import qualified System.FilePath as FP

type PackageID = String
data PackageManager = APT | Yum | DNF | Pacman | Nix deriving (Eq, Show)
data OS = Linux PackageManager | OSX deriving (Eq, Show)

data Config = Config { os :: OS,
                       root :: FP.FilePath,
                       backupRoot :: FP.FilePath } deriving (Eq, Show)
