
modifier_triple_shot = class({})

function modifier_triple_shot:IsHidden()
	return false
end


function modifier_triple_shot:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_START, MODIFIER_EVENT_ON_ATTACK	}
end

function modifier_triple_shot:GetTexture()
    return "medusa_split_shot"
end


function modifier_triple_shot:OnAttack( keys )
	
	local caster = self:GetParent()
	local target = keys.target
	
if keys.attacker == caster then
		
	for i = 1, 3 do		
			local vDirection = (caster:GetForwardVector() * 200)
			if vDirection.x < 110 and vDirection.x > -110 then
				vDirection.x = vDirection.x - 60 + i*30
			end
			
			if vDirection.y < 180 and vDirection.y > -180 then
				vDirection.y = vDirection.y - 60 + i*30
			end			
				
			vDirection = Vector(vDirection.x, vDirection.y, 0) 
			vDirection = vDirection:Normalized()	
			
			local info = {
				EffectName	= "particles/units/heroes/hero_windrunner/windrunner_spell_powershot.vpcf",
				Ability = self,
				Source = caster,
				vSpawnOrigin = caster:GetAbsOrigin(),
				vVelocity = vDirection * 4000 * 0.7, 
				fStartRadius = 70,
				fEndRadius = 100,
				fDistance = 1500,
				Source = caster,
				iUnitTargetTeams = DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetTypes = DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
				iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
				iVisionTeamNumber = caster:GetTeamNumber(),
				iVisionRadius = 65
			}
			numb_linear_projectile = ProjectileManager:CreateLinearProjectile( info )

	end
	
	if target ~= nil and target:GetTeamNumber() ~= caster:GetTeamNumber() then
		--local cleaveDamage = caster:GetAgility()
		local cleaveDamage = caster:GetAverageTrueAttackDamage()/2
		DoCleaveAttack( caster, target, self:GetAbility(), cleaveDamage, 700, nil )
	end	
	
end


end

function modifier_triple_shot:RemoveOnDeath()
	return false
end

