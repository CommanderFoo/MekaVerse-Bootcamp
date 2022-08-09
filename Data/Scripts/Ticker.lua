---@class Ticker
local Ticker = {}

function Ticker:tick(fn)
	self.st = time()

	self.ticking_task = Task.Spawn(function()
		self.dt = time() - self.st

		fn(self.dt)
	end)

	self.ticking_task.repeatCount = -1
end

function Ticker:cancel()
	if(self.ticking_task ~= nil) then
		self.ticking_task:Cancel()
		self.ticking_task = nil
	end
end

function Ticker:new()
	self.__index = self

	return setmetatable({}, self)
end

return Ticker