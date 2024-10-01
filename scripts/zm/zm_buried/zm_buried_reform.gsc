#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;

init()
{
    move_divetonuke_collision();
}

move_divetonuke_collision()
{
	if (!is_gametype_active("zclassic"))
	{
		return;
	}

	trigs = getentarray("vending_divetonuke", "target");

	if (!isdefined(trigs))
	{
		return;
	}

	foreach (trig in trigs)
	{
		if (isdefined(trig.clip))
		{
			trig.clip.origin += (0, 0, -128);
		}
	}
}