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
	local Table; -- just a normal variable
Table = setmetatable({
		Connected = true,
		Disconnect = function(Table)
			Table.Connected = false;
			Disconnect(Table); -- uses rawset(self, self, nil) as part of the RBXScriptSignal
		end,
		Connector = Connector -- Is only used by this module metatable
	}, RBXScriptConnection__metatable);
	return Table;
end
return RBXScriptConnection__metatable;
