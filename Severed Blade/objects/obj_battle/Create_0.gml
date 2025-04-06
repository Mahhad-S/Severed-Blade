instance_deactivate_all(true);

units = [];
turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];

turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 30;
battleWaitTimeRemaining = 0;
currentUser = noone;
currentAction = -1;
currentTargets = noone;

//Make Enemies
for (var i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x+230+(i*10), y+68+(i*20), depth-10, obj_battle_unit_enemy, enemies[i]);
	array_push(units, enemyUnits[i]);
}

//Make party
for (var i = 0; i < array_length(global.party); i++)
{
	partyUnits[i] = instance_create_depth(x+60+(i*10), y+68+(i*15), depth-10, obj_battle_unit_pc, global.party[i]);
	array_push(units, partyUnits[i]);
}


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

function BattleStateSelectAction()
{
	//Get curr unit
	var _unit = unitTurnOrder[turn];
	
	//is the unit dead or unable to act?
	if (!instance_exists(_unit)) || (_unit.hp <= 0)
	{
		battleState = BattleStateVictoryCheck;
		exit;
	}
	
	//Select an action to perform
	BeginAction(_unit.id, global.actionLibrary.attack, _unit.id);
}

function BeginAction(_user, _action, _targets)
{
	currentUser = _user;
	currentAction = _action;
	currentTargets = _targets;
	if (!is_array(currentTargets)) currentTargets = [currentTargets];
	battleWaitTimeRemaining = battleWaitTimeFrames;
	with (_user)
	{
		acting = true;
		//play user animation if it is defined for that action, and that user
		if (!is_undefined(_action[$ "userAnimation"])) && (!is_undefined(_user.sprites[$ _action.userAnimation]))
		{
			sprite_index = sprites[$ _action.userAnimation];
			image_index = 0;
		}
	}
	battleState =  BattleStatePerformAction;
}

function BattleStatePerformAction()
{
	//if animation
}

function BattleStateVictoryCheck()
{
	
}

function BattleStateTurnProgression()
{
	
}

battleState = BattleStateSelectAction;