split_shot_activator = class({})

function split_shot_activator:OnUpgrade()	
	--EmitSoundOn("DOTA_Item.InvisibilitySword.Activate", self:GetCaster())
	local caster = self:GetCaster()
	local ability = caster:FindAbilityByName("kundun_split_shot")
	caster:CastAbilityToggle(ability,-1)	
end
