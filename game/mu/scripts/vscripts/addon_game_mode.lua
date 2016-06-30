-- Generated from template

if main == nil then
	_G.main = class({})
end

require( 'main' )


function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
	
	---------------------------------models-------------------------------
	PrecacheModel("models/items/courier/ig_dragon/ig_dragon.vmdl", context)	--dragon
	PrecacheModel("models/heroes/broodmother/spiderling.vmdl", context)	--spider
	PrecacheModel("models/creeps/neutral_creeps/n_creep_satyr_a/n_creep_satyr_a.vmdl", context)	--bull
	PrecacheModel("models/heroes/warlock/warlock.vmdl", context)	--lich
	PrecacheModel("models/items/warlock/warlocks_summoning_scroll/warlocks_summoning_scroll.vmdl", context)	--lich
	PrecacheModel("models/items/warlock/twisted_firekeeper/twisted_firekeeper.vmdl", context)	--lich
	PrecacheModel("models/heroes/warlock/warlock_cape.vmdl", context)	--lich
	PrecacheModel("models/creeps/neutral_creeps/n_creep_troll_skeleton/n_creep_skeleton_melee.vmdl", context)	--skeleton
	PrecacheModel("models/heroes/doom/doom.vmdl", context)	--ork
	PrecacheModel("models/items/doom/crown_of_omoz/crown_of_omoz.vmdl", context) --ork
	PrecacheModel("models/items/doom/abysssword/abysssword.vmdl", context) --ork	
	PrecacheModel("models/heroes/undying/undying_minion.vmdl", context)	--zombie	
	PrecacheModel("models/items/warlock/golem/hellsworn_golem/hellsworn_golem.vmdl", context) --demon	
	PrecacheModel("models/items/terrorblade/endless_purgatory_demon/endless_purgatory_demon.vmdl", context) --kundun
	PrecacheModel("models/items/wards/knightstatue_ward/knightstatue_ward.vmdl", context) --crystal statue
	PrecacheModel("models/props_debris/shop_set_cage002.vmdl", context) --gates

	PrecacheModel("models/props_gameplay/rune_regeneration01.vmdl", context)
	PrecacheModel("models/items/windrunner/makeshifthornwoodbow_v10/makeshifthornwoodbow_v10.vmdl", context) --elven bow
	PrecacheModel("models/items/clinkz/searing_bow/searing_bow.vmdl", context) --battle bow
	PrecacheModel("models/items/windrunner/wr_sparrow_bowab/wr_sparrow_bowab.vmdl", context) --tiger bow	
	PrecacheModel("models/items/windrunner/rainmaker_bow/rainmaker_bow.vmdl", context) --albatross bow
	PrecacheModel("models/items/drow/bow_of_the_envious_archer/bow_of_the_envious_archer.vmdl", context) --saint crossbow
	PrecacheModel("models/items/drow/iceburst_bow.vmdl", context) --archangel crossbow
	
	PrecacheModel("models/heroes/alchemist/alchemist_sword.vmdl", context) --falchion	
	PrecacheModel("models/items/dragon_knight/fireborn_sword/fireborn_sword.vmdl", context) --double	
	PrecacheModel("models/items/wraith_king/bk/bk_sword2.vmdl", context) --lightining	
	PrecacheModel("models/items/sven/ice_sword/ice_sword.vmdl", context) --crystal
	PrecacheModel("models/items/sven/sword_stone.vmdl", context) --dark	
	PrecacheModel("models/items/dragon_knight/weapon_red_fire_lord_sword/weapon_red_fire_lord_sword.vmdl", context) --archangel	
	
	PrecacheModel("models/items/keeper_of_the_light/spiral_staff_of_the_first_light/spiral_staff_of_the_first_light.vmdl", context) --serpent
	PrecacheModel("models/heroes/crystal_maiden/crystal_maiden_staff.vmdl", context) --legendary	
	PrecacheModel("models/items/warlock/gemstaff/gemstaff.vmdl", context) --resurrection	
	PrecacheModel("models/items/leshrac/tormented_staff/tormented_staff.vmdl", context) --dark soul
	PrecacheModel("models/items/rubick/forgotten_greatstaff/forgotten_greatstaff.vmdl", context) --platina
	PrecacheModel("models/items/skywrath_mage/manticore_of_the_eyrie_staff/manticore_of_the_eyrie_staff.vmdl", context) --archangel		
	
	---------------------------------spells-------------------------------
	
	PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_base_attack.vpcf", context) --dragon attack
	PrecacheResource("particle", "particles/econ/items/enigma/enigma_world_chasm/enigma_blackhole_ti5_dark_swirl.vpcf", context) --evil spirits
	PrecacheResource("particle", "particles/units/heroes/hero_sven/sven_spell_great_cleave.vpcf", context) --cleave
	
	PrecacheResource("particle", "particles/units/heroes/hero_huskar/huskar_inner_vitality.vpcf", context) --greater defense
	PrecacheResource("particle", "particles/units/heroes/hero_oracle/oracle_fortune_purge_root_pnt.vpcf", context) --greater damage	
	PrecacheResource("particle", "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_brightcore_arcana1.vpcf", context) --heal

	PrecacheResource("particle", "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf", context) --ice arrow
	PrecacheResource("particle", "particles/units/heroes/hero_ancient_apparition/ice_temp.vpcf", context) --ice arrow
	
	
	PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_ice_path_shards.vpcf", context) --strike_of_destruction
	PrecacheResource("particle", "particles/units/heroes/hero_juggernaut/juggernaut_ward_create.vpcf", context) --twisting
	PrecacheResource("particle", "particles/units/heroes/hero_brewmaster/brewmaster_windwalk_burst.vpcf", context) --death_stab
	PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_death_coil.vpcf", context) --death_stab
	PrecacheResource("particle", "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_explosion_g_arcana1.vpcf", context) --combo
	PrecacheResource("particle", "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_explosion_h_arcana1.vpcf", context) --combo	
	PrecacheResource("particle", "particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", context) --combo		
	
	PrecacheResource("particle_folder", "particles/units/heroes/hero_templar_assassin/", context) --soul barrier
	PrecacheResource("particle_folder", "particles/units/heroes/hero_crystalmaiden/", context) --ice
	PrecacheResource("particle_folder", "particles/units/heroes/hero_antimage/", context) --blink

	
	
	---------------------------------sounds------------------------------	
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_templar_assassin.vsndevts", context ) --soul barrier		
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts", context ) --soul barrier
	PrecacheResource( "soundfile", "soundevents/game_sounds_creeps.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_broodmother.vsndevts", context )
	
	PrecacheResource( "soundfile", "soundevents/mu_sounds_custom.vsndevts", context )
	
	
	local pathToIG = LoadKeyValues("scripts/items/items_game.txt") 
	--PrecacheForHero("npc_dota_hero_enigma", pathToIG, context)
	
