BattleListWindow = ListWindow:extends{}

local BATTLE_RUNNING = LUA_DIRNAME .. "images/runningBattle.png"
local BATTLE_NOT_RUNNING = LUA_DIRNAME .. "images/nothing.png"

local IMG_READY    = LUA_DIRNAME .. "images/ready.png"
local IMG_UNREADY  = LUA_DIRNAME .. "images/unready.png"

function BattleListWindow:init(parent)
	self:super("init", parent, "Play or watch a game", true, nil, nil, nil, 34)

	if not Configuration.gameConfig.disableBattleListHostButton then
		self.btnNewBattle = Button:New {
			x = 260,
			y = WG.TOP_BUTTON_Y,
			width = 150,
			height = WG.BUTTON_HEIGHT,
			caption = i18n("open_mp_game"),
			objectOverrideFont = Configuration:GetButtonFont(3),
			classname = "option_button",
			parent = self.window,
			OnClick = {
				function ()
					self:OpenHostWindow()
				end
			},
		}
	end

	local function SoftUpdate()
		self:UpdateFilters()
		self:UpdateInfoPanel()
	end

	local function update()
		self:Update()
	end

	self.infoPanel = Panel:New {
		classname = "overlay_window",
		x = "15%",
		y = "45%",
		right = "15%",
		bottom = "45%",
		parent = self.window,
	}
	self.infoLabel = Label:New {
		x = "5%",
		y = "5%",
		width = "90%",
		height = "90%",
		align = "center",
		valign = "center",
		parent = self.infoPanel,
		objectOverrideFont = Configuration:GetFont(3),
	}
	self.infoPanel:SetVisibility(false)

	Label:New {
		x = 20,
		right = 5,
		bottom = 11,
		height = 20,
		objectOverrideFont = Configuration:GetFont(2),
		caption = "Filter out:",
		parent = self.window
	}

	local checkPassworded = Checkbox:New {
		x = 110,
		width = 21,
		bottom = 4,
		height = 30,
		boxalign = "left",
		boxsize = 20,
		caption = " Passworded",
		checked = Configuration.battleFilterPassworded3 or false,
		objectOverrideFont = Configuration:GetFont(2),
		OnChange = {
			function (obj, newState)
				Configuration:SetConfigValue("battleFilterPassworded3", newState)
				SoftUpdate()
			end
		},
		parent = self.window,
	}
	local checkNonFriend = Checkbox:New {
		x = 280,
		width = 21,
		bottom = 4,
		height = 30,
		boxalign = "left",
		boxsize = 20,
		caption = " Non-friend",
		checked = Configuration.battleFilterNonFriend or false,
		objectOverrideFont = Configuration:GetFont(2),
		OnChange = {
			function (obj, newState)
				Configuration:SetConfigValue("battleFilterNonFriend", newState)
				SoftUpdate()
			end
		},
		parent = self.window,
	}
	local checkRunning = Checkbox:New {
		x = 435,
		width = 21,
		bottom = 4,
		height = 30,
		boxalign = "left",
		boxsize = 20,
		caption = " Running",
		checked = Configuration.battleFilterRunning or false,
		objectOverrideFont = Configuration:GetFont(2),
		OnChange = {
			function (obj, newState)
				Configuration:SetConfigValue("battleFilterRunning", newState)
				SoftUpdate()
			end
		},
		parent = self.window,
	}

	local function UpdateCheckboxes()
		checkPassworded:SetToggle(Configuration.battleFilterPassworded3)
		checkNonFriend:SetToggle(Configuration.battleFilterNonFriend)
		checkRunning:SetToggle(Configuration.battleFilterRunning)
	end
	WG.Delay(UpdateCheckboxes, 0.2)

	self:SetMinItemWidth(320)
	self.columns = 3
	self.itemHeight = 80
	self.itemPadding = 1

	local function UpdateTimersDelay()
		self:UpdateTimers()
		WG.Delay(UpdateTimersDelay, 30)
	end
	WG.Delay(UpdateTimersDelay, 30)

	self.listenerUpdateDisabled = false
	self.onBattleOpened = function(listener, battleID)
		if self.listenerUpdateDisabled then
			return
		end
		self:AddBattle(battleID, lobby:GetBattle(battleID))
		SoftUpdate()
	end
	lobby:AddListener("OnBattleOpened", self.onBattleOpened)

	self.onBattleClosed = function(listener, battleID)
		if self.listenerUpdateDisabled then
			return
		end
		self:RemoveRow(battleID)
		SoftUpdate()
	end
	lobby:AddListener("OnBattleClosed", self.onBattleClosed)

	self.onJoinedBattle = function(listener, battleID)
		if self.listenerUpdateDisabled then
			return
		end
		self:JoinedBattle(battleID)
		SoftUpdate()
	end
	lobby:AddListener("OnJoinedBattle", self.onJoinedBattle)

	self.onLeftBattle = function(listener, battleID)
		if self.listenerUpdateDisabled then
			return
		end
		self:LeftBattle(battleID)
		SoftUpdate()
	end
	lobby:AddListener("OnLeftBattle", self.onLeftBattle)

	self.onUpdateBattleInfo = function(listener, battleID)
		if self.listenerUpdateDisabled then
			return
		end
		self:OnUpdateBattleInfo(battleID)
		SoftUpdate()
	end
	lobby:AddListener("OnUpdateBattleInfo", self.onUpdateBattleInfo)

	self.onBattleIngameUpdate = function(listener, battleID, isRunning)
		if self.listenerUpdateDisabled then
			return
		end
		self:OnBattleIngameUpdate(battleID, isRunning)
		SoftUpdate()
	end
	lobby:AddListener("OnBattleIngameUpdate", self.onBattleIngameUpdate)

	local function onConfigurationChange(listener, key, value)
		if key == "displayBadEngines3" then
			update()
		end
	end
	Configuration:AddListener("OnConfigurationChange", onConfigurationChange)

	local function downloadFinished(listener, downloadID)
		for battleID,_ in pairs(self.itemNames) do
			self:UpdateSync(battleID)
		end
	end
	WG.DownloadHandler.AddListener("DownloadFinished", downloadFinished)

	update()
