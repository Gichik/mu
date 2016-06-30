--LinkLuaModifier("modifier_movespeed_slow", "modifiers/modifier_movespeed_slow.lua", LUA_MODIFIER_MOTION_NONE )

strike_of_destruction = class({})

function strike_of_destruction:GetCastAnimation()
    return ACT_DOTA_ATTACK 
end

function strike_of_destruction:OnSpellStart()

	local caster = self:GetCaster() 

        local info = {
            EffectName = "particles/units/heroes/hero_jakiro/jakiro_ice_path_shards.vpcf",
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
		
	EmitSoundOn("MU.strike_of_destruction", caster)
		
		
end


function strike_of_destruction:Animation(self,target)
 	
	local id1 = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ice_temp.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	
	GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d", RandomInt(1, 99999)), 
		function()
		ParticleManager:DestroyParticle(id1, false)
		return nil
		end,
		0.2)	
	
end


function strike_of_destruction:OnProjectileHit( target, location )
strike_of_destruction:Animation(self,target)
strike_of_destruction:Damage(self,target)
end


function strike_of_destruction:Damage(self,target)

	local caster = self:GetCaster()
	local dmg = caster:GetStrength()/2
			
	EmitSoundOn("MU.ice", caster)
	local damage = {
		victim = target,
		attacker = caster,
		damage = dmg,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = this,
		}
		ApplyDamage( damage )
		target:AddNewModifier( caster, self, "modifier_crystal_maiden_frostbite", {duration = 3} )			
	
end
