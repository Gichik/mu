soul_barrier = class({})


function soul_barrier:OnSpellStart()

local caster = self:GetCaster()	
local  modifier = caster:AddNewModifier( caster, self, "modifier_templar_assassin_refraction_absorb", {} )
--modifier:SetStackCount(self:GetSpecialValueFor("stacks")) 
modifier:SetStackCount(caster:GetIntellect()/100)
EmitSoundOn("MU.soul_barrier", caster)

end