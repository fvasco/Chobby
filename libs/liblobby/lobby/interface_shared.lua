VFS.Include(LIB_LOBBY_DIRNAME .. "lobby.lua")

LOG_SECTION = "liblobby"

if not Spring.GetConfigInt("LuaSocketEnabled", 0) == 1 then
	Spring.Log(LOG_SECTION, LOG.ERROR, "LuaSocketEnabled is disabled")
	return false
end

Interface = Lobby:extends{}

function Interface:init()
-- dumpConfig()
	self.messagesSentCount = 0
	self.lastSentSeconds = Spring.GetTimer()
	self.status = "offline"
	self.finishedConnecting = false
	self.listeners = {}

	-- Inheritance is too shallow for interface_zerok.lua to get its own init.
	if self.InheritanceIsBrokenWorkaroundInit then
		self:InheritanceIsBrokenWorkaroundInit()
	end

	-- timeout (in seconds) until first message is received from server before disconnect is assumed
	self.connectionTimeout = 50

	-- private
	self.raggedJsonStore = {}

	self:super("init")
end

function Interface:Connect(host, port, user, password, cpu, localIP, lobbyVersion)
--host = "test.zero-k.info"
--port = 8202
	self:super("Connect", host, port)
	if self.client then
		self.client:close()
	end
	self.client = socket.tcp()
	self.client:settimeout(0)

	self.loginData = {user, password, cpu, localIP, lobbyVersion}

	self._startedConnectingTime = os.clock()
	local res, err = self.client:connect(host, port)
	if res == nil and err == "host not found" then
		self:_OnDisconnected("Host not found")
		-- The socket is expected to return "timeout" immediately since timeout time is set  to 0
	elseif not (res == nil and err == "timeout") then
		Spring.Log(LOG_SECTION, LOG.ERROR, "Error in connect: " .. err)
    else
        self.status = "connecting"
    end
	return true
end

function Interface:Disconnect()
	self.status = "offline"
	self.finishedConnecting = false
	if self.client then
		self.client:close()
	end
	self:_OnDisconnected(nil, true)
end

