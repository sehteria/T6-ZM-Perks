#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;

init()
{
    if( getDvar("mapname") == "zm_transit" && getDvar("g_gametype") == "zstandard" && getDvar("ui_zm_mapstartlocation") == "town" )
	{
        level thread town_perks();
    }
}

town_perks()
{
    flag_wait( "start_zombie_round_logic" );
    wait 1;
    level notify( "deadshot_on" );
    wait_network_frame();
    level notify( "additionalprimaryweapon_on" );
    wait_network_frame();
}