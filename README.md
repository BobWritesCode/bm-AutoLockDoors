# [Bob's Mods] Auto Lock Doors

## Work in progress

## Features

Used to trigger a timed lock on a door using qb-doorlock

Example: A player hits a store for a robbery. You can configure the nearest doors (in the config and within a certain distance) to lock for a specific time.

## Dependencies

- qb-core
- qb-doorlock or cd_doorlock

## Usage

You need to place this trigger event client side of when you want to activate the nearby door lock

```TriggerEvent('bm-AutoLockDoors:client:LockClosestDoor')```

## License

    [Bob's Mods]  Auto Lock Doors
    Copyright (C) 2024

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>
