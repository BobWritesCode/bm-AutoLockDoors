local Countdowns = {}

RegisterNetEvent('bm-AutoLockDoors:client:RecieveCountdowns', function(_Countdowns)
  DebugPrint2("Function: ", "bm-AutoLockDoors:client:RecieveCountdowns")
  Countdowns = _Countdowns
  local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
  for k, v in pairs(Countdowns) do
    if #(v.coords - vec3(x, y, z)) < 2  and Countdowns[k].count == Config.doors[k].lockTime then
      _SetEntityCollision()
      break
    end
  end
end)

function DoorLockThread()
  CreateThread(function()
    local isActive = true
    while isActive do
      Wait(1000)
      local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
      for k, _ in pairs(Countdowns) do
        Countdowns[k].count -= 1
        if #(Countdowns[k].coords - vec3(x, y, z)) < 2 then
          Notification(source, 'Time left...', Countdowns[k].count, 'primary', 1000)
        end
        if Countdowns[k].count <= 0 then
          Countdowns[k] = nil
        end
      end
    end
  end)
end


RegisterNetEvent('bm-AutoLockDoors:client:AdminLockClosestDoor', function()
  DebugPrint2("Function: ", "bm-AutoLockDoors:client:AdminLockClosestDoor")
  -- _SetEntityCollision()
  LockClosestDoor()
end)

function _SetEntityCollision()
  CreateThread(function()
    SetPedToRagdoll(PlayerPedId(), 2000, 0, 0, false, false, false)
    Wait(0)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityCollision(PlayerPedId(), false, true)
    Wait(2000)
    SetEntityCollision(PlayerPedId(), true, true)
    FreezeEntityPosition(PlayerPedId(), false)
  end)
end

RegisterNetEvent('bm-AutoLockDoors:client:LockClosestDoor', function()
  DebugPrint2("Function: ", "bm-AutoLockDoors:client:LockClosestDoor")
  LockClosestDoor()
end)

function LockClosestDoor()
  DebugPrint2("Function: ", "LockClosestDoor")
  local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
  for k, v in pairs(Config.doors) do
    if not Countdowns[k] then
      if #(v.coords - vec3(x, y, z)) < 30 then
        TriggerServerEvent('bm-AutoLockDoors:server:lockdoor', k, v.group)
        break
      end
    end
  end
end

DoorLockThread()

print("^1[Bob\'s Mods] ^2Auto Door Locks ^7-^5 Client^7")
