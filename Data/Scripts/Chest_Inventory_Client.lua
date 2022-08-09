local ROOT = script:GetCustomProperty("Root"):WaitForObject()

---@type Inventory
local Inventory = require(script:GetCustomProperty("Inventory"))

local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
local INVENTORY_UI = script:GetCustomProperty("InventoryUI"):WaitForObject()
local SLOTS = ROOT:GetCustomProperty("Slots"):WaitForObject()
local SLOT_COUNT = ROOT:GetCustomProperty("SlotCount")
local SLOTS_PER_ROW = ROOT:GetCustomProperty("SlotsPerRow")
local MAX_HEIGHT = ROOT:GetCustomProperty("MaxHeight")
local NAME = ROOT:GetCustomProperty("Name")
local START_VISIBLE = ROOT:GetCustomProperty("StartVisible")

local SLOT_FRAME_NORMAL = ROOT:GetCustomProperty("SlotFrameNormal")
local SLOT_FRAME_HOVER = ROOT:GetCustomProperty("SlotFrameHover")
local SLOT_BACKGROUND_NORMAL = ROOT:GetCustomProperty("SlotBackgroundNormal")
local SLOT_BACKGROUND_HOVER = ROOT:GetCustomProperty("SlotBackgroundHover")

local INVENTORY = script:GetCustomProperty("InventoryObj"):WaitForObject()

local localPlayer = Game.GetLocalPlayer()
local inTrigger = false

local inventory = nil

local function CloseUI()
	INVENTORY_UI.visibility = Visibility.FORCE_OFF

	if inTrigger then
		TRIGGER.isInteractable = true
	else
		TRIGGER.isInteractable = false
	end
end

local function OnInteracted(trigger, obj)
	if inTrigger and Object.IsValid(obj) and obj:IsA("Player") and obj == localPlayer then
		INVENTORY_UI.visibility = Visibility.FORCE_ON
		TRIGGER.isInteractable = false
		Inventory.enable_cursor()
	end
end

local function OnExitTrigger(trigger, obj)
	if Object.IsValid(obj) and obj:IsA("Player") and obj == localPlayer then
		inTrigger = false
		CloseUI()
	end
end

local function OnEnterTrigger(trigger, obj)
	if Object.IsValid(obj) and obj:IsA("Player") and obj == localPlayer then
		TRIGGER.isInteractable = true
		inTrigger = true
	end
end

if(INVENTORY ~= nil) then
	Inventory.init({

		inventory = INVENTORY,
		inventory_ui = INVENTORY_UI,
		slots = SLOTS,
		slot_count = SLOT_COUNT,
		slot_frame_normal = SLOT_FRAME_NORMAL,
		slot_frame_hover = SLOT_FRAME_HOVER,
		slot_background_normal = SLOT_BACKGROUND_NORMAL,
		slot_background_hover = SLOT_BACKGROUND_HOVER,
		start_visible = START_VISIBLE,
		type = Inventory.Type.CHEST_INVENTORY,
		slots_per_row = SLOTS_PER_ROW,
		max_height = MAX_HEIGHT,

	})
end

TRIGGER.interactedEvent:Connect(OnInteracted)
TRIGGER.endOverlapEvent:Connect(OnExitTrigger)
TRIGGER.beginOverlapEvent:Connect(OnEnterTrigger)