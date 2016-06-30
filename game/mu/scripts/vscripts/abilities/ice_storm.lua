LinkLuaModifier("modifier_movespeed_slow", "modifiers/modifier_movespeed_slow.lua", LUA_MODIFIER_MOTION_NONE )

ice_storm = class({})


 function ice_storm:GetAOERadius()
     return self:GetSpecialValueFor("radius")
 end

 function ice_storm:GetBehavior() 
     local behav = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
     return behav
 end


function ice_storm:OnSpellStart()
	EmitSoundOn("MU.ice_storm", self:GetCaster())
	ice_storm:Animation(self)
	ice_storm:Damage(self)
end


function ice_storm:Animation(self)

local rVector = nil
local point =  self:GetCursorPosition()
local id1 = {}
local id2 = {}

for i = 1, 5 do 

	rVector = RandomVector( RandomFloat( 0, self:GetSpecialValueFor("radius")-100 ))
	
	id1[i] = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControl( id1[i], 0, point + rVector)
	
	id2[i] = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf", PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControl( id2[i], 0, point + rVector)	
	

end
	
						
	GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d", RandomInt(1, 99999)), 
			function()
			ParticleManager:DestroyParticle(id2[1], false)
			ParticleManager:DestroyParticle(id2[2], false)
			ParticleManager:DestroyParticle(id2[3], false)
			ParticleManager:DestroyParticle(id2[4], false)
			ParticleManager:DestroyParticle(id2[5], false)
			return nil
			end,
			0.8)			
	
end


function ice_storm:Damage(self)
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local dmg = caster:GetAverageTrueAttackDamage()/2
	
	
	local units = FindUnitsInRadius( caster:GetTeamNumber(), point, caster, self:GetSpecialValueFor("radius") ,
	DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 1, #units do		
	if units[ i ] then 
			--StartSoundEvent("Hero_Spirit_Breaker.GreaterBash", units[ i ])
			local damage = {
				victim = units[ i ],
				attacker = self:GetCaster(),
				damage = dmg,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = this,
			}
			ApplyDamage( damage )
			units[ i ]:AddNewModifier( caster, self, "modifier_movespeed_slow", {duration = 3} )			
	end
	end
	
end
