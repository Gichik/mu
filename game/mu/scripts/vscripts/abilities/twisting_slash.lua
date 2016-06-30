LinkLuaModifier("modifier_first_step", "modifiers/modifier_first_step.lua", LUA_MODIFIER_MOTION_NONE )

twisting_slash = class({})

function twisting_slash:OnSpellStart()

	local caster = self:GetCaster()	
	
	caster:AddNewModifier( caster, self, "modifier_first_step", {duration = 1} )
	
	local id1 = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_ward_create.vpcf", PATTACH_ABSORIGIN_FOLLOW  , caster)
	
	twisting_slash:damage(self)
	GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d",RandomInt(1, 99999)), 
		function()
		ParticleManager:DestroyParticle(id1, false)
		return nil
		end,
		1)	
		
	EmitSoundOn("MU.twisting_slash", caster)
			
	
end


function twisting_slash:damage(self)
	local caster = self:GetCaster()
	local pos = self:GetCaster():GetAbsOrigin()
	local dmg = caster:GetStrength()
	
	local units = FindUnitsInRadius( caster:GetTeamNumber(), pos, caster, self:GetCastRange(pos,caster) ,
	DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 1, #units do		
	if units[ i ] then 
			
			local damage = {
				victim = units[ i ],
				attacker = self:GetCaster(),
				damage = dmg,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = this,
			}
			ApplyDamage( damage )	
	end
	end
end