end

function BattleListWindow:RemoveListeners()
	lobby:RemoveListener("OnBattleOpened", self.onBattleOpened)
	lobby:RemoveListener("OnBattleClosed", self.onBattleClosed)
	lobby:RemoveListener("OnJoinedBattle", self.onJoinedBattle)
	lobby:RemoveListener("OnLeftBattle", self.onLeftBattle)
	lobby:RemoveListener("OnUpdateBattleInfo", self.onUpdateBattleInfo)
	lobby:RemoveListener("OnBattleIngameUpdate", self.onBattleIngameUpdate)
	lobby:RemoveListener("OnConfigurationChange", self.onConfigurationChange)
	lobby:RemoveListener("DownloadFinished", self.downloadFinished)
end

function BattleListWindow:Update()
	self:Clear()

	local battles = lobby:GetBattles()
	local tmp = {}
	for _, battle in pairs(battles) do
		table.insert(tmp, battle)
	end
	battles = tmp

	for _, battle in pairs(battles) do
		self:AddBattle(battle.battleID, battle)
	end
	self:UpdateFilters()
	self:UpdateInfoPanel()
end

function BattleListWindow:UpdateInfoPanel()
	local battles = lobby:GetBattles()
	local noBattles = true
	for _, battle in pairs(battles) do
		noBattles = false
	end
	if noBattles then
		self.infoPanel:SetVisibility(true)
		self.infoPanel:BringToFront()
		self.infoLabel:SetCaption("No games, check your connection.")
		return
	end

	local firstPanel = self.orderPanelMapping[1]
	if firstPanel then
		if not firstPanel.inFilter then
			self.infoPanel:SetVisibility(true)
			self.infoPanel:BringToFront()
			self.infoLabel:SetCaption("No games in filter")
			return
		end
	else
		-- Must have hidden games
		self.infoPanel:SetVisibility(true)
		self.infoPanel:BringToFront()
		self.infoLabel:SetCaption("Games are hidden, unsure why.")
		return
	end

	self.infoPanel:SetVisibility(false)
end

