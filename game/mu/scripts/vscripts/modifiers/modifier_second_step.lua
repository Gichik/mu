
modifier_second_step = class({})

function modifier_second_step:IsHidden()
	return false
end

function modifier_second_step:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_START, MODIFIER_EVENT_ON_ATTACK	}
end

function modifier_second_step:GetTexture()
    return "death_stab"
end

function modifier_second_step:RemoveOnDeath()
	return true
end

function modifier_second_step:OnCreated()
	if IsServer () then
		local ability = self:GetCaster():FindAbilityByName("combo")
		ability:SetLevel(1)
	end
end


function modifier_second_step:OnDestroy()
	if IsServer () then
		local ability = self:GetCaster():FindAbilityByName("combo")
		ability:SetLevel(0)
	end
end