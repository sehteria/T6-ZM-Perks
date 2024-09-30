#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;

init()
{
    if( getDvar("mapname") == "zm_transit" && getDvar("g_gametype") == "zstandard" && getDvar("ui_zm_mapstartlocation") == "transit" )
	{
        level thread busdepot_perks();
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