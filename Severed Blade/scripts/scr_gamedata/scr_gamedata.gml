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
		elementType: -1,
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
		elementType: -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "strike",
		effectSprite: spr_slash,
		effectOnTarget: MODE.ALWAYS,
		func: function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++) {
		        var targ = _targets[i];

		        // roll base damage off STR
		        var base = ceil(
		            _user.STR +
		            random_range(-_user.STR * 0.25, _user.STR * 0.25)
		        );

		        // add weapon atkStat if equipped
		        if (_user.equipment.weapon != -1) {
		            base += _user.equipment.weapon.atkStat;
		        }

		        // physical modifier from equipped weapon’s atkType
		        var physMod = 1;
				if (_user.equipment.weapon != -1) {
				    var w = _user.equipment.weapon;
				    physMod = getPhysMod(w.atkType, targ.armorClass);
				}

		        // elemental modifier
				var elemMod = 1;
				if (self.elementType != -1) elemMod = getElemMod(self.elementType, targ.elementType);

		        // compute & apply final damage
		        var dmg = round(base * physMod * elemMod);
		        BattleChangeHP(targ, -dmg, 0);
			}
		}
	},
	cleave:
	{
		name: "Cleave",
		atkType: "Slash",
		description: "{0} cleaves!",
		subMenu: "Attack",
		elementType: -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.ALWAYS,
		userAnimation: "strike",
		effectSprite: spr_slash,
		effectOnTarget: MODE.ALWAYS,
		func: function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++) {
		        var targ = _targets[i];

		        // roll base damage off STR
		        var base = ceil(
		            _user.STR +
		            random_range(-_user.STR * 0.25, _user.STR * 0.25)
		        );

		        // add weapon atkStat if equipped
		        if (_user.equipment.weapon != -1) {
		            base += _user.equipment.weapon.atkStat;
		        }

		        // physical modifier from equipped weapon’s atkType
		        var physMod = 1;
				if (_user.equipment.weapon != -1) {
				    var w = _user.equipment.weapon;
				    physMod = getPhysMod(w.atkType, targ.armorClass);
				}

		        // elemental modifier (unchanged)
				var elemMod = 1;
				if (self.elementType != -1) elemMod = getElemMod(self.elementType, targ.elementType);

		        // compute & apply final damage
		        var dmg = round(base * physMod * elemMod);
		        BattleChangeHP(targ, -dmg, 0);
			}
		} 
	},
	stab:
	{
		name: "Stab",
		atkType: "Pierce",
		description: "{0} stabs!",
		subMenu: "Attack",
		elementType: -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "strike",
		effectSprite: spr_slash,
		effectOnTarget: MODE.ALWAYS,
		func: function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++) {
		        var targ = _targets[i];

		        // roll base damage off STR
		        var base = ceil(
		            _user.STR +
		            random_range(-_user.STR * 0.25, _user.STR * 0.25)
		        );

		        // add weapon atkStat if equipped
		        if (_user.equipment.weapon != -1) {
		            base += _user.equipment.weapon.atkStat;
		        }

		        // physical modifier from equipped weapon’s atkType
		        var physMod = 1;
				if (_user.equipment.weapon != -1) {
				    var w = _user.equipment.weapon;
				    physMod = getPhysMod(w.atkType, targ.armorClass);
				}

		        // elemental modifier
				var elemMod = 1;
				if (self.elementType != -1) elemMod = getElemMod(self.elementType, targ.elementType);

		        // compute & apply final damage
		        var dmg = round(base * physMod * elemMod);
		        BattleChangeHP(targ, -dmg, 0);
			}
		},
	},
	smash:
	{
		name: "Smash",
		atkType: "Bludgeon",
		description: "{0} smashes!",
		subMenu: "Attack",
		elementType: -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "strike",
		effectSprite: spr_slash,
		effectOnTarget: MODE.ALWAYS,
		func: function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++) {
		        var targ = _targets[i];

		        // roll base damage off STR
		        var base = ceil(
		            _user.STR +
		            random_range(-_user.STR * 0.25, _user.STR * 0.25)
		        );

		        // add weapon atkStat if equipped
		        if (_user.equipment.weapon != -1) {
		            base += _user.equipment.weapon.atkStat;
		        }

		        // physical modifier from equipped weapon’s atkType
		        var physMod = 1;
				if (_user.equipment.weapon != -1) {
				    var w = _user.equipment.weapon;
				    physMod = getPhysMod(w.atkType, targ.armorClass);
				}

		        // elemental modifier
				var elemMod = 1;
				if (self.elementType != -1) elemMod = getElemMod(self.elementType, targ.elementType);

		        // compute & apply final damage
		        var dmg = round(base * physMod * elemMod);
		        BattleChangeHP(targ, -dmg, 0);
			}
		},
	},
	pound:
	{
		name: "Pound",
		atkType: "Bludgeon",
		description: "{0} pounds!",
		subMenu: "Attack",
		elementType: -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.ALWAYS,
		userAnimation: "strike",
		effectSprite: spr_slash,
		effectOnTarget: MODE.ALWAYS,
		func: function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++) {
		        var targ = _targets[i];

		        // roll base damage off STR
		        var base = ceil(
		            _user.STR +
		            random_range(-_user.STR * 0.25, _user.STR * 0.25)
		        );

		        // add weapon atkStat if equipped
		        if (_user.equipment.weapon != -1) {
		            base += _user.equipment.weapon.atkStat;
		        }

		        // physical modifier from equipped weapon’s atkType
		        var physMod = 1;
				if (_user.equipment.weapon != -1) {
				    var w = _user.equipment.weapon;
				    physMod = getPhysMod(w.atkType, targ.armorClass);
				}

		        // elemental modifier
				var elemMod = 1;
				if (self.elementType != -1) elemMod = getElemMod(self.elementType, targ.elementType);

		        // compute & apply final damage
		        var dmg = round(base * physMod * elemMod);
		        BattleChangeHP(targ, -dmg, 0);
		    }
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
	raigeki : 
	{
		name : "Raigeki",
		description : "{0} channels Raigeki!",
		class: "Samurai",
		subMenu : "Magic",
		elementType: "Ignis",
		epCost : 6,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: spr_slash,
		effectOnTarget: MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++) {
		        var targ = _targets[i];

		        // roll base damage off STR
		        var base = ceil(
		            _user.STR +
		            random_range(-_user.STR * 0.25, _user.STR * 0.25)
		        );

		        // add weapon atkStat if equipped
		        if (_user.equipment.weapon != -1) {
		            base += _user.equipment.weapon.atkStat;
		        }

		        // physical modifier from equipped weapon’s atkType
		        var physMod = 1;
				if (_user.equipment.weapon != -1) {
				    var w = _user.equipment.weapon;
				    physMod = getPhysMod(w.atkType, targ.armorClass);
				}

		        // elemental modifier (unchanged)
				var elemMod = 1;
				if (self.elementType != -1) elemMod = getElemMod(self.elementType, targ.elementType);

		        // compute & apply final damage
		        var dmg = round(base * physMod * elemMod);
		        BattleChangeHP(targ, -dmg, 0);
		    }
			BattleChangeEP(_user, -epCost)
		}		
	},
}

