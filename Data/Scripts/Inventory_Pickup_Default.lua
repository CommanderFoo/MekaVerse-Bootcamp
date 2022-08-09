local Inventory_Pickup = require(script:GetCustomProperty("Inventory_Pickup"))
local ROOT = script:GetCustomProperty("Root"):WaitForObject()

Inventory_Pickup.register(ROOT)