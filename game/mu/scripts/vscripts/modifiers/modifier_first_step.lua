
modifier_first_step = class({})

function modifier_first_step:IsHidden()
	return false
end


function modifier_first_step:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_START, MODIFIER_EVENT_ON_ATTACK	}
end

function modifier_first_step:GetTexture()
    return "twisting_slash"
end

function modifier_first_step:RemoveOnDeath()
	return true
end

