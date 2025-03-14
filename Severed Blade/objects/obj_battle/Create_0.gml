instance_deactivate_all(true);

units = [];

//Make Enemies
for (var i = 0; i < array_length(enemies); i++)
{
	//Hardcoded directions --  needs change
	enemyUnits[i] = instance_create_depth(x+250+(i*10), y+68+(i*20), depth-10, obj_battle_unit, enemies[i]);
	array_push(units, enemyUnits[i]);
}

//Make Party
for (var i = 0; i < array_length(global.party); i++)
{
	//Hardcoded directions --  needs change
	partyUnits[i] = instance_create_depth(x+70+(i*10), y+68+(i*15), depth-10, obj_battle_unit, global.party[i]);
	array_push(units, partyUnits[i]);
}