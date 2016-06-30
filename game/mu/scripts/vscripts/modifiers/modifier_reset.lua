
modifier_reset = class({})

function modifier_reset:IsHidden()
	return false
end


function modifier_reset:GetTexture()
    return "reset"
end

function modifier_reset:RemoveOnDeath()
	return false
end

