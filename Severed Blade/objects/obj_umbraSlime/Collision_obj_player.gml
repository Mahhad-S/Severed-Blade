if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.umbraSlime,global.enemies.umbraSlime,global.enemies.umbraSlime],
			[global.enemies.umbraSlime,global.enemies.umbraSlime],
		), 
		spr_grassfield_bg
	);
	instance_destroy();
}