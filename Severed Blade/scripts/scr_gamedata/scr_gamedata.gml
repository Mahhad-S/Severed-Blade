//Party Data
global.party =
[
	{
		name: "Hashimoto Sobu",
		hp: 39,
		hpMax: 80,
		mp: 0,
		mpMax: 15,
		strength: 6,
		sprites : { idle: spr_battle_player},
		actions : []
	}
];

//Enemy Data
global.enemies =
{
	slimeG: 
	{
		name: "Green Slime",
		hp: 30,
		hpMax: 30,
		mp: 0,
		mpMax: 0,
		strength: 5,
		sprites: { idle: spr_slime},
		actions: [],
		xpValue : 15,
		AIscript : function()
		{
			//enemy turn ai goes here
		}
	}
}
