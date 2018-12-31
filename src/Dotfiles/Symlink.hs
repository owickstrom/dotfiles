module Dotfiles.Symlink (symlinkDotfiles, symlinkConfigFiles) where

import           Control.Monad
import           Dotfiles.Core
import           Dotfiles.Print
import           Dotfiles.Process
import           System.Directory
import           System.FilePath
import           System.Posix.Files
import           Text.Printf

isSymbolicLinkTo :: FilePath -> FilePath -> IO Bool
p1 `isSymbolicLinkTo` p2 =
  catch' (do t <- readSymbolicLink p1
             return $ t == p2)

symlinkDotfile :: Config -> FilePath -> IO ()
symlinkDotfile (Config _ _ br) source = do
  home <- getHomeDirectory
  let fileName     = takeFileName source
      backupTarget = br </> ("." ++ fileName)
      target       = home </> ("." ++ fileName)
  symlinked <- target `isSymbolicLinkTo` source
  if symlinked
    then warning $ printf "%s already symlinked to dotfiles." target
    else do
      exists <- fileExist target
      when exists $ do
        info $ "Renaming " ++ target ++ " to " ++ backupTarget
        createDirectoryIfMissing True br
        rename target backupTarget
        info $ printf "Created backup of %s in %s" target backupTarget
      createSymbolicLink source target
      success $ printf "Created symlink to %s" source

symlinkConfigFile :: Config -> FilePath -> FilePath -> IO ()
symlinkConfigFile (Config _ _ br) configDir source = do
  home <- getHomeDirectory
  let relPath = makeRelative configDir source
      backupTarget = br </> "config" </> relPath
      target       = home </> ".config" </> relPath
  symlinked <- target `isSymbolicLinkTo` source
  if symlinked
    then warning $ printf "%s already symlinked to config directory." target
    else do
      exists <- fileExist target
      when exists $ do
        info $ "Renaming " ++ target ++ " to " ++ backupTarget
        createDirectoryIfMissing True (takeDirectory backupTarget)
        rename target backupTarget
        info $ printf "Created backup of %s in %s" target backupTarget
      createDirectoryIfMissing True (takeDirectory target)
      createSymbolicLink source target
      success $ printf "Created symlink to %s" source

getFilesAndDirsIn :: FilePath -> IO [FilePath]
getFilesAndDirsIn dir = fmap (dir </>) <$> listDirectory dir

getFilesRecursiveIn :: FilePath -> IO [FilePath]
getFilesRecursiveIn dir = foldMap (onPath dir) =<< listDirectory dir
  where
    onPath baseDir p = do
      let absPath = baseDir </> p
      isFile' <- doesFileExist absPath
      if isFile'
        then return [absPath]
        else getFilesRecursiveIn absPath

symlinkDotfiles :: Config -> IO ()
symlinkDotfiles config@(Config os' r _) = do
  let specificDirName = case os' of
                      (Linux _) -> "linux-dotfiles"
                      OSX       -> "osx-dotfiles"
      special = [r </> "vim"]

  specific <- getFilesAndDirsIn (r </> specificDirName)
  shared <- getFilesAndDirsIn (r </> "shared-dotfiles")
  mapM_ (symlinkDotfile config) (special ++ specific ++ shared)

symlinkConfigFiles :: Config -> IO ()
symlinkConfigFiles config@(Config os' r _) = do
  let configDir       = r </> "config"
      specialDirNames = ["nvim", "Code" </> "User" </> "snippets"]
      specialDirs     = (configDir </>) <$> specialDirNames
  dirs    <- listDirectory configDir
  -- we don't want to recursively go into the nvim dir with all it's
  -- git repos, so it's special-cased here
  regular <- foldMap getFilesRecursiveIn
                     ((configDir </>) <$> filter (/= "nvim") dirs)
  mapM_ (symlinkConfigFile config configDir) (specialDirs <> regular)
