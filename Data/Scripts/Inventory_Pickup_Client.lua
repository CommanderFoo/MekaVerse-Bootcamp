---@type SmartObject
local OUTLINE = script:GetCustomProperty("Outline"):WaitForObject()

---@type Trigger
local OUTLINE_TRIGGER = script:GetCustomProperty("OutlineTrigger"):WaitForObject()

---@type Folder
local ITEM = script:GetCustomProperty("Item"):WaitForObject()

local LOCAL_PLAYER = Game.GetLocalPlayer()

local function on_outline_trigger_exit(trigger, other)
	if(other == LOCAL_PLAYER) then
		OUTLINE:SetSmartProperty("Enabled", false)
	end
end

local function on_outline_trigger_enter(trigger, other)
	if(other == LOCAL_PLAYER) then
		OUTLINE:SetSmartProperty("Enabled", true)
		OUTLINE:SetSmartProperty("Object To Outline", ITEM)
	end
end

OUTLINE_TRIGGER.beginOverlapEvent:Connect(on_outline_trigger_enter)
OUTLINE_TRIGGER.endOverlapEvent:Connect(on_outline_trigger_exit)