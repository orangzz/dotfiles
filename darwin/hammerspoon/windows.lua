--  position to either full screen, maximum screen,  half screen (edges), or quarter screen (corners)

-- drag to snap zone

-- window movement
-- edit mode cmd+x
-- wasdc move-left move-bottom move-top move-right move center
-- yuio top-left  bottom-left  bottom-right  top-right
-- hjkl right-half  bottom-half top-half  left-half

-- window positioning
-- window resizing

-- space movement
--   circle space
--   jump to space



--  recalculates window sizes when moving between displays.
--  resizing windows near screen edges and/or the Dock.
-- when disconnecting an external display.
-- Grow and Shrink via keyboard now repeat when you hold the assigned keys down
--- overlapping, obscuring
-- assign window to screen

local config = {
    windowGap = 10,
    outerGap = 20,
    animationDuration = 0.2,
    modifier = {"shift", "cmd"}
}

{
    "saved-layouts": [
      -- split side by side, main panel on left.If either pane has more than one window, that pane will split into columns
      --  all the remaining windows are placed in the other pane with only one window being visible at a time
        "tall",

        "two-pane"
    ],
    "mod1": [
        "control",
        "shift"
    ],

    "actions": {
      "resize",
      "move",
      "swap",
      "focus"
    }

    "layouts-on-screen-1": [
        "tall",
        "fullscreen"
    ],
    "layouts-on-screen-2": [
        "two-pane",
        "tall"
    ],
    "layouts-on-screen-3": [
        "floating"
    ],

    "window-resize-step": 5,

    "floating-applications": [
        "Activity Monitor",
    ],

}
--  layout actions/controls
-- `expandMain`
-- `shrinkMain`
-- `increaseMainCount`
-- `decreaseMainCount`

-- change/events
-- a window has been added to tracking
-- a window has been removed from tracking
-- the current focused window has changes
-- two windows have been swapped in position
-- "space_change"
-- "layout_change"



function toggle_maximizescreen()
  return function()
      local win = hs.window.focusedWindow()
      if not win then
        win:setFullScreen(not win:isFullScreen())
      end
  end
end



local function moveToLeftHalf()
  return function()
    local win = hs.window.focusedWindow()
     local frame = win:frame()
     local screen = win:screen(),frame()
     f.x = max.x
     f.y = max.y
     f.w = max.w / 2
     f.h = max.h
     win:setFrame(frame, config.animationDuration)
  end
end

local function moveToRightHalf()
  return function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local max = screen:frame()
      f.x = max.x + max.w / 2
      f.y = max.y
      f.w = max.w / 2
      f.h = max.h
      win:setFrame(f)
  end
end

local function getCurrentWindow()
    local win = hs.window.focusedWindow()
    if not win then
      hs.alert.show("No focused window")
      return
    end
    return win
end

local function positionWindow(positionFn)
  return function()
    local win = getCurrentWindow()
    if not win then return end
    local frame = win:frame()
    local screen = screen:frame():frame()

    positionFn(frame, screen)
    win:setFrame(frame, config.animationDuration)
end

local windowPositions = {
  leftHalf = positionWindow(function(frame, screen)
    frame.x = screen.x
    frame.y = screen.y
    frame.w = screen.w / 2
    frame.h = screen.h
  end),
  rightHalf = positionWindow(function(frame, screen)
    frame.x = screen.x + screen.w / 2
    frame.y = screen.y
    frame.w = screen.w / 2
    frame.h = screen.h
  end),
  topHalf = positionWindow(function(frame, screen)
    frame.x = screen.x
    frame.y = screen.y
    frame.w = screen.w
    frame.h = screen.h / 2
  end),
    bottomHalf = positionWindow(function(frame, screen)
    frame.x = screen.x
    frame.y = screen.y + screen.h / 2
    frame.w = screen.w
    frame.h = screen.h / 2
  end),
}


local function executeAmethystCommand(args)
    local task = hs.task.new("/usr/local/bin/amethyst", nil, args)
    if task then
        task:start()
    else
        hs.alert.show("Failed to execute Amethyst command")
    end
end

