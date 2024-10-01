#include common_scripts\utility;
#include clientscripts\mp\_utility;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\zombies\_zm_perks;
#include clientscripts\mp\zombies\_zm_perk_divetonuke;
#include clientscripts\mp\_visionset_mgr;
#include clientscripts\mp\_ambientpackage;
#include clientscripts\mp\_music;
#include clientscripts\mp\_audio;
#include clientscripts\mp\_fx;
#include clientscripts\mp\_filter;
#include clientscripts\mp\zombies\_zm;

main()
{
	replaceFunc( clientscripts\mp\zombies\_zm_perks::perks_register_clientfield, ::perks_register_clientfield );
	replaceFunc( clientscripts\mp\zombies\_zm::init_client_flag_callback_funcs, ::init_client_flag_callback_funcs);

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
        clientscripts\mp\zombies\_zm_perk_divetonuke::enable_divetonuke_perk_for_level();

		level thread toggle_vending_deadshot_power_on_think();
		level thread toggle_vending_deadshot_power_off_think();
		level thread toggle_vending_divetonuke_power_on_think();
		level thread toggle_vending_divetonuke_power_off_think();
	}
}

toggle_vending_deadshot_power_on_think()
{
	while (1)
	{
		level waittill("toggle_vending_deadshot_power_on");
		ents = getentarray(0);
		foreach (ent in ents)
		{
			if (isdefined(ent.model) && ent.model == "p6_zm_al_vending_ads_on")
			{
				ent mapshaderconstant(0, 1, "ScriptVector0");
				ent setshaderconstant(0, 1, 0, 0.5, 0, 0);
			}
		}
	}
}
toggle_vending_deadshot_power_off_think()
{
	while (1)
	{
		level waittill("toggle_vending_deadshot_power_off");
		ents = getentarray(0);
		foreach (ent in ents)
		{
			if (isdefined(ent.model) && ent.model == "p6_zm_al_vending_ads_on")
			{
				ent mapshaderconstant(0, 1, "ScriptVector0");
				ent setshaderconstant(0, 1, 0, 0, 0, 0);
			}
		}
	}
}

toggle_vending_divetonuke_power_on_think()
{
	while (1)
	{
		level waittill("toggle_vending_divetonuke_power_on");

		ents = getentarray(0);

		foreach (ent in ents)
		{
			if (isdefined(ent.model) && ent.model == "p6_zm_al_vending_nuke_on")
			{
				ent mapshaderconstant(0, 1, "ScriptVector0");
				ent setshaderconstant(0, 1, 0, 0.5, 0, 0);
			}
		}
	}
}

toggle_vending_divetonuke_power_off_think()
{
	while (1)
	{
		level waittill("toggle_vending_divetonuke_power_off");

		ents = getentarray(0);

		foreach (ent in ents)
		{
			if (isdefined(ent.model) && ent.model == "p6_zm_al_vending_nuke_on")
			{
				ent mapshaderconstant(0, 1, "ScriptVector0");
				ent setshaderconstant(0, 1, 0, 0, 0, 0);
			}
		}
	}
}

