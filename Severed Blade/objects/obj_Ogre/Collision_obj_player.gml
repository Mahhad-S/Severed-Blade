if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.ogre]
		), 
		spr_grassfield_bg
	);
	instance_destroy();
}