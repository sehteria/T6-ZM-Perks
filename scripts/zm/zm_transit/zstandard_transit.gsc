#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;

main()
{
    if( getDvar("mapname") == "zm_transit" && getDvar("g_gametype") == "zstandard" && getDvar("ui_zm_mapstartlocation") == "transit" )
	{
        replaceFunc ( maps\mp\zm_transit_standard_station::main, ::main_o );

        level thread busdepot_perks();
    }
}

main_o()
{
    maps\mp\gametypes_zm\_zm_gametype::setup_standard_objects( "station" );
    maps\mp\zm_transit_standard_station::station_treasure_chest_init();
    level.enemy_location_override_func = maps\mp\zm_transit_standard_station::enemy_location_override;
    collision = spawn( "script_model", ( -6896, 4744, 0 ), 1 );
    collision setmodel( "zm_collision_transit_busdepot_survival" );
    collision disconnectpaths();
    flag_wait( "initial_blackscreen_passed" );
    flag_set( "power_on" );
    level setclientfield( "zombie_power_on", 1 );
    zombie_doors = getentarray( "zombie_door", "targetname" );

    foreach ( door in zombie_doors )
    {
        if ( isdefined( door.script_noteworthy ) && door.script_noteworthy == "local_electric_door" )
        {
            door trigger_off();
        }
    }
}

busdepot_perks()
{
    if (is_not_busdepot())
	{
	   return;
	}
    flag_wait( "start_zombie_round_logic" );
    wait 1;
    level notify( "revive_on" );
    wait_network_frame();
    level notify( "doubletap_on" );
    wait_network_frame();
    level notify( "marathon_on" );
    wait_network_frame();
    level notify( "juggernog_on" );
    wait_network_frame();
    level notify( "sleight_on" );
    wait_network_frame();
    level notify( "tombstone_on" );
    wait_network_frame();
    level notify( "deadshot_on" );
    wait_network_frame();
    level notify( "additionalprimaryweapon_on" );
    wait_network_frame();
    level notify( "Pack_A_Punch_on" );
    wait_network_frame();
}

is_not_busdepot()
{
	return !getdvar("g_gametype") == "zclassic" && getdvar("mapname") == "zm_transit" && getdvar("ui_zm_mapstartlocation") == "transit";
}