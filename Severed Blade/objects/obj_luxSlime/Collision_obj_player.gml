if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.luxSlime,global.enemies.luxSlime,global.enemies.luxSlime],
			[global.enemies.luxSlime,global.enemies.luxSlime],
		), 
		spr_grassfield_bg
	);
	instance_destroy();
}