local ROOT = script:GetCustomProperty("Root"):WaitForObject()

---@type Inventory
local Inventory = require(script:GetCustomProperty("Inventory"))

Inventory.create({

	inventory = script:GetCustomProperty("InventoryObj"):WaitForObject(),
	slot_count = ROOT:GetCustomProperty("SlotCount"),
	storage_key = ROOT:GetCustomProperty("StorageKey"),
	name = ROOT:GetCustomProperty("Name"),
	type = Inventory.Type.CHEST_INVENTORY

})