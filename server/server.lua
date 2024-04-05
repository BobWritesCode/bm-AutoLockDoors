local QBCore = exports['qb-core']:GetCoreObject()

local Countdowns = {}

QBCore.Commands.Add('bmautolockdoor', "Used to test closest auto door lock", {}, false, function(source)
  DebugPrint2("Command: ", "bmautolockdoor")
  TriggerClientEvent('bm-AutoLockDoors:client:AdminLockClosestDoor', source)
end, 'admin')

function DoorLockThread()
  DebugPrint2("Function: ", "DoorLockThread")
  CreateThread(function()
    local isActive = true
    while isActive do
      Wait(1000)
      ---
      for doorName, v in pairs(Countdowns) do
        Countdowns[doorName].count -= 1
        if Countdowns[doorName].count <= 0 then
          if Config.doorLockFramework == 'QB' then
            local players = QBCore.Functions.GetPlayers()
            for _, player in pairs(players) do
              TriggerEvent('qb-doorlock:server:updateState', doorName, false, false, false, false, false, false, player)
              break
            end
          elseif Config.doorLockFramework == 'cd_doorlock' then
            TriggerClientEvent('cd_doorlock:SetDoorState_name', -1, false, doorName, v.group)
          end
          Countdowns[doorName] = nil
        end
      end
      ---
    end
  end)
end

function LockDoor(source, doorName, doorGroup)
  DebugPrint2("Function: ", "LockDoor")
  DebugPrint2("source: ", source)
  DebugPrint2("doorName: ", doorName)
  if Config.doorLockFramework == 'QB' then
    TriggerEvent('qb-doorlock:server:updateState', doorName, true, false, false, false, false, false, source)
  elseif Config.doorLockFramework == 'cd_doorlock' then
    TriggerClientEvent('cd_doorlock:SetDoorState_name', -1, true, doorName, doorGroup)
    Notification(source, 'Security lock', 'The door locks have been triggered, your need to wait it out')
  end
  Countdowns[doorName] = {}
  Countdowns[doorName].count = Config.doors[doorName].lockTime
  Countdowns[doorName].coords = Config.doors[doorName].coords
  Countdowns[doorName].group = Config.doors[doorName].group
  TriggerClientEvent('bm-AutoLockDoors:client:RecieveCountdowns', -1, Countdowns)
end

RegisterNetEvent('bm-AutoLockDoors:server:lockdoor', function(doorName, doorGroup)
  DebugPrint2("Function: ", "bm-AutoLockDoors:server:lockdoor")
  LockDoor(source, doorName, doorGroup)
end)

DoorLockThread()

print("^1[Bob\'s Mods] ^2Auto Door Locks ^7-^5 Server^7")
