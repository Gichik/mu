
LinkLuaModifier("modifier_one_punch_man_speed", "modifiers/modifier_one_punch_man_speed.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_triple_shot", "modifiers/modifier_triple_shot.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_reset", "modifiers/modifier_reset.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_time_quest", "modifiers/modifier_time_quest.lua", LUA_MODIFIER_MOTION_NONE )

function SetWinner(data)
	--local entH = EntIndexToHScript(data.entindex_attacker)
	--GameRules:MakeTeamLose(entH:GetTeamNumber())
end


function Respawn(data)

	local moob = data.caster
	local name = moob:GetUnitName()
	local SpawnLoc = moob.vSpawnLoc
	local SpawnVector = moob.vSpawnVector

	if (SpawnLoc == nil) then
		SpawnLoc = moob:GetOrigin()
	end

	if (SpawnVector == nil) then
		SpawnVector = Vector(0,-1,0)
	end

	if name == "npc_gates" then	
		GameRules:GetGameModeEntity():SetContextThink(string.format("GatesThink_%d",moob:GetEntityIndex()), 
			function()
			local unit = CreateUnitByName(name, SpawnLoc, false, nil, nil, DOTA_TEAM_NEUTRALS )
			unit.vSpawnLoc = SpawnLoc 
			unit.vSpawnVector = SpawnVector
			unit:SetForwardVector(SpawnVector)
			unit:SetHullRadius(400)
			end,
			data.Time)
	elseif name == "npc_crystal_statue" then	
		GameRules:GetGameModeEntity():SetContextThink(string.format("CrystalStatueThink_%d",moob:GetEntityIndex()), 
			function()
			local unit = CreateUnitByName(name, SpawnLoc, false, nil, nil, DOTA_TEAM_NEUTRALS )
			unit.vSpawnLoc = SpawnLoc 
			unit.vSpawnVector = SpawnVector
			unit:SetForwardVector(SpawnVector)
			end,
			data.Time)
	elseif name == "npc_devil" then	
		GameRules:GetGameModeEntity():SetContextThink(string.format("DevilThink_%d",moob:GetEntityIndex()), 
			function()
			local unit = CreateUnitByName(name, SpawnLoc, true, nil, nil, DOTA_TEAM_NEUTRALS )
			unit.vSpawnLoc = SpawnLoc 
			unit.vSpawnVector = SpawnVector
			unit:SetForwardVector(SpawnVector)
			end,
			data.Time)
	else	
		GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d",moob:GetEntityIndex()), 
			function()
			local unit = CreateUnitByName(name, SpawnLoc, true, nil, nil, DOTA_TEAM_NEUTRALS )
			unit.vSpawnLoc = SpawnLoc 
			unit.vSpawnVector = SpawnVector
			unit:SetForwardVector(SpawnVector)
			end,
			data.Time)			
	end

end


function AddRuneModifier(data)
local target = data.attacker
target:AddNewModifier( target, nil, data.Name, {duration = 15} )
end

function ChekClass(data)
	local target = data.caster

	if target:GetName() ==  "npc_dota_hero_windrunner" then

		if target:HasModifier("modifier_dk_item_bonus_damage") then
			target:RemoveModifierByName("modifier_dk_item_bonus_damage")
		end

		if target:HasModifier("modifier_dk_item_bonus_defense") then
			target:RemoveModifierByName("modifier_dk_item_bonus_defense")
		end	

		if target:HasModifier("modifier_dw_item_bonus_intellect") then
			target:RemoveModifierByName("modifier_dw_item_bonus_intellect")
		end

		if target:HasModifier("modifier_dw_item_bonus_defense") then
			target:RemoveModifierByName("modifier_dw_item_bonus_defense")
		end	
		
	end

	if target:GetName() ==  "npc_dota_hero_sven" then

		if target:HasModifier("modifier_triple_shot") then
			target:RemoveModifierByName("modifier_triple_shot")
		end

		if target:HasModifier("modifier_elf_item_bonus_damage") then
			target:RemoveModifierByName("modifier_elf_item_bonus_damage")
		end	
		
		if target:HasModifier("modifier_elf_item_bonus_defense") then
			target:RemoveModifierByName("modifier_elf_item_bonus_defense")
		end	

		if target:HasModifier("modifier_dw_item_bonus_intellect") then
			target:RemoveModifierByName("modifier_dw_item_bonus_intellect")
		end

		if target:HasModifier("modifier_dw_item_bonus_defense") then
			target:RemoveModifierByName("modifier_dw_item_bonus_defense")
		end	
		
	end

	if target:GetName() ==  "npc_dota_hero_dazzle" then

		if target:HasModifier("modifier_triple_shot") then
			target:RemoveModifierByName("modifier_triple_shot")
		end

		if target:HasModifier("modifier_dk_item_bonus_damage") then
			target:RemoveModifierByName("modifier_dk_item_bonus_damage")
		end

		if target:HasModifier("modifier_dk_item_bonus_defense") then
			target:RemoveModifierByName("modifier_dk_item_bonus_defense")
		end	

		if target:HasModifier("modifier_elf_item_bonus_damage") then
			target:RemoveModifierByName("modifier_elf_item_bonus_damage")
		end	
		
		if target:HasModifier("modifier_elf_item_bonus_defense") then
			target:RemoveModifierByName("modifier_elf_item_bonus_defense")
		end	
		
	end

end


function AddModifier(data)
local target = data.caster

if data.Class == target:GetName() then
	target:AddNewModifier( target, nil, data.Name, {} )
