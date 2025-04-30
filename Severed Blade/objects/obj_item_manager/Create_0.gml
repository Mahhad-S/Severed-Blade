// create event for obj_item_manager

/// @desc Create all items and inventory

depth = -9999;

//create the items

global.item_list =	
	{
		
	// **consumable items**
	attack_up_potion : 
		{
	
		name: "Attack Up Potion",
		itemDescription: "A bright red colored potion in a slim bottle. Raises attack by 10%",
		consumable: true,
		equip: false,
		icon: spr_attack_up_potion,
	
		},
	camping_set : 
		{
	
		name: "Camping Set",
		itemDescription: "Everything you need to camp out in the wilderness! Recovers 30% of HP and EP for the party when used",
		consumable: true,
		equip: false,
		icon: spr_camping_set,
	
		},
	defense_up_potion : 
		{
	
		name: "Defense Up Potion",
		itemDescription: "A bright green colored potion in a slim bottle. Raises defense by 10%",
		consumable: true,
		equip: false,
		icon: spr_defense_up_potion,
	
		},
	dropped_item : 
		{
	
		name: "",
		itemDescription: "",
		consumable: false,
		equip: false,
		icon: spr_dropped_item,
	
		},
	gold_bag :
		{
	
		name: "Bag of Gold",
		itemDescription: "A bag of gold, open it to find out how much gold is inside!",
		consumable: false,
		equip: false,
		icon: spr_gold_bag,
	
		},
	minor_ep_potion : 
		{
	
		name: "Minor Potion of EP",
		itemDescription: "A dull blue colored potion diluted in water. Restores 20% of total EP",
		consumable: true,
		equip: false,
		description : "{0} uses a Minor Potion of EP!",
		icon: spr_minor_ep_potion,
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
	standard_ep_potion : 
		{
	
		name: "Standard Potion of EP",
		itemDescription: "A blue colored potion. Restores 40% of total EP",
		consumable: true,
		equip: false,
		icon: spr_standard_ep_potion,
	
		},
	major_ep_potion : 
		{
	
		name: "Major Potion of EP",
		itemDescription: "A bright blue potion in a large bottle. Restores 60% of total EP",
		consumable: true,
		equip: false,
		icon: spr_major_ep_potion,
	
		},
	minor_hp_potion : 
		{
	
		name: "Minor Potion of HP",
		itemDescription: "A dull red colored potion diluted in water. Restores 20% of total HP",
		description : "{0} uses a Minor Potion of HP!",
		consumable: true,
		equip: false,
		icon: spr_minor_hp_potion,
		subMenu : "Item",
		targetRequired: true,
		targetEnemyByDefault: false, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		battlefunc : function(_user, _targets)
			{
				var _heal = 30;
				BattleChangeHP(_targets[0], _heal);
			}	
	
		},
	standard_hp_potion : 
		{
	
		name: "Standard Potion of HP",
		itemDescription: "A red colored potion. Restores 40% of total HP",
		consumable: true,
		equip: false,
		icon: spr_standard_hp_potion,
	
		},
	major_hp_potion : 
		{
	
		name: "Major Potion of HP",
		itemDescription: "A bright red colored potion in a gold bottle. Restores 60% of total HP",
		consumable: true,
		equip: false,
		icon: spr_major_hp_potion,
	
		},
		
	revival_potion :
		{
		
		name: "Potion of Revival",
		itemDescription: "A potion capped with a heart shaped revival stone. Revives one party member",
		description : "{0} uses a Potion of Revival!",
		consumable: true,
		equip: false,
		icon: spr_revival_potion,
		subMenu : "Item",
		targetEnemyByDefault: false, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		targetRequired: true,
		func : function(_user, _targets)
			{
				var _heal = 30;
				BattleChangeHP(_targets[0], _heal, 1);
			}	
		
		},

	// **equipment items**
	aqua_staff : 
		{
	
		name: "Staff of Aqua Efficiency",
		itemDescription: "A blue staff adorned with an Aqua crystal at its tip. Increased Aqua Spell Power. Decreased Terra Spell Power",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Mage",
		icon: spr_aqua_staff,
	
		},
	ignis_staff  : 
		{
	
		name: "Staff of Ignis Efficiency",
		itemDescription: "A red staff adorned with an Ignis crystal at its tip. Increased Ignis Spell Power, Decreased Aqua Spell Power",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Mage",
		icon: spr_ignis_staff,
	
		},
	lux_staff  : 
		{
	
		name: "Staff of Lux Efficiency",
		itemDescription: "A gold staff adorned with a Lux crystal at its tip. Increased Lux Spell Power, Decreased Umbra Spell Power",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Mage",
		icon: spr_lux_staff,
	
		},
	staff  : 
		{
	
		name: "Basic Staff",
		itemDescription: "A basic wooden staff. Assists the user in casting spells",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Mage",
		icon: spr_staff,
	
		},
	terra_staff : 
		{
	
		name: "Staff of Terra Efficiency",
		itemDescription: "An amber staff adorned with a Terra crystal at its tip. Increased Terra Spell Power, Decreased Ventus Spell Power",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Mage",
		icon: spr_terra_staff,
	
		},
	umbra_staff : 
		{
	
		name: "Staff of Umbra Efficiency",
		itemDescription: "A grey staff adorned with an Umbra crystal at its tip. Increased Umbra Spell Power, Decreased Lux Spell Power",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Mage",
		icon: spr_umbra_staff,
	
		},
	ventus_staff : 
		{
	
		name: "Staff of Ventus Efficiency",
		itemDescription: "A green staff adorned with a Ventus crystal at its tip. Increased Ventus Spell Power, Decreased Ignis Spell Power",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Mage",
		icon: spr_ventus_staff,
	
		},
	bow : 
		{
	
		name: "Basic Bow",
		itemDescription: "A basic shitty bow, I don't even think it's worth using. God I hate bow users. you're better off selling this shit",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		icon: spr_bow,
	
		},
	elven_bow : 
		{
	
		name: "Elven Bow",
		itemDescription: "A beautiful ornate bow, made of silverwood and metal fittings, will not fail you",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		icon: spr_elven_bow,
	
		},
	dwarven_bow : 
		{
	
		name: "Dwarven Bow",
		itemDescription: "A bow made of strong, pure metal, with a string made of braided steel cable. Whatever you're shooting at will NOT be moving afterwards",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		icon: spr_dwarven_bow,
	
		},
	holy_sword : 
		{
	
		name: "Excalibur",
		itemDescription: "The Holy Sword Excalibur, King of all Blades. Made of an unknown material. He who draws this sword will rule the world",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Samurai",
		icon: spr_holy_sword,
	
		},
	katana : 
		{
	
		name: "Katana",
		itemDescription: "The sword left behind by the leader of the bandits who killed Sobu's family.",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Samurai",
		icon: spr_katana,
	
		},
	wakizashi : 
		{
	
		name: "Wakizashi",
		itemDescription: "A small, shortsword-like blade, forged in the same fashion as Sobu's Katana",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Samurai",
		icon: spr_wakizashi,
	
		},
	slayer_sword : 
		{
	
		name: "Bastard Sword",
		itemDescription: "A great behemoth of a blade. It takes a lot of GUTS to swing this",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Samurai",
		icon: spr_slayer_sword,
	
		},
	wooden_club : 
		{
	
		name: "Wooden Club",
		itemDescription: "A large somewhat long log of wood fashioned to look like a club",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Tank",
		icon: spr_wooden_club,
	
		},	
	mace : 
		{
	
		name: "Iron Mace",
		itemDescription: "A mass produced bludgeoning weapon for the army. Effective against heavy armor",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Tank",
		icon: spr_mace,
	
		},
	morning_star : 
		{
	
		name: "Morningstar",
		itemDescription: "Similar to a mace, reinforced with higher strength steel and increased mass. Heavy hitting and definitely lethal",
		consumable: false,
		equip: true,
		equipType: "Weapon",
		class: "Tank",
		icon: spr_morning_star,
	
		},
	samurai_light_head : 
		{
	
		name: "Thin Head Wrap",
		itemDescription: "A thin piece of cloth to be wrapped around the head",
		consumable: false,
		equip: true,
		equipType: "Head",
		class: "Samurai",
		icon: spr_samurai_light_head,
	
		},
	samurai_medium_head : 
		{
	
		name: "Thick Head Wrap",
		itemDescription: "A robust, thick piece of cloth to be wrapped around the head",
		consumable: false,
		equip: true,
		equipType: "Head",
		class: "Samurai",
		icon: spr_samurai_medium_head,
	
		},
	samurai_heavy_head : 
		{
	
		name: "Ronin's Helmet",
		itemDescription: "A sturdy helmet, typically worn by wandering Ronin who are walking their own path",
		consumable: false,
		equip: true,
		equipType: "Head",
		class: "Samurai",
		icon: spr_samurai_heavy_head,
	
		},
	samurai_light_body : 
		{
	
		name: "Cloth Tunic",
		itemDescription: "A simple base layer typically worn under armor",
		consumable: false,
		equip: true,
		equipType: "Body",
		class: "Samurai",
		icon: spr_samurai_light_body,
	
		},
	samurai_medium_body : 
		{
	
		name: "Domaru",
		itemDescription: "Armor worn for on foot battles by lower ranking samurai",
		consumable: false,
		equip: true,
		equipType: "Body",
		class: "Samurai",
		icon: spr_samurai_medium_body,
	
		},
	samurai_heavy_body : 
		{
	
		name: "O-Yoroi",
		itemDescription: "Large, overlapping boxy armor offering increased protection for samurai",
		consumable: false,
		equip: true,
		equipType: "Body",
		class: "Samurai",
		icon: spr_samurai_heavy_body,
	
		},
	mage_light_head : 
		{
	
		name: "Apprentice Mage Hat",
		itemDescription: "If you want to be a mage you have to dress for the part",
		consumable: false,
		equip: true,
		equipType: "Head",
		class: "Mage",
		icon: spr_mage_light_head,
	
		},
	mage_medium_head : 
		{
	
		name: "Novice Mage Hat",
		itemDescription: "The mark of an established mage who has learned more than a couple spells",
		consumable: false,
		equip: true,
		equipType: "Head",
		class: "Mage",
		icon: spr_mage_medium_head,
	
		},
	mage_heavy_head : 
		{
	
		name: "Mage's Crown",
		itemDescription: "Mages who wear a crown are the most masterful of mages in their discipline",
		consumable: false,
		equip: true,
		equipType: "Head",
		class: "Mage",
		icon: spr_mage_heavy_head,
	
		},
	mage_light_body : 
		{
	
		name: "Apprentice Mage Robes",
		itemDescription: "Simple robes typicall worn by a beginner mage",
		consumable: false,
		equip: true,
		equipType: "Body",
		class: "Mage",
		icon: spr_mage_light_body,
	
		},
	mage_medium_body : 
		{
	
		name: "Novice Mage Robes",
		itemDescription: "Mail reinforced by magic that the majority of mages wear in their everyday lives",
		consumable: false,
		equip: true,
		equipType: "Body",
		class: "Mage",
		icon: spr_mage_medium_body,
	
		},
	mage_heavy_body : 
		{
	
		name: "Battlemage Armor",
		itemDescription: "Sturdy mages armour provided enhanced protection to mages who are suited to combat",
		consumable: false,
		equip: true,
		equipType: "Body",
		class: "Mage",
		icon: spr_mage_heavy_body,
	
		},
	tank_light_head : 
		{
	
		name: "Light Helm",
		itemDescription: "Simple light helmet made of forged scrap metal. May or may not crumble in one hit",
		consumable: false,
		equip: true,
		equipType: "Head",
		class: "Tank",
		icon: spr_tank_light_head,
	
		},
	tank_medium_head : 
		{
	
		name: "Iron Helm",
		itemDescription: "A sturdy helmet worn by most knights, will protect the head",
		consumable: false,
		equip: true,
		equipType: "Head",
		class: "Tank",
		icon: spr_tank_medium_head,
	
		},
	tank_heavy_head : 
		{
	
		name: "Reinforced Helm",
		itemDescription: "A steel reinforced helmet that will block many sorts of blows, not sure if you can hear out of it though",
		consumable: false,
		equip: true,
		equipType: "Head",
		class: "Tank",
		icon: spr_tank_heavy_head,
	
		},
	tank_light_body : 
		{
	
		name: "Light Cuirass",
		itemDescription: "Leather armour with pauldrons made of scrap metal, somewhat effective for a couple hits",
		consumable: false,
		equip: true,
		equipType: "Body",
		class: "Tank",
		icon: spr_tank_light_body,
	
		},
	tank_medium_body : 
		{
	
		name: "Armoured Mail",
		itemDescription: "Standard equipment worn by most knights, will protect the body",
		consumable: false,
		equip: true,
		equipType: "Body",
		class: "Tank",
		icon: spr_tank_medium_body,
	
		},
	tank_heavy_body : 
		{
	
		name: "Fully Plated Armoour",
		itemDescription: "STAY BEHIND ME MEN, WE WILL NOT FALTER, AND WE WILL NOT LOSE OUR POSITION, I AM YOUR ANCHOR",
		consumable: false,
		equip: true,
		equipType: "Body",
		class: "Tank",
		icon: spr_tank_heavy_body,
	
		},
	}

//create the inventory

global.inventory = array_create(0);
global.selected_index = 0;