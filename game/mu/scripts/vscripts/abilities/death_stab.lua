LinkLuaModifier("modifier_second_step", "modifiers/modifier_second_step.lua", LUA_MODIFIER_MOTION_NONE )

death_stab = class({})

function death_stab:GetCastAnimation()
    return ACT_DOTA_ATTACK 
end

function death_stab:OnSpellStart()

	local caster = self:GetCaster() 
	local target = self:GetCursorTarget()

	
	if caster:HasModifier("modifier_first_step") then
		caster:RemoveModifierByName("modifier_first_step")
		caster:AddNewModifier( caster, self, "modifier_second_step", {duration = 1} )
	end
	
        local info = {
            EffectName = "particles/units/heroes/hero_abaddon/abaddon_death_coil.vpcf",
            Ability = self,
            Target = self:GetCursorTarget(),
            Source = caster,
            bDodgeable = true,
            bProvidesVision = false,
            vSpawnOrigin = caster:GetAbsOrigin(),
            iMoveSpeed = 900,
            iVisionRadius = 0,
            iVisionTeamNumber = caster:GetTeamNumber(),
            iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
        }
        ProjectileManager:CreateTrackingProjectile(info)
		
	EmitSoundOn("MU.death_stab", caster)
	
	local id1 = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_windwalk_burst.vpcf", PATTACH_ABSORIGIN , target)


	
end



function death_stab:OnProjectileHit( target, location )

	local caster = self:GetCaster()
	local dmg = caster:GetAverageTrueAttackDamage()
			
	local damage = {
		victim = target,
		attacker = caster,
		damage = dmg,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = this,
		}
		ApplyDamage( damage )

end
