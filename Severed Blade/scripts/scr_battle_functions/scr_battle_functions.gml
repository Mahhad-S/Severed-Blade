function NewEncounter(_enemies, _bg)
{
	instance_create_depth(
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]),
		-9999,obj_battle,
		{ enemies: _enemies, creator: id, battleBackground: _bg}
	);
}

function BattleChangeHP(_target, _amount, _livingCheck = 0)
{
		//_livingCheck: 0 = alive only, 1 = dead only, 2 = any
		var _failed = false;
		if (_livingCheck == 0) && (_target.hp <= 0) _failed = true;
		if (_livingCheck == 1) && (_target.hp > 0) _failed = true;
	
		var _col = c_white;
		if (_amount > 0) _col = c_lime;
		if (_failed) 
		{
			_col = c_white;
			_amount = "failed";
		}
		instance_create_depth(_target.x,_target.y,_target.depth-1, obj_battle_floatingText, {font: f_text_battle, col: _col, text: string(_amount)})
		if (!_failed) _target.hp = clamp(_target.hp + _amount, 0, _target.hpMax);
}

function BattleChangeEP(_target, _amount, _show = false)
{
	if (_show) instance_create_depth(_target.x,_target.y,_target.depth-1, obj_battle_floatingText, {font: f_text_battle, col: c_aqua, text: string(_amount) + "ep"})
	_target.ep = clamp(_target.ep + _amount, 0, _target.epMax);
}

//After picking an action, confirm any targets or options and then continue
function MenuSelectAction(_user, _action)
{
	//make menu inactive
	with (obj_Menu) active = false;
	
	with (obj_battle)
	{
		if (_action.targetRequired)
		{
			with (targetCursor)
			{
				cursorAction = _action;
				cursorAll = _action.targetAll;
				if (cursorAll == MODE.VARIES) cursorAll = 1; //"toggle" starts as all by default
				cursorUser = _user;
				cursorActive = true;
				if (_action.targetEnemyByDefault) //cursorTarget enemy by default
				{
					cursorIndex = 0;
					cursorSide = obj_battle.enemyUnits;
					cursorTarget = obj_battle.enemyUnits[cursorIndex];
				}
				else //cursorTarget self by default
				{
					cursorSide = obj_battle.partyUnits;
					cursorTarget = cursorUser;
					var _findSelf = function(_element, _user)
					{
						return (_element == cursorTarget)	
					}
					cursorIndex = array_find_index(obj_battle.partyUnits, _findSelf);
				}
			}
		}
		else
		{
			with (obj_Menu) instance_destroy();
			BeginAction(_user,_action,-1)
		}
	}
}

function IsActionAvailable(_unit, _action)
{
	
	if (variable_struct_exists(_action, "epCost"))
	{
		if (_unit.ep >= _action.epCost) return true;	
	}
	else
	{
		return true;
	}
	return false;
}

function RemoveItemFromInventory(item_to_use)
{
	// Loop through the inventory
    for (var i = 0; i < array_length(global.inventory); i++) {
        var item = global.inventory[i];
        
        // Match the item (you could match by id, name, or instance equality)
        if (item != undefined && item == item_to_use) 
			{
                array_delete(global.inventory, i, 1);
            }
            
        break;
	}
}

function SaveGlobalValuesTemp() {
	for (var i = 0; i < array_length(global.party); i++)
			{
				if (i < array_length(partyUnits) && instance_exists(partyUnits[i])) {
					global.party[i].hp = partyUnits[i].hp;
					global.party[i].ep = partyUnits[i].ep;
				}
			}
}