// Base Values for Stats
global.base_HP = 50;
global.base_EP = 15;

//Party Data
global.party =
[
	{
		name: "Hashimoto Sobu",
		class: "Samurai",
		elementType: "Ignis",
		Level: 1,
		currentXP: 0,
		xpNeededToLevelUp: 50,
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
		actions : [global.actionLibrary.strike, global.actionLibrary.defend, global.actionLibrary.escape, global.actionLibrary.raigeki]
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
		name: "Ventus Slime",
		elementType: "Ventus",
		armorClass: "Light",
		hp: 30,
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
	ignisSlime: 
	{
		name: "Ignis Slime",
		elementType: "Ignis",
		armorClass: "Light",
		hp: 30,
		hpMax: 30,
		ep: 0,
		epMax: 0,
		STR: 5,
		sprites: { idle: spr_ignis_slime_idle, strike: spr_ignis_slime_strike },
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
	aquaSlime: 
	{
		name: "Aqua Slime",
		elementType: "Aqua",
		armorClass: "Light",
		hp: 30,
		hpMax: 30,
		ep: 0,
		epMax: 0,
		STR: 5,
		sprites: { idle: spr_aqua_slime_idle, strike: spr_aqua_slime_strike },
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
	terraSlime: 
	{
		name: "Terra Slime",
		elementType: "Terra",
		armorClass: "Light",
		hp: 30,
		hpMax: 30,
		ep: 0,
		epMax: 0,
		STR: 5,
		sprites: { idle: spr_terra_slime_idle, strike: spr_terra_slime_strike },
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
	luxSlime: 
	{
		name: "Lux Slime",
		elementType: "Lux",
		armorClass: "Light",
		hp: 30,
		hpMax: 30,
		ep: 0,
		epMax: 0,
		STR: 5,
		sprites: { idle: spr_lux_slime_idle, strike: spr_lux_slime_strike },
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
	umbraSlime: 
	{
		name: "Umbra Slime",
		elementType: "Umbra",
		armorClass: "Light",
		hp: 30,
		hpMax: 30,
		ep: 0,
		epMax: 0,
		STR: 5,
		sprites: { idle: spr_umbra_slime_idle, strike: spr_umbra_slime_strike },
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
		elementType: "Terra",
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