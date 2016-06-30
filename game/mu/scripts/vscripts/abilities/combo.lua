--LinkLuaModifier("modifier_second_step", "modifiers/modifier_second_step.lua", LUA_MODIFIER_MOTION_NONE )

combo = class({})

function combo:GetCastAnimation()
    return ACT_DOTA_ATTACK 
end

function combo:OnSpellStart()

	local caster = self:GetCaster() 
	local target = self:GetCursorTarget()
	local dmg = caster:GetAverageTrueAttackDamage()*2
			
	EmitSoundOn("MU.combo", caster)
			
	local damage = {
		victim = target,
		attacker = caster,
		damage = dmg,
		damage_type = DAMAGE_TYPE_PURE,
		ability = this,
		}
		ApplyDamage( damage )
		knockback(caster,target)
		
	if caster:HasModifier("modifier_second_step") then
		caster:RemoveModifierByName("modifier_second_step")
	end
	
local id1 = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_explosion_g_arcana1.vpcf",
 PATTACH_ABSORIGIN , target)
local id2 = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_explosion_h_arcana1.vpcf",
 PATTACH_ABSORIGIN , target)
local id3 = ParticleManager:CreateParticle("particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", PATTACH_ABSORIGIN , target)

		
end


function knockback( caster, target )
	
	local vCaster = caster:GetAbsOrigin()
	local vTarget = target:GetAbsOrigin()
	local len = ( vTarget - vCaster ):Length2D()
	local knockbackModifierTable =
	{
		should_stun = 1,
		knockback_duration = 1,
		duration = 1,
		knockback_distance = len,
		knockback_height = 0,
		center_x = caster:GetAbsOrigin().x,
		center_y = caster:GetAbsOrigin().y,
		center_z = caster:GetAbsOrigin().z
	}
	target:AddNewModifier( caster, nil, "modifier_knockback", knockbackModifierTable )
	EmitSoundOn("MU.combo_two", caster)
end