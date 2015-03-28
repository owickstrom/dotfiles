module Dotfiles.Symlink (symlinkDotfiles) where

import System.FilePath
import System.Posix.Files
import System.Directory
import Text.Printf
import Control.Monad
import Dotfiles.Core
import Dotfiles.Print
import Dotfiles.Process

isSymbolicLinkTo :: FilePath -> FilePath -> IO Bool
p1 `isSymbolicLinkTo` p2 =
  catch' (do t <- readSymbolicLink p1
             return $ t == p2)

symlinkDotfile :: Config -> FilePath -> IO ()
symlinkDotfile (Config _ _ br) source = do
  home <- getHomeDirectory
  let fileName = takeFileName source
      backupTarget = br </> ("." ++ fileName)
      target = home </> ("." ++ fileName)

  symlinked <- target `isSymbolicLinkTo` source
  if symlinked then
    warning $ printf "%s already symlinked to dotfiles." target
  else
    do exists <- fileExist target
       info $ "Renaming " ++ target ++ " to " ++ backupTarget
       when exists $ do rename target backupTarget
                        info $ printf "Created backup of %s in %s" target backupTarget
       createSymbolicLink source target
       success $ printf "Created symlink to %s" source

validDotfilePath :: FilePath -> Bool
validDotfilePath ".." = False
validDotfilePath "." = False
validDotfilePath _ = True

getDotfilesInDirectory :: FilePath -> IO [FilePath]
getDotfilesInDirectory dir = do
  names <- getDirectoryContents dir
  return $ map (dir </>) $ filter validDotfilePath names

symlinkDotfiles :: Config -> IO ()
symlinkDotfiles config@(Config os' r _) = do
  let specificDirName = case os' of
                      (Linux _) -> "linux-dotfiles"
                      OSX -> "osx-dotfiles"
      special = [r </> "vim"]

  -- TODO: git clone owickstrom/prelude and symlink to $HOME/.emacs.d

  specific <- getDotfilesInDirectory (r </> specificDirName)
  shared <- getDotfilesInDirectory (r </> "shared-dotfiles")
  mapM_ (symlinkDotfile config) (special ++ specific ++ shared)
