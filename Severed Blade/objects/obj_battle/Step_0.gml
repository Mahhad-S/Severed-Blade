//Run state machine
battleState();

//Cursor control
if (cursor.active)
{
	with (cursor)
	{
		//input
		var _keyUP = keyboard_check_pressed(vk_up);
		var _keyDown = keyboard_check_pressed(vk_down);
		var _keyLeft = keyboard_check_pressed(vk_left);
		var _keyRight = keyboard_check_pressed(vk_right);
		var _keyToggle = false;
		var _keyConfirm = false;
		var _keyCancel = false;
		confirmDelay++
		if (confirmDelay > 1)
		{
			_keyConfirm = keyboard_check_pressed(vk_enter);
			_keyCancel = keyboard_check_pressed(vk_escape);
			_keyToggle = keyboard_check_pressed(vk_shift);
		}
		var _moveH = _keyRight - _keyLeft;
		var _moveV = _keyDown - _keyUP;
		
		if (_moveH == -1) targetSide = obj_battle.partyUnits;
		if (_moveH == 1) targetSide = obj_battle.enemyUnits;
		
		//verify target list
		if (targetSide == obj_battle.enemyUnits)
		{
			targetSide = array_filter(targetSide, function(_element, _index)
			{
				return _element.hp > 0;
			});
		}
		
		//move between targets
		if(targetAll == false) //single target mode
		{
			if (_moveV == -1) targetIndex++;
			if (_moveV == 1) targetIndex--;
			
			//wrap
			var _targets = array_length(targetSide);
			if (targetIndex < 0) targetIndex = _targets -1;
			if (targetIndex > (_targets - 1)) targetIndex = 0;
			
			//identify target
			activeTarget = targetSide[targetIndex];
			
			//togle all mode
			if (activeAction.targetAll == MODE.VARIES) && (_keyToggle) //switch yo all mode
			{
				targetAll = true;
			}
		}
		else //target all mode
		{
			activeTarget = targetSide;
			if (activeAction.targetAll == MODE.VARIES) && (_keyToggle) //switch yo single mode
			{
				targetAll = false;
			}
		}
		
		//Confirm action
		if (_keyConfirm)
		{
			with (obj_battle) BeginAction(cursor.activeUser, cursor.activeAction, cursor.activeTarget);
			with (obj_Menu) instance_destroy();
			active = false;
			confirmDelay = 0;
		}
		
		//Cancel & return to menu
		if (_keyCancel) && (!_keyConfirm)
		{
			with (obj_Menu) active = true;
			active = false;
			confirmDelay = 0;
		}
	}
}