// helper to fill in secondary stats
function calc_derived_stats(member) {
    // Max HP = base_HP × (2 + (CON/10))
    member.hpMax = floor( global.base_HP * (2 + (member.CON / 10)) );
    member.hp    = member.hpMax;
    // Max EP = base_EP × (1 + ((2×INT)/10))
    member.epMax = floor( global.base_EP * (1 + ((2 * member.INT) / 10)) );
    member.ep    = member.epMax;
    // Base ATK/DEF
    member.ATK = member.STR * 2;
    member.DEF = member.CON * 2;

    // Weapon bonus to ATK
    if (is_struct(member.equipment.weapon) 
      && variable_struct_exists(member.equipment.weapon, "atkStat")) {
        member.ATK += member.equipment.weapon.atkStat;
    }

    // Head armor bonus to DEF
    if (is_struct(member.equipment.head) 
      && variable_struct_exists(member.equipment.head, "defStat")) {
        member.DEF += member.equipment.head.defStat;
    }

    // Body armor bonus to DEF
    if (is_struct(member.equipment.body) 
      && variable_struct_exists(member.equipment.body, "defStat")) {
        member.DEF += member.equipment.body.defStat;
    }
}

/// Builds member.actions based on their equipped weapon + all non-attack moves.
function refresh_actions(member) {
    // start with an empty array
    var list = [];

    // grab all the keys in global.actionLibrary
    var names = variable_struct_get_names(global.actionLibrary);

	// if you have a weapon with an atkType, only pull matching actions
    var wpn = member.equipment.weapon;
    if (is_struct(wpn) && variable_struct_exists(wpn, "atkType")) {
        var wtype = wpn.atkType;
        for (var i = 0; i < array_length(names); i++) {
            var key = names[i];
            var act = variable_struct_get(global.actionLibrary, key);
            if (variable_struct_exists(act, "atkType") && act.atkType == wtype) {
                array_push(list, act);
            }
        }
    }
    else {
        // no weapon → default only Strike
        array_push(list, global.actionLibrary.strike);
    }

    for (var i = 0; i < array_length(names); i++) {
        var key = names[i];
        var act = variable_struct_get(global.actionLibrary, key);
        if (!variable_struct_exists(act, "atkType")) {
            array_push(list, act);
        }
    }

    member.actions = list;
}

function award_xp(_enemies) {
    // Sum all XP from the defeated enemies
    var totalXP = 0;
    for (var e = 0; e < array_length(_enemies); e++) {
        totalXP += _enemies[e].xpValue;
    }

    // Distribute to each surviving member
    for (var i = 0; i < array_length(global.party); i++) {
        var member = global.party[i];
        // only award to those still standing
        if (member.hp > 0) {
            member.currentXP += totalXP;

            //  Handle as many level-ups as necessary
            while (member.currentXP >= member.xpNeededToLevelUp) {
                member.currentXP -= member.xpNeededToLevelUp;
                member.Level += 1;
                // bump core stats
                member.STR += 1;
                member.INT += 1;
                member.CON += 1;
                member.SPD += 1;
                // make the next level a bit harder
                member.xpNeededToLevelUp = ceil(member.xpNeededToLevelUp * 1.2);
                // recompute HP/EP/ATK/DEF after stat bumps
                calc_derived_stats(member);
            }
        }

        // Save back to the party array
        global.party[i] = member;
    }
}