perks_register_clientfield()
{
	bits = 1;
	if (clientscripts\mp\zombies\_zm_weapons::is_weapon_included("emp_grenade_zm"))
	{
		bits = 2;
	}
	if (is_true(level.zombiemode_using_additionalprimaryweapon_perk))
	{
		registerclientfield("toplayer", "perk_additional_primary_weapon", 1, bits, "int", level.zombies_global_perk_client_callback, 0, 1);
	}
	if (is_true(level.zombiemode_using_deadshot_perk))
	{
		registerclientfield("toplayer", "perk_dead_shot", 1, bits, "int", level.zombies_global_perk_client_callback, 0, 1);
	}
	if (is_true(level.zombiemode_using_doubletap_perk))
	{
		registerclientfield("toplayer", "perk_double_tap", 1, bits, "int", level.zombies_global_perk_client_callback, 0, 1);
	}
	if (is_true(level.zombiemode_using_juggernaut_perk))
	{
		registerclientfield("toplayer", "perk_juggernaut", 1, bits, "int", level.zombies_global_perk_client_callback, 0, 1);
	}
	if (is_true(level.zombiemode_using_marathon_perk))
	{
		registerclientfield("toplayer", "perk_marathon", 1, bits, "int", level.zombies_global_perk_client_callback, 0, 1);
	}
	if (is_true(level.zombiemode_using_revive_perk))
	{
		registerclientfield("toplayer", "perk_quick_revive", 1, bits, "int", level.zombies_global_perk_client_callback, 0, 1);
	}
	if (is_true(level.zombiemode_using_sleightofhand_perk))
	{
		registerclientfield("toplayer", "perk_sleight_of_hand", 1, bits, "int", level.zombies_global_perk_client_callback, 0, 1);
	}
	if (is_true(level.zombiemode_using_tombstone_perk))
	{
		registerclientfield("toplayer", "perk_tombstone", 1, bits, "int", level.zombies_global_perk_client_callback, 0, 1);
	}
	if (is_true(level.zombiemode_using_perk_intro_fx))
	{
		registerclientfield("scriptmover", "clientfield_perk_intro_fx", 1000, 1, "int", ::perk_meteor_fx, 0);
	}
	if (is_true(level.zombiemode_using_chugabud_perk))
	{
		registerclientfield("toplayer", "perk_chugabud", 1000, 1, "int", level.zombies_global_perk_client_callback, 0, 1);
	}
	if (level._custom_perks.size > 0)
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
	level thread perk_init_code_callbacks();
}

init_client_flag_callback_funcs()
{
	level.disable_deadshot_clientfield = 1;
	level._client_flag_callbacks = [];
	level._client_flag_callbacks["vehicle"] = [];
	level._client_flag_callbacks["player"] = [];
	level._client_flag_callbacks["actor"] = [];
	level._client_flag_callbacks["scriptmover"] = [];
	if (isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx)
	{
		register_clientflag_callback("scriptmover", level._zombie_scriptmover_flag_board_vertical_fx, ::handle_vertical_board_clientside_fx);
		register_clientflag_callback("scriptmover", level._zombie_scriptmover_flag_board_horizontal_fx, ::handle_horizontal_board_clientside_fx);
	}
	if (isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx)
	{
		register_clientflag_callback("scriptmover", level._zombie_scriptmover_flag_rock_fx, ::handle_rock_clientside_fx);
	}
	register_clientflag_callback("scriptmover", level._zombie_scriptmover_flag_box_random, clientscripts\mp\zombies\_zm_weapons::weapon_box_callback);
	if (!is_true(level.disable_deadshot_clientfield))
	{
		registerclientfield("toplayer", "deadshot_perk", 1, 1, "int", ::player_deadshot_perk_handler, 0, 1);
	}
	if (!is_true(level._no_navcards))
	{
		if (level.scr_zm_ui_gametype == "zclassic" && !level.createfx_enabled)
		{
			registerclientfield("allplayers", "navcard_held", 1, 4, "int", undefined, 0, 1);
			level thread set_clientfield_navcard_code_callback("navcard_held");
		}
	}
	if (!is_true(level._no_water_risers))
	{
		registerclientfield("actor", "zombie_riser_fx_water", 1, 1, "int", ::handle_zombie_risers_water, 1);
	}
	if (is_true(level._foliage_risers))
	{
		registerclientfield("actor", "zombie_riser_fx_foliage", 12000, 1, "int", ::handle_zombie_risers_foliage, 1);
	}
	registerclientfield("actor", "zombie_riser_fx", 1, 1, "int", ::handle_zombie_risers, 1);
	if (is_true(level.risers_use_low_gravity_fx))
	{
		registerclientfield("actor", "zombie_riser_fx_lowg", 1, 1, "int", ::handle_zombie_risers_lowg, 1);
	}
}