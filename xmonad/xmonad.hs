import XMonad
import XMonad.Config.Gnome (gnomeConfig)
import XMonad.Hooks.EwmhDesktops (fullscreenEventHook)
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders (smartBorders)

myManageHook = composeAll
  [ transience'
  , windowTypes
  , titles
  ]
  where windowTypes = composeOne
          [ isSplash -?> doIgnore
          , isDialog -?> doCenterFloat
          ]
        isSplash = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_SPLASH"
        titles = composeOne
          [ title =? "Eclipse" -?> doFloat
          , title =? "Monitor" -?> doFloat
          ]

myHandleEventHook = fullscreenEventHook

myModMask = mod4Mask

main =
  xmonad $ gnomeConfig
      { focusFollowsMouse = True
      , handleEventHook = myHandleEventHook <+> handleEventHook gnomeConfig
      , layoutHook = smartBorders $ layoutHook gnomeConfig
      , manageHook = myManageHook <+> manageHook gnomeConfig
      , modMask = myModMask
      }