function BattleListWindow:MakeWatchBattle(battleID, battle)
	local function RejoinBattleFunc()
		if not VFS.HasArchive(battle.mapName) then
			WG.Chobby.InformationPopup("Map download required. Wait for the download to complete and try again.")
			WG.DownloadHandler.MaybeDownloadArchive(battle.mapName, "map", -1)
			return
		end

		if not VFS.HasArchive(battle.gameName) then
			WG.Chobby.InformationPopup("Game update required. Wait for the download to complete or restart the game.")
			WG.DownloadHandler.MaybeDownloadArchive(battle.gameName, "game", -1)
			return
		end

		lobby:RejoinBattle(battleID)
	end

	local height = self.itemHeight - 20
	local parentButton = Button:New {
		classname = "button_rounded",
		name = "battleButton",
		x = 0,
		right = 0,
		y = 0,
		height = self.itemHeight,
		caption = "",
		OnClick = {
			function()
				if Spring.GetGameName() == "" then
					RejoinBattleFunc()
				else
					WG.Chobby.ConfirmationPopup(RejoinBattleFunc, "Are you sure you want to leave your current game to watch/rejoin this one?", nil, 315, 200)
				end
			end
		},
		tooltip = "battle_tooltip_" .. battleID,
	}

	local lblTitle = Label:New {
		name = "lblTitle",
		x = height + 3,
		y = 0,
		right = 0,
		height = 20,
		valign = 'center',
		objectOverrideFont = Configuration:GetFont(2),
		caption = (battle.title or "") .. " - Click to watch",
		parent = parentButton,
		OnResize = {
			function (obj, xSize, ySize)
				obj:SetCaption(StringUtilities.GetTruncatedStringWithDotDot(battle.title .. " - Click to watch", obj.font, xSize or obj.width))
			end
		}
	}
	local minimap = Panel:New {
		name = "minimap",
		x = 3,
		y = 3,
		width = height - 6,
		height = height - 6,
		padding = {1,1,1,1},
		parent = parentButton,
	}

	local mapImageFile, needDownload = Configuration:GetMinimapSmallImage(battle.mapName)
	local minimapImage = Image:New {
		name = "minimapImage",
		x = 0,
		y = 0,
		right = 0,
		bottom = 0,
		keepAspect = true,
		file = mapImageFile,
		fallbackFile = Configuration:GetLoadingImage(2),
		checkFileExists = needDownload,
		parent = minimap,
	}
	local runningImage = Image:New {
		name = "runningImage",
		x = 0,
		y = 0,
		right = 0,
		bottom = 0,
		keepAspect = false,
		file = BATTLE_RUNNING,
		parent = minimap,
	}
	runningImage:BringToFront()

	local playerCount = lobby:GetBattlePlayerCount(battleID)
	local lblPlayersOnMap = Label:New {
		name = "playersOnMapCaption",
		x = height + 3,
		right = 0,
		y = 20,
		height = 15,
		valign = 'center',
		objectOverrideFont = Configuration:GetFont(1),
		caption = playerCount .. ((playerCount == 1 and " player on " ) or " players on ") .. battle.mapName:gsub("_", " "),
		parent = parentButton,
	}

	local modeName = battle.battleMode and Configuration.battleTypeToHumanName[battle.battleMode]
	if battle.isRunning then
		if modeName then
			modeName = modeName .. " - "
		else
			modeName = ""
		end
		modeName = modeName .. "Running for " .. Spring.Utilities.GetTimeToPast(battle.runningSince)
	end

	local lblRunningTime = Label:New {
		name = "runningTimeCaption",
		x = height + 3,
		right = 0,
		y = 36,
		height = 15,
		valign = 'center',
		objectOverrideFont = Configuration:GetFont(1),
		caption = modeName,
		parent = parentButton,
	}

	return parentButton
end

