-- Logs app focus to focus.log for the my-impact dashboard. Agents
-- driving Chrome steal focus, so each activation is tagged `user`
-- when a key or click came just before it, else `auto`.
local M = {
  path = os.getenv("HOME") .. "/.config/jrasmusbm/focus.log",
  lastInput = 0,
}

local function log(what, who)
  local f = io.open(M.path, "a")
  if not f then return end
  f:write(string.format("%d\tapp\t%s\t%s\n", os.time(), what, who))
  f:close()
end

local et = hs.eventtap.event.types
M.input = hs.eventtap.new(
  { et.keyDown, et.leftMouseDown, et.rightMouseDown },
  function()
    M.lastInput = hs.timer.secondsSinceEpoch()
    return false
  end
)
M.input:start()

M.apps = hs.application.watcher.new(function(name, evt, _)
  if evt == hs.application.watcher.activated then
    local human = hs.timer.secondsSinceEpoch() - M.lastInput < 1.5
    log(name or "?", human and "user" or "auto")
  end
end)
M.apps:start()

-- Browser time is grouped per tab, not per app: while a Chromium
-- browser is in front, each tab switch or page change logs
-- `tab<TAB>url<TAB>title` (switching tabs never activates the app,
-- so the app watcher can't see it).
M.browsers = { ["Brave Browser"] = true, ["Google Chrome"] = true }
M.lastTab = nil

local function clean(s)
  return (s or ""):gsub("[\t\n\r]", " "):sub(1, 200)
end

local function logTab()
  local front = hs.application.frontmostApplication()
  local name = front and front:name()
  if not (name and M.browsers[name]) then return end
  local ok, res = hs.osascript.applescript(string.format([[
    tell application "%s"
      set t to active tab of front window
      return (URL of t) & (character id 9) & (title of t)
    end tell]], name))
  if not ok or not res then return end
  local url, title = res:match("^(.-)\t(.*)$")
  if not url or url == M.lastTab then return end
  M.lastTab = url
  local f = io.open(M.path, "a")
  if not f then return end
  f:write(string.format("%d\ttab\t%s\t%s\n", os.time(), clean(url), clean(title)))
  f:close()
end

M.tabTimer = nil
local function soon()
  if M.tabTimer then M.tabTimer:stop() end
  M.tabTimer = hs.timer.doAfter(0.7, logTab)
end

M.browserWindows = hs.window.filter.new(function(w)
  local app = w:application()
  return app and M.browsers[app:name()] or false
end)
M.browserWindows:subscribe({
  hs.window.filter.windowFocused,
  hs.window.filter.windowTitleChanged,
}, soon)

local away = {
  [hs.caffeinate.watcher.screensDidLock] = true,
  [hs.caffeinate.watcher.screensaverDidStart] = true,
  [hs.caffeinate.watcher.systemWillSleep] = true,
}
M.power = hs.caffeinate.watcher.new(function(evt)
  if away[evt] then
    log("(away)", "user")
  elseif evt == hs.caffeinate.watcher.screensDidUnlock then
    local front = hs.application.frontmostApplication()
    log(front and front:name() or "?", "user")
  end
end)
M.power:start()

spoon.FocusLog = M
return M
