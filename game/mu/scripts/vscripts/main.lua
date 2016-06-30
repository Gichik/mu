
_G.nCREATURE_RESPAWN_TIME = 5


XP_PER_LEVEL_TABLE = {
	0, -- 1
	200, -- 2
	500, -- 3
	900,
	1400,
	2000,
	2700,
	3500,
	4400,
	5400,
	6500,
	7700,
	9000,
	10400,
	11900,
	13500,
	15200,
	17000,
	18900,
	20900,
	23000,
	25200,
	27500,
	29900,
	32400,
	35000,
	37700,
	40500,
	43400,
	46400,
	49500,
	52700,
	56000,
	59400,
	62900,
	66500,
	70200,
	74000,
	77900,
	81900,
	86000,
	90200,
	94500,
	98900,
	103400,
	108000,
	112700,
	117500,
	122400,
	127400,
	132500,
	137700,
	143000,
	148400,
	153900,
	159500,
	165200,
	171000,
	176900,
	182900,
	189000,
	195200,
	201500,
	207900,
	214400,
	221000,
	227700,
	234500,
	241400,
	248400,
	255500,
	262700,
	270000,
	277400,
	284900,
	292500,
	300200,
	308000,
	315900,
	323900,
	332000,
	340200,
	348500,
	356900,
	365400,
	374000,
	382700,
	391500,
	400400,
	409400,
	418500,
	427700,
	437000,
	446400,
	455900,
	465500,
	475200,
	485000,
	494900,
	504900	 
 }

 
 
 
function main:InitGameMode()
	print( "InitGameMode" )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 3 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 3 )
	
	GameRules:SetTimeOfDay( 0.5 )
	GameRules:SetHeroRespawnEnabled( true )
	GameRules:SetUseUniversalShopMode( false )
	GameRules:SetHeroSelectionTime( 10.0 )
	GameRules:SetPreGameTime( 5.0 )
	GameRules:SetPostGameTime( 60.0 )
	GameRules:SetTreeRegrowTime( 60.0 )
	GameRules:SetHeroMinimapIconScale( 0.7 )
	GameRules:SetCreepMinimapIconScale( 0.7 )
	GameRules:SetRuneMinimapIconScale( 0.7 )
	GameRules:SetGoldTickTime( 60.0 )
	GameRules:SetGoldPerTick( 0 )
	GameRules:SetStartingGold(1000)
	GameRules:GetGameModeEntity():SetRemoveIllusionsOnDeath( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesVisible( false )
	GameRules:GetGameModeEntity():SetBuybackEnabled( true )
	GameRules:GetGameModeEntity():SetRecommendedItemsDisabled( true )	
	GameRules:SetSameHeroSelectionEnabled( true )

	GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled( true )
	
	GameRules:GetGameModeEntity():SetUseCustomHeroLevels(true)
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(100)		
	GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel( XP_PER_LEVEL_TABLE )


	GameRules:GetGameModeEntity():SetLoseGoldOnDeath(false)	
	GameRules:SetUseBaseGoldBountyOnHeroes(false)
	
	--GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled( true )

    ListenToGameEvent('entity_killed', Dynamic_Wrap(main, 'OnEntityKilled'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(main, 'GameRulesStateChange'), self)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(main, 'OnNPCSpawn'), self)
	ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(main, 'OnPlayerGainedLevel'), self)
	ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(main, 'OnItemPickedUp'), self)	
	GameRules.DropTable = LoadKeyValues("scripts/kv/item_drops.kv")	

	main:SpawnMoobs()
	GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d", RandomInt(1, 99999)), 
			function()
				StartSoundEventFromPosition("MU.intro",Vector(0,0,0))
			return nil
			end,
			1)
	
end



 function main:GameRulesStateChange(keys)
	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then 
		ShowGenericPopup( "#popup_title_Main", "#popup_body_Main", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
		SendToConsole("stopsound")	
	GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d", RandomInt(1, 99999)), 
			function()
				local entity = Entities:FindByName( nil, "spawn_bc_1")
				StartSoundEventFromPosition("MU.blood_castle",entity:GetAbsOrigin())

				entity = Entities:FindByName( nil, "spawn_ds")
				StartSoundEventFromPosition("MU.devil_square",entity:GetAbsOrigin())

				entity = Entities:FindByName( nil, "spawn_kalima")
				StartSoundEventFromPosition("MU.map_kundun",entity:GetAbsOrigin())

				entity = Entities:FindByName( nil, "pub_radiant")
				StartSoundEventFromPosition("MU.pub",entity:GetAbsOrigin())

				entity = Entities:FindByName( nil, "pub_dire")
				StartSoundEventFromPosition("MU.pub_dire",entity:GetAbsOrigin())

				entity = Entities:FindByName( nil, "pub_neutral")
				StartSoundEventFromPosition("MU.intro",entity:GetAbsOrigin())

				--EmitSoundOnLocationWithCaster(entity:GetAbsOrigin(),"MU.blood_castle",entity)
				--EmitSoundOn("MU.blood_castle",entity)
				--EmitSoundOnLocationWithCaster(entity:GetAbsOrigin(),"MU.blood_castle",entity)
				--StartSoundEventFromPositionUnreliable("MU.blood_castle",entity:GetAbsOrigin())
			return 60
			end,
			1)		
	end
