{-# LANGUAGE FlexibleContexts #-}

import XMonad
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Config.Gnome (gnomeConfig)
import XMonad.Hooks.ManageHelpers (composeOne, doSideFloat, isDialog, isInProperty, transience, (-?>), Side(CE))
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.Fullscreen (fullscreenSupport)
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Tabbed (simpleTabbed)

import qualified Data.Map as M

myLayoutHook = tiled ||| Full ||| simpleTabbed ||| Grid
  where tiled = Tall 1 (3/100) (3/5)

myManageHook = composeAll [ manageWindow, manageOverrides ]
  where manageWindow = composeOne
          [ transience
          -- Dialogs (e.g. Ubuntu logout dialog)
          , isDialog -?> doFloat
          -- Splash screens
          , isSplash -?> doIgnore
          ]
        manageOverrides = composeOne
          [ className =? "Teensy" -?> doSideFloat CE
          , (className =? "xsane" <||> className =? "Xsane") <&&> title =? "Warning" -?> doFloat
          ]
        isSplash = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_SPLASH"

myModMask = mod4Mask

myStartupHook = setWMName "LG3D"

myKeys (XConfig {modMask = modMask}) = M.fromList
  [ ((modMask .|. shiftMask, xK_q), spawn "gnome-session-quit --logout")
  ]

myConfig baseConfig = withSmartBorders $ withFullscreen $ withDesktopLayoutModifiers $ baseConfig
  { focusFollowsMouse = True
  , layoutHook = myLayoutHook
  , keys = myKeys <+> keys baseConfig
  , manageHook = myManageHook <+> manageHook baseConfig
  , modMask = myModMask
  , startupHook = startupHook baseConfig >> myStartupHook
  }
  where
    -- Include support for full screen windows
    withFullscreen = fullscreenSupport
    -- Include smart borders (= hide when only one window exists)
    withSmartBorders c = c { layoutHook = smartBorders $ layoutHook c }
    -- Include sane desktop behaviour (e.g. avoidStruts for docks/panels)
    withDesktopLayoutModifiers c = c { layoutHook = desktopLayoutModifiers $ layoutHook c }

main = xmonad $ myConfig $ gnomeConfig
