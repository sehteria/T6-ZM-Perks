#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_perks;
#include maps\mp\zombies\_zm_perk_divetonuke;
#include maps\mp\_visionset_mgr;
#include maps\mp\zombies\_zm_power;
#include maps\mp\zombies\_zm;

main()
{
    replaceFunc( maps\mp\zombies\_zm_perks::perks_register_clientfield, ::perks_register_clientfield );
    replaceFunc( maps\mp\zombies\_zm::init_client_flags, ::init_client_flags );
    replaceFunc( maps\mp\zombies\_zm_perks::give_perk, ::give_perk );
    replaceFunc( maps\mp\zombies\_zm_perks::default_vending_precaching, ::default_vending_precaching );

    perks();
}

perks()
{
    if ( getDvar("mapname") == "zm_transit" || getDvar("mapname") == "zm_nuked" || getDvar("mapname") == "zm_highrise" || getDvar("mapname") == "zm_prison" || getDvar("mapname") == "zm_buried" ) //GLOBAL
    {
        level.zombiemode_using_marathon_perk = 1;
        level.zombiemode_using_deadshot_perk = 1;
        level.zombiemode_using_additionalprimaryweapon_perk = 1;
        level.zombiemode_using_divetonuke_perk = 1;
        maps\mp\zombies\_zm_perk_divetonuke::enable_divetonuke_perk_for_level();
    }
}

perks_register_clientfield()
{
	bits = 1;
	if (isdefined(level.zombie_include_weapons) && isdefined(level.zombie_include_weapons["emp_grenade_zm"]))
	{
		bits = 2;
	}
	if (isdefined(level.zombiemode_using_additionalprimaryweapon_perk) && level.zombiemode_using_additionalprimaryweapon_perk)
	{
		registerclientfield("toplayer", "perk_additional_primary_weapon", 1, bits, "int");
	}
	if (isdefined(level.zombiemode_using_deadshot_perk) && level.zombiemode_using_deadshot_perk)
	{
		registerclientfield("toplayer", "perk_dead_shot", 1, bits, "int");
	}
	if (isdefined(level.zombiemode_using_doubletap_perk) && level.zombiemode_using_doubletap_perk)
	{
		registerclientfield("toplayer", "perk_double_tap", 1, bits, "int");
	}
	if (isdefined(level.zombiemode_using_juggernaut_perk) && level.zombiemode_using_juggernaut_perk)
	{
		registerclientfield("toplayer", "perk_juggernaut", 1, bits, "int");
	}
	if (isdefined(level.zombiemode_using_marathon_perk) && level.zombiemode_using_marathon_perk)
	{
		registerclientfield("toplayer", "perk_marathon", 1, bits, "int");
	}
	if (isdefined(level.zombiemode_using_revive_perk) && level.zombiemode_using_revive_perk)
	{
		registerclientfield("toplayer", "perk_quick_revive", 1, bits, "int");
	}
	if (isdefined(level.zombiemode_using_sleightofhand_perk) && level.zombiemode_using_sleightofhand_perk)
	{
		registerclientfield("toplayer", "perk_sleight_of_hand", 1, bits, "int");
	}
	if (isdefined(level.zombiemode_using_tombstone_perk) && level.zombiemode_using_tombstone_perk)
	{
		registerclientfield("toplayer", "perk_tombstone", 1, bits, "int");
	}
	if (isdefined(level.zombiemode_using_perk_intro_fx) && level.zombiemode_using_perk_intro_fx)
	{
		registerclientfield("scriptmover", "clientfield_perk_intro_fx", 1000, 1, "int");
	}
	if (isdefined(level.zombiemode_using_chugabud_perk) && level.zombiemode_using_chugabud_perk)
	{
		registerclientfield("toplayer", "perk_chugabud", 1000, 1, "int");
	}
	if (isdefined(level._custom_perks))
	{
		a_keys = getarraykeys(level._custom_perks);
		for (i = 0; i < a_keys.size; i++)
		{
			if (isdefined(level._custom_perks[a_keys[i]].clientfield_register))
			{
				level [[level._custom_perks[a_keys[i]].clientfield_register]]();
			}
		}
	}
}

init_client_flags()
{
	level.disable_deadshot_clientfield = 1;
	if (isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx)
	{
		level._zombie_scriptmover_flag_board_horizontal_fx = 14;
		level._zombie_scriptmover_flag_board_vertical_fx = 13;
	}
	if (isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx)
	{
		level._zombie_scriptmover_flag_rock_fx = 12;
	}
	level._zombie_player_flag_cloak_weapon = 14;
	if (!(isdefined(level.disable_deadshot_clientfield) && level.disable_deadshot_clientfield))
	{
		registerclientfield("toplayer", "deadshot_perk", 1, 1, "int");
	}
	registerclientfield("actor", "zombie_riser_fx", 1, 1, "int");
	if (!(isdefined(level._no_water_risers) && level._no_water_risers))
	{
		registerclientfield("actor", "zombie_riser_fx_water", 1, 1, "int");
	}
	if (isdefined(level._foliage_risers) && level._foliage_risers)
	{
		registerclientfield("actor", "zombie_riser_fx_foliage", 12000, 1, "int");
	}
	if (isdefined(level.risers_use_low_gravity_fx) && level.risers_use_low_gravity_fx)
	{
		registerclientfield("actor", "zombie_riser_fx_lowg", 1, 1, "int");
	}
}

