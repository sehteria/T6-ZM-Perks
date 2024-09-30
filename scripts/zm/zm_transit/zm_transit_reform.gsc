#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;

main()
{
    replaceFunc( maps\mp\zm_transit_standard_station::main, ::main_o );
    replaceFunc( maps\mp\zm_transit_lava::zombie_exploding_death, ::zombie_exploding_death );

    electric_door_changes();
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

zombie_exploding_death( zombie_dmg, trap )
{
    self endon( "stop_flame_damage" );

    if ( isdefined( self.isdog ) && self.isdog && isdefined( self.a.nodeath ) )
    {
        return;
    }

    while ( isdefined( self ) && self.health >= zombie_dmg && ( isdefined( self.is_on_fire ) && self.is_on_fire ) )
    {
        wait 0.5;
    }

    if ( !isdefined( self ) || !( isdefined( self.is_on_fire ) && self.is_on_fire ) || isdefined( self.damageweapon ) && ( self.damageweapon == "tazer_knuckles_zm" || self.damageweapon == "jetgun_zm" ) || isdefined( self.knuckles_extinguish_flames ) && self.knuckles_extinguish_flames )
    {
        return;
    }

    tag = "J_SpineLower";

    if ( isdefined( self.animname ) && self.animname == "zombie_dog" )
    {
        tag = "tag_origin";
    }

    if ( is_mature() )
    {
        if ( isdefined( level._effect["zomb_gib"] ) )
        {
            playfx( level._effect["zomb_gib"], self gettagorigin( tag ) );
        }
    }
    else if ( isdefined( level._effect["spawn_cloud"] ) )
    {
        playfx( level._effect["spawn_cloud"], self gettagorigin( tag ) );
    }

    self radiusdamage( self.origin, 128, 30, 15, undefined, "MOD_GRENADE_SPLASH" );
    self ghost();

    if ( isdefined( self.isdog ) && self.isdog )
    {
        self hide();
    }
    else
    {
        self delay_thread( 1, ::self_delete );
    }
}

electric_door_changes() //BO2 Reimagined
{
	if (is_classic())
	{
		return;
	}

	zombie_doors = getentarray("zombie_door", "targetname");

	for (i = 0; i < zombie_doors.size; i++)
	{
        
		if (isDefined(zombie_doors[i].script_noteworthy) && (zombie_doors[i].script_noteworthy == "local_electric_door" || zombie_doors[i].script_noteworthy == "electric_door"))
		{
			if (zombie_doors[i].target == "lab_secret_hatch")
			{
				continue;
			}

			zombie_doors[i].script_noteworthy = "default";
			zombie_doors[i].zombie_cost = 750;

			// link Bus Depot and Farm electric doors together
			new_target = undefined;

			if (zombie_doors[i].target == "pf1766_auto2353")
			{
				new_target = "pf1766_auto2352";

			}
			else if (zombie_doors[i].target == "pf1766_auto2358")
			{
				new_target = "pf1766_auto2357";
			}

			if (isDefined(new_target))
			{
				targets = getentarray(zombie_doors[i].target, "targetname");
				zombie_doors[i].target = new_target;

				foreach (target in targets)
				{
					target.targetname = zombie_doors[i].target;
				}
			}
		}
	} 
}