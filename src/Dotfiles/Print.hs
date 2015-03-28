{-# LANGUAGE OverloadedStrings #-}

module Dotfiles.Print where

import System.Console.ANSI

printWithStyle :: [SGR] -> String -> IO ()
printWithStyle styles t = do
  setSGR [SetConsoleIntensity BoldIntensity,
          SetColor Foreground Vivid Magenta]
  putStr "=> "
  setSGR [Reset]
  setSGR styles
  putStrLn t
  setSGR [Reset]

header :: String -> IO ()
header = printWithStyle [SetUnderlining SingleUnderline,
                         SetConsoleIntensity BoldIntensity]

info :: String -> IO ()
info = printWithStyle [SetConsoleIntensity BoldIntensity,
                       SetColor Foreground Vivid Blue]

echo :: String -> IO ()
echo = printWithStyle []

success :: String -> IO ()
success = printWithStyle [SetColor Foreground Vivid Green]

warning :: String -> IO ()
warning = printWithStyle [SetColor Foreground Vivid Yellow]
