// create event for obj_battle

//Transition setup
transitionProg = 0;
surfTransition = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
surface_copy(surfTransition,0,0,application_surface);
instance_deactivate_all(true);

//Battle setup
battleWaitForMenu = false
battleWaitTimeFrames = 45; //time to wait before finishing an action or turn
battleWaitTimeRemaining = 0;
battleText = "";
battleEndMessageProg = 0;
battleEndMessages = [];
battleXpGained = 0;
conclusionType = -1;
escaped = false;
turn = 0;
turnCount = 0;
roundCount = 0;
units = [];
unitTurnOrder = [];
unitRenderOrder = [];
unitDepth = depth-10;

//Make party
for (var i = 0; i < array_length(global.party); i++)
{
	partyUnits[i] = instance_create_depth(x+70+(i*10), y+55+(i*15), unitDepth, obj_battle_unit_pc, global.party[i]);
	array_push(units, partyUnits[i]);
}

//Make Enemies
for (var i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x+230+((i mod 3)*10)+((i div 3)*25),y+71+((i mod 3)*20), unitDepth, obj_battle_unit_enemy, enemies[i]);
	array_push(units, enemyUnits[i]);
}

//Make cursorTarget cursor
targetCursor = 
{
	cursorUser: noone,
	cursorTarget: noone,
	cursorAction : -1,
	cursorSide : -1, 
	cursorIndex : 0,
	cursorError : false,
	cursorConfirmDelay : 0,
	cursorActive : false,
	cursorAll : 0 //0: single, 1: all
};

//Shuffle turn order
unitTurnOrder = array_shuffle(units);

//Get render order
RefreshRenderOrder = function()
{
	unitRenderOrder = [];
	array_copy(unitRenderOrder, 0, units, 0, array_length(units));
	array_sort(unitRenderOrder, function(_1,_2)
	{
		return _1.y - _2.y;
	});
}
RefreshRenderOrder();

//Start a unit action
function BeginAction(_user, _action, _targets)
{
	battleState = BattleStatePerformAction;
	currentUser = _user;
	currentAction = _action;
	currentTargets = _targets;
	if (!is_array(currentTargets)) currentTargets = [currentTargets];
	battleText = string_ext(_action.description,[_user.name]);
	battleWaitTimeRemaining = battleWaitTimeFrames;
	with (_user)
	{
		acting = true;
		//consume item if needed
		if (_action.subMenu == "Item") RemoveItemFromInventory(_action, 1)
		//play user animation if it is defined for that action, and that user
		if  (!is_undefined(_action[$ "userAnimation"])) && (!is_undefined(_user.sprites[$ _action.userAnimation]))
		{
			sprite_index = sprites[$ _action.userAnimation];
			image_index = 0;
		}
	}
}

function BattleStateSelectAction()
{
	if (!instance_exists(obj_Menu))
	{
		//Get curr unit
		var _unit = unitTurnOrder[turn]
		
		//Is this unit alive and able to act?
		if (instance_exists(_unit)) && (_unit.hp > 0)
		{
			//Reset any one turn effects
			_unit.defending = false;
		
			//Player
			if (_unit.enemy == false)
			{
				//Compile the action menu
				var _menuOptions = [];
				var _subMenus = {};
				
				//add inventory to action list
				var consumable_list = [];
				for (var i = 0; i < array_length(global.inventory); i++) 
				{
					var item = global.inventory[i];
					if (item != undefined && item.consumable)
					{
						array_push(consumable_list, item);
					}
				}
				
				var _actionList = array_union(_unit.actions, consumable_list);
				
				for (var i = 0; i < array_length(_actionList); i++)
				{
					var _action = _actionList[i]
					var _available = IsActionAvailable(_unit,_action);
					//Add item count to option name if necessary
					var _name = _action.name;
					//add top level action
					if (_action.subMenu == -1) array_push(_menuOptions,[_name, MenuSelectAction, [_unit, _action], _available]);
					else 
					{
						//create or add to a submenu
						if (is_undefined(_subMenus[$ _action.subMenu]))
						{
							variable_struct_set(_subMenus, _action.subMenu, [[_name, MenuSelectAction, [_unit, _action], _available]]);
						}				
						else
						{
							array_push(_subMenus[$ _action.subMenu],[_name, MenuSelectAction, [_unit, _action], _available]);
						}
					}
				}
				
				//turn sub menus into an array
				var _subMenusArray = variable_struct_get_names(_subMenus);
				for (var i = 0; i < array_length(_subMenusArray); i++)
				{
					//sort submenu if needed
					//(here)
					
					//add back option at end of each submenu
					array_push( _subMenus[$ _subMenusArray[i]] , ["Back", MenuGoBack, -1, true]);
					//add submenu into main menu
					array_push(_menuOptions, [_subMenusArray[i], SubMenu, [_subMenus[$ _subMenusArray[i]]], true]);
				}
				
				//sort top level menu
				array_sort(_menuOptions, function(_a, _b)
				{
					var _Priority = function(_option)
					{
						if (_option[0] == "Attack") return 99;
						if (_option[0] == "Magic") return 50;
						if (_option[0] == "Defend") return 30;
						if (_option[0] == "Item") return -10;
						if (_option[0] == "Escape") return -15;
						return 0;
					}
					return _Priority(_b) - _Priority(_a);
				});
					
				Menu(x+10,y+110,_menuOptions,,74,60)
			}
			else //Enemy
			{
				//run ai script for that enemy
				var _enemyAction = _unit.AIscript();
				if (_enemyAction != -1) BeginAction(_unit.id, _enemyAction[0], _enemyAction[1]); 
			}
		}
		else
		{
			battleState = BattleStateTurnProgression;
		}
	}
}