end

end

function RemoveTripleShotModifier(data)
local target = data.caster

if target:HasItemInInventory("item_bow_elven") == false
and target:HasItemInInventory("item_bow_battle") == false
and target:HasItemInInventory("item_bow_tiger") == false
and target:HasItemInInventory("item_crossbow_saint") == false
and target:HasItemInInventory("item_crossbow_archangel") == false
and target:HasItemInInventory("item_bow_albatross") == false then
	target:RemoveModifierByName(data.Name)
end

ChekClass(data)

end


function GiveAttributes(data)
local target = data.caster
local attribute = data.Attribute

if attribute == "Agility" then
	target:ModifyAgility(5)
end

if attribute == "Intellect" then
	target:ModifyIntellect(5)
end

if attribute == "Strength" then
	target:ModifyStrength(5)
end

end

function ChekTicket(data)

local caster = data.caster
local part_name = data.PartName
--print("chek")

if caster:HasItemInInventory(part_name) then
	local item = nil
	local charges = 0
	local first = 0
	for i = 0, 5 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == part_name and first == 0 then
				if item:GetCurrentCharges() > 4 then
					charges = item:GetCurrentCharges()
					if charges == 5 then
						caster:RemoveItem(item)
						caster:AddItemByName(data.TicketName)
					else
						item:SetCurrentCharges(charges-5)
						if caster:HasAnyAvailableInventorySpace() then
							caster:AddItemByName(data.TicketName)
						else
							CreateDrop(data.TicketName, caster:GetAbsOrigin())
						end
					end
				end
			first = 1
			end
		end
	end
end
	
end

function LearnSkill(data)
--print("LearnSkill")
local caster = data.caster
local ability = caster:FindAbilityByName(data.SkillName)
	if ability and (ability:GetLevel() == 0) then
		ability:SetLevel(1)
		RemoveItemFromHero(data)
	end

end

function DoReset(data)

	local caster = data.caster

	if caster:GetLevel() >= 100 then 
		
		local name = caster:GetName()
		local reset = 1
		local strength = caster:GetStrength()	
		local agility = caster:GetAgility()
		local intellect = caster:GetIntellect()
		local charges = {}
		charges["item_small_heal_potion"] = GetCharges(caster,"item_small_heal_potion")
		charges["item_large_heal_potion"] = GetCharges(caster,"item_large_heal_potion")	
		charges["item_small_mana_potion"] = GetCharges(caster,"item_small_mana_potion")
		charges["item_large_mana_potion"] = GetCharges(caster,"item_large_mana_potion")		
		charges["item_skull_token"] = GetCharges(caster,"item_skull_token")
		charges["item_scroll_of_archangel"] = GetCharges(caster,"item_scroll_of_archangel")
		charges["item_symbol_of_kundun"] = GetCharges(caster,"item_symbol_of_kundun")
		charges["item_orb_of_agility"] = GetCharges(caster,"item_orb_of_agility")
		charges["item_orb_of_intellect"] = GetCharges(caster,"item_orb_of_intellect")
		charges["item_orb_of_strength"] = GetCharges(caster,"item_orb_of_strength")
		charges["item_ward_observer"] = GetCharges(caster,"item_ward_observer")
		charges["item_ward_sentry"] = GetCharges(caster,"item_ward_sentry")

		
		if caster:HasModifier("modifier_reset") then
			reset = caster:GetModifierStackCount("modifier_reset",caster)+1
		end

		caster = PlayerResource:ReplaceHeroWith(caster:GetPlayerID(), caster:GetName(), caster:GetGold(), 0)
		caster:AddNewModifier( caster, self, "modifier_reset", {} )	
		caster:SetModifierStackCount("modifier_reset",caster,reset)

		
		caster:SetBaseStrength(strength)
		caster:SetBaseAgility(agility)
		caster:SetBaseIntellect(intellect)	
		
		for i = 0, 5 do
			item = caster:GetItemInSlot(i)
			if item ~= nil then
				if item:IsStackable() == true then
					item:SetCurrentCharges(charges[item:GetAbilityName()])
				end
			end
		end
		data.caster:AddNoDraw()
		data.caster = caster
		RemoveItemFromHero(data)

	end	
end


function GetCharges(caster, name)
	local item = nil
	for i = 0, 5 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == name then 
				return item:GetCurrentCharges()
			end
		end
	end
end


function HealPotion(data)
local health = data.caster:GetHealth()+data.Heal
data.caster:SetHealth(health)
RemoveItemFromHero(data)
end

function ManaPotion(data)
data.caster:GiveMana(data.Mana)
RemoveItemFromHero(data)
end

function RemoveItemFromHero(data)
local caster = data.caster
local item = nil
local charges = 0

local first = 0
	for i = 0, 5 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == data.item_name and first == 0 then
				
				if item:IsStackable() == true then
					if item:GetCurrentCharges() > 1 then
						charges = item:GetCurrentCharges()
						item:SetCurrentCharges(charges-1)
					else
						caster:RemoveItem(item)
					end
				else
					caster:RemoveItem(item)			
				end
				first = 1
			end
		end
	end	
end


function CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos)
end 

function PlaySound(data)
	local moob = data.caster
	if moob:GetUnitName() == "npc_dragon" then
		StartSoundEvent("n_creep_kobolds.Death", moob)
	end
	if moob:GetUnitName() == "npc_lich" then
		StartSoundEvent("n_creep_trollWarlord.Death", moob)
	end

end