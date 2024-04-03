local QBCore = exports['qb-core']:GetCoreObject()

local Countdowns = {}

function DoorLockThread()
  DebugPrint2("Function: ", "DoorLockThread")
  CreateThread(function()
    local isActive = true
    while isActive do
      Wait(1000)
      for k, _ in pairs(Countdowns) do
        Countdowns[k].count -= 1
        if Countdowns[k].count <= 0 then
          local players = QBCore.Functions.GetPlayers()
          for _, v in pairs(players) do
            TriggerEvent('qb-doorlock:server:updateState', k, false, false, false, false, false, false, v)
            break
          end
          Countdowns[k] = nil
        end
      end
    end
  end)
end

function LockDoor(source, doorName)
  DebugPrint2("Function: ", "LockDoor")
  DebugPrint2("source: ", source)
  DebugPrint2("doorName: ", doorName)
  TriggerEvent('qb-doorlock:server:updateState', doorName, true, false, false, false, false, false, source)
  Notification(source, 'Security lock', 'The door locks have been triggered, your need to wait it out')
  Countdowns[doorName] = {}
  Countdowns[doorName].count = Config.AutoLockingDoords[doorName].lockTime
  Countdowns[doorName].coords = Config.AutoLockingDoords[doorName].coords
  TriggerClientEvent('bm-AutoLockDoors:client:RecieveCountdowns', -1 , Countdowns)
end

RegisterNetEvent('bm-AutoLockDoors:server:lockdoor', function(doorName)
  DebugPrint2("Function: ", "bm-AutoLockDoors:server:lockdoor")
  LockDoor(source, doorName)
end)

DoorLockThread()

print("^1[Bob\'s Mods] ^2Auto Door Locks ^7-^5 Server^7")