end

function main:OnPlayerGainedLevel(data)
	local player = PlayerResource:GetSelectedHeroEntity(data.player-1)
	player:SetAbilityPoints(0)
	player:ModifyGold(100, false, 0)
	player:SetHealth(player:GetMaxHealth()) 
	player:GiveMana(player:GetMaxMana())
end

function main:OnNPCSpawn(data)
	--print("spawn")
	local unit = EntIndexToHScript(data.entindex)

	if unit:IsHero() then	
		--print("spawn")
		unit:SetAbilityPoints(0)		
		StopSoundEvent("MU.blood_castle", unit)
		StopSoundEvent("MU.devil_square", unit)
		StopSoundEvent("MU.map_kundun", unit)
		StopSoundEvent("MU.pub", unit)
		StopSoundEvent("MU.lorencia", unit)
		--StartSoundEvent("MU.pub", unit)
		--EmitSoundOnClient("MU.pub", PlayerResource:GetPlayer(unit:GetPlayerID()))
	else
	    if unit:GetUnitName() == "npc_devil" then
	    	GameRules:SendCustomMessage("<font color='#585bfa'>Devil was reborn in the Devil Square!</font>", 0, 0)
	    end	

	    if unit:GetUnitName() == "npc_crystal_statue" then
	    	GameRules:SendCustomMessage("<font color='#585bfa'>Crystal statue was rebuilt in the Blood of the Castle!</font>", 0, 0)
	    end	
	end
end

function main:OnItemPickedUp(data)
	local item = EntIndexToHScript( data.ItemEntityIndex )
	local hero = EntIndexToHScript( data.HeroEntityIndex )
	local team = hero:GetTeamNumber() 
	local gold = RandomInt(50, 150)
	if data.itemname == "item_bag_of_gold" then
		main:MainChekClass(hero)
		for i=0,6 do
			if PlayerResource:IsValidPlayer(i) then
				local player = PlayerResource:GetPlayer(i)
				local teamNumb = player:GetTeamNumber()

				if teamNumb == team then
					PlayerResource:ModifyGold( player:GetPlayerID(), gold, true, 0 )
					SendOverheadEventMessage( hero, OVERHEAD_ALERT_GOLD, player, gold, nil )
				end
			
			end
		end
		UTIL_Remove( item )

	end
end

function main:SpawnMoobs()

	local point = nil
	local unit = nil
	local item = nil

	for i = 1, 4 do
		for j = 1, 6 do 	
		point = Entities:FindByName( nil, "spawn_moobs_" .. i):GetAbsOrigin()
		unit = CreateUnitByName("npc_dragon", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_NEUTRALS  )	
		unit.vSpawnLoc = unit:GetOrigin()
		end
	end	


	for i = 1, 6 do 	
		point = Entities:FindByName( nil, "spawn_moobs_5"):GetAbsOrigin()
		unit = CreateUnitByName("npc_spider", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_NEUTRALS  )	
		unit.vSpawnLoc = unit:GetOrigin()
		unit.vSpawnVector = Vector(-1,-1,0)
		unit:SetForwardVector(Vector(-1,-1,0))

		point = Entities:FindByName( nil, "spawn_moobs_6"):GetAbsOrigin()
		unit = CreateUnitByName("npc_bull", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_NEUTRALS  )	
		unit.vSpawnLoc = unit:GetOrigin()
		unit.vSpawnVector = Vector(1,1,0)
		unit:SetForwardVector(Vector(1,1,0))

		point = Entities:FindByName( nil, "spawn_moobs_7"):GetAbsOrigin()
		unit = CreateUnitByName("npc_lich", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_NEUTRALS  )	
		unit.vSpawnLoc = unit:GetOrigin()
		unit.vSpawnVector = Vector(-1,0,0)
		unit:SetForwardVector(Vector(-1,0,0))

		point = Entities:FindByName( nil, "spawn_moobs_8"):GetAbsOrigin()
		unit = CreateUnitByName("npc_skeleton", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_NEUTRALS  )	
		unit.vSpawnLoc = unit:GetOrigin()
		unit.vSpawnVector = Vector(0,1,0)
		unit:SetForwardVector(Vector(0,1,0))
	end