function BattleStatePerformAction()
{
	//if animation etc is still playing
	if (currentUser.acting)
	{
		//when it ends, perform action effect if it exists
		if (currentUser.image_index >= currentUser.image_number -1)
		{
			with (currentUser)
			{
				sprite_index = sprites.idle;
				image_index = 0;
				acting = false;
			}
			
			if (variable_struct_exists(currentAction, "effectSprite"))
			{
				if (currentAction.effectOnTarget == MODE.ALWAYS) || ( (currentAction.effectOnTarget == MODE.VARIES) && (array_length(currentTargets) <= 1) )
				{
					for (var i = 0; i < array_length(currentTargets); i++)
					{
						instance_create_depth(currentTargets[i].x-25,currentTargets[i].y-20,currentTargets[i].depth-1,obj_battle_effect,{sprite_index : currentAction.effectSprite});	
					}
				}
				else //play it at 0,0
				{
					var _effectSprite = currentAction.effectSprite
					if (variable_struct_exists(currentAction, "effectSpriteNoTarget")) _effectSprite = currentAction.effectSpriteNoTarget;
					instance_create_depth(x,y,depth-100,obj_battle_effect,{sprite_index : _effectSprite});	
				}
				
			}
			currentAction.func(currentUser, currentTargets);
		}
	} 
	else //wait for delay and then end the turn
	{
		if (!instance_exists(obj_battle_effect))
		{
			battleWaitTimeRemaining--
			if (battleWaitTimeRemaining == 0)
			{
				battleState = BattleStateVictoryCheck;
			}
		}
	}
}

function BattleStateVictoryCheck()
{
	//Is the battle over?
	var _endTheBattle = false;
	var _noEnemiesAlive = !array_any(enemyUnits, function(_unit)
	{
		return (_unit.hp > 0);
	});
	
	var _noPartyAlive = !array_any(partyUnits, function(_unit)
	{
		return (_unit.hp > 0);
	});
	
	//Player lose overrides win
	//Lose check
	if (_noPartyAlive)
	{
		_endTheBattle = true;
		conclusionType = 0;
		battleEndMessages[0] = "All party members defeated!";
		battleEndMessages[1] = "Game over...";
	}
	else
	{
		//Win check
		if (_noEnemiesAlive)
		{
			conclusionType = 1;
			_endTheBattle = true;
			battleEndMessages[0] = "Victory!!";
			for (var i = 0; i < array_length(enemyUnits); i++)
			{
				battleXpGained += enemyUnits[i].xpValue;
			}
			award_xp(enemyUnits);
			battleEndMessages[1] = string("Gained {0} experience points", battleXpGained);
		}
	}
	
	//Escaped
	if (escaped)
	{
		conclusionType = 2;
		_endTheBattle = true;
		battleEndMessages[0] = "Escaped!"
		battleEndMessages[1] = "No experience gained."
	}
	
	battleState = _endTheBattle ? BattleStateEnding : BattleStateTurnProgression;
}

function BattleStateTurnProgression()
{
	turnCount++; //total turns
	turn++;
	//Loop turns
	if (turn > array_length(unitTurnOrder) - 1) 
	{
			turn = 0;
			roundCount++;	
	}
	battleText = "";
	battleState = BattleStateSelectAction;
}

function BattleStateEnding()
{
	if (keyboard_check_pressed(vk_space)) battleEndMessageProg++;
	if (battleEndMessageProg >= array_length(battleEndMessages))
	{
		transitionProg -= 0.01;
		if (transitionProg <= 0.0)
		{
			SaveGlobalValuesTemp();
			instance_destroy();
		}
	}
	else
	{
		battleText = battleEndMessages[battleEndMessageProg];
	}
}

function BattleStateBegin()
{
	transitionProg += 0.01;
	if (transitionProg >= 1.0)
	{
		transitionProg = 1.0;
		battleState = BattleStateSelectAction;
	}
}

battleState = BattleStateBegin;