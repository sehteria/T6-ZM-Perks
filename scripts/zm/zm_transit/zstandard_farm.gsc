#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;

init()
{
    if( getDvar("mapname") == "zm_transit" && getDvar("g_gametype") == "zstandard" && getDvar("ui_zm_mapstartlocation") == "farm" )
    {
        level thread farm_perks();
    }
}

farm_perks()
{
	flag_wait("start_zombie_round_logic");
    wait 1;
    level notify( "marathon_on" );
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