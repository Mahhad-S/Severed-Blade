if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.ignisSlime,global.enemies.ignisSlime,global.enemies.ignisSlime],
			[global.enemies.ignisSlime,global.enemies.ignisSlime],
		), 
		spr_grassfield_bg
	);
	instance_destroy();
}