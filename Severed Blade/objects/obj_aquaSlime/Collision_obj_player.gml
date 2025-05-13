if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.aquaSlime,global.enemies.aquaSlime,global.enemies.aquaSlime],
			[global.enemies.aquaSlime,global.enemies.aquaSlime],
		), 
		spr_grassfield_bg
	);
	instance_destroy();
}