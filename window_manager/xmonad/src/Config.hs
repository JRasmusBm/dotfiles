module Main where

import XMonad

main =
  xmonad
    def
      { modMask = mod4Mask,
        terminal = "/usr/bin/zsh"
      }
