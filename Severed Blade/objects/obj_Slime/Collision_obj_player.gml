if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.slimeG,global.enemies.slimeG,global.enemies.slimeG],
			[global.enemies.slimeG,global.enemies.slimeG],
		), 
		spr_grassfield_bg
	);
	instance_destroy();
}