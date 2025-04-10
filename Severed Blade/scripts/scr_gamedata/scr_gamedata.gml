//Action Library
global.actionLibrary =
{
	strike:
	{
		name: "Strike",
		description: "{0} attacks!",
		subMenu: -1,
		targetRequired: true,
		tergetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "strike",
		effectSprite: spr_slash,
		effectOnTarget: MODE.ALWAYS,
		func: function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
			BattleChangeHP(_targets[0], -_damage, 0);
		}
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
		sprites : { idle: spr_pIdle, strike: spr_pStrike, Aura: spr_pAura, defend: spr_pDefend, item: spr_pItem, down: spr_pDown },
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
		sprites: { idle: spr_slime_idle, strike: spr_slime_strike },
		actions: [global.actionLibrary.strike],
		xpValue : 15,
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(obj_battle.partyUnits, function(_unit, index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
}