function BattleListWindow:MakeJoinBattle(battleID, battle)

	local height = self.itemHeight - 20
	local parentButton = Button:New {
		classname = "button_rounded",
		name = "battleButton",
		x = 0,
		right = 0,
		y = 0,
		height = self.itemHeight,
		caption = "",
		OnClick = {
			function()
				local myBattleID = lobby:GetMyBattleID()
				if myBattleID then
					if battleID == myBattleID then
						-- Do not rejoin current battle
						local battleTab = WG.Chobby.interfaceRoot.GetBattleStatusWindowHandler()
						battleTab.OpenTabByName("myBattle")
						return
					end
					if not Configuration.confirmation_battleFromBattle then
						local myBattle = lobby:GetBattle(myBattleID)
						if not WG.Chobby.Configuration.showMatchMakerBattles and myBattle and not myBattle.isMatchMaker then
							local function Success()
								self:JoinBattle(battle)
							end
							ConfirmationPopup(Success, "Are you sure you want to leave your current battle and join a new one?", "confirmation_battleFromBattle")
							return
						end
					end
				end
				self:JoinBattle(battle)
			end
		},
		tooltip = "battle_tooltip_" .. battleID,
	}

	local lblTitle = Label:New {
		name = "lblTitle",
		x = height + 3,
		y = 0,
		right = 0,
		height = 20,
		valign = 'center',
		objectOverrideFont = Configuration:GetFont(2),
		caption = battle.title,
		parent = parentButton,
		OnResize = {
			function (obj, xSize, ySize)
				obj:SetCaption(StringUtilities.GetTruncatedStringWithDotDot(battle.title, obj.font, obj.width))
			end
		}
	}
	local minimap = Panel:New {
		name = "minimap",
		x = 3,
		y = 3,
		width = height - 6,
		height = height - 6,
		padding = {1,1,1,1},
		parent = parentButton,
	}

	local mapImageFile, needDownload = Configuration:GetMinimapSmallImage(battle.mapName)
	local minimapImage = Image:New {
		name = "minimapImage",
		x = 0,
		y = 0,
		right = 0,
		bottom = 0,
		keepAspect = true,
		file = mapImageFile,
		fallbackFile = Configuration:GetLoadingImage(2),
		checkFileExists = needDownload,
		parent = minimap,
	}
	local runningImage = Image:New {
		name = "runningImage",
		x = 0,
		y = 0,
		right = 0,
		bottom = 0,
		keepAspect = false,
		file = (battle.isRunning and BATTLE_RUNNING) or BATTLE_NOT_RUNNING,
		parent = minimap,
	}
	runningImage:BringToFront()

	local lblPlayers = Label:New {
		name = "playersCaption",
		x = height + 3,
		width = 50,
		y = 18,
		height = 22,
		valign = 'bottom',
		objectOverrideFont = Configuration:GetFont(2),
		caption = lobby:GetBattlePlayerCount(battleID) .. "/" .. battle.maxPlayers,
		parent = parentButton,
	}

	if battle.passworded then
		local imgPassworded = Image:New {
			name = "password",
			x = height + 50,
			width = 15,
			height = 15,
			y = 20,
			height = 15,
			margin = {0, 0, 0, 0},
			file = CHOBBY_IMG_DIR .. "lock.png",
			parent = parentButton,
		}
	end

	if not Configuration.gameConfig.hideGameExistanceDisplay then
		local imHaveGame = Image:New {
			name = "imHaveGame",
			x = height + 50,
			width = 15,
			height = 15,
			y = 20,
			height = 15,
			file = (VFS.HasArchive(battle.gameName) and IMG_READY or IMG_UNREADY),
			parent = parentButton,
		}
	end

	local lblGame = Label:New {
		name = "gameCaption",
		x = height + 70,
		right = 0,
		y = 20,
		height = 15,
		valign = 'center',
		caption = self:_MakeGameCaption(battle),
		objectOverrideFont = Configuration:GetFont(1),
		parent = parentButton,
	}

	local imHaveMap = Image:New {
		name = "imHaveMap",
		x = height + 50,
		width = 15,
		height = 15,
		y = 36,
		height = 15,
		file = (VFS.HasArchive(battle.mapName) and IMG_READY or IMG_UNREADY),
		parent = parentButton,
	}
	local lblMap = Label:New {
		name = "mapCaption",
		x = height + 70,
		right = 0,
		y = 36,
		height = 15,
		valign = 'center',
		caption = battle.mapName:gsub("_", " "),
		objectOverrideFont = Configuration:GetFont(1),
		parent = parentButton,
	}

	return parentButton
end

function BattleListWindow:AddBattle(battleID, battle)
	battle = battle or lobby:GetBattle(battleID)
	if not (Configuration.displayBadEngines3 or Configuration:IsValidEngineVersion(battle.engineVersion)) then
		return
	end

	if not battle then
		return
	end

	local button
	if battle.isMatchMaker then
		button = self:MakeWatchBattle(battleID, battle)
	else
		button = self:MakeJoinBattle(battleID, battle)
	end

	self:AddRow({button}, battle.battleID)
end

