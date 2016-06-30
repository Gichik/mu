modifier_physical_dmg_bonus = class({})

function modifier_physical_dmg_bonus:IsHidden()
	return false
end

function modifier_physical_dmg_bonus:DeclareFunctions()

	return {MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE}
	
end

function modifier_physical_dmg_bonus:GetTexture()
    return "greater_damage"
end



function modifier_physical_dmg_bonus:OnCreated(params)
		if IsServer () then
			self.dmg = params.dmg
			self:SetStackCount(self.dmg)
			
			local id1 = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_fortune_purge_root_pnt.vpcf", 
			PATTACH_ABSORIGIN_FOLLOW , self:GetAbility():GetCursorTarget() )
			
			GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d", params.creationtime), 
			function()
			ParticleManager:DestroyParticle(id1, false)
			return nil
			end,
			params.duration)
			
			--print(self:GetCaster():GetIntellect())
		end
end


function modifier_physical_dmg_bonus:GetModifierPreAttack_BonusDamage()
	
	return self:GetStackCount()
	
end


function modifier_physical_dmg_bonus:RemoveOnDeath()
	return true
end