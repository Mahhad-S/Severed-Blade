//Action Library
global.actionLibrary =
{
	name: "Attack",
	description: "{0} attacks!",
	subMenu: -1,
	targetRequired: true,
	tergetEnemyByDefault: true,
	targetAll: MODE.NEVER,
	userAnimation: "attack",
	effectSprite: spr_slash,
	effectOnTarget: MODE.ALWAYS
	func: function(_user, _targets)
	{
		var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
		with (_targets[0]) hp = max(0, hp - _damage);
	}
}

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

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
		sprites : { idle: spr_pIdle, attack: spr_pAttack, Aura: spr_pAura, defend: spr_pDefend, item: spr_pItem },
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
		sprites: { idle: spr_slime_idle, attack: spr_slime_attack },
		actions: [],
		xpValue : 15,
		AIscript : function()
		{
			//enemy turn ai goes here
		}
	}
}