function Interface:_SendCommand(command, sendMessageCount)
	if sendMessageCount then
		self.messagesSentCount = self.messagesSentCount + 1
		command = "#" .. self.messagesSentCount .. " " .. command
	end
	if command[#command] ~= "\n" then
		command = command .. "\n"
	end
	if not self.client then
		Spring.Echo("Missing self.client!!!")
		return
	end
	self.client:send(command)
	self:_CallListeners("OnCommandSent", command:sub(1, #command-1))
	self.lastSentSeconds = Spring.GetTimer()
end

function Interface:SendCustomCommand(command)
	self:_SendCommand(command, false)
end

function Interface:ProcessBuffer()
	if not self.commandBuffer then
		return false
	end

	self.bufferExecutionPos = self.bufferExecutionPos + 1
	local command = self.commandBuffer[self.bufferExecutionPos]
	if not self.commandBuffer[self.bufferExecutionPos + 1] then
		-- Reset buffer pointers because external widgets read (self.commandsInBuffer > 0)
		-- to set self.bufferCommandsEnabled.
		self:CommandReceived(command)
		self.commandBuffer = false
		self.commandsInBuffer = 0
		self.bufferExecutionPos = 0
		return false
	end
	self:CommandReceived(command)
	return true
end

function Interface:SendCommandToBuffer(cmdName)
	if not self.bufferBypass then
		return true
	end
	return not self.bufferBypass[cmdName]
end

function Interface:CommandReceived(command)
	if command == "" then
		return true -- Mark as successful to remove the command.
	end
	local cmdId, cmdName, arguments
	local argumentsPos = false
	if command:sub(1,1) == "#" then
		local i = command:find(" ")
		cmdId = command:sub(2, i - 1)
		argumentsPos = command:find(" ", i + 1)
		if argumentsPos ~= nil then
			cmdName = command:sub(i + 1, argumentsPos - 1)
		else
			cmdName = command:sub(i + 1)
		end
	else
		argumentsPos = command:find(" ")
		if argumentsPos ~= nil then
			cmdName = command:sub(1, argumentsPos - 1)
		else
			cmdName = command
		end
	end

	if self.bufferCommandsEnabled and self:SendCommandToBuffer(cmdName) then
		if not self.commandBuffer then
			self.commandBuffer = {}
			self.commandsInBuffer = 0
			self.bufferExecutionPos = 0
		end
		self.commandsInBuffer = self.commandsInBuffer + 1
		self.commandBuffer[self.commandsInBuffer] = command
		self:_CallListeners("OnCommandBuffered", command)
		return true
	end

	if argumentsPos then
		arguments = command:sub(argumentsPos + 1)
	end

	return self:_OnCommandReceived(cmdName, arguments, cmdId)
end

function Interface:_GetCommandPattern(cmdName)
	return Interface.commandPattern[cmdName]
end

function Interface:_GetCommandFunction(cmdName)
	return Interface.commands[cmdName], Interface.commandPattern[cmdName]
end

function Interface:_GetJsonCommandFunction(cmdName)
	return Interface.jsonCommands[cmdName]
end

-- status can be one of: "offline", "connected", "connected" and "disconnected"
function Interface:GetConnectionStatus()
	return self.status
end

function Interface:_OnCommandReceived(cmdName, arguments, cmdId)
	local commandFunction, pattern = self:_GetCommandFunction(cmdName)
	local fullCmd
	if arguments ~= nil then
		fullCmd = cmdName .. " " .. arguments
	else
		fullCmd = cmdName
	end

	if commandFunction ~= nil then
		local pattern = self:_GetCommandPattern(cmdName)
		if pattern then
			local funArgs = {arguments:match(pattern)}
			if #funArgs ~= 0 then
				commandFunction(self, unpack(funArgs))
			else
				Spring.Log(LOG_SECTION, LOG.ERROR, "Failed to match command: ", cmdName, ", args: " .. tostring(arguments) .. " with pattern: ", pattern)
			end
		else
			--Spring.Echo("No pattern for command: " .. cmdName)
			commandFunction(self)
		end
	else
		local jsonCommandFunction = self:_GetJsonCommandFunction(cmdName)
		if jsonCommandFunction ~= nil then
			local success, obj = pcall(json.decode, arguments)
			if not success then
				Spring.Log(LOG_SECTION, LOG.ERROR, "Failed to parse JSON: " .. tostring(arguments))
				return false
			end
			if obj then
				jsonCommandFunction(self, obj)
			end
		else
			Spring.Log(LOG_SECTION, LOG.ERROR, "No such function: " .. cmdName .. ", for command: " .. fullCmd)
		end
	end
	self:_CallListeners("OnCommandReceived", fullCmd)
	return true
end

function Interface:_SocketUpdate()
	if self.client == nil then
		return
	end
	-- get sockets ready for read
	local readable, writeable, err = socket.select({self.client}, {self.client}, 0)
	local host, port = self.client:getpeername()
--	if host == nil then
--		self.client:shutdown()
--		self.client = nil
--		self:_OnDisconnected("Cannot resolve host.")
--		return
--	end
	local brec, bsent, age = self.client:getstats()
	if err ~= nil then
		-- some error happened in select
		if err == "timeout" then
			-- we've received no data after connecting for a while. assume connection cannot be established
			if brec == 0 and os.clock() - self._startedConnectingTime > self.connectionTimeout then
				self.client:shutdown()
				self.client = nil
				self:_OnDisconnected("No response from host.")
			end
			-- nothing to do, return
			return
		end
		Spring.Log(LOG_SECTION, LOG.ERROR, "Error in select: " .. error)
	end
	
	local config = WG.Chobby and WG.Chobby.Configuration
	for _, input in ipairs(readable) do
		local s, status, commandsStr = input:receive('*a') --try to read all data
		if (status == "timeout" or status == nil) and commandsStr ~= nil and commandsStr ~= "" then
			Spring.Log(LOG_SECTION, LOG.DEBUG, commandsStr)
			
			if config and config.debugRawMessages then
				Spring.Utilities.TableEcho(self.raggedJsonStore, "self.raggedJsonStore")
				Spring.Echo("commandsStr", commandsStr)
			end
			local commands = explode("\n", commandsStr)
			
			if #commands > 0 then
				local allFail = true
				local newRagged = {}
				for i = 1, #self.raggedJsonStore do
					local internalSuccess
					local success = pcall(function () internalSuccess = self:CommandReceived(self.raggedJsonStore[i] .. commands[1]) end)
					if (success and internalSuccess) then
						allFail = false
					else
						newRagged[#newRagged + 1] = self.raggedJsonStore[i]
					end
				end
				self.raggedJsonStore = newRagged
				if allFail then
					local internalSuccess
					local success = pcall(function () internalSuccess = self:CommandReceived(commands[1]) end)
					if not (success and internalSuccess) then
						Spring.Echo("Processing failed for", commands[1])
					end
				end
				for i = 2, #commands-1 do
					local command = commands[i]
					if command ~= nil then
						self:CommandReceived(command)
					end
				end
				if #commands > 1 then
					local internalSuccess
					local success = pcall(function () internalSuccess = self:CommandReceived(commands[#commands]) end)
					if not (success and internalSuccess) then
						self.raggedJsonStore[#self.raggedJsonStore + 1] = commands[#commands]
					end
				end
			end
		elseif status == "closed" then
			Spring.Log(LOG_SECTION, LOG.INFO, "Disconnected from server.")
			input:close()
			-- if status is "offline", user initiated the disconnection
			if self.status ~= "offline" then
				self.status = "disconnected"
			end
			self:_OnDisconnected()
		end
	end
end

function Interface:SafeUpdate()
	self:super("SafeUpdate")
	self:_SocketUpdate()
	-- prevent timeout with PING
	if self.status == "connected" then
		local currentTime = Spring.GetTimer()
		if Spring.DiffTimers(currentTime, self.lastSentSeconds) > 30 then
			self:Ping()
		end
	end
end

function Interface:Update()
	xpcall(function() self:SafeUpdate() end,
		function(err) self:_PrintError(err) end )
end
