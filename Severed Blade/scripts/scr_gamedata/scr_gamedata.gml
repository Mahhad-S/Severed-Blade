enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

//Action Library
global.actionLibrary =
{
	strike:
	{
		name: "Strike",
		description: "{0} attacks!",
		subMenu: "Attack",
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "strike",
		effectSprite: spr_slash,
		effectOnTarget: MODE.ALWAYS,
		func: function(_user, _targets)
		{
			var _damage = ceil(_user.STR + random_range(-_user.STR * 0.25, _user.STR * 0.25));
			BattleChangeHP(_targets[0], -_damage, 0);
		}
	},
	defend : 
	{
		name : "Defend",
		description : "{0} assumes a defensive stance!",
		subMenu : -1,
		targetRequired: false,
		func : function(_user, _target)
		{
			_user.defending = true;
		}		
	},
	escape : 
	{
		name : "Escape",
		description : "",
		subMenu : -1,
		targetRequired: false,
		func : function(_user, _target)
		{
			if (random(1) < 0.8) //success
			{
				obj_battle.escaped = true;
			}
			else //fail
			{
				obj_battle.battleText = "Failed to escape!";
			}
		}		
	},
	ice : 
	{
		name : "Ice",
		description : "{0} casts Ice!",
		subMenu : "Magic",
		epCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: spr_slash,
		effectOnTarget: MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = irandom_range(10,15);
			BattleChangeHP(_targets[0], -_damage);
			BattleChangeEP(_user, -epCost)
		}		
	},
	potion : 
	{
		name : "Potion",
		description : "{0} uses a Potion!",
		subMenu : "Item",
		targetRequired: true,
		targetEnemyByDefault: false, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		func : function(_user, _targets)
		{
			var _heal = 30;
			BattleChangeHP(_targets[0], _heal);
		}		
	},
	ether : 
	{
		name : "Ether",
		description : "{0} uses an Ether!",
		subMenu : "Item",
		targetEnemyByDefault: false, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		targetRequired: true,
		func : function(_user, _targets)
		{
			var _healEP = 50;
			BattleChangeEP(_targets[0], _healEP, true);
		}		
	},
	revive : 
	{
		name : "Revive",
		description : "{0} uses a Revive!",
		subMenu : "Item",
		targetEnemyByDefault: false, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		targetRequired: true,
		func : function(_user, _targets)
		{
			var _heal = 30;
			BattleChangeHP(_targets[0], _heal, 1);
		}		
	}
}

//Party Data
global.party =
[
	{
		name: "Hashimoto Sobu",
		hp: 70,
		hpMax: 80,
		ep: 30,
		epMax: 30,
		STR: 7,
		INT: 5,
		CON: 6,
		SPD: 4,
		sprites : { idle: spr_pIdle, strike: spr_pStrike, Aura: spr_pAura, defend: spr_pDefend, item: spr_pItem, down: spr_pDown },
		actions : [global.actionLibrary.strike, global.actionLibrary.defend, global.actionLibrary.escape, global.actionLibrary.ice]
	}
];

//Enemy Data
global.enemies =
{
	slimeG: 
	{
		name: "Green Slime",
		hp: 1,
		hpMax: 30,
		ep: 0,
		epMax: 0,
		STR: 5,
		sprites: { idle: spr_slime_idle, strike: spr_slime_strike },
		actions: [global.actionLibrary.strike],
		xpValue : 15,
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(obj_battle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
}

//Inventory
global.inventory =
[
	[global.actionLibrary.potion, 4],
	[global.actionLibrary.revive, 2],
	[global.actionLibrary.ether, 1],
]