function BattleListWindow:ItemInFilter(id)
	local battle = lobby:GetBattle(id)
	local filterString = Configuration.gameConfig.battleListOnlyShow
	if filterString ~= nil then
		local filterToGame = string.find(battle.gameName, filterString)
		if filterToGame == nil then
			return false
		end
	end
	if not lobby:GetBattleHasFriend(id) then
		if Configuration.battleFilterPassworded3 and battle.passworded then
			return false
		end
		if Configuration.battleFilterNonFriend then
			return false
		end
	end
	if Configuration.battleFilterRunning and battle.isRunning then
		return false
	end
	return true
end

function BattleListWindow:CompareItems(id1, id2)
	local battle1, battle2 = lobby:GetBattle(id1), lobby:GetBattle(id2)
	if id1 and id2 then
		if not (battle1 and battle2) then
			return false
		end
		if battle1.passworded ~= battle2.passworded then
			return battle2.passworded
		end
		if battle1.isMatchMaker ~= battle2.isMatchMaker then
			return battle2.isMatchMaker
		end
		if (lobby:GetBattlePlayerCount(battle1.battleID) == 0) ~= (lobby:GetBattlePlayerCount(battle2.battleID) == 0) then
			return (lobby:GetBattlePlayerCount(battle2.battleID) == 0)
		end
		if battle1.isRunning ~= battle2.isRunning then
			return battle2.isRunning
		end
		local countOne = lobby:GetBattlePlayerCount(id1)
		local countTwo = lobby:GetBattlePlayerCount(id2)
		if countOne ~= countTwo then
			return countOne > countTwo
		end
		return id1 > id2 -- stabalize the sort.
	else
		Spring.Echo("battle1", id1, battle1, battle1 and battle1.users)
		Spring.Echo("battle2", id2, battle2, battle2 and battle2.users)
		return false
	end
end

function BattleListWindow:RecalculateOrder(id)
	if lobby.commandBuffer then
		return
	end
	self:super("RecalculateOrder", id)
end

function BattleListWindow:UpdateSync(battleID)
	local battle = lobby:GetBattle(battleID)
	if not (Configuration.displayBadEngines3 or Configuration:IsValidEngineVersion(battle.engineVersion)) then
		return
	end

	local items = self:GetRowItems(battleID)
	if not items then
		self:AddBattle(battleID)
		return
	end

	local imHaveMap = items.battleButton:GetChildByName("imHaveMap")
	if imHaveMap ~= nil then
		imHaveMap.file = (VFS.HasArchive(battle.mapName) and IMG_READY or IMG_UNREADY)
	end

	local imHaveGame = items.battleButton:GetChildByName("imHaveGame")
	if imHaveGame ~= nil then
		imHaveGame.file = (VFS.HasArchive(battle.gameName) and IMG_READY or IMG_UNREADY)
	end
end

function BattleListWindow:UpdateTimers()
	for battleID,_ in pairs(self.itemNames) do
		local items = self:GetRowItems(battleID)
		if not items then
			break
		end

		local battle = lobby:GetBattle(battleID)
		local runningTimeCaption = items.battleButton:GetChildByName("runningTimeCaption")
		if battle and runningTimeCaption then
			local modeName = battle.battleMode and Configuration.battleTypeToHumanName[battle.battleMode]
			if modeName then
				modeName = modeName .. " - "
			else
				modeName = ""
			end
			runningTimeCaption:SetCaption(modeName .. "Running for " .. Spring.Utilities.GetTimeToPast(battle.runningSince))
		end
	end
end

function BattleListWindow:_MakeGameCaption(battle)
	local gameCaption = battle.battleMode and Configuration.battleTypeToHumanName[battle.battleMode]
	if gameCaption == nil then
		gameCaption = battle.gameName -- :sub(1, 22)
	end
	if battle.isRunning then
		gameCaption = gameCaption .. " - Running for " .. Spring.Utilities.GetTimeToPast(battle.runningSince)
	end
	return gameCaption
end

function BattleListWindow:JoinedBattle(battleID)
	local battle = lobby:GetBattle(battleID)
	if not (Configuration.displayBadEngines3 or Configuration:IsValidEngineVersion(battle.engineVersion)) then
		return
	end

	local items = self:GetRowItems(battleID)
	if not items then
		self:AddBattle(battleID)
		return
	end

	local playersCaption = items.battleButton:GetChildByName("playersCaption")
	if playersCaption then
		playersCaption:SetCaption(lobby:GetBattlePlayerCount(battleID) .. "/" .. battle.maxPlayers)
	else
		local playersOnMapCaption = items.battleButton:GetChildByName("playersOnMapCaption")
		local playerCount = lobby:GetBattlePlayerCount(battleID)
		playersOnMapCaption:SetCaption(playerCount .. ((playerCount == 1 and " player on " ) or " players on ") .. battle.mapName:gsub("_", " "))
	end
	self:RecalculateOrder(battleID)
