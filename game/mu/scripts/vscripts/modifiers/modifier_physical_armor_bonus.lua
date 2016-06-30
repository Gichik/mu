modifier_physical_armor_bonus = class({})

function modifier_physical_armor_bonus:IsHidden()
	return false
end

function modifier_physical_armor_bonus:DeclareFunctions()

	return {MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS}
	
end

function modifier_physical_armor_bonus:GetTexture()
    return "greater_defense"
end



function modifier_physical_armor_bonus:OnCreated(params)
		if IsServer () then
			self.armor = params.armor
			self:SetStackCount(self.armor)
			--print(self:GetCaster():GetIntellect())
			
			local id1 = ParticleManager:CreateParticle("particles/units/heroes/hero_huskar/huskar_inner_vitality.vpcf",
			PATTACH_ABSORIGIN_FOLLOW , self:GetAbility():GetCursorTarget() )
			
			GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d", params.creationtime), 
			function()
			ParticleManager:DestroyParticle(id1, false)
			return nil
			end,
			params.duration)			
			
			
		end
end


function modifier_physical_armor_bonus:GetModifierPhysicalArmorBonus()
	
	return self:GetStackCount()
	
end


function modifier_physical_armor_bonus:RemoveOnDeath()
	return true
end