end

-- Create the game mode when we activate
function Activate()
	main:InitGameMode()
end



function IsForHero(str, tbl)
	if type(tbl["used_by_heroes"]) ~= type(1) and tbl["used_by_heroes"] then -- привет от вашего друга, индийского быдлокодера работающего за еду
		if tbl["used_by_heroes"][str] then
			return true
		end
	end
	return false
end

function PrecacheForHero(name,path,context)

	print('[PrecacheHero] Start')
print("----------------------------------------Precache Start----------------------------------------")

	local wearablesList = {} --переменная для надеваемых шмоток(для всех героев)
	local precacheWearables = {} --переменная только для шмоток нужного героя
	local precacheParticle = {}
	for k, v in pairs(path) do
		if k == 'items' then
			wearablesList = v
		end
	end
	local counter = 0
	local counter_particle = 0
	local value
	for k, v in pairs(wearablesList) do -- выбираем из списка предметов только предметы на нужных героев
		if IsForHero(name, wearablesList[k]) then
			if wearablesList[k]["model_player"] then
				value = wearablesList[k]["model_player"] 
				precacheWearables[value] = true
			end
			if wearablesList[k]["particle_file"] then -- прекешируем еще и частицы, куда ж без них!
				value = wearablesList[k]["particle_file"] 
				precacheParticle[value] = true
			end
		end
	end

	for wearable,_ in pairs( precacheWearables ) do --собственно само прекеширование всех занесенных в список шмоток
		print("Precache model: " .. wearable)
		PrecacheResource( "model", wearable, context )
		counter = counter + 1
	end

	for wearable,_ in pairs( precacheParticle) do --и прекеширование частиц
		print("Precache particle: " .. wearable)
		PrecacheResource( "particle", wearable, context )
		counter_particle = counter_particle + 1

	end

	PrecacheUnitByNameSync(name, context) -- прекешируем саму модель героя! иначе будут бегать шмотки без тела
		
    print('[Precache]' .. counter .. " models loaded and " .. counter_particle .." particles loaded")
	print('[Precache] End')

end