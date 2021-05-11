module Main where

import XMonad
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)

main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey myConfig

myBorderColour :: [Char]
myBorderColour = "#333333"

myBorderWidth :: Dimension
myBorderWidth = 2

myWorkspaces :: [[Char]]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myTerminal :: [Char]
myTerminal = "/usr/bin/zsh"

myPP :: PP
myPP =
  xmobarPP
    { ppCurrent = xmobarColor "#117FF5" "",
      ppTitle = const "",
      ppHidden = xmobarColor "#626262" "",
      ppHiddenNoWindows = xmobarColor "#626262" ""
    }

myKeys :: [((KeyMask, KeySym), X ())]
myKeys =
  [ -- Functions

    ((mod4Mask, xK_F1), spawn "amixer -D pulse set Master 1+ toggle"),
    ((mod4Mask, xK_F2), spawn "amixer -D pulse sset Master 5%-"),
    ((mod4Mask, xK_F3), spawn "amixer -D pulse sset Master 5%+"),
    -- sudoers file hack, because of weird intel drivers
    ((mod4Mask, xK_F5), spawn "sudo light -U 5"),
    ((mod4Mask, xK_F6), spawn "sudo light -A 5"),
    ((mod4Mask, xK_F11), spawn "xkb-switch -n"),
    -- Applications
    ((mod4Mask, xK_b), spawn "brave"),
    ((mod4Mask, xK_w), kill),
    ((mod4Mask, xK_d), spawn "rofi -show run"),
    ((mod4Mask, xK_o), spawn "pass clip --rofi"),
    ((mod4Mask, xK_End), spawn "dm-tool lock"),
    ((mod4Mask, xK_v), windows copyToAll),
    ((controlMask .|. mod4Mask, xK_v), killAllOtherCopies),
    ((0, xK_Print), spawn "sleep 0.2; scrot -o -q 100 -s /tmp/shot.png; copyq write image/png - < /tmp/shot.png && copyq select 0"),
    ((controlMask, xK_Print), spawn "scrot -o -q 100 /tmp/shot.png; copyq write image/png - < /tmp/shot.png && copyq select 0"),
    -- Adjust split
    ((mod4Mask, xK_j), sendMessage MirrorShrink),
    ((mod4Mask, xK_k), sendMessage MirrorExpand),
    -- Workspaces
    ((controlMask .|. mod4Mask, xK_l), nextWS),
    ((controlMask .|. mod4Mask, xK_h), prevWS),
    ((mod4Mask .|. shiftMask, xK_l), shiftToNext >> nextWS),
    ((mod4Mask .|. shiftMask, xK_h), shiftToPrev >> prevWS),
    -- Master pane count
    ((mod4Mask, xK_apostrophe), sendMessage (IncMasterN (-1))),
    ((mod4Mask, xK_semicolon), sendMessage (IncMasterN 1))
  ]

toggleStrutsKey :: XConfig l -> (KeyMask, KeySym)
toggleStrutsKey XConfig {modMask = modm} = (modm, xK_b)

myManageHook :: ManageHook
myManageHook =
  composeAll
    [ isFullscreen --> (doF W.focusDown <+> doFullFloat),
      className =? "mpv" --> doRectFloat (W.RationalRect 0.9 0.84 0.09 0.13) <+> doF copyToAll
    ]

type MyResizable = ModifiedLayout SmartBorder ResizableTall

myResizable :: MyResizable a
myResizable = smartBorders $ ResizableTall 1 (3 / 100) (1 / 2) []

myLayout :: Choose (ModifiedLayout SmartBorder ResizableTall) (Choose (Mirror (ModifiedLayout SmartBorder ResizableTall)) Full) a
myLayout = myResizable ||| Mirror myResizable ||| Full

myConfig :: XConfig (Choose (ModifiedLayout SmartBorder ResizableTall) (Choose (Mirror (ModifiedLayout SmartBorder ResizableTall)) Full))
myConfig =
  def
    { terminal = myTerminal,
      borderWidth = myBorderWidth,
      normalBorderColor = myBorderColour,
      focusedBorderColor = myBorderColour,
      workspaces = myWorkspaces,
      manageHook = myManageHook,
      modMask = mod4Mask,
      layoutHook = myLayout
    }
    `removeKeys` [(mod4Mask, xK_comma), (mod4Mask, xK_period), (mod4Mask, xK_k), (mod4Mask, xK_j)]
    `additionalKeys` myKeys
