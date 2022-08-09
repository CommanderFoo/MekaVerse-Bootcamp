---@type Inventory_Events
local Inventory_Events = require(script:GetCustomProperty("Inventory_Events"))

local INVENTORY_ASSETS = require(script:GetCustomProperty("InventoryAssets"))
local INVENTORY = script:GetCustomProperty("Inventory")
local DEBUG = script:GetCustomProperty("Debug")
local SLOT = script:GetCustomProperty("Slot")
local HOTBAR_SLOT = script:GetCustomProperty("HotbarSlot")

local DROPPED_ITEM_BOUNCES = script:GetCustomProperty("DroppedItemBounces")
local DROPPED_ITEM_BOUNCINESS = script:GetCustomProperty("DroppedItemBounciness")
local DROPPED_DIST_FROM_PLAYER = script:GetCustomProperty("DroppedDistFromPlayer")
local DROPPED_UP_DIST_FROM_PLAYER = script:GetCustomProperty("DroppedUpDistFromPlayer")
local DROPPED_ITEM_SPEED = script:GetCustomProperty("DroppedItemSpeed")
local DROPPED_ITEM_GRAVITY = script:GetCustomProperty("DroppedItemGravity")
local DROPPED_ITEM_PROJ_RADIUS = script:GetCustomProperty("DroppedItemProjRadius")
local DROPPED_ITEM_PROJ_LENGTH = script:GetCustomProperty("DroppedItemProjLength")
local DROPPED_ITEM_PROJ_LIFE_SPAN = script:GetCustomProperty("DroppedItemProjLifeSpan")

---@class Inventory
local Inventory = {

	disabled_hover = {},

	---@type Inventory_Events
	Events = Inventory_Events

}

Inventory.INVENTORIES = {}
Inventory.INVENTORY_PANELS = {}
Inventory.IS_INSIDE = false

---@class Inventory.ACTIVE
Inventory.ACTIVE = {

	slot = nil,
	slot_icon = nil,
	slot_count = nil,
	slot_index = nil,
	inventory = nil,
	has_item = false,
	hovered_slot_index = nil,
	hovered_inventory = nil,
	hovered_slot = nil

}

---@class Inventory.Type
Inventory.Type = {

	PLAYER_INVENTORY = 1, --Player assigned
	HOTBAR_INVENTORY = 2, --Player assigned
	CHEST_INVENTORY = 3, --World assigned
	ARMOR_INVENTORY = 4, --Player assigned
	STASH_INVENTORY = 5, --Player assigned
	PET_INVENTORY = 6 --Player assigned

}

-- Server