end

function BattleListWindow:LeftBattle(battleID)
	local battle = lobby:GetBattle(battleID)
	if not (Configuration.displayBadEngines3 or Configuration:IsValidEngineVersion(battle.engineVersion)) then
		return
	end

	local items = self:GetRowItems(battleID)
	if not items then
		self:AddBattle(battleID)
		return
	end

	local playersCaption = items.battleButton:GetChildByName("playersCaption")
	if playersCaption then
		playersCaption:SetCaption(lobby:GetBattlePlayerCount(battleID) .. "/" .. battle.maxPlayers)
	else
		local playersOnMapCaption = items.battleButton:GetChildByName("playersOnMapCaption")
		local playerCount = lobby:GetBattlePlayerCount(battleID)
		playersOnMapCaption:SetCaption(playerCount .. ((playerCount == 1 and " player on " ) or " players on ") .. battle.mapName:gsub("_", " "))
	end
	self:RecalculateOrder(battleID)
end

function BattleListWindow:OnUpdateBattleInfo(battleID)
	local battle = lobby:GetBattle(battleID)
	if not (Configuration.displayBadEngines3 or Configuration:IsValidEngineVersion(battle.engineVersion)) then
		return
	end

	local items = self:GetRowItems(battleID)
	if not items then
		self:AddBattle(battleID)
		return
	end

	local lblTitle = items.battleButton:GetChildByName("lblTitle")
	local mapCaption = items.battleButton:GetChildByName("mapCaption")
	local imHaveMap = items.battleButton:GetChildByName("imHaveMap")
	local minimapImage = items.battleButton:GetChildByName("minimap"):GetChildByName("minimapImage")
	local password = items.battleButton:GetChildByName("password")

	if imHaveMap then
		-- Password Update
		if password and not battle.passworded then
			password:Dispose()
		elseif battle.passworded and not password then
			local imgPassworded = Image:New {
				name = "password",
				x = items.battleButton.height + 28,
				y = 22,
				height = 30,
				width = 30,
				margin = {0, 0, 0, 0},
				file = CHOBBY_IMG_DIR .. "lock.png",
				parent = items.battleButton,
			}
		end

		-- Resets title and truncates.
		lblTitle.OnResize[1](lblTitle)

		minimapImage.file, minimapImage.checkFileExists = Configuration:GetMinimapSmallImage(battle.mapName)
		minimapImage:Invalidate()

		mapCaption:SetCaption(battle.mapName:gsub("_", " "))
		if VFS.HasArchive(battle.mapName) then
			imHaveMap.file = IMG_READY
		else
			imHaveMap.file = IMG_UNREADY
		end
		imHaveMap:Invalidate()


		local imHaveGame = items.battleButton:GetChildByName("imHaveGame")
		if imHaveGame ~= nil then
			imHaveGame.file = (VFS.HasArchive(battle.gameName) and IMG_READY or IMG_UNREADY)
		end

		local gameCaption = items.battleButton:GetChildByName("gameCaption")
		gameCaption:SetCaption(self:_MakeGameCaption(battle))

		local playersCaption = items.battleButton:GetChildByName("playersCaption")
		playersCaption:SetCaption(lobby:GetBattlePlayerCount(battleID) .. "/" .. battle.maxPlayers)
	else
		-- Resets title and truncates.
		local lblTitle = items.battleButton:GetChildByName("lblTitle")
		lblTitle.OnResize[1](lblTitle)

		local minimapImage = items.battleButton:GetChildByName("minimap"):GetChildByName("minimapImage")
		minimapImage.file, minimapImage.checkFileExists = Configuration:GetMinimapSmallImage(battle.mapName)
		minimapImage:Invalidate()

		local playersOnMapCaption = items.battleButton:GetChildByName("playersOnMapCaption")
		local playerCount = lobby:GetBattlePlayerCount(battleID)
		playersOnMapCaption:SetCaption(playerCount .. ((playerCount == 1 and " player on " ) or " players on ") .. battle.mapName:gsub("_", " "))
	end
	self:RecalculateOrder(battleID)
