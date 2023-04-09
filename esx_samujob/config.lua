Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

Config.ReviveReward               = 2500  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'fr'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 8 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 10 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = false
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(352.79, -561.57, 28.79), heading = 162.79 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(-457.38705444336, -338.3415222168, 34.500751495362),
			sprite = 61,
			scale  = 1.2,
			color  = 0
		},

		SamuActions = {
			vector3(-435.0728149414, -324.11630249024, 34.91081237793) 
		},

		Pharmacies = {
			vector3(-430.68710327148, -324.8969116211, 34.910789489746)
		},

		Vehicles = {
			{
				Spawner = vector3(0.0, 0.0, 0.0),
				InsideShop = vector3(0.0, 0.0, 0.0),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-0.0, 0.0, 0.0), heading = 179.06, radius = 4.0 },
					{ coords = vector3(0.0, 0.0, 0.0), heading = 179.06, radius = 4.0 },
					{ coords = vector3(0.0, 0.0, 0.0), heading = 179.06, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(0.0, 0.0, 0.0),
				InsideShop = vector3(0.0, 0.0, 0.0),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					--{ coords = vector3(300.0929260254, -1452.8033447266, 00.0), heading = 142.7, radius = 10.0 },
					  { coords = vector3(313.35125732422, -1465.2447509766, 00.0), heading = 142.7, radius = 10.0 }      
				}
			}
		},

		--FastTravels = {
			{
				From = vector3(339.29, -583.79, 74.16),
				To = { coords = vector3(324.63, -558.15, 28.73), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			--{
			--	From = vector3(275.3, -1361, 23.5),
			--	To = { coords = vector3(295.8, -1446.5, 28.9), heading = 0.0 },
			--	Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			--},
--
			--{
			--	From = vector3(247.3, -1371.5, 23.5),
			--	To = { coords = vector3(333.1, -1434.9, 45.5), heading = 138.6 },
			--	Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			--},
--
			--{
			--	From = vector3(335.5, -1432.0, 45.50),
			--	To = { coords = vector3(249.1, -1369.6, 23.5), heading = 0.0 },
			--	Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			--},
--
			--{
			--	From = vector3(234.5, -1373.7, 20.9),
			--	To = { coords = vector3(320.9, -1478.6, 28.8), heading = 0.0 },
			--	Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			--},
--
			--{
			--	From = vector3(317.9, -1476.1, 28.9),
			--	To = { coords = vector3(238.6, -1368.4, 23.5), heading = 0.0 },
			--	Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			--}
		--},

		--FastTravelsPrompt = {
		--	{
		--		From = vector3(237.4, -1373.8, 26.0),
		--		To = { coords = vector3(251.9, -1363.3, 38.5), heading = 0.0 },
		--		Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
		--		Prompt = _U('fast_travel')
		--	},
--
		--	{
		--		From = vector3(256.5, -1357.7, 36.0),
		--		To = { coords = vector3(235.4, -1372.8, 26.3), heading = 0.0 },
		--		Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
		--		Prompt = _U('fast_travel')
		--	}
		--}

	}
}

Config.AuthorizedVehicles = {

	samu = {
		{ model = 'sp', label = 'sp', price = 1000},
		{ model = 'dodgeems', label = 'Dodge EMS', price = 1000},
		{ model = 'VLDDSIS', label = 'Pompier', price = 1000},
		{ model = 'x5om', label = 'Samu Lyon', price = 1000},
		{ model = 'FSR', label = 'Pompier', price = 1000},
		{ model = 'firetruk', label = 'Pompier', price = 1000},
		{ model = 'vl3sm', label = 'Pompier Routier', price = 1000}
	},

	doctor = {
		{ model = 'sp', label = 'sp', price = 1000},
		{ model = 'dodgeems', label = 'Dodge EMS', price = 1000},
		{ model = 'VLDDSIS', label = 'Pompier', price = 1000},
		{ model = 'x5om', label = 'Samu Lyon', price = 1000},
		{ model = 'FSR', label = 'Pompier', price = 1000},
		{ model = 'firetruk', label = 'Pompier', price = 1000},
		{ model = 'vl3sm', label = 'Pompier Routier', price = 1000}
	},

	chief_doctor = {
		{ model = 'sp', label = 'sp', price = 1000},
		{ model = 'dodgeems', label = 'Dodge EMS', price = 1000},
		{ model = 'VLDDSIS', label = 'Pompier', price = 1000},
		{ model = 'x5om', label = 'Samu Lyon', price = 1000},
		{ model = 'FSR', label = 'Pompier', price = 1000},
		{ model = 'firetruk', label = 'Pompier', price = 1000},
		{ model = 'vl3sm', label = 'Pompier Routier', price = 1000}
	},

	boss = {
		{ model = 'sp', label = 'sp', price = 1000},
		{ model = 'dodgeems', label = 'Dodge EMS', price = 1000},
		{ model = 'VLDDSIS', label = 'Pompier', price = 1000},
		{ model = 'x5om', label = 'Samu Lyon', price = 1000},
		{ model = 'FSR', label = 'Pompier', price = 1000},
		{ model = 'firetruk', label = 'Pompier', price = 1000},
		{ model = 'vl3sm', label = 'Pompier Routier', price = 1000}
	}

}

Config.AuthorizedHelicopters = {

	samu = {},

	doctor = {},

	chief_doctor = {
                { model = 'polmav', label = 'Helicoptere Urgence', price = 1 },
	},

	boss = {
		{ model = 'supervolito', label = 'Helicoptere Urgence', price = 1 },
	}

}
