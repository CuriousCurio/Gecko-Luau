-- A simple object that requires a connector which can be anything abd a disconnector which can be anything
-- Used for the RBXScriptSignal module

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
	local self = setmetatable({
		Connected = true,
		Disconnect = function(self)
			self.Connected = false;
			Disconnect(self);
		end,
		Connector = Connector
	}, RBXScriptConnection__metatable);
	return self;
end
return RBXScriptConnection__metatable;
