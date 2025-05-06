function filter_equippable_items(_class, _slot) {
    var result = [];

    if (!is_array(global.inventory)) return result;

    for (var i = 0; i < array_length(global.inventory); i++) {
        var item = global.inventory[i];

        if (item.equip && item.equipType == _slot && item.class == _class) {
            array_push(result, item);
        }
    }

    return result;
}

function equip_item_to_party_member(member_index, item) {
    if (!is_struct(item) || !variable_struct_exists(item, "equipType")) {
        show_debug_message("Tried to equip an invalid item.");
        return;
    }

    var slot = string_lower(item.equipType); // "Weapon" → "weapon"
    var member = global.party[member_index];

    if (slot == "head") {
        member.equipment.head = item;
    } else if (slot == "body") {
        member.equipment.body = item;
    } else if (slot == "weapon") {
        member.equipment.weapon = item;
    }

    global.party[member_index] = member;
	
	calc_derived_stats(global.party[member_index]);
	
	// **NEW** recalc their actions array
    refresh_actions(member);

    // and write BACK if you need to
    global.party[member_index] = member;
}