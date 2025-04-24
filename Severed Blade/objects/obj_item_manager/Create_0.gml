depth = -9999;

global.font = f_text

//create the items

global.item_list =	
	{
		
	// **consumable items**
	attack_up_potion : 
		{
	
		name: "Attack Up Potion",
		description: "A bright red colored potion in a slim bottle. Raises attack by 10%",
		icon: spr_attack_up_potion,
	
		},
	camping_set : 
		{
	
		name: "Camping Set",
		description: "Everything you need to camp out in the wilderness! Recovers 30% of HP and EP for the party when used",
		icon: spr_camping_set,
	
		},
	defense_up_potion : 
		{
	
		name: "Defense Up Potion",
		description: "A bright green colored potion in a slim bottle. Raises defense by 10%",
		icon: spr_defense_up_potion,
	
		},
	dropped_item : 
		{
	
		name: "",
		description: "",
		icon: spr_dropped_item,
	
		},
	gold_bag :
		{
	
		name: "Bag of Gold",
		description: "A bag of gold, open it to find out how much gold is inside!",
		icon: spr_gold_bag,
	
		},
	minor_ep_potion : 
		{
	
		name: "Minor Potion of EP",
		description: "A dull blue colored potion diluted in water. Restores 10% of total EP",
		icon: spr_minor_ep_potion,
	
		},
	standard_ep_potion : 
		{
	
		name: "Standard Potion of EP",
		description: "A blue colored potion. Restores 20% of total EP",
		icon: spr_standard_ep_potion,
	
		},
	major_ep_potion : 
		{
	
		name: "Major Potion of EP",
		description: "A bright blue potion in a large bottle. Restores 30% of total EP",
		icon: spr_major_ep_potion,
	
		},
	minor_hp_potion : 
		{
	
		name: "Minor Potion of HP",
		description: "A dull red colored potion diluted in water. Restores 10% of total HP",
		icon: spr_minor_hp_potion,
	
		},
	standard_hp_potion : 
		{
	
		name: "Standard Potion of HP",
		description: "A red colored potion. Restores 20% of total HP",
		icon: spr_standard_hp_potion,
	
		},
	major_hp_potion : 
		{
	
		name: "Major Potion of HP",
		description: "A bright red colored potion in a gold bottle. Restores 30% of total HP",
		icon: spr_major_hp_potion,
	
		},

	// **equipment items**
	aqua_staff : 
		{
	
		name: "Staff of Aqua Efficiency",
		description: "A blue staff adorned with an Aqua crystal at its tip. Increased Aqua Spell Power. Decreased Terra Spell Power",
		icon: spr_aqua_staff,
	
		},
	ignis_staff  : 
		{
	
		name: "Staff of Ignis Efficiency",
		description: "A red staff adorned with an Ignis crystal at its tip. Increased Ignis Spell Power, Decreased Aqua Spell Power",
		icon: spr_ignis_staff,
	
		},
	lux_staff  : 
		{
	
		name: "Staff of Lux Efficiency",
		description: "A gold staff adorned with a Lux crystal at its tip. Increased Lux Spell Power, Decreased Umbra Spell Power",
		icon: spr_,
	
		},
	staff  : 
		{
	
		name: "Basic Staff",
		description: "A basic wooden staff. Assists the user in casting spells",
		icon: spr_staff,
	
		},
	terra_staff : 
		{
	
		name: "Staff of Terra Efficiency",
		description: "An amber staff adorned with a Terra crystal at its tip. Increased Terra Spell Power, Decreased Ventus Spell Power",
		icon: spr_terra_staff,
	
		},
	umbra_staff : 
		{
	
		name: "Staff of Umbra Efficiency",
		description: "A grey staff adorned with an Umbra crystal at its tip. Increased Umbra Spell Power, Decreased Lux Spell Power",
		icon: spr_umbra_staff,
	
		},
	ventus_staff : 
		{
	
		name: "Staff of Ventus Efficiency",
		description: "A green staff adorned with a Ventus crystal at its tip. Increased Ventus Spell Power, Decreased Ignis Spell Power",
		icon: spr_ventus_staff,
	
		},
	bow : 
		{
	
		name: "Basic Bow",
		description: "A basic shitty bow, I don't even think it's worth using. God I hate bow users. you're better off selling this shit",
		icon: spr_bow,
	
		},
	elven_bow : 
		{
	
		name: "Elven Bow",
		description: "A beautiful ornate bow, made of silverwood and metal fittings, will not fail you",
		icon: spr_elven_bow,
	
		},
	dwarven_bow : 
		{
	
		name: "Dwarven Bow",
		description: "A bow made of strong, pure metal, with a string made of braided steel cable. Whatever you're shooting at will NOT be moving afterwards",
		icon: spr_dwarven_bow,
	
		},
	holy_sword : 
		{
	
		name: "Excalibur",
		description: "The Holy Sword Excalibur, King of all Blades. Made of an unknown material. He who draws this sword will rule the world",
		icon: spr_holy_sword,
	
		},
	katana : 
		{
	
		name: "Katana",
		description: "The sword left behind by the leader of the bandits who killed Sobu's family.",
		icon: spr_katana,
	
		},
	wakizashi : 
		{
	
		name: "Wakizashi",
		description: "A small, shortsword-like blade, forged in the same fashion as Sobu's Katana",
		icon: spr_wakizashi,
	
		},
	slayer_sword : 
		{
	
		name: "Slayer's Sword",
		description: "A great behemoth of a blade. No doubt a swing from this monster would split boulders in half",
		icon: spr_slayer_sword,
	
		},
	wooden_club : 
		{
	
		name: "Wooden Club",
		description: "A large somewhat long log of wood fashioned to look like a club",
		icon: spr_wooden_club,
	
		},	
	mace : 
		{
	
		name: "Iron Mace",
		description: "A mass produced bludgeoning weapon for the army. Effective against heavy armor",
		icon: spr_mace,
	
		},
	morning_star : 
		{
	
		name: "Morningstar",
		description: "Similar to a mace, reinforced with higher strength steel and increased mass. Heavy hitting and definitely lethal",
		icon: spr_morning_star,
	
		},
	samurai_light_head : 
		{
	
		name: "Thin Head Wrap",
		description: "A thin piece of cloth to be wrapped around the head",
		icon: spr_samurai_light_head,
	
		},
	samurai_medium_head : 
		{
	
		name: "Thick Head Wrap",
		description: "A robust, thick piece of cloth to be wrapped around the head",
		icon: spr_samurai_medium_head,
	
		},
	samurai_heavy_head : 
		{
	
		name: "Ronin's Helmet",
		description: "A sturdy helmet, typically worn by wandering Ronin who are walking their own path",
		icon: spr_samurai_heavy_head,
	
		},
	samurai_light_body : 
		{
	
		name: "Cloth Tunic",
		description: "A simple base layer typically worn under armor",
		icon: spr_samurai_light_body,
	
		},
	samurai_medium_body : 
		{
	
		name: "Domaru",
		description: "Armor worn for on foot battles by lower ranking samurai",
		icon: spr_samurai_medium_body,
	
		},
	samurai_heavy_body : 
		{
	
		name: "O-Yoroi",
		description: "Large, overlapping boxy armor offering increased protection for samurai",
		icon: spr_samurai_heavy_body,
	
		},
	mage_light_head : 
		{
	
		name: "Apprentice Mage Hat",
		description: "If you want to be a mage you have to dress for the part",
		icon: spr_mage_light_head,
	
		},
	mage_medium_head : 
		{
	
		name: "Novice Mage Hat",
		description: "The mark of an established mage who has learned more than a couple spells",
		icon: spr_mage_medium_head,
	
		},
	mage_heavy_head : 
		{
	
		name: "Mage's Crown",
		description: "Mages who wear a crown are the most masterful of mages in their discipline",
		icon: spr_mage_heavy_head,
	
		},
	mage_light_body : 
		{
	
		name: "Apprentice Mage Robes",
		description: "Simple robes typicall worn by a beginner mage",
		icon: spr_mage_light_body,
	
		},
	mage_medium_body : 
		{
	
		name: "Novice Mage Robes",
		description: "Magically reinforced mail that the majority of mages wear in their everyday lives",
		icon: spr_mage_medium_body,
	
		},
	mage_heavy_body : 
		{
	
		name: "Battlemage Armor",
		description: "Sturdy mages armour provided enhanced protection to mages who are suited to combat",
		icon: spr_mage_heavy_body,
	
		},
	tank_light_head : 
		{
	
		name: "Light Helm",
		description: "Simple light helmet made of forged scrap metal. May or may not crumble in one hit",
		icon: spr_tank_light_head,
	
		},
	tank_medium_head : 
		{
	
		name: "Iron Helm",
		description: "A sturdy helmet worn by most knights, will protect the head",
		icon: spr_tank_medium_head,
	
		},
	tank_heavy_head : 
		{
	
		name: "Reinforced Helm",
		description: "A steel reinforced helmet that will block many sorts of blows, not sure if you can hear out of it though",
		icon: spr_tank_heavy_head,
	
		},
	tank_light_body : 
		{
	
		name: "Light Cuirass",
		description: "Leather armour with pauldrons made of scrap metal, somewhat effective for a couple hits",
		icon: spr_tank_light_body,
	
		},
	tank_medium_body : 
		{
	
		name: "Armoured Mail",
		description: "Standard equipment worn by most knights, will protect the body",
		icon: spr_tank_medium_body,
	
		},
	tank_heavy_body : 
		{
	
		name: "Fully Plated Armoour",
		description: "STAY BEHIND ME MEN, WE WILL NOT FALTER, AND WE WILL NOT LOSE OUR POSITION, I AM YOUR ANCHOR",
		icon: spr_tank_heavy_body,
	
		},
	}

//create the inventory

inventory = array_create(0);
selected_item = -1

//for drawing and mouse pos
sep = 16;
scrn_bord = 16;