local amethystCommands = {
    toggleFloat = function()
        executeAmethystCommand({"-m", "window", "--toggle", "float"})
    end,

    cycleLayoutForward = function()
        executeAmethystCommand({"-m", "layout", "--cycle", "forward"})
    end,

    cycleLayoutBackward = function()
        executeAmethystCommand({"-m", "layout", "--cycle", "backward"})
    end,

    expandMainPane = function()
        executeAmethystCommand({"-m", "layout", "--expand-main"})
    end,

    shrinkMainPane = function()
        executeAmethystCommand({"-m", "layout", "--shrink-main"})
    end,

    increaseMainCount = function()
        executeAmethystCommand({"-m", "layout", "--increase-main"})
    end,

    decreaseMainCount = function()
        executeAmethystCommand({"-m", "layout", "--decrease-main"})
    end,

    focusClockwise = function()
        executeAmethystCommand({"-m", "window", "--focus", "clockwise"})
    end,

    focusCounterClockwise = function()
        executeAmethystCommand({"-m", "window", "--focus", "counterclockwise"})
    end,

    swapClockwise = function()
        executeAmethystCommand({"-m", "window", "--swap", "clockwise"})
    end,

    swapCounterClockwise = function()
        executeAmethystCommand({"-m", "window", "--swap", "counterclockwise"})
    end,

    swapWithMain = function()
        executeAmethystCommand({"-m", "window", "--swap", "main"})
    end
}

local function setupHotkeys()
  local mod = config.super
local function setupHotkeys()
    local mod = config.modifier

    -- Window positioning hotkeys
    hs.hotkey.bind(mod, "h", windowPositions.leftHalf)      -- Left half
    hs.hotkey.bind(mod, "l", windowPositions.rightHalf)     -- Right half
    hs.hotkey.bind(mod, "k", windowPositions.topHalf)       -- Top half
    hs.hotkey.bind(mod, "j", windowPositions.bottomHalf)    -- Bottom half
    hs.hotkey.bind(mod, "m", windowPositions.maximize)      -- Maximize
    hs.hotkey.bind(mod, "f", toggleFullscreen())            -- Toggle fullscreen

    -- Amethyst integration hotkeys
    hs.hotkey.bind(mod, "space", amethystCommands.toggleFloat)           -- Toggle float
    hs.hotkey.bind(mod, "tab", amethystCommands.cycleLayoutForward)      -- Next layout
    hs.hotkey.bind(mod, "`", amethystCommands.cycleLayoutBackward)       -- Previous layout

    -- main pane adjustments
    hs.hotkey.bind(mod, "=", amethystCommands.expandMainPane)            -- Expand main
    hs.hotkey.bind(mod, "-", amethystCommands.shrinkMainPane)            -- Shrink main
    hs.hotkey.bind(mod, "]", amethystCommands.increaseMainCount)         -- More main windows
    hs.hotkey.bind(mod, "[", amethystCommands.decreaseMainCount)         -- Fewer main windows

    -- Focus and swapping
    hs.hotkey.bind(mod, "n", amethystCommands.focusClockwise)            -- Focus next
    hs.hotkey.bind(mod, "p", amethystCommands.focusCounterClockwise)     -- Focus previous
    hs.hotkey.bind(mod, "return", amethystCommands.swapWithMain)         -- Swap with main
    hs.hotkey.bind(mod, ".", amethystCommands.swapClockwise)             -- Swap clockwise
    hs.hotkey.bind(mod, ",", amethystCommands.swapCounterClockwise)      -- Swap counter-clockwise
end

-- clockwise position


-- swap position


-- cycle layout forward
-- cycle layout backward
-- increase main panel count
-- decrease main panel count
-- custom layout 1
-- custom layout 2
-- move focus counter clockwise
-- move focus clockwise
-- move focus to main window
-- move focus to clockwise screen
-- swap focus window to counter clockwise screen
-- swap focus window to  clockwise screen
-- swap focus window to  clockwise
-- swap focus window to  counter clockwise
-- swap focus window with main window
-- throw focus window to space left
-- throw focus window to space right
-- throw focus window to space 1
-- throw focus window to space 2
-- throw focus window to space screen 1
-- focus screen 1
-- throw focus window to space screen 2
-- focus screen 2
end

-- Reload hotkey
hs.hotkey.bind(config.modifier, "r", function()
    hs.reload()
end)


hs.hotkey.bind(config.modifier, "space", function()
  hs.execute('opt/homebrew/bin/sketchybar --trigger swap_menus_and_spaces')
end)

