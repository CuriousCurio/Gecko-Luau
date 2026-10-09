-- This module is used for the Class module,  
-- This module also uses the RBXScriptConnection module

local RBXScriptConnection = require(script.Parent.RBXScriptConnection);

local RBXScriptSignal__metatable = {
	__index = {
		Disconnect = function(self) -- Clears and disconnects the RBXScriptSignal, which is a table
			for connection in pairs(self) do
				connection:Disconnect();
			end
			table.clear(self);
		end,
		Connect = function(self, Connector:(any)) -- Each using the :Connect() functin using RBXScriptConnection
			local connection;
			local Disconnect = function()rawset(self, connection, nil);end
			connection = RBXScriptConnection.new(Connector, Disconnect);

			rawset(self, connection, true);
			return connection;
		end,
		Wait = function(self) -- Waits until the signal has fired
			local time = 0;
			local wait = true;
			local cxn = self:Connect(function()wait = nil;end);
			while (wait) do
				time += task.wait();
			end
			cxn:Disconnect();
			return time;
		end,
		Once = function(self, Connector)
			local cxn; cxn = self:Connect(function(...)Connector(...); cxn:Disconnect();end);
			return cxn;
		end
	},
	__newindex = function()end,
	__call = function(self, ...) -- For iteration
		local arg = {...};

		for connection in pairs(self) do
			local s,e = pcall(function() connection(table.unpack(arg)); end);
			if (s == false) then spawn(function() error(e); end) end
		end
	end,
	__tostring = function(self)
		return getmetatable(self).__type;
	end,
	__metatable = table.freeze({__type = "RBXScriptSignal"})
};


function RBXScriptSignal__metatable.new() -- If a table is used, it will be
	 return setmetatable({}, RBXScriptSignal__metatable);
end
return RBXScriptSignal__metatable;
