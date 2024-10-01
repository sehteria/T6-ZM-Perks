#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;

main()
{
    replaceFunc( maps\mp\zm_highrise::custom_vending_precaching, ::custom_vending_precaching );
    replaceFunc( maps\mp\zm_highrise_elevators::init_elevator_perks, ::init_elevator_perks );
}

init()
{
    move_marathon_origins();
}

custom_vending_precaching()
{
    if ( isdefined( level.zombiemode_using_pack_a_punch ) && level.zombiemode_using_pack_a_punch )
    {
        precacheitem( "zombie_knuckle_crack" );
        precachemodel( "p6_anim_zm_buildable_pap" );
        precachemodel( "p6_anim_zm_buildable_pap_on" );
        precachestring( &"ZOMBIE_PERK_PACKAPUNCH" );
        precachestring( &"ZOMBIE_PERK_PACKAPUNCH_ATT" );
        level._effect["packapunch_fx"] = loadfx( "maps/zombie/fx_zmb_highrise_packapunch" );
        level.machine_assets["packapunch"] = spawnstruct();
        level.machine_assets["packapunch"].weapon = "zombie_knuckle_crack";
        level.machine_assets["packapunch"].off_model = "p6_anim_zm_buildable_pap";
        level.machine_assets["packapunch"].on_model = "p6_anim_zm_buildable_pap_on";
    }

    if ( isdefined( level.zombiemode_using_additionalprimaryweapon_perk ) && level.zombiemode_using_additionalprimaryweapon_perk )
    {
        precacheitem( "zombie_perk_bottle_additionalprimaryweapon" );
        precacheshader( "specialty_additionalprimaryweapon_zombies" );
        precachemodel( "zombie_vending_three_gun" );
        precachemodel( "zombie_vending_three_gun_on" );
        precachestring( &"ZOMBIE_PERK_ADDITIONALWEAPONPERK" );
        level._effect["additionalprimaryweapon_light"] = loadfx( "misc/fx_zombie_cola_arsenal_on" );
        level.machine_assets["additionalprimaryweapon"] = spawnstruct();
        level.machine_assets["additionalprimaryweapon"].weapon = "zombie_perk_bottle_additionalprimaryweapon";
        level.machine_assets["additionalprimaryweapon"].off_model = "zombie_vending_three_gun";
        level.machine_assets["additionalprimaryweapon"].on_model = "zombie_vending_three_gun_on";
    }

    if ( isdefined( level.zombiemode_using_deadshot_perk ) && level.zombiemode_using_deadshot_perk )
    {
        precacheitem( "zombie_perk_bottle_deadshot" );
        precacheshader( "specialty_ads_zombies" );
        precachemodel( "zombie_vending_ads" );
        precachemodel( "zombie_vending_ads_on" );
        precachestring( &"ZOMBIE_PERK_DEADSHOT" );
        level._effect["deadshot_light"] = loadfx( "misc/fx_zombie_cola_dtap_on" );
        level.machine_assets["deadshot"] = spawnstruct();
        level.machine_assets["deadshot"].weapon = "zombie_perk_bottle_deadshot";
        level.machine_assets["deadshot"].off_model = "zombie_vending_ads";
        level.machine_assets["deadshot"].on_model = "zombie_vending_ads_on";
    }

    if ( isdefined( level.zombiemode_using_divetonuke_perk ) && level.zombiemode_using_divetonuke_perk )
    {
        precacheitem( "zombie_perk_bottle_nuke" );
        precacheshader( "specialty_divetonuke_zombies" );
        precachemodel( "zombie_vending_nuke" );
        precachemodel( "zombie_vending_nuke_on" );
        precachestring( &"ZOMBIE_PERK_DIVETONUKE" );
        level._effect["divetonuke_light"] = loadfx( "misc/fx_zombie_cola_dtap_on" );
        level.machine_assets["divetonuke"] = spawnstruct();
        level.machine_assets["divetonuke"].weapon = "zombie_perk_bottle_nuke";
        level.machine_assets["divetonuke"].off_model = "zombie_vending_nuke";
        level.machine_assets["divetonuke"].on_model = "zombie_vending_nuke_on";
    }

    if ( isdefined( level.zombiemode_using_doubletap_perk ) && level.zombiemode_using_doubletap_perk )
    {
        precacheitem( "zombie_perk_bottle_doubletap" );
        precacheshader( "specialty_doubletap_zombies" );
        precachemodel( "zombie_vending_doubletap2" );
        precachemodel( "zombie_vending_doubletap2_on" );
        precachestring( &"ZOMBIE_PERK_DOUBLETAP" );
        level._effect["doubletap_light"] = loadfx( "misc/fx_zombie_cola_dtap_on" );
        level.machine_assets["doubletap"] = spawnstruct();
        level.machine_assets["doubletap"].weapon = "zombie_perk_bottle_doubletap";
        level.machine_assets["doubletap"].off_model = "zombie_vending_doubletap2";
        level.machine_assets["doubletap"].on_model = "zombie_vending_doubletap2_on";
    }

    if ( isdefined( level.zombiemode_using_juggernaut_perk ) && level.zombiemode_using_juggernaut_perk )
    {
        precacheitem( "zombie_perk_bottle_jugg" );
        precacheshader( "specialty_juggernaut_zombies" );
        precachemodel( "zombie_vending_jugg" );
        precachemodel( "zombie_vending_jugg_on" );
        precachestring( &"ZOMBIE_PERK_JUGGERNAUT" );
        level._effect["jugger_light"] = loadfx( "misc/fx_zombie_cola_jugg_on" );
        level.machine_assets["juggernog"] = spawnstruct();
        level.machine_assets["juggernog"].weapon = "zombie_perk_bottle_jugg";
        level.machine_assets["juggernog"].off_model = "zombie_vending_jugg";
        level.machine_assets["juggernog"].on_model = "zombie_vending_jugg_on";
    }

    if ( isdefined( level.zombiemode_using_marathon_perk ) && level.zombiemode_using_marathon_perk )
    {
        precacheitem( "zombie_perk_bottle_marathon" );
        precacheshader( "specialty_marathon_zombies" );
        precachemodel( "zombie_vending_marathon" );
        precachemodel( "zombie_vending_marathon_on" );
        precachestring( &"ZOMBIE_PERK_MARATHON" );
        level._effect["marathon_light"] = loadfx( "maps/zombie/fx_zmb_cola_staminup_on" );
        level.machine_assets["marathon"] = spawnstruct();
        level.machine_assets["marathon"].weapon = "zombie_perk_bottle_marathon";
        level.machine_assets["marathon"].off_model = "zombie_vending_marathon";
        level.machine_assets["marathon"].on_model = "zombie_vending_marathon_on";
    }

    if ( isdefined( level.zombiemode_using_revive_perk ) && level.zombiemode_using_revive_perk )
    {
        precacheitem( "zombie_perk_bottle_revive" );
        precacheshader( "specialty_quickrevive_zombies" );
        precachemodel( "zombie_vending_revive" );
        precachemodel( "zombie_vending_revive_on" );
        precachestring( &"ZOMBIE_PERK_QUICKREVIVE" );
        level._effect["revive_light"] = loadfx( "misc/fx_zombie_cola_revive_on" );
        level._effect["revive_light_flicker"] = loadfx( "maps/zombie/fx_zmb_cola_revive_flicker" );
        level.machine_assets["revive"] = spawnstruct();
        level.machine_assets["revive"].weapon = "zombie_perk_bottle_revive";
        level.machine_assets["revive"].off_model = "zombie_vending_revive";
        level.machine_assets["revive"].on_model = "zombie_vending_revive_on";
    }

    if ( isdefined( level.zombiemode_using_sleightofhand_perk ) && level.zombiemode_using_sleightofhand_perk )
    {
        precacheitem( "zombie_perk_bottle_sleight" );
        precacheshader( "specialty_fastreload_zombies" );
        precachemodel( "zombie_vending_sleight" );
        precachemodel( "zombie_vending_sleight_on" );
        precachestring( &"ZOMBIE_PERK_FASTRELOAD" );
        level._effect["sleight_light"] = loadfx( "misc/fx_zombie_cola_on" );
        level.machine_assets["speedcola"] = spawnstruct();
        level.machine_assets["speedcola"].weapon = "zombie_perk_bottle_sleight";
        level.machine_assets["speedcola"].off_model = "zombie_vending_sleight";
        level.machine_assets["speedcola"].on_model = "zombie_vending_sleight_on";
    }

    if ( isdefined( level.zombiemode_using_tombstone_perk ) && level.zombiemode_using_tombstone_perk )
    {
        precacheitem( "zombie_perk_bottle_tombstone" );
        precacheshader( "specialty_tombstone_zombies" );
        precachemodel( "zombie_vending_tombstone" );
        precachemodel( "zombie_vending_tombstone_on" );
        precachemodel( "ch_tombstone1" );
        precachestring( &"ZOMBIE_PERK_TOMBSTONE" );
        level._effect["tombstone_light"] = loadfx( "misc/fx_zombie_cola_on" );
        level.machine_assets["tombstone"] = spawnstruct();
        level.machine_assets["tombstone"].weapon = "zombie_perk_bottle_tombstone";
        level.machine_assets["tombstone"].off_model = "zombie_vending_tombstone";
        level.machine_assets["tombstone"].on_model = "zombie_vending_tombstone_on";
    }

    if ( isdefined( level.zombiemode_using_chugabud_perk ) && level.zombiemode_using_chugabud_perk )
    {
        precacheitem( "zombie_perk_bottle_whoswho" );
        precacheshader( "specialty_quickrevive_zombies" );
        precachemodel( "p6_zm_vending_chugabud" );
        precachemodel( "p6_zm_vending_chugabud_on" );
        precachemodel( "ch_tombstone1" );
        precachestring( &"ZOMBIE_PERK_TOMBSTONE" );
        level._effect["tombstone_light"] = loadfx( "misc/fx_zombie_cola_on" );
        level.machine_assets["whoswho"] = spawnstruct();
        level.machine_assets["whoswho"].weapon = "zombie_perk_bottle_whoswho";
        level.machine_assets["whoswho"].off_model = "p6_zm_vending_chugabud";
        level.machine_assets["whoswho"].on_model = "p6_zm_vending_chugabud_on";
	}
	if (level._custom_perks.size > 0)
	{
		a_keys = getarraykeys(level._custom_perks);
		for (i = 0; i < a_keys.size; i++)
		{
			if (isdefined(level._custom_perks[a_keys[i]].precache_func))
			{
				level [[level._custom_perks[a_keys[i]].precache_func]]();
			}
		}
	}
}

