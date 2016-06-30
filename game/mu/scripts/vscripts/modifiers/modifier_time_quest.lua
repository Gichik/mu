modifier_time_quest = class({})

function modifier_time_quest:IsHidden()
	return false
end


function modifier_time_quest:GetTexture()
    return "dungeon"
end


function modifier_time_quest:OnCreated(params)
--[[		if IsServer () then
			GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d", params.creationtime), 
			function()
				if self:GetCaster():IsAlive() and self:GetCaster():HasModifier("modifier_time_quest") then
					--self:GetParent():SetAbsOrigin(Vector(-1152.000000, 0.000000, 159.999878))
					self:GetCaster():RespawnHero(false, false, false)
				end
			return nil
			end,
			params.duration)
			
		end]]
end

function modifier_time_quest:RemoveOnDeath()
	return true
end