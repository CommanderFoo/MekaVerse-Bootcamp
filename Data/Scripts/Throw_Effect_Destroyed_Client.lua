local THROWN_ITEM_EFFECT_DESTROYED = script:GetCustomProperty("ThrownItemEffectDestroyed")

script.destroyEvent:Connect(function()
	World.SpawnAsset(THROWN_ITEM_EFFECT_DESTROYED, { position = script:GetWorldPosition() })
end)