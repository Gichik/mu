LinkLuaModifier("modifier_movespeed_slow", "modifiers/modifier_movespeed_slow.lua", LUA_MODIFIER_MOTION_NONE )

ice_arrow = class({})


function ice_arrow:OnSpellStart()

	local caster = self:GetCaster() 

        local info = {
            EffectName = "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf",
            Ability = self,
            Target = self:GetCursorTarget(),
            Source = caster,
            bDodgeable = true,
            bProvidesVision = false,
            vSpawnOrigin = caster:GetAbsOrigin(),
            iMoveSpeed = 1200,
            iVisionRadius = 0,
            iVisionTeamNumber = caster:GetTeamNumber(),
            iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
        }
        ProjectileManager:CreateTrackingProjectile(info)

end


function ice_arrow:Animation(self,target)
	
	local id1 = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ice_temp.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	
	GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d", RandomInt(1, 99999)), 
		function()
		ParticleManager:DestroyParticle(id1, false)
		return nil
		end,
		0.2)	
		
end


function ice_arrow:OnProjectileHit( target, location )
ice_arrow:Animation(self,target)
ice_arrow:Damage(self,target)
end


function ice_arrow:Damage(self,target)

	local caster = self:GetCaster()
	local dmg = caster:GetAgility()/2
	EmitSoundOn("MU.ice", caster)
			

	local damage = {
		victim = target,
		attacker = caster,
		damage = dmg,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = this,
		}
		ApplyDamage( damage )
		target:AddNewModifier( caster, self, "modifier_movespeed_slow", {duration = 3} )			
	
end