----------------------------------------------BC-------------------------------------------
	for i = 1, 8 do
		for j = 1, 5 do 	
		point = Entities:FindByName( nil, "spawn_bc_" .. i):GetAbsOrigin()
		unit = CreateUnitByName("npc_ork", point + RandomVector( RandomFloat( 0, 200 )), true, nil, nil, DOTA_TEAM_NEUTRALS )	
		unit.vSpawnLoc = unit:GetOrigin()
		unit.vSpawnVector = Vector(0,-1,0)
		unit:SetForwardVector(Vector(0,-1,0))
		end
	end	


	for i = 1, 20 do 	
	point = Entities:FindByName( nil, "spawn_bc_9"):GetAbsOrigin()
	unit = CreateUnitByName("npc_ork", point + RandomVector( RandomFloat( 0, 700 )), true, nil, nil, DOTA_TEAM_NEUTRALS )	
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(0,-1,0)
	unit:SetForwardVector(Vector(0,-1,0))		
	end

	point = Entities:FindByName( nil, "spawn_bc_9"):GetAbsOrigin()
	unit = CreateUnitByName("npc_crystal_statue", point, true, nil, nil, DOTA_TEAM_NEUTRALS)	
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(0,-1,0)
	unit:SetForwardVector(Vector(0,-1,0))

	point = Entities:FindByName( nil, "spawn_bc_gates"):GetAbsOrigin()
	unit = CreateUnitByName("npc_gates", point, false, nil, nil, DOTA_TEAM_NEUTRALS)	
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(0,-1,0)
	unit:SetForwardVector(Vector(0,-1,0))
	unit:SetHullRadius(400)


----------------------------------------------DS-------------------------------------------


		for i = 1, 40 do 	
		point = Entities:FindByName( nil, "spawn_ds"):GetAbsOrigin()
		unit = CreateUnitByName("npc_zombie", point + RandomVector( RandomFloat( 0, 1000 )), true, nil, nil, DOTA_TEAM_NEUTRALS)	
		unit.vSpawnLoc = unit:GetOrigin()
		end


		point = Entities:FindByName( nil, "spawn_ds"):GetAbsOrigin()
		unit = CreateUnitByName("npc_devil", point + RandomVector( RandomFloat( 0, 1000 )), true, nil, nil, DOTA_TEAM_NEUTRALS)	
		unit.vSpawnLoc = unit:GetOrigin()


----------------------------------------------Kalima-------------------------------------------

		point = Entities:FindByName( nil, "spawn_kalima"):GetAbsOrigin()
		unit = CreateUnitByName("npc_kundun", point + RandomVector( RandomFloat( 0, 700 )), true, nil, nil, DOTA_TEAM_NEUTRALS)	
		unit.vSpawnLoc = unit:GetOrigin()



end

function main:OnEntityKilled (data)
    local killedUnit = EntIndexToHScript( data.entindex_killed )
    if killedUnit:IsNeutralUnitType() or killedUnit:IsCreature() then
        main:RollDrops(killedUnit)
    end

    if killedUnit:GetUnitName() == "npc_kundun" then
    	local attaker = EntIndexToHScript( data.entindex_attacker )
    	GameRules:SetGameWinner(attaker:GetTeamNumber())
    	GameRules:SendCustomMessage("<font color='#585bfa'>Kundum was defeated!</font>", 0, 0)
    end	

    if killedUnit:GetUnitName() == "npc_devil" then
    	GameRules:SendCustomMessage("<font color='#585bfa'>Some hero killed the Devil in the Devil Square!</font>", 0, 0)
    end	
 
    if killedUnit:GetUnitName() == "npc_gates" then
    	GameRules:SendCustomMessage("<font color='#585bfa'>Some hero destroy the Gates of Blood Castle!</font>", 0, 0)
    end	

    if killedUnit:GetUnitName() == "npc_crystal_statue" then
    	GameRules:SendCustomMessage("<font color='#585bfa'>Some hero destroy the Crystal Statue in to Blood Castle!</font>", 0, 0)
    end	

end

   
function main:RollDrops(unit)
    local DropInfo = GameRules.DropTable[unit:GetUnitName()]
    if DropInfo then
        for item_name,chance in pairs(DropInfo) do
            if RollPercentage(chance) then
                -- Create the item
                local item = CreateItem(item_name, nil, nil)
                local pos = unit:GetAbsOrigin()
                local drop = CreateItemOnPositionSync( pos, item )
                local pos_launch = pos+RandomVector(RandomFloat(50,50))
                item:LaunchLoot(false, 200, 0.75, pos_launch)
            end
        end
    end
end 

function main:MainChekClass(caster)
	local target = caster

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