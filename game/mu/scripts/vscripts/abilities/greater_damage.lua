LinkLuaModifier("modifier_physical_dmg_bonus", "modifiers/modifier_physical_dmg_bonus.lua", LUA_MODIFIER_MOTION_NONE )

greater_damage = class({})

function greater_damage:GetCastAnimation()
    return ACT_DOTA_CAST_ABILITY_1  
end

function greater_damage:OnSpellStart()

	if IsServer () then
        local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local bonus = caster:GetIntellect()/5
		if target:HasModifier("modifier_physical_dmg_bonus") then
			target:RemoveModifierByName("modifier_physical_dmg_bonus")
			
		end	
		EmitSoundOn("MU.baff", caster)
		target:AddNewModifier( caster, self, "modifier_physical_dmg_bonus", {duration = 10, dmg = bonus} )		
		
    end

end