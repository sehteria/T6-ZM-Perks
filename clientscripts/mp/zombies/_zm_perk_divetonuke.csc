#include clientscripts\mp\zombies\_zm_perks;
#include clientscripts\mp\_visionset_mgr;

enable_divetonuke_perk_for_level()
{
    clientscripts\mp\zombies\_zm_perks::register_perk_clientfields( "specialty_flakjacket", ::divetonuke_client_field_func, ::divetonuke_code_callback_func );
    clientscripts\mp\zombies\_zm_perks::register_perk_init_thread( "specialty_flakjacket", ::init_divetonuke );
}

init_divetonuke()
{
    if ( isdefined( level.enable_magic ) && level.enable_magic )
    {
        clientscripts\mp\_visionset_mgr::vsmgr_register_visionset_info( "zm_perk_divetonuke", 9000, 5, "zombie_cosmodrome_divetonuke", "zombie_cosmodrome_divetonuke" );
    }

    level._effect["divetonuke_groundhit"] = loadfx( "maps/zombie/fx_zmb_phdflopper_exp" );
}

divetonuke_client_field_func()
{
	bits = 1;
	if (clientscripts\mp\zombies\_zm_weapons::is_weapon_included("emp_grenade_zm"))
	{
		bits = 2;
	}
	registerclientfield("toplayer", "perk_dive_to_nuke", 9000, bits, "int", undefined, 0, 1);
}

divetonuke_code_callback_func()
{
    setupclientfieldcodecallbacks( "toplayer", 1, "perk_dive_to_nuke" );
}