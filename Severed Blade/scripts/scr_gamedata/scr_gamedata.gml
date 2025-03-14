//Party Data
global.party = 
[
	{
		name: "Hashimoto Sobu",
		hp: 10,
		hp_max: 10,
		mp: 10,
		mp_max: 10,
		strength: 10,
		intelligence: 10,
		dexterity: 10,
		sprites : { idle: spr_battle_player },
		actions : []
	}
];

//Enemy Data
global.enemies =
{
	slime:
	{
		name: "Slime",
		hp: 10,
		hp_max: 10,
		mp: 10,
		mp_max: 10,
		strength: 10,
		intelligence: 10,
		dexterity: 10,
		sprites : {},
		actions : [],
		xpValue : 15,
		AIscript : function()
		{
			//enemy turn ai goes here
		}
	}
	
}