-- the RBXScriptSignal.new creates a table which holds multiple RBXScriptConnection
-- This module is only used for the RBXScriptSignal module
-- This module is used by the :Connect function in the RBXScriptSignal metatable

local typeof = require(script.parent.parent.typeof)

local RBXScriptConnection__metatable = {
	__newindex = function(self)end,
	__call = function(self, ...)
		return self.Connector(...);
	end,
	__tostring = function(self)
		return typeof(self) .. (self.Connected and "+" or "-");
	end,
	__metatable = table.freeze({__type = "RBXScriptConnection"})
};



function RBXScriptConnection__metatable.new(Connector:(any), Disconnect:(any))
	local self; -- just a normal variable
self = setmetatable({
		Connected = true,
		Disconnect = function(self)
			self.Connected = false;
			Disconnect(self); -- uses rawset(self, self, nil) as part of the RBXScriptSignal
		end,
		Connector = Connector
	}, RBXScriptConnection__metatable);
	return self;
end
return RBXScriptConnection__metatable;
