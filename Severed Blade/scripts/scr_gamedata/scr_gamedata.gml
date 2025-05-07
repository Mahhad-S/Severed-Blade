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
		atkType: -1,
		description: "{0} strikes!",
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
	cut:
	{
		name: "Cut",
		atkType: "Slash",
		description: "{0} slashes!",
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
	stab:
	{
		name: "Stab",
		atkType: "Pierce",
		description: "{0} pierces!",
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
	smash:
	{
		name: "Smash",
		atkType: "Bludgeon",
		description: "{0} bludgeons!",
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
}

// Base Values for Stats
global.base_HP = 50;
global.base_EP = 25;

//Party Data
global.party =
[
	{
		name: "Hashimoto Sobu",
		class: "Samurai",
		Level: 1,
		STR: 8,
		INT: 5,
		CON: 6,
		SPD: 6,
		equipment : {
		    head: -1,
		    body: -1,
		    weapon: -1
		},
		sprites : { idle: spr_pIdle, strike: spr_pStrike, Aura: spr_pAura, defend: spr_pDefend, item: spr_pItem, down: spr_pDown },
		actions : [global.actionLibrary.strike, global.actionLibrary.defend, global.actionLibrary.escape, global.actionLibrary.ice]
	}
];

// run function to refresh stats over entire party
var cnt = array_length(global.party);
for (var i = 0; i < cnt; i++) {
    calc_derived_stats(global.party[i]);
}

for (var i = 0; i < array_length(global.party); i++) {
    var pm = global.party[i];
    calc_derived_stats(pm);
    refresh_actions(pm);
    global.party[i] = pm;
}

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
	},
	ogre:
	{
		name: "Ogre",
		hp: 100,
		hpMax: 100,
		ep: 40,
		epMax: 40,
		STR: 10,
		sprites: { idle: spr_ogre_idle, strike: spr_ogre_attack },
		actions: [global.actionLibrary.strike],
		xpValue : 150,
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