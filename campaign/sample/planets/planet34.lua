--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Planet config

local function GetPlanet(planetUtilities, planetID)
	
	local image = LUA_DIRNAME .. "images/planets/inferno04.png"
	
	local planetData = {
		name = "Fel Diacia",
		startingPlanet = false,
		mapDisplay = {
			x = (planetUtilities.planetPositions and planetUtilities.planetPositions[planetID][1]) or 0.57,
			y = (planetUtilities.planetPositions and planetUtilities.planetPositions[planetID][2]) or 0.61,
			image = image,
			size = planetUtilities.PLANET_SIZE_MAP,
		},
		infoDisplay = {
			image = image,
			size = planetUtilities.PLANET_SIZE_INFO,
			backgroundImage = planetUtilities.backgroundImages[math.floor(math.random()*#planetUtilities.backgroundImages) + 1],
			terrainType = "Steppe",
			radius = "7440 km",
			primary = "Woondai",
			primaryType = "G8V",
			milRating = 1,
			feedbackLink = "http://zero-k.info/Forum/Thread/24566",
			text = "This unterraformable dustball of a planet would never have attracted any attention, was it not lying right on the largest warp nexus in the galaxy."
			.. "\n "
			.. "\nAnd of course, some pirates were trying to take it over, biting much more than they could chew - the Empire made sure to guard it well. Good thing the pirates' security was so poor, I managed to hack their IFF."
			,
			extendedText = "The Imperials had dug into a reasonable defensive position, assisted by aircraft. I should supplement my ground forces with Thunderbirds to disarm enemy defenses and Swifts to shoot down their planes."
		},
		tips = {
			{
				image = "unitpics/staticrearm.png",
				text = [[After firing their payload, bombers must retreat to base and rearm. The Airplane Plant has one rearm pad. If you have a large number of bombers, build an Airpad so your bombers can get back into the fight sooner. ]]
			},
			{
				image = "unitpics/bomberdisarm.png",
				text = [[The Thunderbird can disarm a large army along its bombing path. Use the manual fire (default hotkey D) to fire immediately.]]
			},
			{
				image = "unitpics/planefighter.png",
				text = [[Swifts are good for intercepting enemy bombers or protecting your own. Use the manual fire (default hotkey D) to activate a speed boost.]]
			},
			{
				image = "LuaUI/Images/ibeam.png",
				text = [[Metal income from extractors is split evenly between teammates, with whoever builds an extractor temporarily recieving a slightly larger share as payment. Reclaim is private though, as is any metal in storage. Mouse over the metal icon at the top of the screen for a detailed breakdown.]]
			},
		},
		gameConfig = {
			mapName = "Valles_Marineris_v2",
			playerConfig = {
				startX = 2364,
				startZ = 5324,
				allyTeam = 0,
				commanderParameters = {
					facplop = true,
					defeatIfDestroyedObjectiveID = 2,
					facing = 1,
				},
				extraUnlocks = {
					"factoryplane",
					"planecon",
					"planefighter",
					"bomberriot",
					"bomberdisarm",
					"staticrearm",
				},
				startUnits = {
					{
						name = "spiderscout",
						x = 5843,
						z = 5333,
						facing = 1,
					},
					{
						name = "factoryplane",
						x = 2264,
						z = 5584,
						facing = 1,
					},
					{
						name = "staticrearm",
						x = 1898,
						z = 5333,
						facing = 1,
					},
					{
						name = "staticradar",
						x = 4205,
						z = 5900,
						facing = 1,
					},
					{
						name = "bomberdisarm",
						x = 1050,
						z = 5016,
						facing = 1,
						commands = {
							{cmdID = planetUtilities.COMMAND.RAW_MOVE, pos = {2652, 5016}},
						},
					},
					{
						name = "bomberdisarm",
						x = 1050,
						z = 5192,
						facing = 1,
						commands = {
							{cmdID = planetUtilities.COMMAND.RAW_MOVE, pos = {2652, 5192}},
						},
					},
					{
						name = "bomberdisarm",
						x = 1050,
						z = 5368,
						facing = 1,
						commands = {
							{cmdID = planetUtilities.COMMAND.RAW_MOVE, pos = {2652, 5368}},
						},
					},
					{
						name = "bomberdisarm",
						x = 1050,
						z = 5544,
						facing = 1,
						commands = {
							{cmdID = planetUtilities.COMMAND.RAW_MOVE, pos = {2652, 5544}},
						},
					},
					{
						name = "cloakraid",
						x = 2480,
						z = 5392,
						facing = 1,
					},
					{
						name = "cloakraid",
						x = 2480,
						z = 5344,
						facing = 1,
					},
					{
						name = "cloakraid",
						x = 2432,
						z = 5248,
						facing = 1,
					},
					{
						name = "staticmex",
						x = 408,
						z = 5128,
						facing = 0,
					},
					{
						name = "staticmex",
						x = 1016,
						z = 5224,
						facing = 0,
					},
					{
						name = "staticmex",
						x = 600,
						z = 5608,
						facing = 0,
					},
					{
						name = "cloakraid",
						x = 2432,
						z = 5344,
						facing = 1,
					},
					{
						name = "energysolar",
						x = 2264,
						z = 5848,
						facing = 2,
					},
					{
						name = "energysolar",
						x = 2264,
						z = 6008,
						facing = 2,
					},
					{
						name = "energysolar",
						x = 2312,
						z = 5928,
						facing = 2,
					},
					{
						name = "energysolar",
						x = 2344,
						z = 5064,
						facing = 2,
					},
					{
						name = "energysolar",
						x = 2344,
						z = 4904,
						facing = 2,
					},
					{
						name = "energysolar",
						x = 2392,
						z = 4984,
						facing = 0,
					},
					{
						name = "cloakraid",
						x = 2480,
						z = 5296,
						facing = 1,
					},
					{
						name = "turretlaser",
						x = 2256,
						z = 5904,
						facing = 1,
					},
					{
						name = "turretlaser",
						x = 2336,
						z = 4960,
						facing = 1,
					},
					{
						name = "cloakraid",
						x = 2432,
						z = 5296,
						facing = 1,
					},
					{
						name = "cloakraid",
						x = 2480,
						z = 5200,
						facing = 1,
					},
					{
						name = "staticradar",
						x = 2384,
						z = 4768,
						facing = 2,
					},
					{
						name = "cloakraid",
						x = 2432,
						z = 5392,
						facing = 1,
					},
					{
						name = "staticcon",
						x = 2232,
						z = 5192,
						facing = 0,
						selfPatrol = true,
					},
					{
						name = "staticcon",
						x = 2232,
						z = 5300,
						facing = 0,
						selfPatrol = true,
					},
					{
						name = "cloakraid",
						x = 2432,
						z = 5200,
						facing = 1,
					},
					{
						name = "staticmex",
						x = 2248,
						z = 5944,
						facing = 0,
					},
					{
						name = "cloakraid",
						x = 2480,
						z = 5248,
						facing = 1,
					},
					{
						name = "cloakraid",
						x = 2432,
						z = 5440,
						facing = 1,
					},
					{
						name = "cloakraid",
						x = 2480,
						z = 5440,
						facing = 1,
					},
					{
						name = "cloakraid",
						x = 2528,
						z = 5440,
						facing = 1,
					},
					{
						name = "cloakraid",
						x = 2528,
						z = 5440 - 1*48,
						facing = 1,
					},
					{
						name = "cloakraid",
						x = 2528,
						z = 5440 - 2*48,
						facing = 1,
					},
					{
						name = "cloakraid",
						x = 2528,
						z = 5440 - 3*48,
						facing = 1,
					},
					{
						name = "cloakraid",
						x = 2528,
						z = 5440 - 4*48,
						facing = 1,
					},
					{
						name = "cloakraid",
						x = 2528,
						z = 5440 - 5*48,
						facing = 1,
					},
					{
						name = "staticmex",
						x = 1656,
						z = 5224,
						facing = 0,
					},
					{
						name = "staticmex",
						x = 2328,
						z = 5000,
						facing = 0,
					},
					{
						name = "turretheavylaser",
						x = 2412,
						z = 4820,
						facing = 1,
					},
				}
			},
			aiConfig = {
				{
					humanName = "Ally",
					aiLib = "Circuit_difficulty_autofill_ally",
					bitDependant = true,
					--aiLib = "Null AI",
					--bitDependant = false,
					allyTeam = 0,
					unlocks = {
						"staticmex",
						"staticradar",
						"staticstorage",
						"energysolar",
						"energywind",
						"energypylon",
						"staticcon",
						"turretlaser",
						"turretmissile",
						"turretaalaser",
						"turretemp",
						"factoryveh",
						"vehcon",
						"vehscout",
						"vehraid",
						"vehassault",
						"vehriot",
						"vehsupport",
						"vehaa",
						"veharty",
						"factorytank",
						"tankcon",
						"tankraid",
						"tankheavyraid",
						"tankriot",
						"tankassault",
						"tankarty",
						"tankaa",
					},
					commander = false,
					startUnits = {
						{
							name = "staticradar",
							x = 1829,
							z = 1950,
							facing = 1,
						},
						{
							name = "staticmex",
							x = 968,
							z = 3208,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 2664,
							z = 3704,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 2024,
							z = 3976,
							facing = 2,
						},
						{
							name = "staticmex",
							x = 248,
							z = 3032,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 1944,
							z = 4024,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 1992,
							z = 4104,
							facing = 1,
						},
						{
							name = "energygeo",
							x = 632,
							z = 4312,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 600,
							z = 3496,
							facing = 0,
						},
						{
							name = "factoryveh",
							x = 1104,
							z = 3632,
							facing = 1,
						},
						{
							name = "energysolar",
							x = 2072,
							z = 4056,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 2008,
							z = 4040,
							facing = 1,
						},
						{
							name = "staticmex",
							x = 1208,
							z = 4040,
							facing = 0,
						},
						{
							name = "staticstorage",
							x = 600,
							z = 3672,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 1072,
							z = 4000,
							facing = 1,
						},
						{
							name = "staticcon",
							x = 968,
							z = 3640,
							facing = 1,
						},
						{
							name = "vehraid",
							x = 1521,
							z = 3664,
							facing = 1,
						},
						{
							name = "vehscout",
							x = 2782,
							z = 2517,
							facing = 2,
						},
						{
							name = "staticcon",
							x = 920,
							z = 3608,
							facing = 1,
						},
						{
							name = "vehraid",
							x = 1621,
							z = 3081,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 2024,
							z = 3880,
							facing = 1,
						},
						{
							name = "staticradar",
							x = 896,
							z = 3536,
							facing = 1,
						},
						{
							name = "turretlaser",
							x = 688,
							z = 3280,
							facing = 1,
						},
						{
							name = "vehscout",
							x = 1964,
							z = 3543,
							facing = 1,
						},
						{
							name = "vehcon",
							x = 890,
							z = 2132,
							facing = 2,
						},
						{
							name = "energywind",
							x = 200,
							z = 2968,
							facing = 1,
						},
						{
							name = "energywind",
							x = 2136,
							z = 3928,
							facing = 1,
						},
						{
							name = "turretmissile",
							x = 2608,
							z = 3648,
							facing = 1,
						},
						{
							name = "turretlaser",
							x = 1120,
							z = 3424,
							facing = 1,
						},
						{
							name = "vehassault",
							x = 1500,
							z = 1736,
							facing = 2,
						},
						{
							name = "vehassault",
							x = 1543,
							z = 1455,
							facing = 1,
						},
						{
							name = "vehsupport",
							x = 1121,
							z = 3631,
							facing = 1,
							buildProgress = 0.70230001,
						},
						{
							name = "turretlaser",
							x = 2768,
							z = 3728,
							facing = 1,
						},
						{
							name = "turretlaser",
							x = 592,
							z = 5264,
							facing = 1,
						},
						{
							name = "turretlaser",
							x = 176,
							z = 2208,
							facing = 1,
						},
						{
							name = "staticradar",
							x = 2448,
							z = 3616,
							facing = 1,
						},
						{
							name = "turretlaser",
							x = 2768,
							z = 3552,
							facing = 1,
						},
						{
							name = "vehsupport",
							x = 1744,
							z = 3510,
							facing = 1,
						},
						{
							name = "turretmissile",
							x = 2848,
							z = 3888,
							facing = 1,
						},
						{
							name = "vehassault",
							x = 1588,
							z = 1494,
							facing = 1,
						},
						{
							name = "energywind",
							x = 1256,
							z = 4024,
							facing = 1,
						},
						{
							name = "staticstorage",
							x = 1240,
							z = 3912,
							facing = 1,
						},
						{
							name = "staticradar",
							x = 784,
							z = 5104,
							facing = 1,
						},
						{
							name = "staticmex",
							x = 248,
							z = 2264,
							facing = 0,
						},
						{
							name = "staticcon",
							x = 872,
							z = 3608,
							facing = 1,
						},
						{
							name = "turretlaser",
							x = 1584,
							z = 5120,
							facing = 1,
						},
						{
							name = "vehcon",
							x = 1021,
							z = 1989,
							facing = 2,
						},
						{
							name = "turretmissile",
							x = 2672,
							z = 3888,
							facing = 1,
						},
						{
							name = "vehcon",
							x = 729,
							z = 1972,
							facing = 1,
						},
						{
							name = "staticmex",
							x = 616,
							z = 1896,
							facing = 0,
						},
						{
							name = "energywind",
							x = 2104,
							z = 4168,
							facing = 1,
						},
						{
							name = "staticcon",
							x = 2504,
							z = 3704,
							facing = 1,
						},
						{
							name = "vehraid",
							x = 2072,
							z = 3793,
							facing = 0,
						},
						{
							name = "vehcon",
							x = 860,
							z = 2825,
							facing = 2,
						},
						{
							name = "energywind",
							x = 1048,
							z = 5176,
							facing = 1,
						},
						{
							name = "energywind",
							x = 1224,
							z = 4120,
							facing = 1,
						},
						{
							name = "energywind",
							x = 952,
							z = 5224,
							facing = 1,
						},
						{
							name = "energysolar",
							x = 1112,
							z = 4056,
							facing = 1,
						},
						{
							name = "turretheavylaser",
							x = 1863,
							z = 1850,
							facing = 1,
						},
						{
							name = "turretaalaser",
							x = 1930,
							z = 1960,
							facing = 1,
						},
						{
							name = "vehriot",
							x = 1502,
							z = 1532,
							facing = 1,
						},
						{
							name = "staticcon",
							x = 904,
							z = 3656,
							facing = 1,
						},
						{
							name = "vehcon",
							x = 2175,
							z = 4033,
							facing = 2,
						},
						{
							name = "turretlaser",
							x = 2608,
							z = 3472,
							facing = 1,
						},
						{
							name = "energysolar",
							x = 1864,
							z = 3976,
							facing = 1,
						},
						{
							name = "vehsupport",
							x = 1513,
							z = 1577,
							facing = 1,
						},
						{
							name = "staticmex",
							x = 984,
							z = 2072,
							facing = 0,
						},
						{
							name = "staticcon",
							x = 2648,
							z = 3624,
							facing = 1,
						},
						{
							name = "energywind",
							x = 2504,
							z = 3800,
							facing = 1,
						},
						{
							name = "energywind",
							x = 1128,
							z = 4168,
							facing = 1,
						},
						{
							name = "vehraid",
							x = 1802,
							z = 3150,
							facing = 0,
						},
						{
							name = "staticradar",
							x = 832,
							z = 3456,
							facing = 1,
						},
						{
							name = "energysolar",
							x = 1368,
							z = 4040,
							facing = 1,
						},
						{
							name = "energysolar",
							x = 1944,
							z = 3944,
							facing = 1,
						},
						{
							name = "vehriot",
							x = 1462,
							z = 1546,
							facing = 1,
						},
						{
							name = "energywind",
							x = 1288,
							z = 3928,
							facing = 1,
						},
						{
							name = "energysolar",
							x = 2664,
							z = 3768,
							facing = 1,
						},
						{
							name = "vehassault",
							x = 1536,
							z = 1712,
							facing = 1,
						},
						{
							name = "staticcon",
							x = 968,
							z = 3592,
							facing = 1,
						},
						{
							name = "energysolar",
							x = 1144,
							z = 3976,
							facing = 1,
						},
						{
							name = "vehcon",
							x = 1129,
							z = 2966,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 1912,
							z = 4104,
							facing = 1,
						},
						{
							name = "turretmissile",
							x = 656,
							z = 3456,
							facing = 1,
						},
						{
							name = "energysolar",
							x = 1160,
							z = 3896,
							facing = 1,
						},
						{
							name = "energysolar",
							x = 2616,
							z = 3848,
							facing = 1,
						},
					}
				},
				{
					humanName = "Iseuwi",
					aiLib = "Circuit_difficulty_autofill",
					bitDependant = true,
					--aiLib = "Null AI",
					--bitDependant = false,
					commanderParameters = {
						facplop = false,
					},
					allyTeam = 1,
					unlocks = {
						"staticcon",
						"turretriot",
						"turretlaser",
						"staticradar",
						"staticmex",
						"energysolar",
						"energywind",
						"energygeo",
						"factoryhover",
						"hovercon",
						"hoverraid",
						"hoverskirm",
						"hoverriot",
                        "hoverheavyraid",
						"factoryplane",
						"planeheavyfighter",
						"bomberprec",
						"bomberriot",
					},
					difficultyDependantUnlocks = {
						[2] = {"hoveraa",},
						[3] = {"hoveraa","bomberheavy", "hoverarty",},
						[4] = {"hoveraa","bomberheavy", "hoverassault", "hoverarty","turretgauss",},
					},
					startX = 4800,
					startZ = 850,
					commanderLevel = 6,
					commander = {
						name = "Yangdi",
						chassis = "recon",
						decorations = {
						},
						modules = {
							"commweapon_shotgun",
							"commweapon_concussion",
							"module_autorepair",
							"module_autorepair",
							"module_ablative_armor",
							"module_ablative_armor",
							"module_adv_targeting",
							"module_high_power_servos",
							"module_high_power_servos",
							"module_adv_nano",
						}
					},
					midgameUnits = {
						{
							name = "planeheavyfighter",
							x = 5000,
							z = 340,
							facing = 0,
							spawnRadius = 50,
							delay = 200,
							orbitalDrop = false,
							difficultyAtLeast = 3,
						},
						{
							name = "planeheavyfighter",
							x = 5100,
							z = 340,
							facing = 0,
							spawnRadius = 50,
							delay = 200,
							orbitalDrop = false,
							difficultyAtLeast = 4,
						},
						-- Raptors at 2:30
						{
							name = "planeheavyfighter",
							x = 5000,
							z = 340,
							facing = 0,
							spawnRadius = 50,
							delay = 2.5*30*60,
							orbitalDrop = false,
							difficultyAtLeast = 2,
						},
						{
							name = "planeheavyfighter",
							x = 5100,
							z = 340,
							facing = 0,
							spawnRadius = 50,
							delay = 2.5*30*60,
							orbitalDrop = false,
							difficultyAtLeast = 3,
						},
						{
							name = "planeheavyfighter",
							x = 5200,
							z = 340,
							facing = 0,
							spawnRadius = 50,
							delay = 2.5*30*60,
							orbitalDrop = false,
							difficultyAtLeast = 4,
						},
						{
							name = "bomberprec",
							x = 5300,
							z = 340,
							facing = 0,
							spawnRadius = 50,
							delay = 2.5*30*60,
							orbitalDrop = false,
							difficultyAtLeast = 3,
							difficultyAtMost = 3,
						},
						{
							name = "bomberheavy",
							x = 5400,
							z = 340,
							facing = 0,
							spawnRadius = 50,
							delay = 2.5*30*60,
							orbitalDrop = false,
							difficultyAtLeast = 3,
						},
						-- Bombers at 4:30
						{
							name = "bomberprec",
							x = 5000,
							z = 340,
							facing = 0,
							spawnRadius = 50,
							delay = 4.5*30*60,
							orbitalDrop = false,
						},
						{
							name = "bomberprec",
							x = 5100,
							z = 340,
							facing = 0,
							spawnRadius = 50,
							delay = 4.5*30*60,
							orbitalDrop = false,
							difficultyAtMost = 3,
						},
						{
							name = "bomberprec",
							x = 5200,
							z = 340,
							facing = 0,
							spawnRadius = 50,
							delay = 4.5*30*60,
							orbitalDrop = false,
							difficultyAtLeast = 3,
							difficultyAtMost = 3,
						},
						{
							name = "bomberheavy",
							x = 5300,
							z = 340,
							facing = 0,
							spawnRadius = 50,
							delay = 4.5*30*60,
							orbitalDrop = false,
							difficultyAtLeast = 4,
						},
						-- Both at at 7:30
						{
							name = "planeheavyfighter",
							x = 5000,
							z = 340,
							facing = 0,
							spawnRadius = 50,
							delay = 7.5*30*60,
							orbitalDrop = false,
						},
						{
							name = "planeheavyfighter",
							x = 5100,
							z = 340,
							facing = 0,
							spawnRadius = 50,
							delay = 7.5*30*60,
							orbitalDrop = false,
							difficultyAtLeast = 3,
						},
					},
					startUnits = {
						{
							name = "turretheavylaser",
							x = 2872,
							z = 1176,
							facing = 0,
						},
						{
							name = "turretheavylaser",
							x = 3560,
							z = 2776,
							facing = 0,
						},
						{
							name = "turretriot",
							x = 3080,
							z = 1336,
							facing = 0,
						},
						{
							name = "turretriot",
							x = 2680,
							z = 984,
							facing = 0,
						},
						{
							name = "turretriot",
							x = 3544,
							z = 2504,
							facing = 0,
						},
						{
							name = "turretriot",
							x = 3576,
							z = 3048,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 2768,
							z = 1088,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 2976,
							z = 1264,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 3552,
							z = 2640,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 3568,
							z = 2912,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 5488,
							z = 3696,
							facing = 3,
						},
						{
							name = "factoryplane",
							x = 4950,
							z = 520,
							facing = 0,
						},
						{
							name = "factoryhover",
							x = 4700,
							z = 1100,
							facing = 0,
						},
						{
							name = "hoverraid",
							x = 3846,
							z = 2404,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 5272,
							z = 984,
							facing = 0,
							difficultyAtLeast = 2,
						},
						{
							name = "energysolar",
							x = 5336,
							z = 1000,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 3680,
							z = 1168,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 5192,
							z = 216,
							facing = 0,
							difficultyAtLeast = 3,
						},
						{
							name = "energywind",
							x = 5144,
							z = 248,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 5256,
							z = 232,
							facing = 0,
						},
						{
							name = "staticradar",
							x = 5504,
							z = 3536,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 5536,
							z = 192,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 4520,
							z = 1288,
							facing = 0,
							difficultyAtLeast = 4,
						},
						{
							name = "staticradar",
							x = 5344,
							z = 384,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 4576,
							z = 1216,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 3720,
							z = 2456,
							facing = 0,
							difficultyAtLeast = 2,
						},
						{
							name = "staticmex",
							x = 5816,
							z = 248,
							facing = 0,
							difficultyAtLeast = 3,
						},
						{
							name = "energysolar",
							x = 5752,
							z = 264,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 4456,
							z = 1288,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 3704,
							z = 3016,
							facing = 0,
							difficultyAtLeast = 4,
						},
						{
							name = "energywind",
							x = 5864,
							z = 200,
							facing = 0,
						},
						{
							name = "energywind",
							x = 5768,
							z = 152,
							facing = 0,
						},
						{
							name = "hovercon",
							x = 3494,
							z = 2261,
							facing = 2,
						},
						{
							name = "energywind",
							x = 5864,
							z = 312,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 4920,
							z = 2136,
							facing = 0,
							difficultyAtLeast = 2,
						},
						{
							name = "energygeo",
							x = 4088,
							z = 120,
							facing = 0,
						},
						{
							name = "hoverraid",
							x = 3288,
							z = 3264,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 3408,
							z = 2272,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 6328,
							z = 1160,
							facing = 0,
							difficultyAtLeast = 3,
						},
						{
							name = "turretlaser",
							x = 4880,
							z = 2368,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 4976,
							z = 880,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 4840,
							z = 3560,
							facing = 0,
							difficultyAtLeast = 4,
						},
						{
							name = "turretlaser",
							x = 6288,
							z = 1152,
							facing = 3,
						},
						{
							name = "hoverskirm",
							x = 4121,
							z = 1309,
							facing = 0,
						},
						{
							name = "staticradar",
							x = 4736,
							z = 2288,
							facing = 0,
						},
						{
							name = "hoverraid",
							x = 3450,
							z = 3087,
							facing = 2,
						},
						{
							name = "staticmex",
							x = 5624,
							z = 1768,
							facing = 0,
							difficultyAtLeast = 2,
						},
						{
							name = "staticmex",
							x = 3304,
							z = 2136,
							facing = 0,
							difficultyAtLeast = 4,
						},
						{
							name = "staticcon",
							x = 4760,
							z = 760,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 5632,
							z = 1728,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 4504,
							z = 2456,
							facing = 0,
							difficultyAtLeast = 2,
						},
						{
							name = "hovercon",
							x = 3348,
							z = 2000,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 4504,
							z = 3016,
							facing = 0,
							difficultyAtLeast = 2,
						},
						{
							name = "staticmex",
							x = 5320,
							z = 2760,
							facing = 0,
							difficultyAtLeast = 3,
						},
						{
							name = "staticcon",
							x = 4792,
							z = 712,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 5200,
							z = 2800,
							facing = 3,
						},
						{
							name = "hoverriot",
							x = 4752,
							z = 848,
							facing = 0,
							buildProgress = 0.94580001,
						},
						{
							name = "turretlaser",
							x = 4624,
							z = 3408,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 4528,
							z = 880,
							facing = 0,
						},
						{
							name = "staticradar",
							x = 3568,
							z = 2128,
							facing = 0,
							buildProgress = 0.23029999,
						},
						{
							name = "staticmex",
							x = 3688,
							z = 1288,
							facing = 0,
							difficultyAtLeast = 4,
						},
						{
							name = "hoverarty",
							x = 3961,
							z = 1387,
							facing = 0,
						},
					}
				},
				{
					humanName = "Iwainiul",
					aiLib = "Circuit_difficulty_autofill",
					bitDependant = true,
					--aiLib = "Null AI",
					--bitDependant = false,
					commanderParameters = {
						facplop = false,
					},
					allyTeam = 1,
					unlocks = {
						"staticcon",
						"turretriot",
						"turretlaser",
						"turretaalaser",
						"staticradar",
						"staticmex",
						"energysolar",
						"energywind",
						"energygeo",
						"factoryshield",
						"shieldcon",
						"shieldraid",
						"shieldriot",
						"shieldskirm",
						"shieldassault",
					},
					difficultyDependantUnlocks = {
						[2] = {"shieldarty", "striderhub", "striderdante"},
						[3] = {"shieldarty", "striderhub", "striderdante", "shieldfelon",},
						[4] = {"shieldarty", "striderhub", "striderdante", "shieldfelon", "turretgauss",},
					},
					startX = 7100,
					startZ = 3600,
					commanderLevel = 6,
					commander = {
						name = "Yangdu",
						chassis = "recon",
						decorations = {
							"skin_recon_leopard",
						},
						modules = {
							"commweapon_heavymachinegun",
							"commweapon_concussion",
							"module_autorepair",
							"module_autorepair",
							"module_ablative_armor",
							"module_ablative_armor",
							"module_adv_targeting",
							"module_high_power_servos",
							"module_high_power_servos",
							"module_adv_nano",
						}
					},
					midgameUnits = {
						{
							name = "shieldaa",
							x = 7300,
							z = 3350,
							facing = 0,
							spawnRadius = 50,
							delay = 2.5*30*60,
							orbitalDrop = true,
						},
						{
							name = "shieldaa",
							x = 7300,
							z = 3450,
							facing = 0,
							spawnRadius = 50,
							delay = 2.5*30*60,
							orbitalDrop = true,
						},
						{
							name = "shieldaa",
							x = 7300,
							z = 3250,
							facing = 0,
							spawnRadius = 50,
							delay = 7.5*30*60,
							orbitalDrop = true,
						},
						{
							name = "shieldaa",
							x = 7300,
							z = 3350,
							facing = 0,
							spawnRadius = 50,
							delay = 7.5*30*60,
							orbitalDrop = true,
						},
					},
					startUnits = {
						{
							name = "turretheavylaser",
							x = 5752,
							z = 5272,
							facing = 0,
						},
						{
							name = "turretheavylaser",
							x = 4104,
							z = 4104,
							facing = 0,
						},
						{
							name = "turretriot",
							x = 5784,
							z = 5576,
							facing = 0,
						},
						{
							name = "turretriot",
							x = 3832,
							z = 4104,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 5744,
							z = 5152,
							facing = 0,
						},
						{
							name = "turretriot",
							x = 4360,
							z = 4104,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 5760,
							z = 5424,
							facing = 0,
						},
						{
							name = "turretriot",
							x = 5736,
							z = 5016,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 3952,
							z = 4112,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 4240,
							z = 4112,
							facing = 0,
						},
						{
							name = "energywind",
							x = 7944,
							z = 648,
							facing = 3,
						},
						{
							name = "factoryshield",
							x = 7016,
							z = 3488,
							facing = 3,
						},
						{
							name = "energywind",
							x = 8024,
							z = 2312,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 7240,
							z = 3208,
							facing = 0,
							difficultyAtLeast = 2,
						},
						{
							name = "energysolar",
							x = 7304,
							z = 3192,
							facing = 3,
						},
						{
							name = "shieldcon",
							x = 4210,
							z = 4782,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 7624,
							z = 3496,
							facing = 0,
							difficultyAtLeast = 3,
						},
						{
							name = "energysolar",
							x = 7640,
							z = 3432,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 7976,
							z = 3032,
							facing = 0,
							difficultyAtLeast = 4,
						},
						{
							name = "energywind",
							x = 7928,
							z = 3016,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 7968,
							z = 3184,
							facing = 3,
						},
						{
							name = "energysolar",
							x = 8040,
							z = 3064,
							facing = 3,
						},
						{
							name = "staticradar",
							x = 7648,
							z = 528,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 7016,
							z = 4040,
							facing = 0,
							difficultyAtLeast = 2,
						},
						{
							name = "staticmex",
							x = 7208,
							z = 5224,
							facing = 0,
							difficultyAtLeast = 3,
						},
						{
							name = "staticradar",
							x = 7936,
							z = 2304,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 7960,
							z = 2264,
							facing = 0,
							difficultyAtLeast = 4,
						},
						{
							name = "shieldcon",
							x = 6580,
							z = 1389,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 6216,
							z = 4008,
							facing = 0,
							difficultyAtLeast = 2,
						},
						{
							name = "energysolar",
							x = 7944,
							z = 2200,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 7120,
							z = 3680,
							facing = 3,
							buildProgress = 0.3777,
						},
						{
							name = "turretlaser",
							x = 6176,
							z = 4016,
							facing = 3,
						},
						{
							name = "shieldskirm",
							x = 6511,
							z = 3528,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 7608,
							z = 1896,
							facing = 0,
							difficultyAtLeast = 3,
						},
						{
							name = "shieldcon",
							x = 5876,
							z = 4891,
							facing = 0,
						},
						{
							name = "energygeo",
							x = 7544,
							z = 4280,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 6280,
							z = 4024,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 7296,
							z = 1840,
							facing = 3,
						},
						{
							name = "shieldraid",
							x = 6376,
							z = 3253,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 6944,
							z = 3680,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 7224,
							z = 2072,
							facing = 0,
							difficultyAtLeast = 4,
						},
						{
							name = "shieldcon",
							x = 7000,
							z = 3605,
							facing = 1,
						},
						{
							name = "turretlaser",
							x = 7008,
							z = 4000,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 7992,
							z = 664,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 7160,
							z = 1400,
							facing = 0,
							difficultyAtLeast = 2,
						},
						{
							name = "shieldskirm",
							x = 5236,
							z = 4631,
							facing = 2,
						},
						{
							name = "turretlaser",
							x = 7008,
							z = 3280,
							facing = 3,
						},
						{
							name = "energysolar",
							x = 7080,
							z = 4024,
							facing = 3,
						},
						{
							name = "shieldcon",
							x = 7556,
							z = 5509,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 7432,
							z = 584,
							facing = 0,
							difficultyAtLeast = 3,
						},
						{
							name = "staticradar",
							x = 7152,
							z = 3920,
							facing = 3,
						},
						{
							name = "shieldassault",
							x = 5107,
							z = 4730,
							facing = 2,
						},
						{
							name = "staticcon",
							x = 7224,
							z = 3480,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 7656,
							z = 200,
							facing = 0,
							difficultyAtLeast = 4,
						},
						{
							name = "shieldassault",
							x = 4852,
							z = 4776,
							facing = 3,
						},
						{
							name = "staticcon",
							x = 7176,
							z = 3496,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 6984,
							z = 312,
							facing = 0,
							difficultyAtLeast = 2,
						},
						{
							name = "shieldriot",
							x = 5119,
							z = 4502,
							facing = 1,
							difficultyAtLeast = 3,
						},
						{
							name = "turretlaser",
							x = 7088,
							z = 288,
							facing = 3,
						},
						{
							name = "shieldassault",
							x = 5216,
							z = 4537,
							facing = 3,
						},
						{
							name = "shieldassault",
							x = 4977,
							z = 4532,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 7808,
							z = 432,
							facing = 3,
						},
						{
							name = "shieldassault",
							x = 5191,
							z = 4707,
							facing = 1,
						},
						{
							name = "staticmex",
							x = 5560,
							z = 3704,
							facing = 0,
							difficultyAtLeast = 4,
						},
						{
							name = "shieldcon",
							x = 7169,
							z = 3785,
							facing = 2,
						},
						{
							name = "staticmex",
							x = 4984,
							z = 4600,
							facing = 0,
							difficultyAtLeast = 2,
						},
						{
							name = "energywind",
							x = 7704,
							z = 136,
							facing = 3,
						},
						{
							name = "shieldraid",
							x = 6382,
							z = 3317,
							facing = 3,
						},
						{
							name = "staticcon",
							x = 7176,
							z = 3544,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 7584,
							z = 5328,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 5896,
							z = 5000,
							facing = 0,
							difficultyAtLeast = 3,
						},
						{
							name = "staticmex",
							x = 7608,
							z = 5608,
							facing = 0,
							buildProgress = 0.08,
							difficultyAtLeast = 4,
						},
					}
				},
			},
			defeatConditionConfig = {
				-- Indexed by allyTeam.
				[0] = { },
				[1] = {
					ignoreUnitLossDefeat = false,
					vitalCommanders = true,
					vitalUnitTypes = {
						"factoryhover",
						"factoryspider",
					},
					loseAfterSeconds = false,
					allyTeamLossObjectiveID = 1,
				},
			},
			objectiveConfig = {
				-- This is just related to displaying objectives on the UI.
				[1] = {
					description = "Destroy the enemy Commander and Factories",
				},
				[2] = {
					description = "Protect your Commander",
				},
			},
			bonusObjectiveConfig = {
				[1] = {
					victoryByTime = 20*60,
					image = planetUtilities.ICON_OVERLAY.CLOCK,
					description = "Win by 20:00",
					experience = planetUtilities.BONUS_EXP,
				},
				[2] = {
					onlyCountRemovedUnits = true,
					satisfyByTime = 6*60,
					comparisionType = planetUtilities.COMPARE.AT_LEAST,
					targetNumber = 4,
					enemyUnitTypes = {
						"turretheavylaser",
					},
					image = planetUtilities.ICON_DIR .. "turretheavylaser.png",
					imageOverlay = planetUtilities.ICON_OVERLAY.ATTACK,
					description = "Destroy 4 enemy Stingers before 6:00",
					experience = planetUtilities.BONUS_EXP,
				},
			}
		},
		completionReward = {
			experience = planetUtilities.MAIN_EXP,
			units = {
				"factoryplane",
				"planecon",
				"planefighter",
				"bomberdisarm",
			},
			modules = {
				"module_adv_nano_LIMIT_H_1",
			},
			abilities = {
			},
			codexEntries = {
				"faction_lawless",
				"entry_event",
			}
		},
	}
	
	return planetData
end

return GetPlanet