give_perk( perk, bought )
{
    self setperk( perk );
    self.num_perks++;

    if ( isdefined( bought ) && bought )
    {
        self maps\mp\zombies\_zm_audio::playerexert( "burp" );

        if ( isdefined( level.remove_perk_vo_delay ) && level.remove_perk_vo_delay )
            self maps\mp\zombies\_zm_audio::perk_vox( perk );
        else
            self delay_thread( 1.5, maps\mp\zombies\_zm_audio::perk_vox, perk );

        self setblur( 4, 0.1 );
        wait 0.1;
        self setblur( 0, 0.1 );
        self notify( "perk_bought", perk );
    }

    self perk_set_max_health_if_jugg( perk, 1, 0 );

    if (!(isDefined(level.disable_deadshot_clientfield) && level.disable_deadshot_clientfield))
    {
        if ( perk == "specialty_deadshot" )
            self setclientfieldtoplayer( "deadshot_perk", 1 );
        else if ( perk == "specialty_deadshot_upgrade" )
            self setclientfieldtoplayer( "deadshot_perk", 1 );
    }

    if ( perk == "specialty_scavenger" )
        self.hasperkspecialtytombstone = 1;

    players = get_players();

    if ( use_solo_revive() && perk == "specialty_quickrevive" )
    {
        self.lives = 1;

        if ( !isdefined( level.solo_lives_given ) )
            level.solo_lives_given = 0;

        if ( isdefined( level.solo_game_free_player_quickrevive ) )
            level.solo_game_free_player_quickrevive = undefined;
        else
            level.solo_lives_given++;

        if ( level.solo_lives_given >= 3 )
            flag_set( "solo_revive" );

        self thread solo_revive_buy_trigger_move( perk );
    }

    if ( perk == "specialty_finalstand" )
    {
        self.lives = 1;
        self.hasperkspecialtychugabud = 1;
        self notify( "perk_chugabud_activated" );
    }

    if ( isdefined( level._custom_perks[perk] ) && isdefined( level._custom_perks[perk].player_thread_give ) )
        self thread [[ level._custom_perks[perk].player_thread_give ]]();

    self set_perk_clientfield( perk, 1 );
    maps\mp\_demo::bookmark( "zm_player_perk", gettime(), self );
    self maps\mp\zombies\_zm_stats::increment_client_stat( "perks_drank" );
    self maps\mp\zombies\_zm_stats::increment_client_stat( perk + "_drank" );
    self maps\mp\zombies\_zm_stats::increment_player_stat( perk + "_drank" );
    self maps\mp\zombies\_zm_stats::increment_player_stat( "perks_drank" );

    if ( !isdefined( self.perk_history ) )
        self.perk_history = [];

    self.perk_history = add_to_array( self.perk_history, perk, 0 );

    if ( !isdefined( self.perks_active ) )
        self.perks_active = [];

    self.perks_active[self.perks_active.size] = perk;
    self notify( "perk_acquired" );
    self thread perk_think( perk );
}

default_vending_precaching()
{
    if ( isdefined( level.zombiemode_using_pack_a_punch ) && level.zombiemode_using_pack_a_punch )
    {
        precacheitem( "zombie_knuckle_crack" );
        precachemodel( "p6_anim_zm_buildable_pap" );
        precachemodel( "p6_anim_zm_buildable_pap_on" );
        precachestring( &"ZOMBIE_PERK_PACKAPUNCH" );
        precachestring( &"ZOMBIE_PERK_PACKAPUNCH_ATT" );
        level._effect["packapunch_fx"] = loadfx( "maps/zombie/fx_zombie_packapunch" );
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
        precachemodel( "p6_zm_al_vending_ads_on" );
        precachestring( &"ZOMBIE_PERK_DEADSHOT" );
        level._effect["deadshot_light"] = loadfx( "misc/fx_zombie_cola_dtap_on" );
        level.machine_assets["deadshot"] = spawnstruct();
        level.machine_assets["deadshot"].weapon = "zombie_perk_bottle_deadshot";
        level.machine_assets["deadshot"].off_model = "p6_zm_al_vending_ads_on";
        level.machine_assets["deadshot"].on_model = "p6_zm_al_vending_ads_on";
        level.machine_assets["deadshot"].power_on_callback = ::vending_deadshot_power_on;
		level.machine_assets["deadshot"].power_off_callback = ::vending_deadshot_power_off;
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

    if ( level._custom_perks.size > 0 )
    {
        a_keys = getarraykeys( level._custom_perks );

        for ( i = 0; i < a_keys.size; i++ )
        {
            if ( isdefined( level._custom_perks[a_keys[i]].precache_func ) )
                level [[ level._custom_perks[a_keys[i]].precache_func ]]();
        }
    }
}

vending_deadshot_power_on()
{
	if (level.script == "zm_prison")
	{
		self setclientfield("toggle_perk_machine_power", 2);
	}
	else
	{
		level thread clientnotifyloop("toggle_vending_deadshot_power_on", "deadshot_off");
	}
}

vending_deadshot_power_off()
{
	if (level.script == "zm_prison")
	{
		self setclientfield("toggle_perk_machine_power", 1);
	}
	else
	{
		level thread clientnotifyloop("toggle_vending_deadshot_power_off", "deadshot_on");
	}
}

clientnotifyloop(notify_str, endon_str)
{
	if (isdefined(endon_str))
	{
		level endon(endon_str);
	}

	while (1)
	{
		clientnotify(notify_str);

		level waittill("connected", player);

		wait 0.05;
	}
}