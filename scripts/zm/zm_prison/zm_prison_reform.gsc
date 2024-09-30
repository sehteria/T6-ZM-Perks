#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;

main()
{
	replaceFunc( maps\mp\zm_prison::delete_perk_machine_clip, ::delete_perk_machine_clip );
}

init()
{
	precacheModel("collision_clip_32x32x128");
}

delete_perk_machine_clip()
{
	perk_machines = getentarray("zombie_vending", "targetname");

	foreach (perk_machine in perk_machines)
	{
		if (isdefined(perk_machine.clip))
		{
			perk_machine.clip delete();
		}

		if (isdefined(perk_machine.target) && perk_machine.target == "vending_divetonuke" || perk_machine.target == "vending_additionalprimaryweapon")
		{
			spawn_custom_perk_collision(perk_machine);
		}
	}
}

spawn_custom_perk_collision(perk_machine)
{
	collision = spawn("script_model", perk_machine.origin + (0, 0, 64), 1);
	collision.angles = perk_machine.angles;

	collision setmodel("collision_clip_32x32x128");
	collision disconnectpaths();
}