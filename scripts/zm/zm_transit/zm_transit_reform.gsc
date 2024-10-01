#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;

main()
{
    replaceFunc( maps\mp\zm_transit_standard_station::main, ::main_o );
    replaceFunc( maps\mp\zm_transit_lava::zombie_exploding_death, ::zombie_exploding_death );

    electric_door_changes();

    if (is_not_busdepot())
	{
	   return;
	}
}

init()
{   if( getDvar("ui_zm_mapstartlocation") == "town" )
    {
        level thread town_vault_breach_init();
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

town_vault_breach_init()
{
    vault_doors = getentarray( "town_bunker_door", "targetname" );
    array_thread( vault_doors, ::town_vault_breach );
}

town_vault_breach()
{
    if ( isdefined( self ) )
    {
        self.damage_state = 0;

        if ( isdefined( self.target ) )
        {
            clip = getent( self.target, "targetname" );
            clip linkto( self );
            self.clip = clip;
        }

        self thread vault_breach_think();
    }
    else
        return;
}

vault_breach_think()
{
    level endon( "intermission" );
    self.health = 99999;
    self setcandamage( 1 );
    self.damage_state = 0;
    self.clip.health = 99999;
    self.clip setcandamage( 1 );

    while ( true )
    {
        self thread track_clip_damage();
        self waittill( "damage", amount, attacker, direction, point, dmg_type, modelname, tagname, partname, weaponname );

        if ( isdefined( weaponname ) && ( weaponname == "emp_grenade_zm" || weaponname == "ray_gun_zm" || weaponname == "ray_gun_upgraded_zm" ) )
            continue;

        if ( isdefined( amount ) && amount <= 1 )
            continue;

        if ( isplayer( attacker ) && ( dmg_type == "MOD_PROJECTILE" || dmg_type == "MOD_PROJECTILE_SPLASH" || dmg_type == "MOD_EXPLOSIVE" || dmg_type == "MOD_EXPLOSIVE_SPLASH" || dmg_type == "MOD_GRENADE" || dmg_type == "MOD_GRENADE_SPLASH" ) )
        {
            if ( self.damage_state == 0 )
                self.damage_state = 1;

            playfxontag( level._effect["def_explosion"], self, "tag_origin" );
            self playsound( "exp_vault_explode" );
            self bunkerdoorrotate( 1 );

            if ( isdefined( self.script_flag ) )
                flag_set( self.script_flag );

            if ( isdefined( self.clip ) )
                self.clip connectpaths();

            wait 1;
            playsoundatposition( "zmb_cha_ching_loud", self.origin );
            return;
        }
    }
}

track_clip_damage()
{
    self endon( "damage" );
    self.clip waittill( "damage", amount, attacker, direction, point, dmg_type );
    self notify( "damage", amount, attacker, direction, point, dmg_type );
}

bunkerdoorrotate( open, time )
{
    if ( !isdefined( time ) )
        time = 0.2;

    rotate = self.script_float;

    if ( !open )
        rotate = rotate * -1;

    if ( isdefined( self.script_angles ) )
    {
        self notsolid();
        self rotateto( self.script_angles, time, 0, 0 );
        self thread maps\mp\zombies\_zm_blockers::door_solid_thread();
    }
}

is_not_busdepot()
{
	return !getdvar("g_gametype") == "zclassic" && getdvar("mapname") == "zm_transit" && getdvar("ui_zm_mapstartlocation") == "transit";
}