end

function BattleListWindow:OnBattleIngameUpdate(battleID, isRunning)
	local battle = lobby:GetBattle(battleID)
	if not (Configuration.displayBadEngines3 or Configuration:IsValidEngineVersion(battle.engineVersion)) then
		return
	end

	local items = self:GetRowItems(battleID)
	if not items then
		self:AddBattle(battleID)
		return
	end

	local runningImage = items.battleButton:GetChildByName("minimap"):GetChildByName("runningImage")
	if isRunning then
		runningImage.file = BATTLE_RUNNING
	else
		runningImage.file = BATTLE_NOT_RUNNING
	end
	runningImage:Invalidate()
	self:RecalculateOrder(battleID)
end

function BattleListWindow:OpenHostWindow()
	local hostBattleWindow = Window:New {
		caption = "",
		name = "hostBattle",
		parent = WG.Chobby.lobbyInterfaceHolder,
		width = 530,
		height = 310,
		resizable = false,
		draggable = false,
		classname = "main_window",
	}

	local title = Label:New {
		x = 150,
		width = 170,
		y = 15,
		height = 35,
		caption = i18n("open_mp_game"),
		objectOverrideFont = Configuration:GetFont(4),
		parent = hostBattleWindow,
	}

	local gameNameLabel = Label:New {
		x = 15,
		width = 200,
		y = 75,
		align = "right",
		height = 35,
		caption = i18n("game_name") .. ":",
		objectOverrideFont = Configuration:GetFont(3),
		parent = hostBattleWindow,
	}
	local gameNameEdit = EditBox:New {
		x = 220,
		width = 260,
		y = 70,
		height = 35,
		text = (lobby:GetMyUserName() or "Player") .. "'s Battle",
		objectOverrideFont = Configuration:GetFont(3),
		objectOverrideHintFont = Configuration:GetHintFont(3),
		parent = hostBattleWindow,
	}

	local passwordLabel = Label:New {
		x = 15,
		width = 200,
		y = 115,
		align = "right",
		height = 35,
		caption = i18n("password_optional") .. ":",
		objectOverrideFont = Configuration:GetFont(3),
		parent = hostBattleWindow,
	}
	local passwordEdit = EditBox:New {
		x = 220,
		width = 260,
		y = 110,
		height = 35,
		text = "",
		hint = "Set for a private game",
		objectOverrideFont = Configuration:GetFont(3),
		objectOverrideHintFont = Configuration:GetHintFont(3),
		useIME = false,
		parent = hostBattleWindow,
	}

	local typeLabel = Label:New {
		x = 15,
		width = 200,
		y = 155,
		align = "right",
		height = 35,
		caption = i18n("game_type") .. ":",
		objectOverrideFont = Configuration:GetFont(3),
		parent = hostBattleWindow,
	}
	
	local modeList, customModeMap = {"Cooperative", "Team", "1v1", "FFA", "Custom"}, false
	if WG.ModoptionsPanel and WG.ModoptionsPanel.GetCustomModes then
		modeList, customModeMap = WG.ModoptionsPanel.GetCustomModes(modeList, true)
	end
	
	local typeCombo = ComboBox:New {
		x = 220,
		width = 260,
		y = 150,
		height = 35,
		itemHeight = 22,
		text = "",
		objectOverrideFont = Configuration:GetFont(3),
		items = modeList,
		selected = 1,
		parent = hostBattleWindow,
	}

	local function CancelFunc()
		hostBattleWindow:Dispose()
	end

	local function HostBattle()
		WG.BattleRoomWindow.LeaveBattle()
		local modeSelection = typeCombo.items[typeCombo.selected]
		if customModeMap and customModeMap[modeSelection] then
			local modeData = customModeMap[modeSelection]
			if modeData.shortName then
				-- This asks infra to redownload and apply the custom mode, hopefully solving version issues.
				WG.ModoptionsPanel.UpdateCustomMode(modeData.shortName, true)
			end
			lobby:HostBattle(gameNameEdit.text, (string.len(passwordEdit.text) > 0) and passwordEdit.text, 
				modeData.roomType or "Custom",
				modeData.map,
				modeData.game,
				--modeData.game or (modeData.rapidTag and VFS.GetNameFromRapidTag and VFS.GetNameFromRapidTag(modeData.rapidTag)),
				--VFS.GetNameFromRapidTag returns very old versions sometimes.
				modeData.options
			)
		else
			lobby:HostBattle(gameNameEdit.text, (string.len(passwordEdit.text) > 0) and passwordEdit.text, modeSelection)
		end
		hostBattleWindow:Dispose()
	end

	local buttonHost = Button:New {
		right = 150,
		width = 135,
		bottom = 1,
		height = 70,
		caption = i18n("host"),
		objectOverrideFont = Configuration:GetButtonFont(3),
		parent = hostBattleWindow,
		classname = "action_button",
		OnClick = {
			function()
				HostBattle()
			end
		},
	}

	local buttonCancel = Button:New {
		right = 1,
		width = 135,
		bottom = 1,
		height = 70,
		caption = i18n("cancel"),
		objectOverrideFont = Configuration:GetButtonFont(3),
		parent = hostBattleWindow,
		classname = "negative_button",
		OnClick = {
			function()
				CancelFunc()
			end
		},
	}

	local popupHolder = PriorityPopup(hostBattleWindow, CancelFunc, HostBattle)