function Inventory.give_items(opts)
	for i = 1, opts.inventory.slotCount do
		local item = INVENTORY_ASSETS[math.random(#INVENTORY_ASSETS)].asset

		if(opts.inventory:CanAddItem(item, { count = 1 })) then
			opts.inventory:AddItem(item, { count = 1 })
		end
	end

	opts.inventory:AddItem(INVENTORY_ASSETS[1].asset, { count = 1 })
end

function Inventory.create(opts)
	local inventory = opts.inventory

	if(inventory == nil) then
		inventory = World.SpawnAsset(INVENTORY, { networkContext = NetworkContextType.NETWORKED })
		opts.inventory = inventory
	end

	if(inventory == nil) then
		error("Could not find or create inventory.")
		return
	end

	inventory:Resize(opts.slot_count)
	inventory.name = opts.name or inventory.id
	Inventory.set_priority(inventory, opts.priority)

	if(opts.player ~= nil) then
		inventory:Assign(opts.player)
	else
		Inventory.give_items(opts)
	end

	Inventory.INVENTORIES[inventory.id] = opts

	if(DEBUG) then
		Inventory.give_items(opts)
	end

	return {

		load = function()
			Inventory.load(opts)
		end

	}
end

function Inventory.set_priority(inventory, priority)
	if(priority ~= nil and priority > 0) then
		inventory:SetCustomProperty("priority", priority)
	end
end

---@TODO check type of inventory and load data table based on type.
function Inventory.load(opts)
	if(opts.type == Inventory.Type.CHEST_INVENTORY) then
		-- ?
	else
		local data = Storage.GetPlayerData(opts.player)
		local inv = data[opts.storage_key] or nil

		if(inv ~= nil) then
			for slot_index, entry in ipairs(inv) do
				local item = Inventory.find_lookup_item_by_index(entry[1])

				if(item ~= nil) then
					if(opts.inventory:CanAddItem(item.asset, { count = entry[2], slot = slot_index })) then
						opts.inventory:AddItem(item.asset, { count = entry[2], slot = slot_index })
					end
				end
			end
		end

		if(opts.type == Inventory.Type.HOTBAR_INVENTORY and opts.storage_slot_key ~= nil) then
			if(data[opts.storage_slot_key] ~= nil) then
				opts.player:SetPrivateNetworkedData("inventory.hotbar." .. opts.storage_slot_key, data[opts.storage_slot_key])
			end
		end
	end
end

---@TODO check type of inventory and save based on data table type.
---Saves inventory.
---@param player Player
function Inventory.save(player)
	if(player == nil) then
		-- ?
	else
		local data = Storage.GetPlayerData(player)

		for id, obj in pairs(Inventory.INVENTORIES) do
			if(obj.player ~= nil and obj.player == player) then
				local inv = obj.inventory

				if(Object.IsValid(inv)) then
					local tmp = {}

					for i = 1, inv.slotCount do
						local item = inv:GetItem(i)
						local entry = {}

						if(item ~= nil) then
							local lookup_item, item_index = Inventory.find_lookup_item_by_asset_id(item.itemAssetId)

							if(lookup_item ~= nil) then
								entry = { item_index, item.count }
							end
						end

						table.insert(tmp, entry)
					end

					data[obj.storage_key] = tmp
				end
			end
		end

		Storage.SetPlayerData(player, data)
	end

	return {

		cleanup = function()
			if(player ~= nil) then
				Inventory.remove_player_inventory(player)
			end
		end

	}
end

function Inventory.save_hotbar_slot(player, storage_slot_key, slot_index)
	if(slot_index > -1) then
		local data = Storage.GetPlayerData(player)

		data[storage_slot_key] = slot_index
		Storage.SetPlayerData(player, data)
	end
end

---Removes a player's inventory.
---@param player Player
function Inventory.remove_player_inventory(player)
	for id, obj in pairs(Inventory.INVENTORIES) do
		if(obj.player ~= nil and obj.player == player and obj.clean_up) then
			obj.inventory:Destroy()
			Inventory.INVENTORIES[id] = nil
			Inventory.INVENTORY_PANELS[id] = nil
		end
	end
end

---Moves an item from one slot to another. This supports cross inventories.
---@param from_inventory_id string The inventory id the item is coming from.
---@param to_inventory_id string The inventory id the item is going too.
---@param from_slot_index integer The slot index the item is coming from.
---@param to_slot_index integer The slot index the item is going too.
function Inventory.move_item_handler(player, from_inventory_id, to_inventory_id, from_slot_index, to_slot_index)
	local from_inventory_obj = Inventory.INVENTORIES[from_inventory_id]
	local to_inventory_obj = Inventory.INVENTORIES[to_inventory_id]

	if(from_inventory_obj ~= nil and to_inventory_obj ~= nil) then
		local from_inventory = from_inventory_obj.inventory
		local to_inventory = to_inventory_obj.inventory

		if(from_inventory == to_inventory) then
			if(from_inventory:CanMoveFromSlot(from_slot_index, to_slot_index)) then
				from_inventory:MoveFromSlot(from_slot_index, to_slot_index)
			end
		else
			local from_item = from_inventory:GetItem(from_slot_index)
			local to_item = to_inventory:GetItem(to_slot_index)

			local from_item_asset_id = from_item.itemAssetId
			local from_item_count = from_item.count

			if(to_item ~= nil) then
				local to_item_asset_id = to_item.itemAssetId
				local to_item_count = to_item.count
				local skip_from_item = false

				if(to_item_asset_id == from_item_asset_id) then
					local total = to_item_count + from_item_count

					if(total > to_item.maximumStackCount) then
						if(to_item_count == to_item.maximumStackCount) then
							to_item_count = to_item.maximumStackCount
							from_item_count = total - to_item.maximumStackCount
						else
							to_item_count = total - to_item.maximumStackCount
							from_item_count = to_item.maximumStackCount
						end
					else
						skip_from_item = true
						from_item_count = total
					end
				end

				from_inventory:RemoveFromSlot(from_slot_index)
				to_inventory:RemoveFromSlot(to_slot_index)

				if(not skip_from_item) then
					from_inventory:AddItem(to_item_asset_id, { count = to_item_count, slot = from_slot_index })
				end
			else
				from_inventory:RemoveFromSlot(from_slot_index)
			end

			to_inventory:AddItem(from_item_asset_id, { count = from_item_count, slot = to_slot_index })
		end
	end
end

---Drops an item into an inventory. If the item is outside of an inventory, then it will drop into the world.
---@param from_inventory_id string The inventory id the item is coming from.
---@param to_inventory_id string The inventory id the item is going too.
---@param from_slot_index integer The slot index the item is coming from.
---@param to_slot_index integer The slot index the item is going too.
---@param is_inside boolean Determins if the item being dropped is over an inventory or not.
function Inventory.drop_one_handler(player, from_inventory_id, to_inventory_id, from_slot_index, to_slot_index, is_inside)
	local from_inventory_obj = Inventory.INVENTORIES[from_inventory_id]
	local to_inventory_obj = Inventory.INVENTORIES[to_inventory_id]

	if(from_inventory_obj ~= nil and to_inventory_obj ~= nil) then
		local from_inventory = from_inventory_obj.inventory
		local to_inventory = to_inventory_obj.inventory
		local item = from_inventory:GetItem(from_slot_index)
		local item_asset_id = item.itemAssetId

		if(not is_inside) then
			if(from_inventory:CanRemoveFromSlot(from_slot_index, { count = 1 })) then
				local owner = from_inventory.owner or player

				Inventory.drop_item_into_world(owner, item_asset_id, 1, from_inventory, from_slot_index)
				from_inventory:RemoveFromSlot(from_slot_index, { count = 1 })
			end
		elseif(to_inventory:CanAddItem(item_asset_id, { count = 1, slot = to_slot_index }) and from_inventory:CanRemoveFromSlot(from_slot_index)) then
			to_inventory:AddItem(item_asset_id, { count = 1, slot = to_slot_index })
			from_inventory:RemoveFromSlot(from_slot_index, { count = 1 })
		end
	end
end

function Inventory.drop_stack_handler(player, from_inventory_id, to_inventory_id, from_slot_index, to_slot_index, is_inside)
	local from_inventory_obj = Inventory.INVENTORIES[from_inventory_id]
	local to_inventory_obj = Inventory.INVENTORIES[to_inventory_id]

	if(from_inventory_obj ~= nil and to_inventory_obj ~= nil) then
		local from_inventory = from_inventory_obj.inventory
		local item = from_inventory:GetItem(from_slot_index)
		local item_asset_id = item.itemAssetId

		if(not is_inside) then
			if(from_inventory:CanRemoveFromSlot(from_slot_index, { count = item.count })) then
				local owner = from_inventory.owner or player

				Inventory.drop_item_into_world(owner, item_asset_id, item.count, from_inventory, from_slot_index)
				from_inventory:RemoveFromSlot(from_slot_index, { count = item.count })
			end
		end
	end
end

function Inventory.drop_item_into_world(owner, item_asset_id, count, inventory, from_slot_index)
	local item = Inventory.find_lookup_item_by_asset_id(item_asset_id)
	local forward = owner:GetViewWorldRotation() * Vector3.FORWARD
	local projectile = Projectile.Spawn(item.throw_template, owner:GetWorldPosition() + (Vector3.UP * DROPPED_UP_DIST_FROM_PLAYER) + (forward * DROPPED_DIST_FROM_PLAYER), forward)

	projectile.shouldDieOnImpact = false
	projectile.speed = DROPPED_ITEM_SPEED
	projectile.gravityScale = DROPPED_ITEM_GRAVITY
	projectile.bouncesRemaining = DROPPED_ITEM_BOUNCES
	projectile.capsuleRadius = DROPPED_ITEM_PROJ_RADIUS
	projectile.capsuleLength = DROPPED_ITEM_PROJ_LENGTH
	projectile.bounciness = DROPPED_ITEM_BOUNCINESS

	projectile.impactEvent:Connect(function(proj, other, hit)
		if(not other:IsA("Player")) then
			projectile.bouncesRemaining = math.max(0, projectile.bouncesRemaining - 1)

			if(projectile.bouncesRemaining == 0) then
				projectile:Destroy()
				Events.Broadcast(Inventory_Events.DROP, item, count, hit:GetImpactPosition() + (Vector3.UP * 10))
			end
		end
	end)

	projectile.lifeSpan = DROPPED_ITEM_PROJ_LIFE_SPAN
end

---Removes an item from a slot.
---@param inventory_id string
---@param slot_index integer
function Inventory.remove_item_handler(player, inventory_id, slot_index)
	local inventory_obj = Inventory.INVENTORIES[inventory_id]

	if(inventory_obj ~= nil) then
		local inventory = inventory_obj.inventory

		if(inventory:CanRemoveFromSlot(slot_index)) then
			inventory:RemoveFromSlot(slot_index)
		end
	end
end

function Inventory.get_player_inventories(player)
	local inventories = {}

	for i, inv in pairs(Inventory.INVENTORIES) do
		if(inv.owner == player) then
			table.insert(inventories, inv)
		end
	end

	return inventories
end

-- Client

---Clears the ACTIVE table.
function Inventory.clear_dragged_item()
	Inventory.ACTIVE.slot = nil
	Inventory.ACTIVE.slot_icon = nil
	Inventory.ACTIVE.slot_count = nil
	Inventory.ACTIVE.slot_index = nil
	Inventory.ACTIVE.inventory = nil
	Inventory.ACTIVE.has_item = false
	Inventory.ACTIVE.hovered_slot = nil
	Inventory.ACTIVE.hovered_slot_index = nil
	Inventory.ACTIVE.hovered_inventory = nil
end

---Set the drag proxy object and setup the icon and count properties.
---@param proxy UIControl
function Inventory.set_drag_proxy(proxy)
	Inventory.PROXY = proxy
	Inventory.PROXY_ICON = proxy:FindChildByName("Icon")
	Inventory.PROXY_COUNT = Inventory.PROXY_ICON:FindChildByName("Count")
end

---Enables the cursor for the player.
function Inventory.enable_cursor()
	UI.SetCanCursorInteractWithUI(true)
	UI.SetCursorVisible(true)
end

---Disables the cursor for the player.
function Inventory.disable_cursor()
	UI.SetCanCursorInteractWithUI(false)
	UI.SetCursorVisible(false)
end

---When a slot is pressed, it will either pick up the item in a slot, swap it,
---or add to the stack count of the going to slot.
---@param button UIButton
---@param params table Table contains slot and inventory information.
function Inventory.on_slot_pressed_event(button, params)
	local icon = params.slot:GetCustomProperty("Icon"):GetObject()
	local is_hidden = icon.visibility == Visibility.FORCE_OFF and true or false
	local count = params.slot:GetCustomProperty("Count"):GetObject()

	-- Has item already.
	if(Inventory.ACTIVE.has_item) then

		-- No icon, so this is an empty slot, and dropping it into it.
		if(is_hidden) then
			icon.visibility = Visibility.FORCE_ON
			icon:SetImage(Inventory.PROXY_ICON:GetImage())
			Inventory.ACTIVE.slot.opacity = 1
			Inventory.ACTIVE.slot_icon.visibility = Visibility.FORCE_OFF

			if(Object.IsValid(count) and Object.IsValid(Inventory.ACTIVE.slot_count)) then
				count.text = Inventory.ACTIVE.slot_count.text
			end

			if(Object.IsValid(Inventory.ACTIVE.slot_count)) then
				Inventory.ACTIVE.slot_count.text = "0"
			end

		-- Slot contains existing item
		else
			local item = Inventory.ACTIVE.inventory:GetItem(Inventory.ACTIVE.slot_index)
			local hovered_inventory = Inventory.ACTIVE.hovered_inventory or Inventory.ACTIVE.inventory
			local to_item = hovered_inventory:GetItem(Inventory.ACTIVE.hovered_slot_index or Inventory.ACTIVE.slot_index)

			if(item ~= nil and to_item ~= nil and item.itemAssetId == to_item.itemAssetId and to_item.count == to_item.maximumStackCount) then
				Inventory.ACTIVE.slot.opacity = 1
			else
				local tmp_img = icon:GetImage()
				local tmp_count = nil

				if(Object.IsValid(count)) then
					tmp_count = count.text
				end

				icon:SetImage(Inventory.ACTIVE.slot_icon:GetImage())

				if(Object.IsValid(count) and Object.IsValid(Inventory.ACTIVE.slot_count)) then
					count.text = Inventory.ACTIVE.slot_count.text
				end

				Inventory.ACTIVE.slot_icon:SetImage(tmp_img)

				if(tmp_count ~= nil and Object.IsValid(Inventory.ACTIVE.slot_count)) then
					Inventory.ACTIVE.slot_count.text = tmp_count
				end

				Inventory.ACTIVE.slot.opacity = 1

				tmp_img = nil
				tmp_count = nil
			end
		end

		Events.BroadcastToServer(Inventory_Events.MOVE, Inventory.ACTIVE.inventory.id, params.inventory.id, Inventory.ACTIVE.slot_index, params.slot_index)

		Inventory.clear_dragged_item()
		Inventory.PROXY.visibility = Visibility.FORCE_OFF

	-- No item, pick up from clicked slot.
	elseif(not is_hidden) then
		Inventory.PROXY.visibility = Visibility.FORCE_ON
		Inventory.ACTIVE.has_item = true
		Inventory.PROXY_ICON:SetImage(icon:GetImage())
		Inventory.PROXY_COUNT.text = tostring(params.inventory:GetItem(params.slot_index).count)
		params.slot.opacity = .6
		Inventory.ACTIVE.slot = params.slot
		Inventory.ACTIVE.slot_icon = icon
		Inventory.ACTIVE.slot_count = count
		Inventory.ACTIVE.slot_index = params.slot_index
		Inventory.ACTIVE.inventory = params.inventory
	end
end

---Drops item in to a slot, to an existing count, or into the world.
---@param player Player
---@param action string
function Inventory.drop_action(player, action)
	if(action == "Drop One Item" or action == "Drop Stack") then
		if(Inventory.ACTIVE.has_item and Inventory.ACTIVE.hovered_inventory and Inventory.ACTIVE.hovered_slot) then
			local item = Inventory.ACTIVE.inventory:GetItem(Inventory.ACTIVE.slot_index)
			local item_count = item.count
			local new_count = math.max(0, item.count - 1)
			local item_asset_id = item.itemAssetId

			if(not Inventory.IS_INSIDE) then
				local evt = Inventory_Events.DROP_ONE

				if(action == "Drop Stack") then
					evt = Inventory_Events.DROP_STACK
					new_count = 0
				end

				Events.BroadcastToServer(evt, Inventory.ACTIVE.inventory.id, Inventory.ACTIVE.inventory.id, Inventory.ACTIVE.slot_index, Inventory.ACTIVE.hovered_slot_index, Inventory.IS_INSIDE)

				if(new_count == 0) then
					Inventory.PROXY.visibility = Visibility.FORCE_OFF
					Inventory.ACTIVE.slot.opacity = 1
					Inventory.clear_dragged_item()
				else
					Inventory.PROXY_COUNT.text = tostring(new_count)
				end
			else
				local icon = Inventory.ACTIVE.hovered_slot:GetCustomProperty("Icon"):GetObject()
				local is_hidden = icon.visibility == Visibility.FORCE_OFF and true or false

				if(Inventory.ACTIVE.inventory == Inventory.ACTIVE.hovered_inventory and Inventory.ACTIVE.slot_index == Inventory.ACTIVE.hovered_slot_index) then
					Inventory.PROXY.visibility = Visibility.FORCE_OFF
					Inventory.ACTIVE.slot.opacity = 1
					Inventory.clear_dragged_item()
				elseif(is_hidden) then
					icon.visibility = Visibility.FORCE_ON
					icon:SetImage(Inventory.PROXY_ICON:GetImage())
					Inventory.PROXY_COUNT.text = new_count == 0 and "" or tostring(new_count)

					Events.BroadcastToServer(Inventory_Events.DROP_ONE, Inventory.ACTIVE.inventory.id, Inventory.ACTIVE.hovered_inventory.id, Inventory.ACTIVE.slot_index, Inventory.ACTIVE.hovered_slot_index, true)

					if(new_count == 0) then
						Inventory.PROXY.visibility = Visibility.FORCE_OFF
						Inventory.ACTIVE.slot.opacity = 1
						Inventory.clear_dragged_item()
					end
				else
					local current_item = Inventory.ACTIVE.hovered_inventory:GetItem(Inventory.ACTIVE.hovered_slot_index)
					local can_drop = true

					if(current_item ~= nil and current_item.count == current_item.maximumStackCount and current_item.itemAssetId == item_asset_id) then
						can_drop = false
					end

					if(can_drop) then
						Events.BroadcastToServer(Inventory_Events.DROP_ONE, Inventory.ACTIVE.inventory.id, Inventory.ACTIVE.hovered_inventory.id, Inventory.ACTIVE.slot_index, Inventory.ACTIVE.hovered_slot_index, true)

						if(current_item.itemAssetId == item_asset_id) then
							Inventory.PROXY_COUNT.text = new_count == 0 and "" or tostring(new_count)
						end
					end

					if(new_count == 0) then
						Inventory.PROXY.visibility = Visibility.FORCE_OFF
						Inventory.ACTIVE.slot.opacity = 1
						Inventory.clear_dragged_item()
					end
				end
			end
		end		
	end
end

---Triggers when the player hovers over a slot.
---@param button UIButton
---@param params table
function Inventory.on_hovered_event(button, params)
	local frame = params.slot:GetCustomProperty("Frame"):GetObject()

	if(Inventory.disabled_hover[frame] == nil) then
		frame:SetColor(params.slot_frame_hover)
	end

	params.slot:GetCustomProperty("Background"):GetObject():SetColor(params.slot_background_hover)

	Inventory.ACTIVE.hovered_slot_index = params.slot_index
	Inventory.ACTIVE.hovered_inventory = params.inventory
	Inventory.ACTIVE.hovered_slot = params.slot
end

---Triggers when the player unhovers on a slot.
---@param button UIButton
---@param params table
function Inventory.on_unhovered_event(button, params)
	local frame = params.slot:GetCustomProperty("Frame"):GetObject()

	if(Inventory.disabled_hover[frame] == nil) then
		frame:SetColor(params.slot_frame_normal)
	end

	params.slot:GetCustomProperty("Background"):GetObject():SetColor(params.slot_background_normal)
end

---Looks up an inventory.
---@param name string
---@return Inventory
function Inventory.get_inventory(name, type, container)
	if(type == Inventory.Type.CHEST_INVENTORY) then
		while(container:GetChildren() == 0) do
			Task.Wait()
		end

		return container:GetChildren()[1]
	else
		local local_player = Game.GetLocalPlayer()

		while(#local_player:GetInventories() == 0) do
			Task.Wait()
		end

		for i, inv in ipairs(local_player:GetInventories()) do
			if(inv.name == name) then
				return inv
			end
		end
	end

	return nil
end

function Inventory.get_priority_inventories(player)
	local inventories = {}

	for i, inv in ipairs(player:GetInventories()) do
		local priority = inv:GetCustomProperty("priority")

		if(priority ~= nil and priority > 0) then
			inventories[#inventories + 1] = { priority = priority, inventory = inv }
		end
	end

	table.sort(inventories, function(a, b)
		return a.priority < b.priority
	end)

	return inventories
end

function Inventory.can_pickup_item(player, asset_id)
	local inventories = Inventory.get_priority_inventories(player)

	for index, entry in ipairs(inventories) do
		if(entry.inventory.occupiedSlotCount < entry.inventory.slotCount) then
			return true
		end

		local items = entry.inventory:GetItems(asset_id)

		for i, item in pairs(items) do
			if(item.count < item.maximumStackCount) then
				return true
			end
		end
	end

	return false
end

---Disables the frame from being hovered over. This is used with hotbars.
---@param slot_frame UIImage
function Inventory.disable_frame_hover(slot_frame)
	Inventory.disabled_hover[slot_frame] = 1
end

---Enables frame over on a slot by removing it from the lookup table.
---@param slot_frame UIImage
function Inventory.enable_frame_hover(slot_frame)
	if(Inventory.disabled_hover[slot_frame] ~= nil) then
		Inventory.disabled_hover[slot_frame] = nil
	end
end

---Gets the inventory panels
---@return table
function Inventory.get_panels()
	local panels = {}

	for id, data in pairs(Inventory.INVENTORY_PANELS) do
		table.insert(panels, data)
	end

	return panels
end

---Sets an inventory panel.
---@param id string The inventory id.
---@param panel UIControl
function Inventory.set_panel(id, panel)
	Inventory.INVENTORY_PANELS[id] = panel
end

---Ticks every frame to check if the player is inside an inventory when they have an item.
function Inventory.tick()
	Inventory.IS_INSIDE = false

	if(Inventory.ACTIVE.has_item) then
		local panels = Inventory.get_panels()

		if(#panels > 0) then
			for i, panel in ipairs(panels) do
				if(panel.visibility ~= Visibility.FORCE_OFF) then
					local mouse_pos = Input.GetCursorPosition()
					local pos = panel:GetAbsolutePosition()

					local x_start = 0
					local x_end = 0
					local y_start = 0
					local y_end = 0
					local anchor = panel.anchor

					if(anchor == UIPivot.TOP_LEFT) then
						x_start = pos.x
						x_end = pos.x + panel.width
						y_start = pos.y
						y_end = pos.y + panel.height
					elseif(anchor == UIPivot.TOP_CENTER) then
						x_start = pos.x - (panel.width / 2)
						x_end = pos.x + (panel.width / 2)
						y_start = pos.y
						y_end = pos.y + panel.height
					elseif(anchor == UIPivot.TOP_RIGHT) then
						x_start = pos.x - panel.width
						x_end = pos.x
						y_start = pos.y
						y_end = pos.y + panel.height
					elseif(anchor == UIPivot.MIDDLE_LEFT) then
						x_start = pos.x
						x_end = pos.x + panel.width
						y_start = pos.y - (panel.height / 2)
						y_end = pos.y + (panel.height / 2)
					elseif(anchor == UIPivot.MIDDLE_CENTER) then
						x_start = pos.x - (panel.width / 2)
						x_end = pos.x + (panel.width / 2)
						y_start = pos.y - (panel.height / 2)
						y_end = pos.y + (panel.height / 2)
					elseif(anchor == UIPivot.MIDDLE_RIGHT) then
						x_start = pos.x - panel.width
						x_end = pos.x
						y_start = pos.y - (panel.height / 2)
						y_end = pos.y + (panel.height / 2)
					elseif(anchor == UIPivot.BOTTOM_LEFT) then
						x_start = pos.x
						x_end = pos.x + panel.width
						y_start = pos.y - panel.height
						y_end = pos.y
					elseif(anchor == UIPivot.BOTTOM_CENTER) then
						x_start = pos.x - (panel.width / 2)
						x_end = pos.x + (panel.width / 2)
						y_start = pos.y - panel.height
						y_end = pos.y
					elseif(anchor == UIPivot.BOTTOM_RIGHT) then
						x_start = pos.x - panel.width
						x_end = pos.x
						y_start = pos.y - panel.height
						y_end = pos.y
					end

					if(mouse_pos.x > x_start and mouse_pos.x < x_end and mouse_pos.y > y_start and mouse_pos.y < y_end) then
						Inventory.IS_INSIDE = true
					end

					--print(string.format("Mouse X: %s, Start X: %s, End X: %s, Mouse Y: %s, Start Y: %s, End Y: %s, Inside: %s", mouse_pos.x, x_start, x_end, mouse_pos.y, y_start, y_end, Inventory.IS_INSIDE))
				end
			end
		end
	end
end

---Global inventory changed event.
---@param inventory Inventory
---@param slot_index integer
---@param slots UIPanel
function Inventory.inventory_changed(inventory, slot_index, slots)
	local item = inventory:GetItem(slot_index)
	local child_icon = slots:GetChildren()[slot_index]:GetCustomProperty("Icon"):GetObject()
	local child_count = slots:GetChildren()[slot_index]:GetCustomProperty("Count"):GetObject()

	if(item ~= nil) then
		local icon = item:GetCustomProperty("Icon")

		child_icon:SetImage(icon)
		child_icon.visibility = Visibility.FORCE_ON

		if(Object.IsValid(child_count)) then
			child_count.text = tostring(item.count)
		end

		if(Inventory.ACTIVE.inventory == inventory and Inventory.ACTIVE.slot_index == slot_index) then
			Inventory.PROXY_COUNT.text = tostring(item.count)
		end
	else
		child_icon.visibility = Visibility.FORCE_OFF

		if(Object.IsValid(child_count)) then
			child_count.text = ""
		end
	end
end

function Inventory.create_slots(opts)
	if(opts.slot_count <= 0 or opts.type == Inventory.Type.ARMOR_INVENTORY) then
		return
	end

	local slots_per_row = opts.slots_per_row or opts.slot_count
	local x_offset = 0
	local y_offset = 0
	local is_hotbar = opts.type == Inventory.Type.HOTBAR_INVENTORY and true or false
	local slot_width = 0
	local slot_height = 0
	local counter = 0

	for i = 1, opts.slot_count do
		local slot = World.SpawnAsset(is_hotbar and HOTBAR_SLOT or SLOT)

		if(slot_width == 0) then
			slot_width = slot.width
		end

		if(slot_height == 0) then
			slot_height = slot.height
		end

		slot.parent = opts.slots

		if(counter == slots_per_row) then
			x_offset = 0
			y_offset = y_offset + slot.height
			counter = 0
		end

		slot.x = x_offset
		slot.y = y_offset
		x_offset = x_offset + slot.width
		counter = counter + 1
	end

	local extra_width = math.abs(opts.slots.width)
	local extra_height = math.abs(opts.slots.height)

	if(opts.parent_slots ~= nil) then
		extra_width = math.abs(opts.parent_slots.width)
		extra_height = math.abs(opts.parent_slots.height) + opts.parent_slots.y
	end

	if(opts.type == Inventory.Type.HOTBAR_INVENTORY and opts.inventory_ui.width > 0) then
		opts.slots.x = opts.inventory_ui.width / 2
	end

	opts.inventory_ui.width = math.floor(opts.inventory_ui.width + (slot_width * slots_per_row) + extra_width)
	opts.inventory_ui.height = math.floor(opts.inventory_ui.height + slot_height * (opts.slot_count / slots_per_row) + extra_height)

	if(opts.max_height ~= nil and opts.max_height > 0 and opts.inventory_ui.height > opts.max_height) then
		opts.inventory_ui.height = opts.max_height

		if(opts.parent_slots ~= nil) then
			opts.slots.width = 10
		end
	end
end

function Inventory.init(opts)
	if(opts.slots:GetChildren()[1] ~= nil and opts.slots:GetChildren()[1]:IsA("UIScrollPanel")) then
		opts.parent_slots = opts.slots
		opts.slots = opts.slots:GetChildren()[1]
	end

	Inventory.create_slots(opts)
	Inventory.set_panel(opts.inventory.id, opts.inventory_ui)

	for slot_index, item in pairs(opts.inventory:GetItems()) do
		Inventory.inventory_changed(opts.inventory, slot_index, opts.slots)
	end

	opts.inventory.changedEvent:Connect(Inventory.inventory_changed, opts.slots)

	for index, slot in ipairs(opts.slots:GetChildren()) do
		local button = slot:GetCustomProperty("Button"):GetObject()
		local icon = slot:GetCustomProperty("Icon"):GetObject()

		if(button ~= nil and icon ~= nil and button.isInteractable) then
			local params = {

				inventory = opts.inventory,
				slot = slot,
				slot_index = index,
				slot_frame_hover = opts.slot_frame_hover,
				slot_background_hover = opts.slot_background_hover,
				slot_frame_normal = opts.slot_frame_normal,
				slot_background_normal = opts.slot_background_normal,

			}

			button.pressedEvent:Connect(Inventory.on_slot_pressed_event, params)
			button.hoveredEvent:Connect(Inventory.on_hovered_event, params)
			button.unhoveredEvent:Connect(Inventory.on_unhovered_event, params)
		end
	end

	if(opts.start_visible) then
		opts.inventory_ui.visibility = Visibility.INHERIT
	end
end

-- Shared

---Looks up an item by the index that is used for storage.
---@param index integer
---@return table
function Inventory.find_lookup_item_by_index(index)
	for i, data_item in ipairs(INVENTORY_ASSETS) do
		if(index == i) then
			return data_item
		end
	end

	return nil
end

---Find an item based on an asset id.
---@param item_asset_id string
---@return table, integer
function Inventory.find_lookup_item_by_asset_id(item_asset_id)
	for i, data_item in ipairs(INVENTORY_ASSETS) do
		local id = CoreString.Split(data_item.asset, ":")

		if(id == item_asset_id) then
			return data_item, i
		end
	end
end

-- Events

if(Environment.IsServer()) then
	Events.ConnectForPlayer(Inventory_Events.MOVE, Inventory.move_item_handler)
	Events.ConnectForPlayer(Inventory_Events.DROP_ONE, Inventory.drop_one_handler)
	Events.ConnectForPlayer(Inventory_Events.DROP_STACK, Inventory.drop_stack_handler)
	Events.ConnectForPlayer(Inventory_Events.REMOVE, Inventory.remove_item_handler)
	Events.ConnectForPlayer(Inventory_Events.HOTBAR_SAVE_SLOT, Inventory.save_hotbar_slot)
else
	Input.actionPressedEvent:Connect(Inventory.drop_action)
end


---@DEBUG REMOVE
if(Environment.IsServer()) then
	Input.actionPressedEvent:Connect(function(player, action)
		if(action == "Debug Add Item") then
			player:GetInventories()[math.random(#player:GetInventories())]:AddItem(INVENTORY_ASSETS[math.random(#INVENTORY_ASSETS)].asset, { count = math.random(10) })
		end
	end)
end

return Inventory