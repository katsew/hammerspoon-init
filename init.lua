local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()      
   end
end

local function keyCodeSet(keys)
   return function()
      for i, keyEvent in ipairs(keys) do
         keyEvent()
      end
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local function disableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:disable()
   end
end

local function enableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:enable()
   end
end

local function handleGlobalAppEvent(name, event, app)
   if event == hs.application.watcher.activated then
      if name == "iTerm2" then
         disableAllHotkeys()         
      else
         enableAllHotkeys()
      end
   end
end

appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

-- カーソル移動
remapKey({'ctrl'}, 'f', keyCode('right'))
remapKey({'ctrl'}, 'b', keyCode('left'))
remapKey({'ctrl'}, 'n', keyCode('down'))
remapKey({'ctrl'}, 'p', keyCode('up'))
remapKey({'ctrl'}, 'e', keyCode('right', {'cmd'}))
remapKey({'ctrl'}, 'a', keyCode('left', {'cmd'}))

remapKey({'ctrl', 'shift'}, 'f', keyCode('right', {'shift'}))
remapKey({'ctrl', 'shift'}, 'b', keyCode('left', {'shift'}))
remapKey({'ctrl', 'shift'}, 'n', keyCode('down', {'shift'}))
remapKey({'ctrl', 'shift'}, 'p', keyCode('up', {'shift'}))

remapKey({'ctrl', 'cmd'}, 'f', keyCode('right', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'b', keyCode('left', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'n', keyCode('down', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'p', keyCode('up', {'cmd'}))

-- ページスクロール
remapKey({'ctrl'}, 'v', keyCode('pagedown'))
remapKey({'ctrl'}, 'u', keyCode('pageup'))