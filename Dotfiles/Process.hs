module Dotfiles.Process where

import System.Process
import Control.Exception

run :: String -> [String] -> IO String
run cmd args = readProcess cmd args ""

run_ :: String -> [String] -> IO ()
run_ cmd args = run cmd args >>= const (return ())

catch' :: IO Bool -> IO Bool
catch' action = catch action
                      (const $ return False :: IOException -> IO Bool)

catchAssert :: IO a -> IO Bool
catchAssert action = catch' (do _ <- action
                                return True)


