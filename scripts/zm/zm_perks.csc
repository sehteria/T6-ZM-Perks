#include common_scripts\utility;
#include clientscripts\mp\_utility;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\zombies\_zm_perks;
#include clientscripts\mp\zombies\_zm_perk_divetonuke;
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
    if ( getDvar("mapname") == "zm_transit" )
    {
		level.zombiemode_using_deadshot_perk = 1;
		level.zombiemode_using_additionalprimaryweapon_perk = 1;

		level thread toggle_vending_deadshot_power_on_think();
		level thread toggle_vending_deadshot_power_off_think();
	}
    else if ( getDvar("mapname") == "zm_nuked" )
    {
        level.zombiemode_using_marathon_perk = 1;
		level.zombiemode_using_deadshot_perk = 1;
		level.zombiemode_using_additionalprimaryweapon_perk = 1;

		level thread toggle_vending_deadshot_power_on_think();
		level thread toggle_vending_deadshot_power_off_think();
    }
    else if ( getDvar("mapname") == "zm_prison" && getDvar("g_gametype") == "zclassic" )
    {
        level.zombiemode_using_divetonuke_perk = 1;
        clientscripts\mp\zombies\_zm_perk_divetonuke::enable_divetonuke_perk_for_level();
        level.zombiemode_using_additionalprimaryweapon_perk = 1;
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