end

function BattleListWindow:JoinBattle(battle)
	-- We can be force joined to an invalid engine version. This widget is not
	-- the place to deal with this case.
	if not battle.passworded then
		WG.BattleRoomWindow.LeaveBattle()
		lobby:JoinBattle(battle.battleID)
	else
		local tryJoin, passwordWindow

		local lblError = Label:New {
			x = 30,
			width = 100,
			y = 110,
			height = 80,
			caption = "",
			objectOverrideFont = Configuration:GetFont(2, "error_red", {color = { 1, 0, 0, 1 }}),
			parent = passwordWindow,
		}

		local function onJoinBattleFailed(listener, reason)
			lblError:SetCaption(reason)
		end

		local function onJoinBattle(listener)
			passwordWindow:Dispose()
		end

		passwordWindow = Window:New {
			x = 700,
			y = 300,
			width = 316,
			height = 240,
			caption = "",
			resizable = false,
			draggable = false,
			parent = WG.Chobby.lobbyInterfaceHolder,
			classname = "main_window",
			OnDispose = {
				function()
					lobby:RemoveListener("OnJoinBattleFailed", onJoinBattleFailed)
					lobby:RemoveListener("OnJoinBattle", onJoinBattle)
				end
			},
		}


		local lblPassword = Label:New {
			x = 25,
			right = 15,
			y = 15,
			height = 35,
			objectOverrideFont = Configuration:GetFont(3),
			caption = i18n("enter_battle_password"),
			parent = passwordWindow,
		}

		local ebPassword = EditBox:New {
			x = 30,
			right = 30,
			y = 60,
			height = 35,
			text = "",
			hint = i18n("password"),
			objectOverrideFont = Configuration:GetFont(3),
			objectOverrideHintFont = Configuration:GetHintFont(3),
			passwordInput = true,
			useIME = false,
			parent = passwordWindow,
		}

		function tryJoin()
			lblError:SetCaption("")
			WG.BattleRoomWindow.LeaveBattle()
			lobby:JoinBattle(battle.battleID, ebPassword.text)
		end

		local function CancelFunc()
			passwordWindow:Dispose()
		end

		local btnJoin = Button:New {
			x = 5,
			width = 135,
			bottom = 1,
			height = 70,
			caption = i18n("join"),
			objectOverrideFont = Configuration:GetButtonFont(3),
			classname = "action_button",
			OnClick = {
				function()
					tryJoin()
				end
			},
			parent = passwordWindow,
		}
		local btnClose = Button:New {
			right = 5,
			width = 135,
			bottom = 1,
			height = 70,
			caption = i18n("cancel"),
			objectOverrideFont = Configuration:GetButtonFont(3),
			classname = "negative_button",
			OnClick = {
				function()
					CancelFunc()
				end
			},
			parent = passwordWindow,
		}

		lobby:AddListener("OnJoinBattleFailed", onJoinBattleFailed)
		lobby:AddListener("OnJoinBattle", onJoinBattle)

		local popupHolder = PriorityPopup(passwordWindow, CancelFunc, tryJoin)
		screen0:FocusControl(ebPassword)
	end
end
