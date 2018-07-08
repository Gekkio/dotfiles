{-# LANGUAGE FlexibleContexts #-}

import XMonad
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Config.Gnome (gnomeConfig)
import XMonad.Hooks.EwmhDesktops (fullscreenEventHook)
import XMonad.Hooks.ManageHelpers (composeOne, doFullFloat, doSideFloat, isDialog, isFullscreen, isInProperty, transience', (-?>), Side(CE))
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.IndependentScreens (countScreens, onCurrentScreen, withScreens, workspaces')
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Tabbed (simpleTabbed)

import qualified Data.Map as M
import qualified XMonad.StackSet as W

myLayoutHook = tiled ||| Mirror tiled ||| Full ||| simpleTabbed ||| Grid
  where tiled = Tall 1 (3/100) (3/5)

myManageHook = composeAll [ transience', manageWindow, manageOverrides ]
  where manageWindow = composeOne
          [ isFullscreen -?> doFullFloat
          -- Dialogs (e.g. Ubuntu logout dialog)
          , isDialog -?> doFloat
          -- Splash screens
          , isSplash -?> doIgnore
          ]
        manageOverrides = composeOne
          [ className =? "Teensy" -?> doSideFloat CE
          , (className =? "xsane" <||> className =? "Xsane") <&&> title =? "Warning" -?> doFloat
          , className =? "Gnome-calculator" -?> doFloat
          ]
        isSplash = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_SPLASH"

myModMask = mod4Mask

myStartupHook = setWMName "LG3D"

myKeys conf @ (XConfig {modMask = modMask}) = M.fromList $
  [ ((modMask .|. shiftMask, xK_q), spawn "gnome-session-quit --logout")
  ]
  ++
  [ ((m .|. modMask, k), windows $ onCurrentScreen f i)
         | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
         , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myConfig nScreens baseConfig = withSmartBorders $ withFullscreen $ withDesktopLayoutModifiers $ baseConfig
  { focusFollowsMouse = True
  , layoutHook = myLayoutHook
  , keys = myKeys <+> keys baseConfig
  , manageHook = myManageHook <+> manageHook baseConfig
  , modMask = myModMask
  , startupHook = startupHook baseConfig >> myStartupHook
  , workspaces = if nScreens > 1 then withScreens nScreens (workspaces defaultConfig) else workspaces defaultConfig
  }
  where
    -- Include support for full screen windows
    withFullscreen c = c { handleEventHook = handleEventHook c <+> fullscreenEventHook }
    -- Include smart borders (= hide when only one window exists)
    withSmartBorders c = c { layoutHook = smartBorders $ layoutHook c }
    -- Include sane desktop behaviour (e.g. avoidStruts for docks/panels)
    withDesktopLayoutModifiers c = c { layoutHook = desktopLayoutModifiers $ layoutHook c }

main = do
  nScreens <- countScreens
  xmonad $ myConfig nScreens $ gnomeConfig
