import Data.Monoid
import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "gnome-terminal"

manageHooks :: [ManageHook]
manageHooks = 
  [ isSplash --> doIgnore
  , isFullscreen --> doFullFloat
  , isDialog --> doCenterFloat
  , title =? "Eclipse" --> doFloat
  , appName =? "Do" --> doIgnore
  ]
  where isSplash = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_SPLASH" 

main :: IO ()
main =
  xmonad $ gnomeConfig
      { terminal = myTerminal
        , modMask = myModMask
        , manageHook = manageHook gnomeConfig <+> composeAll manageHooks
        , layoutHook = avoidStruts $ smartBorders $ layoutHook gnomeConfig
        , startupHook = startupHook gnomeConfig >> setWMName "LG3D"
        , logHook = fadeInactiveLogHook 0.8
        , focusFollowsMouse = True
      }
