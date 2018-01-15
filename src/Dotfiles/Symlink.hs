module Dotfiles.Symlink (symlinkDotfiles, symlinkConfigFiles) where

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
       when exists $ do
	 info $ "Renaming " ++ target ++ " to " ++ backupTarget
	 createDirectoryIfMissing True br
         rename target backupTarget
         info $ printf "Created backup of %s in %s" target backupTarget
       createSymbolicLink source target
       success $ printf "Created symlink to %s" source

symlinkConfigFile :: Config -> FilePath -> IO ()
symlinkConfigFile (Config _ _ br) source = do
  home <- getHomeDirectory
  let fileName = takeFileName source
      backupTarget = br </> "config" </> fileName
      target = home </> ".config" </> fileName
  symlinked <- target `isSymbolicLinkTo` source
  if symlinked then
    warning $ printf "%s already symlinked to config directory." target
  else
    do exists <- fileExist target
       when exists $ do info $ "Renaming " ++ target ++ " to " ++ backupTarget
                        createDirectoryIfMissing True br
                        rename target backupTarget
                        info $ printf "Created backup of %s in %s" target backupTarget
       createSymbolicLink source target
       success $ printf "Created symlink to %s" source

validDotfilePath :: FilePath -> Bool
validDotfilePath ".." = False
validDotfilePath "." = False
validDotfilePath _ = True

getFilesInDirectory :: FilePath -> IO [FilePath]
getFilesInDirectory dir = do
  names <- getDirectoryContents dir
  return $ map (dir </>) $ filter validDotfilePath names

symlinkDotfiles :: Config -> IO ()
symlinkDotfiles config@(Config os' r _) = do
  let specificDirName = case os' of
                      (Linux _) -> "linux-dotfiles"
                      OSX -> "osx-dotfiles"
      special = [r </> "vim"]

  specific <- getFilesInDirectory (r </> specificDirName)
  shared <- getFilesInDirectory (r </> "shared-dotfiles")
  mapM_ (symlinkDotfile config) (special ++ specific ++ shared)

symlinkConfigFiles :: Config -> IO ()
symlinkConfigFiles config@(Config os' r _) =
  mapM_ (symlinkConfigFile config) =<< getFilesInDirectory (r </> "config")

