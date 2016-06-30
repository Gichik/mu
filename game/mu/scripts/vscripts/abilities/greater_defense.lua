LinkLuaModifier("modifier_physical_armor_bonus", "modifiers/modifier_physical_armor_bonus.lua", LUA_MODIFIER_MOTION_NONE )

greater_defense = class({})

function greater_defense:GetCastAnimation()
    return ACT_DOTA_CAST_ABILITY_1  
end

function greater_defense:OnSpellStart()

	if IsServer () then
        local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local bonus = caster:GetIntellect()/5
		if target:HasModifier("modifier_physical_armor_bonus") then
			target:RemoveModifierByName("modifier_physical_armor_bonus")
		end
		EmitSoundOn("MU.baff", caster)
		target:AddNewModifier( caster, self, "modifier_physical_armor_bonus", {duration = 10, armor = bonus} )
    end

end