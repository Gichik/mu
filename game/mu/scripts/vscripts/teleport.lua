points = {
Vector(-864,-1120,32),
Vector(-2432,576,54),
Vector(-1280,1600,100),
Vector(768,640,32),
Vector(576,-1024,156)
}



function FunctionTP(event)
	local unit = event.activator
--	print("------------teleport:------------")
	local point = points[RandomInt(1, 5)]
	unit:SetAbsOrigin(point) 
	FindClearSpaceForUnit(unit, point, false) 
	unit:Stop()
	StopAllSound(unit)
	FocusCameraOnPlayer(unit)
	--StartSoundEvent("MU.lorencia", unit)	 
end


function FunctionBackRadTP(event)
	local unit = event.activator
--	print("------------ Rad back teleport:------------")
	local teamNumb = unit:GetTeam()
	local name =  GetTeamName(teamNumb)

	if name == "#DOTA_GoodGuys" then
		local entPoint = Vector(-384,-5568,160) 
		unit:SetAbsOrigin(entPoint) 
		FindClearSpaceForUnit(unit, entPoint, false) 
		unit:Stop()
		StopAllSound(unit)
		FocusCameraOnPlayer(unit)
		--StartSoundEvent("MU.pub", unit)  
	end


end



function FunctionBackDireTP(event)
	local unit = event.activator
--	print("------------Dire back teleport:------------")
	local teamNumb = unit:GetTeam()
	local name =  GetTeamName(teamNumb)

	if name == "#DOTA_BadGuys" then
		local entPoint = Vector(-576,6016,160) 
		unit:SetAbsOrigin(entPoint) 
		FindClearSpaceForUnit(unit, entPoint, false) 
		unit:Stop()
		StopAllSound(unit)
		FocusCameraOnPlayer(unit)
		--StartSoundEvent("MU.pub", unit) 
	end
end


function MoveToQuest(data)
	--print("move to quest")
	local caster = data.caster
	local quest =  data.QuestName

	if quest == "devil_square" then
		local point = Vector(5888,-6272,-96)
		caster:SetAbsOrigin(point) 
		FindClearSpaceForUnit(caster, point, false) 
		caster:Stop() 
		caster:AddNewModifier( caster, self, "modifier_time_quest", {duration = 61} )
		RespawnFromQuest(caster,60)	
		StopAllSound(caster)
		--StartSoundEvent("MU.devil_square", caster)					
	end

	if quest == "blood_castle" then
		local point = Vector(5696,-3008,160)
		caster:SetAbsOrigin(point) 
		FindClearSpaceForUnit(caster, point, false) 
		caster:Stop() 
		caster:AddNewModifier( caster, self, "modifier_time_quest", {duration = 61} )
		RespawnFromQuest(caster,60)
		StopAllSound(caster)
		--StartSoundEvent("MU.blood_castle", caster)
	end

	if quest == "kalima" then
		local point = Vector(-6560,-6496,32)
		caster:SetAbsOrigin(point) 
		FindClearSpaceForUnit(caster, point, false) 
		caster:Stop() 
		StopAllSound(caster)
		--StartSoundEvent("MU.map_kundun", caster)		
	end

	FocusCameraOnPlayer(caster)	
	RemoveItemFromHero(data)

end

function StopAllSound(caster)
	StopSoundEvent("MU.blood_castle", caster)
	StopSoundEvent("MU.devil_square", caster)
	StopSoundEvent("MU.map_kundun", caster)
	StopSoundEvent("MU.pub", caster)
	StopSoundEvent("MU.lorencia", caster)	
end


function FocusCameraOnPlayer(player)
	PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(),player)
	GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d", RandomInt(1, 99999)), 
	function()
		PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), nil)	
	return nil
	end,
	1)
end

function RespawnFromQuest(hero,duration)
	GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d", RandomInt(1, 99999)), 
	function()
		if hero:IsAlive() and hero:HasModifier("modifier_time_quest") then
			hero:RespawnHero(false, false, false)
			FocusCameraOnPlayer(hero)
		end
	return nil
	end,
	duration)
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