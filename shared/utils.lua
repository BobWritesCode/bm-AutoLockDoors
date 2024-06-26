Debug = Config.Debug

function Notification(src, _title, msg, _notifyType, _notifyTime)
  if Config.Notify == "QB" then
    local notifyTime = _notifyTime or 5000
    local notifyType = _notifyType or "primary"
    if src then
      TriggerClientEvent('QBCore:Notify', src, msg, notifyType, notifyTime)
    else
      TriggerEvent('QBCore:Notify', msg, notifyType, notifyTime)
    end
  elseif Config.Notify == "okokNotify" then
    local title = _title or "Chicken Job"
    local notifyTime = _notifyTime or 5000
    local notifyType = _notifyType or "primary"
    TriggerClientEvent('okokNotify:Alert', src, title, msg, notifyTime, notifyType)
  end
end

function ErrorPrint(str1, str2)
  print("^1[Error] ^2" .. tostring(str1) .. "^3" .. tostring(str2) .. "^7")
end

function DebugPrint(str)
  if Config.Debug then print("^4[Debug] ^2" .. tostring(str) .. "^7") end
end

function DebugPrint2(str1, str2)
  if Config.Debug then print("^4[Debug] ^2" .. tostring(str1) .. "^3" .. tostring(str2) .. "^7") end
end

print("^1[Bob\'s Mods] ^2Auto Door Locks ^7- ^5Utils^7")