init_elevator_perks()
{
    level.elevator_perks = [];
    level.elevator_perks_building = [];
    level.elevator_perks_building["green"] = [];
    level.elevator_perks_building["blue"] = [];
    level.elevator_perks_building["green"][0] = spawnstruct();
    level.elevator_perks_building["green"][0].model = "zombie_vending_revive";
    level.elevator_perks_building["green"][0].script_noteworthy = "specialty_quickrevive";
    level.elevator_perks_building["green"][0].turn_on_notify = "revive_on";
    a = 1;
    b = 2;

    if ( randomint( 100 ) > 50 )
    {
        a = 2;
        b = 1;
    }

    level.elevator_perks_building["green"][a] = spawnstruct();
    level.elevator_perks_building["green"][a].model = "p6_zm_vending_chugabud";
    level.elevator_perks_building["green"][a].script_noteworthy = "specialty_finalstand";
    level.elevator_perks_building["green"][a].turn_on_notify = "chugabud_on";
    level.elevator_perks_building["green"][b] = spawnstruct();
    level.elevator_perks_building["green"][b].model = "zombie_vending_sleight";
    level.elevator_perks_building["green"][b].script_noteworthy = "specialty_fastreload";
    level.elevator_perks_building["green"][b].turn_on_notify = "sleight_on";
    level.elevator_perks_building["blue"][0] = spawnstruct();
    level.elevator_perks_building["blue"][0].model = "zombie_vending_three_gun";
    level.elevator_perks_building["blue"][0].script_noteworthy = "specialty_additionalprimaryweapon";
    level.elevator_perks_building["blue"][0].turn_on_notify = "specialty_additionalprimaryweapon_power_on";
    level.elevator_perks_building["blue"][1] = spawnstruct();
    level.elevator_perks_building["blue"][1].model = "zombie_vending_jugg";
    level.elevator_perks_building["blue"][1].script_noteworthy = "specialty_armorvest";
    level.elevator_perks_building["blue"][1].turn_on_notify = "juggernog_on";
    level.elevator_perks_building["blue"][2] = spawnstruct();
    level.elevator_perks_building["blue"][2].model = "zombie_vending_doubletap2";
    level.elevator_perks_building["blue"][2].script_noteworthy = "specialty_rof";
    level.elevator_perks_building["blue"][2].turn_on_notify = "doubletap_on";
    level.elevator_perks_building["blue"][3] = spawnstruct();
    level.elevator_perks_building["blue"][3].model = "p6_anim_zm_buildable_pap";
    level.elevator_perks_building["blue"][3].script_noteworthy = "specialty_weapupgrade";
    level.elevator_perks_building["blue"][3].turn_on_notify = "Pack_A_Punch_on";
    players_expected = getnumexpectedplayers();
    level.override_perk_targetname = "zm_perk_machine_override";
    level.elevator_perks_building["blue"] = array_randomize( level.elevator_perks_building["blue"] );
    level.elevator_perks = arraycombine( level.elevator_perks_building["green"], level.elevator_perks_building["blue"], 0, 0 );
    random_perk_structs = [];
    revive_perk_struct = getstruct( "force_quick_revive", "targetname" );
    revive_perk_struct = getstruct( revive_perk_struct.target, "targetname" );
    perk_structs = getstructarray( "zm_random_machine", "script_noteworthy" );

    for ( i = 0; i < perk_structs.size; i++ )
    {
        random_perk_structs[i] = getstruct( perk_structs[i].target, "targetname" );
        random_perk_structs[i].script_parameters = perk_structs[i].script_parameters;
        random_perk_structs[i].script_linkent = getent( "elevator_" + perk_structs[i].script_parameters + "_body", "targetname" );
    }

    green_structs = [];
    blue_structs = [];

    foreach ( perk_struct in random_perk_structs )
    {
        if ( isdefined( perk_struct.script_parameters ) )
        {
            if ( issubstr( perk_struct.script_parameters, "bldg1" ) )
            {
                green_structs[green_structs.size] = perk_struct;
                continue;
            }

            blue_structs[blue_structs.size] = perk_struct;
        }
    }

    green_structs = array_exclude( green_structs, revive_perk_struct );
    green_structs = array_randomize( green_structs );
    blue_structs = array_randomize( blue_structs );
    level.random_perk_structs = array( revive_perk_struct );
    level.random_perk_structs = arraycombine( level.random_perk_structs, green_structs, 0, 0 );
    level.random_perk_structs = arraycombine( level.random_perk_structs, blue_structs, 0, 0 );

    for ( i = 0; i < level.elevator_perks.size; i++ )
    {
        if ( !isdefined( level.random_perk_structs[i] ) )
            continue;

        level.random_perk_structs[i].targetname = "zm_perk_machine_override";
        level.random_perk_structs[i].model = level.elevator_perks[i].model;
        level.random_perk_structs[i].script_noteworthy = level.elevator_perks[i].script_noteworthy;
        level.random_perk_structs[i].turn_on_notify = level.elevator_perks[i].turn_on_notify;

        if ( !isdefined( level.struct_class_names["targetname"]["zm_perk_machine_override"] ) )
            level.struct_class_names["targetname"]["zm_perk_machine_override"] = [];

        level.struct_class_names["targetname"]["zm_perk_machine_override"][level.struct_class_names["targetname"]["zm_perk_machine_override"].size] = level.random_perk_structs[i];
	}

	static_perk_structs = getstructarray("zm_perk_machine", "targetname");

	foreach (static_perk_struct in static_perk_structs)
	{
		if (static_perk_struct.script_noteworthy == "specialty_longersprint" || static_perk_struct.script_noteworthy == "specialty_flakjacket")
		{
			level.struct_class_names["targetname"]["zm_perk_machine_override"][level.struct_class_names["targetname"]["zm_perk_machine_override"].size] = static_perk_struct;
		}
	}
}

move_marathon_origins()
{
	if (!is_gametype_active("zclassic"))
	{
		return;
	}

	trigs = getentarray("vending_marathon", "target");

	if (!isdefined(trigs))
	{
		return;
	}

	foreach (trig in trigs)
	{
		if (!isdefined(trig.machine))
		{
			continue;
		}

		if (isdefined(trig.clip))
		{
			trig.clip.origin += anglestoup(trig.machine.angles) * 32;
		}

		if (isdefined(trig.bump))
		{
			trig.bump.origin += anglestoup(trig.machine.angles) * 96;
		}

		trig.origin += anglestoup(trig.machine.angles) * 96;
	}
}
