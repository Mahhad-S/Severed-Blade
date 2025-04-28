**ALL STATS WILL USE FLOOR OF CALCULATED VALUES**

--CORE STATS--
STR = Strength
INT = Intelligence
SPD = SPD
CON = Constitution

Core stats increased on level up

--BASE STATS--
HP BASE = 10
EP BASE = 10

--SECONDARY STATS--
Current Max HP = HP BASE × (2.0 + (CON ÷ 10))
Current Max EP = EP BASE × (1.0 + ((2 × INT) ÷ 10))
ATK = Current Attack = (STR × 7.75) + Weapon DMG stat
DEF = Current Defense = (CON × 4.5) + Armor DEF stat

--DAMAGE CALCULATION STATS--
**MAX DMG REDUCTION & Increase == 1.5×**

-PHYSICAL ATTACKS-
Pierce:-> Leather Armor = 1.25
-> Plate Armor = 0.75
-> Forged Armor = 1

Slash:-> Leather Armor = 1
-> Plate Armor = 1.25
-> Forged Armor = 0.75

Bludgeon:-> Leather Armor = 0.75
-> Plate Armor = 1
-> Forged Armor = 1.25

--ELEMENTAL ATTACKS--

-Elemental Strengths and Weaknesses-
Ignis -> Ventus = 1.25
Ventus -> Terra = 1.25
Terra -> Aqua = 1.25
Aqua -> Ignis = 1.25

Ignis -> Ignis = 1.0
Ignis -> Terra = 1.0
Ventus -> Ventus = 1.0
Ventus -> Aqua = 1.0
Terra -> Terra = 1.0
Terra -> Ignis = 1.0
Aqua -> Aqua = 1.0
Aqua -> Vetnus = 1.0

Ignis -> Aqua = 0.75
Aqua -> Terra = 0.75
Terra -> Ventus = 0.75
Ventus -> Ignis = 0.75

**--FINAL DMG CALCULATION--**
DMG = ATK × (PHYSICAL ATTACK MODIFIER) × (ELEMENTAL ATTACK MODIFIER)