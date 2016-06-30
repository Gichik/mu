
ability_heal = class({})

function ability_heal:GetCastAnimation()
    return ACT_DOTA_CAST_ABILITY_1  
end

function ability_heal:OnSpellStart()

	if IsServer () then
        local caster = self:GetCaster()
		local target = self:GetCursorTarget() 
		local health = target:GetHealth()+(caster:GetIntellect()/5)
		target:SetHealth(health)
		
		local id1 = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_brightcore_arcana1.vpcf",
		PATTACH_ABSORIGIN_FOLLOW , target )	
		EmitSoundOn("MU.baff", caster)			
    end

end