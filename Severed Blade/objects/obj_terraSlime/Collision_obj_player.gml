if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.terraSlime,global.enemies.terraSlime,global.enemies.terraSlime],
			[global.enemies.terraSlime,global.enemies.terraSlime],
		), 
		spr_grassfield_bg
	);
	instance_destroy();
}