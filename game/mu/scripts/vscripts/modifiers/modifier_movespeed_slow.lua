
modifier_movespeed_slow = class({})


function modifier_movespeed_slow:IsHidden()
	return false
end


function modifier_movespeed_slow:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE  }
end


function modifier_movespeed_slow:GetTexture()
    return "crystal_maiden_freezing_field"
end


function modifier_movespeed_slow:GetModifierMoveSpeedBonus_Percentage ()
		return -30
end


function modifier_movespeed_slow:RemoveOnDeath()
	return true
end