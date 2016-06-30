evil_spirits = class({})


function evil_spirits:OnSpellStart()

	local caster = self:GetCaster()	
	local id1 = ParticleManager:CreateParticle("particles/econ/items/enigma/enigma_world_chasm/enigma_blackhole_ti5_dark_swirl.vpcf", PATTACH_OVERHEAD_FOLLOW , caster)
	
	evil_spirits:damage(self)
	GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d",RandomInt(1, 99999)), 
		function()
		ParticleManager:DestroyParticle(id1, false)
		return nil
		end,
		0.9)	
		
	EmitSoundOn("MU.evil_spirits", caster)
			
	
end


function evil_spirits:damage(self)
	local caster = self:GetCaster()
	local pos = self:GetCaster():GetAbsOrigin()
	local dmg = caster:GetAverageTrueAttackDamage()
	--print("dmg: " .. dmg)
	
	local units = FindUnitsInRadius( caster:GetTeamNumber(), pos, caster, self:GetCastRange(pos,caster) ,
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
	end
	end
end
