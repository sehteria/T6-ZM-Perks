#include common_scripts\utility;
#include clientscripts\mp\_utility;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\zombies\_zm_perks;
#include clientscripts\mp\_visionset_mgr;
#include clientscripts\mp\_ambientpackage;
#include clientscripts\mp\_music;
#include clientscripts\mp\_audio;

main()
{
	perks();
}

perks()
{
    if ( getDvar("mapname") == "zm_transit" && getDvar("g_gametype") == "zclassic" || getDvar("g_gametype") == "zstandard" )
    {
		level.zombiemode_using_deadshot_perk = 1;
		level.zombiemode_using_additionalprimaryweapon_perk = 1;
	}
    else if ( getDvar("mapname") == "zm_nuked" && getDvar("g_gametype") == "zstandard" )
    {
        level.zombiemode_using_marathon_perk = 1;
		level.zombiemode_using_deadshot_perk = 1;
		level.zombiemode_using_additionalprimaryweapon_perk = 1;
    }
}