--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Planet config

local function GetPlanet(planetUtilities, planetID)
	
	--local image = planetUtilities.planetImages[math.floor(math.random()*#planetUtilities.planetImages) + 1]
	local image = LUA_DIRNAME .. "images/planets/desert01.png"
	
	local planetData = {
		name = "Zooph V",
		startingPlanet = false,
		mapDisplay = {
			x = (planetUtilities.planetPositions and planetUtilities.planetPositions[planetID][1]) or 0.325,
			y = (planetUtilities.planetPositions and planetUtilities.planetPositions[planetID][2]) or 0.31,
			image = image,
			size = planetUtilities.PLANET_SIZE_MAP,
		},
		infoDisplay = {
			image = image,
			size = planetUtilities.PLANET_SIZE_INFO,
			backgroundImage = planetUtilities.backgroundImages[math.floor(math.random()*#planetUtilities.backgroundImages) + 1],
			terrainType = "Arid",
			radius = "5110 km",
			primary = "Zooph",
			primaryType = "G8V",
			milRating = 1,
			feedbackLink = "http://zero-k.info/Forum/Thread/24441",
			text = "A billion years ago, this world was hit by a gigantic asteroid. Ancient terraform works have long since made it inhabitable, but now it also features strange, parallel mountain ranges and great sources of geothermal energy."
			.. "\n "
			.. "\nI wonder who thought it was a good idea to defend those rather dry mountains with Amphbots of all things."
			,
			extendedText = "With a combination of well-placed Snitch mobile bombs and Iris area cloakers, I can decimate entire enemy formations. Those area cloakers need some hefty energy input to work, so I better build some Geothermal Generators to feed them."
		},
		tips = {
			{
				image = "unitpics/shieldbomb.png",
				text = [[Snitches burrow into the ground, cloaking themselves while remaining stationary, then explode when enemies get close. An area cloakers will make Snitches invisible even while moving, transforming them into a potent offensive weapon. Manually detonate Snitches by pressing D.]]
			},
			{
				image = "unitpics/cloakjammer.png",
				text = [[The Iris area cloaker grants cloaking to all friendly units in the surrounding area, including itself. It is fragile and has a large decloak radius so keep it away from enemy spotters. Combine with high damage short range units like riots, raiders or bombs for best effect.]]
			},
			{
				image = "LuaUI/Images/commands/Bold/move.png",
				text = [[Select a group of units, then hold Ctrl and right-click to move all units at the same speed. This is useful for keeping other units (like Snitches) within the cloaking radius of an Iris.]]
			},
			{
				image = "unitpics/staticjammer.png",
				text = [[The Iris mobile cloaker can morph to and from a static version - the Cornea. The Cornea cloaks units in a larger radius and is much harder to spot due to its reduced decloak radius. Cornea can be built by all standard constructors, so area cloakers are available even without a Cloakbot Factory.]]
			},
		},
		gameConfig = {

			mapName = "Fields_Of_Isis",
			playerConfig = {
				startX = 1000,
				startZ = 1700,
				allyTeam = 0,
				commanderParameters = {
					facplop = false,
					defeatIfDestroyedObjectiveID = 2,
				},
				extraUnlocks = {
					"factoryshield",
					"shieldcon",
					"shieldbomb",
					"cloakjammer",
					"staticjammer",
					"energygeo",
				},
				startUnits = {
					{
						name = "shieldbomb",
						x = 2100,
						z = 1400,
						facing = 1,
						commands = {{cmdID = planetUtilities.COMMAND.RAW_MOVE, pos = {2200, 1400}}},
					},
					{
						name = "shieldbomb",
						x = 2500,
						z = 2400,
						facing = 1,
						commands = {{cmdID = planetUtilities.COMMAND.RAW_MOVE, pos = {2600, 2400}}},
					},
					{
						name = "shieldbomb",
						x = 2500,
						z = 1800,
						facing = 1,
						commands = {{cmdID = planetUtilities.COMMAND.RAW_MOVE, pos = {2600, 1800}}},
					},
					{
						name = "shieldbomb",
						x = 2100,
						z = 2700,
						facing = 1,
						commands = {{cmdID = planetUtilities.COMMAND.RAW_MOVE, pos = {2200, 2700}}},
					},
					{
						name = "energygeo",
						x = 936,
						z = 1512,
						facing = 3,
						buildProgress = 0.5,
					},
					{
						name = "cloakcon",
						x = 1137,
						z = 1555,
						facing = 1,
						selfPatrol = true,
					},
					{
						name = "shieldcon",
						x = 1076,
						z = 1621,
						facing = 3,
						selfPatrol = true,
					},
					{
						name = "staticmex",
						x = 264,
						z = 200,
						facing = 1,
					},
					{
						name = "turretmissile",
						x = 720,
						z = 3696,
						facing = 1,
					},
					{
						name = "turretmissile",
						x = 688,
						z = 288,
						facing = 1,
					},
					{
						name = "turretlaser",
						x = 1775,
						z = 1430,
						facing = 1,
					},
					{
						name = "turretlaser",
						x = 1775,
						z = 2520,
						facing = 1,
					},
					{
						name = "factorycloak",
						x = 1544,
						z = 1880,
						facing = 1,
					},
					{
						name = "energysolar",
						x = 632,
						z = 632,
						facing = 1,
					},
					{
						name = "energysolar",
						x = 600,
						z = 808,
						facing = 1,
					},
					{
						name = "energysolar",
						x = 712,
						z = 952,
						facing = 1,
					},
					{
						name = "staticmex",
						x = 760,
						z = 616,
						facing = 1,
					},
					{
						name = "staticmex",
						x = 488,
						z = 824,
						facing = 1,
					},
					{
						name = "staticmex",
						x = 856,
						z = 968,
						facing = 1,
					},
					{
						name = "staticmex",
						x = 1384,
						z = 1752,
						facing = 1,
					},
					{
						name = "staticmex",
						x = 1384,
						z = 2264,
						facing = 1,
					},
					{
						name = "turretriot",
						x = 1736,
						z = 1752,
						facing = 1,
					},
					{
						name = "turretriot",
						x = 1736,
						z = 2232,
						facing = 1,
					},
					{
						name = "staticmex",
						x = 568,
						z = 3016,
						facing = 1,
					},
					{
						name = "staticradar",
						x = 1600,
						z = 720,
						facing = 0,
					},
					{
						name = "staticradar",
						x = 1584,
						z = 3456,
						facing = 0,
					},
					{
						name = "staticmex",
						x = 872,
						z = 3192,
						facing = 1,
					},
					{
						name = "staticmex",
						x = 232,
						z = 3912,
						facing = 1,
					},
					{
						name = "factoryshield",
						x = 1552,
						z = 2120,
						facing = 1,
					},
					{
						name = "staticmex",
						x = 632,
						z = 3368,
						facing = 3,
					},
					{
						name = "energysolar",
						x = 840,
						z = 1096,
						facing = 3,
					},
					{
						name = "energysolar",
						x = 968,
						z = 2888,
						facing = 3,
					},
					{
						name = "energysolar",
						x = 936,
						z = 1208,
						facing = 3,
					},
					{
						name = "energysolar",
						x = 904,
						z = 3000,
						facing = 3,
					},
					{
						name = "energysolar",
						x = 536,
						z = 3352,
						facing = 3,
					},
					{
						name = "energysolar",
						x = 584,
						z = 3240,
						facing = 3,
					},
					{
						name = "energysolar",
						x = 648,
						z = 3128,
						facing = 3,
					},
					{
						name = "energysolar",
						x = 776,
						z = 3112,
						facing = 3,
					},
					{
						name = "energysolar",
						x = 936,
						z = 2696,
						facing = 3,
					},
					{
						name = "cloakriot",
						x = 1900,
						z = 2000,
						facing = 1,
					},
					{
						name = "cloakriot",
						x = 1900,
						z = 1900,
						facing = 1,
					},
					{
						name = "shieldassault",
						x = 1800,
						z = 2000,
						facing = 1,
					},
					{
						name = "shieldassault",
						x = 1800,
						z = 1900,
						facing = 1,
					},
					{
						name = "energysolar",
						x = 1016,
						z = 1352,
						facing = 3,
					},
				}
			},
			aiConfig = {
				{
					startX = 5500,
					startZ = 2000,
					aiLib = "Circuit_difficulty_autofill",
					bitDependant = true,
					--aiLib = "Null AI",
					--bitDependant = false,
					humanName = "HeavyMetal",
					commanderParameters = {
						facplop = false,
						bonusObjectiveID = 2,
					},
					allyTeam = 1,
					unlocks = {
						"staticmex",
						"energysolar",
						"energywind",
						"staticstorage",
						"energygeo",
						"staticradar",
						"staticcon",
						"turretlaser",
						"turretmissile",
						"factoryshield",
						"shieldcon",
						"shieldraid",
						"shieldskirm",
						"shieldassault",
						"shieldfelon",
						"factoryamph",
						"amphcon",
						"amphraid",
						"amphimpulse",
						"amphfloater",
						"amphriot",
						"factorytank",
						"tankcon",
						"tankraid",
						"tankheavyraid",
						"tankriot",
						"tankassault",
						"tankarty",
						"tankaa",
						
					},
					difficultyDependantUnlocks = {
						[3] = {"factoryplane","planecon","bomberriot","planescout",},
						[4] = {"factoryplane","planecon","bomberriot","planescout",},
					},
					commanderLevel = 3,
					commander = {
						name = "Doof",
						chassis = "guardian",
						decorations = {
						},
						modules = { "commweapon_riotcannon",
									"commweapon_riotcannon",
									"module_ablative_armor",
									"module_adv_targeting",
									"module_adv_targeting"}
					},
					startUnits = {
						{
							name = "energygeo",
							x = 6296,
							z = 1544,
							facing = 0,
						},
						-- The AI only starts with one finished geo on Hard+ now.
						{
							name = "energygeo",
							x = 6280,
							z = 2488,
							facing = 0,
							difficultyAtLeast = 3,
						},
						{
							name = "energygeo",
							x = 6280,
							z = 2488,
							facing = 0,
							buildProgress = 0.5,
							difficultyAtMost = 2,
						},
						{
							name = "turretlaser",
							x = 6240,
							z = 1600,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 5816,
							z = 1752,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 5816,
							z = 2264,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 6368,
							z = 1600,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 6632,
							z = 3016,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 6328,
							z = 3192,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 6568,
							z = 3368,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 6952,
							z = 3912,
							facing = 0,
							difficultyAtLeast = 2,
						},
						{
							name = "staticmex",
							x = 6344,
							z = 968,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 6440,
							z = 616,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 6696,
							z = 824,
							facing = 0,
						},
						{
							name = "staticmex",
							x = 6920,
							z = 200,
							facing = 0,
							difficultyAtLeast = 3,
						},
						{
							name = "turretlaser",
							x = 6368,
							z = 1488,
							facing = 3,
						},
						{
							name = "energypylon",
							x = 6520,
							z = 1016,
							facing = 0,
						},
						{
							name = "turretlaser",
							x = 6240,
							z = 1488,
							facing = 3,
						},
						{
							name = "energypylon",
							x = 6456,
							z = 3016,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 6808,
							z = 488,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 6872,
							z = 296,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 6760,
							z = 616,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 6760,
							z = 3512,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 6840,
							z = 3672,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 6888,
							z = 3800,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 6072,
							z = 2392,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 5912,
							z = 2312,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 5928,
							z = 1688,
							facing = 0,
						},
						{
							name = "energysolar",
							x = 6088,
							z = 1608,
							facing = 0,
						},
						{
							name = "factoryamph",
							x = 5696,
							z = 1880,
							facing = 3,
						},
						{
							name = "amphcon",
							x = 5650,
							z = 1880,
							facing = 3,
							difficultyAtLeast = 2,
						},
						{
							name = "amphcon",
							x = 5625,
							z = 1880,
							facing = 3,
							difficultyAtLeast = 3,
						},
						{
							name = "amphcon",
							x = 5600,
							z = 1880,
							facing = 3,
							difficultyAtLeast = 4,
						},
						{
							name = "amphriot",
							x = 5650,
							z = 1830,
							facing = 3,
						},
						{
							name = "amphriot",
							x = 5625,
							z = 1830,
							facing = 3,
							difficultyAtLeast = 2,
						},
						{
							name = "amphriot",
							x = 5600,
							z = 1830,
							facing = 3,
							difficultyAtLeast = 3,
						},
						{
							name = "factoryshield",
							x = 5696,
							z = 2100,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 6240,
							z = 2544,
							facing = 3,
						},
						{
							name = "staticcon",
							x = 5912,
							z = 1992,
							facing = 3,
						},
						{
							name = "turretaafar",
							x = 6048,
							z = 1984,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 6352,
							z = 2544,
							facing = 3,
						},
						{
							name = "turretaaclose",
							x = 6088,
							z = 1352,
							facing = 3,
						},
						{
							name = "turretaaclose",
							x = 6056,
							z = 2632,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 6352,
							z = 2448,
							facing = 3,
						},
						{
							name = "turretaalaser",
							x = 6104,
							z = 2184,
							facing = 3,
						},
						{
							name = "turretaalaser",
							x = 6120,
							z = 1800,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 6240,
							z = 2448,
							facing = 3,
						},
						{
							name = "turretaalaser",
							x = 6328,
							z = 472,
							facing = 3,
						},
						{
							name = "turretaalaser",
							x = 6280,
							z = 3576,
							facing = 3,
						},
						{
							name = "turretriot",
							x = 5480,
							z = 1736,
							facing = 3,
						},
						{
							name = "turretriot",
							x = 5512,
							z = 2216,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 5440,
							z = 1824,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 5440,
							z = 2144,
							facing = 3,
						},
						{
							name = "amphimpulse",
							x = 5245,
							z = 1808,
							facing = 3,
						},
						{
							name = "shieldassault",
							x = 4813,
							z = 2992,
							facing = 3,
						},
						{
							name = "shieldfloater",
							x = 5143,
							z = 2175,
							facing = 3,
						},
						{
							name = "shieldskirm",
							x = 4428,
							z = 604,
							facing = 3,
						},
						{
							name = "tankassault",
							x = 6953,
							z = 1125,
							facing = 3,
							difficultyAtLeast = 3,
							
						},
						{
							name = "tankriot",
							x = 6949,
							z = 2754,
							facing = 3,
							difficultyAtLeast = 2,
						},
						{
							name = "tankcon",
							x = 5935,
							z = 2085,
							facing = 3,
							difficultyAtLeast = 4,
						},
						{
							name = "turretlaser",
							x = 6416,
							z = 3328,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 6432,
							z = 752,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 4640,
							z = 848,
							facing = 3,
						},
						{
							name = "turretlaser",
							x = 4656,
							z = 3152,
							facing = 3,
						},
						{
							name = "staticmex",
							x = 4673,
							z = 3890,
							facing = 3,
							difficultyAtLeast = 4,
						},
						{
							name = "staticmex",
							x = 4855,
							z = 3975,
							facing = 3,
							difficultyAtLeast = 4,
						},
						{
							name = "staticmex",
							x = 4780,
							z = 392,
							facing = 3,
							difficultyAtLeast = 4,
						},
						{
							name = "staticmex",
							x = 5000,
							z = 150,
							facing = 3,
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
					vitalCommanders = false,
					vitalUnitTypes = {
						"energygeo",
					},
					loseAfterSeconds = false,
					allyTeamLossObjectiveID = 1,
				},
			},
			objectiveConfig = {
				-- This is just related to displaying objectives on the UI.
				[1] = {
					description = "Destroy the enemy Geothermal Generators",
				},
				[2] = {
					description = "Protect your Commander",
				},
			},
			bonusObjectiveConfig = {
				[1] = { -- Make an Eraser
					satisfyOnce = true,
					comparisionType = planetUtilities.COMPARE.AT_LEAST,
					targetNumber = 1,
					unitTypes = {
						"cloakjammer",
					},
					image = planetUtilities.ICON_DIR .. "cloakjammer.png",
					imageOverlay = planetUtilities.ICON_OVERLAY.REPAIR,
					description = "Build an Iris",
					experience = planetUtilities.BONUS_EXP,
				},
				[2] = { -- Lose 25 Snitches
					satisfyOnce = true,
					onlyCountRemovedUnits = true,
					comparisionType = planetUtilities.COMPARE.AT_LEAST,
					targetNumber = 25,
					unitTypes = {
						"shieldbomb",
					},
					image = planetUtilities.ICON_DIR .. "shieldbomb.png",
					imageOverlay = planetUtilities.ICON_OVERLAY.ATTACK,
					description = "Lose 25 or more Snitches",
					experience = planetUtilities.BONUS_EXP,
				},
				[3] = { -- Win by 20:00
					victoryByTime = 1200,
					image = planetUtilities.ICON_OVERLAY.CLOCK,
					description = "Win by 20:00",
					experience = planetUtilities.BONUS_EXP,
				},
			},
		},
		completionReward = {
			experience = planetUtilities.MAIN_EXP,
			units = {
				"shieldbomb",
				"cloakjammer",
				"staticjammer",
				"energygeo",
			},
			modules = {
				"module_jammer",
			},
			abilities = {
			},
			codexEntries = {
				"faction_empire"
			},
		},
	}
	
	return planetData
end

return GetPlanet
