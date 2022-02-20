--Salidar

-- Load and initialize the include file.
include('Mirdain-Include')

--Uses Items Automatically
AutoItem = false

--Upon Job change will use a random lockstyleset
Random_Lockstyle = false

--Lockstyle sets to randomly equip
Lockstyle_List = {1,2,6,12}

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "14"
MacroBook = "2"  -- Sub Job macro pallets can be defined in the sub_job_change_custom function below
MacroSet = "1"

-- Use "gs c food" to use the specified food item 
Food = "Sublime Sushi"

-- Threshold for Ammunition Warning
Ammo_Warning_Limit = 99

-- Add CRIT the base modes to allow AM3 Critical Builds
state.OffenseMode:options('TP','ACC','DT','PDL','CRIT')

--Set default modes are (TP,ACC,DT,PDL)
state.OffenseMode:set('TP')

-- Set to true to run organizer on job changes
Organizer = true

--Modes for specific to Ranger
state.WeaponMode:options('Fomalhaut','Annihilator','Gastraphetes','Fail-Not','Naegling', 'Tauret')
state.WeaponMode:set('Fomalhaut')

-- load addons
send_command('lua l hovershot')

--Set the ammo type for each WeaponMode (above) and Types: Bullet, Arrow, Bolt
--This allows for generic gear sets such as ammo=Ammo.RA for Midcast.RA as an example.
Ranged_Weapons = {
	{WeaponMode = "Naegling", Type = "Bullet"},
	{WeaponMode = "Fomalhaut", Type = "Bullet"},
	{WeaponMode = "Annihilator", Type = "Bullet"},
	{WeaponMode = "Fail-Not", Type = "Arrow"},
	{WeaponMode = "Gastraphetes", Type = "Bolt"},
	{WeaponMode = "Tauret", Type = "Bullet"},
}

-- Used to determine if Obi is used or Orpheus Sash - if either is not present it will not change the waist slot
elemental_ws = S{'Aeolian Edge', 'Flaming Arrow', 'Wildfire','Trueflight','Hot Shot'}

-- Initialize Player
jobsetup (LockStylePallet,MacroBook,MacroSet)

-- Goal is 2000 HP
function get_sets()
	-- Weapon setup
	sets.Weapons = {}

	sets.Weapons['Naegling'] = {
		main="Naegling",
		sub="Kraken Club",
		range={ name="Anarchy +2", augments={'Delay:+60','TP Bonus +1000',}},
	}

	sets.Weapons['Fomalhaut'] = {
		main={ name="Perun +1", augments={'Path: A',}},
		sub={ name="Kustawi +1", augments={'Path: A',}},
		range={ name="Fomalhaut", augments={'Path: A',}},
	}

	sets.Weapons['Annihilator'] = {
		main={ name="Perun +1", augments={'Path: A',}},
		sub={ name="Kustawi +1", augments={'Path: A',}},
		range={ name="Annihilator", augments={'Path: A',}},
	}

	sets.Weapons['Gastraphetes'] = {
		main={ name="Perun +1", augments={'Path: A',}},
		sub={ name="Kustawi +1", augments={'Path: A',}},
		range={ name="Gastraphetes", augments={'Path: A',}},
	}

	sets.Weapons['Fail-Not'] = {
		main={ name="Perun +1", augments={'Path: A',}},
		sub={ name="Kustawi +1", augments={'Path: A',}},
		range={ name="Fail-Not", augments={'Path: A',}},
	}

	sets.Weapons['Tauret'] = {
		main="Tauret",
		sub="Ternion Dagger +1",
		range={ name="Anarchy +2", augments={'Delay:+60','TP Bonus +1000',}},
	}

	sets.Weapons.Shield = {
		sub={ name="Nusku Shield",},
	}

	-- Ammo Selection - will choose based off equiped weapon
	Ammo.Bullet.RA = "Chrono Bullet"		-- TP Ammo
	Ammo.Bullet.ACC = "Eradicating Bullet"	-- Accuracy Ammo
	Ammo.Bullet.CRIT = "Eradicating Bullet"	-- Critical Hit Mode Ammo
	Ammo.Bullet.WS = "Chrono Bullet"		-- Physical Weaponskills (consumed)
	Ammo.Bullet.MAB = "Chrono Bullet"		-- Magical Weaponskills
	Ammo.Bullet.MACC = "Chrono Bullet"		-- Magic Accuracy
	Ammo.Bullet.MAG_WS = "Chrono Bullet"	-- Magic Weaponskills (Not Consumed)
	Ammo.Bullet.PHY_WS = "Chrono Bullet"	-- Magic Weaponskills (Not Consumed)

	Ammo.Arrow.RA = "Chrono Arrow"			-- TP Ammo
	Ammo.Arrow.ACC = "Chrono Arrow"			-- Accuracy Ammo
	Ammo.Arrow.CRIT = "Eradicating Bullet"	-- Critical Hit Mode Ammo
	Ammo.Arrow.WS = "Chrono Arrow"			-- Physical Weaponskills (consumed)
	Ammo.Arrow.MAB = "Chrono Arrow"			-- Magical Weaponskills
	Ammo.Arrow.MACC = "Chrono Arrow"		-- Magic Accuracy
	Ammo.Arrow.MAG_WS = "Chrono Arrow"		-- Magic Weaponskills (Not consumed)
	Ammo.Arrow.PHY_WS = "Chrono Bullet"		-- Magic Weaponskills (Not Consumed)

	Ammo.Bolt.RA = "Quelling Bolt"			-- TP Ammo
	Ammo.Bolt.ACC = "Quelling Bolt"			-- Accuracy Ammo
	Ammo.Bolt.CRIT = "Quelling Bolt"		-- Critical Hit Mode Ammo
	Ammo.Bolt.WS = "Quelling Bolt"			-- Physical Weaponskills (consumed)
	Ammo.Bolt.MAB = "Quelling Bolt"			-- Magical Weaponskills
	Ammo.Bolt.MACC = "Quelling Bolt"		-- Magic Accuracy
	Ammo.Bolt.MAG_WS = "Quelling Bolt"		-- Magic  (Not consumed)
	Ammo.Bolt.PHY_WS = "Quelling Bolt"		-- Magic Weaponskills (Not Consumed)

	--Modes to select correct ammo based off weapon type
	Ammo.RA = Ammo[state.RAMode.value].RA
	Ammo.ACC = Ammo[state.RAMode.value].ACC
	Ammo.CRIT = Ammo[state.RAMode.value].CRIT
	Ammo.WSD = Ammo[state.RAMode.value].WSD
	Ammo.MAB = Ammo[state.RAMode.value].MAB
	Ammo.MACC = Ammo[state.RAMode.value].MACC
	Ammo.MAG_WS = Ammo[state.RAMode.value].MAG_WS
	Ammo.PHY_WS = Ammo[state.RAMode.value].PHY_WS

	-- Standard Idle set with -DT,Refresh,Regen with NO movement gear
	sets.Idle = {
		ammo=Ammo.RA, -- Smart_Ammo() will select from your XXXX.RA type
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Malignance Tights",
		feet="Nyame Sollerets",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Sanare Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Damage taken-5%',}}, -- Add DT
    }

	sets.Movement = {
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
	}

	-- Set to be used if you get 
	sets.Cursna_Recieved = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Saida Ring", bag="wardrobe1", priority=2},
		right_ring={ name="Saida Ring", bag="wardrobe3", priority=1},
		waist="Gishdubar Sash",
	}

	--Base TP set to build off when melee'n
	sets.OffenseMode = {ammo=Ammo.RA,}

	--Set focuses on maximum TP gain
	sets.OffenseMode.TP = {
	    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Malignance Boots",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring={ name="Chirich Ring +1", bag="wardrobe1",},
		right_ring="Epona's Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Damage taken-5%',}}, -- Need to update Cape
	}

	--This set is used when OffenseMode is set to DT and enaged
	sets.OffenseMode.DT = set_combine(sets.OffenseMode.TP, {
	    head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
	})

	--This set is used when OffenseMode is set to PDL and enaged
	sets.OffenseMode.PDL = set_combine(sets.OffenseMode.TP, {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})

	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	sets.OffenseMode.ACC = set_combine(sets.OffenseMode.TP, {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		right_ring={ name="Chirich Ring +1", bag="wardrobe3",},
		left_ear="Crep. Earring",
	})

	--This set is used when OffenseMode is CRIT and Engaged
	--Change the sets.OffenseMode.XXX to what you want while engaged - default is DT and shooting is seperate build below for AM3
	sets.OffenseMode.CRIT = set_combine(sets.OffenseMode.DT, {

	})

	--The following sets augment the base TP set above for Dual Wielding
	sets.DualWield = {
		-- Add DW 10% cape
	}

	sets.Precast = {ammo=Ammo.RA,}
	-- 70 snapshot is Cap
	-- Velocity Shot is seperate term - JA of Ranger
	-- Rapid shot is like quick magic
	-- Snapshot is like Fast Cast

	-- True Shot Ranges (Increases RA and WS and)
		-- Distances listed below are effected by Monster Size
		-- Gun ~6.5 yalms
		-- Short Bow ~8.6 yalms
		-- Crossbow ~10.7 yalms
		-- Long Bow ~ 11.8 yalms

	-- Flurry is 15% Snapshot
	-- Flurry II 30% Snapshot

	-- Rapid Shot is a Job Trait of Ranger - 30%

	--No flurry - 60 Snapshot needed (Assuming 10% from Merits)
	-- Snapshot / Rapidshot
	sets.Precast.RA = set_combine(sets.Precast, { -- 5 Snapshot on Perun +1 Augment if used
		ammo=Ammo.RA,
	    head={ name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}}, -- 10
		body="Amini Caban +1", -- 7% Velocity Shot
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, -- 8 / 11
		legs="Orion Braccae +3", -- 15
		feet={ name="Adhe. Gamashes +1", augments={'HP+65','"Store TP"+7','"Snapshot"+10',}, priority=4}, -- 10 / 13
		neck={ name="Scout's Gorget +2", augments={'Path: A',}}, -- 4
		waist="Yemaya Belt", -- 0 / 5
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=3},
		right_ear={ name ="Tuisto Earring", priority=1},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=2},
		right_ring="Crepuscular Ring", -- 3
		back={ name="Belenus's Cape", augments={'"Snapshot"+10',}, priority=5}, -- 10 with 2% Velocity Shot
    })	--60 Snapshot / 29 Rapidshot / 9% Velocity Shot

	-- Only the bullet needs to be set for ACC sets (so that it will match the sets.Midcast.RA.ACC)
    sets.Precast.RA.ACC = set_combine(sets.Precast.RA, {
		ammo=Ammo.ACC,
    })

	-- Flurry - 45 Snapshot Needed
	sets.Precast.RA.Flurry = set_combine(sets.Precast.RA, {
		head="Orion Beret +3",
	    legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}, -- 10/13
	}) --45 Snapshot / 60 Rapidshot / 9% Velocity Shot

	-- Flurry II - 30 Snapshot Needed
	sets.Precast.RA.Flurry_II = set_combine( sets.Precast.RA.Flurry, { 
		feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
    })	--35 Snapshot / 70 Rapidshot / 9% Velocity Shot

	-- Fast Cast for magic such as Utsusemi
	sets.Precast.FastCast = {
	    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --14
		body={ name="Taeon Tabard", augments={'"Fast Cast"+5','HP+40',}}, -- 9
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, -- 8
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+11','"Fast Cast"+6',}}, --6
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}}, -- 8
		neck="Voltsurge Torque", --8
		waist="Siegel Sash", -- 8 (Enhancing Magic only - Utsusemi)
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Etiolation Earring", -- 1
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Weather. Ring", -- 5
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Damage taken-5%',}}, -- Need to upgrade Cape with 10% FC
	} -- 77 FC for Utsusemi (80 is cap)
	 
		--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {
		ammo=Ammo.RA,
	})

	-- Ranged Attack Gear (Normal Midshot)
    sets.Midcast.RA = set_combine(sets.Midcast, {
		head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
		body="Ikenga's Vest",
		hands="Ikenga's Gloves",
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet="Ikenga's Clogs",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="K. Kachina Belt +1",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Crepuscular Ring",
		right_ring="Ilabrat Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Damage taken-5%',}},
    }) -- With Recycle Merits 101 Recycle for TP bonus and Ammo Save

	-- Ranged Attack Gear (High Accuracy Midshot)
    sets.Midcast.RA.ACC = set_combine(sets.Midcast.RA, {
		ammo=Ammo.ACC,
    })

	-- Ranged Attack Gear (Physical Damage Limit)
    sets.Midcast.RA.PDL = set_combine(sets.Midcast.RA, {
	    head="Ikenga's Hat",
		legs="Ikenga's Trousers",
    })

	-- Ranged Attack Gear (Critical Build)
    sets.Midcast.RA.CRIT = set_combine(sets.Midcast.RA, {
		head="Meghanada Visor +2",
		body="Nisroch Jerkin",
		legs="Ikenga's Trousers",
		feet="Osh. Leggings +1",
		right_ring="Ilabrat Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','Crit.hit rate+10','Damage taken-5%',}},
    })

	-- Ranged Attack Gear (Double Shot Midshot)
	sets.Midcast.RA.DoubleShot = set_combine(sets.Midcast.RA, {
	    head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
		hands="Oshosi Gloves +1",
		body={ name="Arc. Jerkin +3", augments={'Enhances "Snapshot" effect',}},
		feet="Osh. Leggings +1",
    })

	-- Ranged Attack Gear (Barrage active)
	sets.Midcast.RA.Barrage = set_combine(sets.Midcast.RA, {
	    hands="Orion Bracers +3",
    })

	-- Job Abilities
	sets.JA = {}
	sets.JA["Eagle Eye Shot"] = {legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},}
	sets.JA["Scavenge"] = {}
	sets.JA["Shadowbind"] = { hands="Orion Bracers +3",}
	sets.JA["Camouflage"] = {body={ name="Arc. Jerkin +3", augments={'Enhances "Snapshot" effect',}},}
	sets.JA["Sharpshot"] = { legs="Orion Braccae +3",} -- Used for rules below
	sets.JA["Barrage"] = {} -- Midcast.RA.Barrage set
	sets.JA["Unlimited Shot"] = {}
	sets.JA["Velocity Shot"] = {}
	sets.JA["Double Shot"] = {} -- Midcast.RA.Double Shot set
	sets.JA["Bounty Shot"] = { ammo= Ammo.RA, hands="Amini Glove. +1",} -- Upgrade to TH4
	sets.JA["Decoy Shot"] = {}
	sets.JA["Overkill"] = {}
	sets.JA["Hover Shot"] = {}

	-- Base Weapon Skill set
	sets.WS = {
		ammo = Ammo.WS,
	    head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		left_ring="Epaminondas's Ring",
	}

	-- Weapon Skill Damage
	sets.WS.WSD = set_combine(sets.WS, {
		ammo=Ammo.WSD,
		head="Orion Beret +3",
		body="Ikenga's Vest",
		hands="Meg. Gloves +2",
		legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
		feet="Ikenga's Clogs",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
	})

	-- Magic Attack Bonus
	sets.WS.MAB = set_combine(sets.WS, {
		ammo=Ammo.MAB,
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
		waist="Eschan Stone", -- Orpheus/Obi Swap
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%','Damage taken-5%',}}, -- Finish Cape
	})

	-- Physical Damage Limit set used in OffenseMode.PDL
	sets.WS.PDL = set_combine(sets.WS, {
	
	})

	-- Accuracy set used in OffenseMode.ACC
	sets.WS.ACC = set_combine(sets.WS, {
		ammo=Ammo.ACC, -- Smart_Ammo() will select from your XXXX.RA type
	})

	-- Gun Weaponskills
	sets.WS["Hot Shot"] = set_combine(sets.WS.MAB, {})
	sets.WS["Split Shot"] = set_combine(sets.WS.WSD, {})
	sets.WS["Sniper Shot"] = set_combine(sets.WS.WSD, {})
	sets.WS["Slug Shot"] = set_combine(sets.WS.WSD, {})
	sets.WS["Blast Shot"] = set_combine(sets.WS.WSD, {})
	sets.WS["Heavy Shot"] = set_combine(sets.WS.WSD, {})
	sets.WS["Detonator"] = set_combine(sets.WS.WSD, {})
	sets.WS["Numbing Shot"] = set_combine(sets.WS.WSD, {})
	sets.WS["Wildfire"] = set_combine(sets.WS.MAB, {
		-- Get Cremation Earring since doesn't scale with TP
	})
	sets.WS["Last Stand"] = set_combine(sets.WS.WSD, {})
	sets.WS["Coronach"] = set_combine(sets.WS.WSD, {
		right_ear="Sherida Earring",
	})

	-- Archery Weaponskills
	sets.WS["Flaming Arrow"] = set_combine(sets.WS.MAB, {})
	sets.WS["Piercing Arrow"] = set_combine(sets.WS.WSD, {})
	sets.WS["Dulling Arrow"] = set_combine(sets.WS.WSD, {})
	sets.WS["Sidewinder"] = set_combine(sets.WS.WSD, {})
	sets.WS["Blast Arrow"] = set_combine(sets.WS.WSD, {})
	sets.WS["Arching Arrow"] = set_combine(sets.WS.WSD, {})
	sets.WS["Refulgent Arrow"] = set_combine(sets.WS.WSD, {})
	sets.WS["Jishnu's Radiance"] = set_combine(sets.WS.WSD, {})
	sets.WS["Apex Arrow"] = set_combine(sets.WS.WSD, {})

	-- Sword Weaponskills
	sets.WS["Fast Blade"] = set_combine(sets.WS.WSD, {})
	sets.WS["Burning Blade"] = set_combine(sets.WS.MAB, {})
	sets.WS["Flat Blade"] = set_combine(sets.WS.WSD, {})
	sets.WS["Shining Blade"] = set_combine(sets.WS.WSD, {})
	sets.WS["Circle Blade"] = set_combine(sets.WS.WSD, {})
	sets.WS["Spirits Within"] = set_combine(sets.WS.WSD, {})
	sets.WS["Savage Blade"] = set_combine(sets.WS.WSD, {})

	-- Dagger Weaponskills
	sets.WS["Wasp Sting"] = set_combine(sets.WS.WSD, {})
	sets.WS["Viper Bite"] = set_combine(sets.WS.WSD, {})
	sets.WS["Shadowstitch"] = set_combine(sets.WS.WSD, {})
	sets.WS["Gust Slash"] = set_combine(sets.WS.WSD, {})
	sets.WS["Cyclone"] = set_combine(sets.WS.WSD, {})
	sets.WS["Energy Steal"] = set_combine(sets.WS.WSD, {})
	sets.WS["Energy Drain"] = set_combine(sets.WS.WSD, {})
	sets.WS["Evisceration"] = set_combine(sets.WS.WSD, {})
	sets.WS['Aeolian Edge'] = set_combine(sets.WS.MAB, {})

	-- Crossbow Weaponskills
	sets.WS["Trueflight"] = set_combine(sets.WS.MAB, {
		right_ring="Weather. Ring",
	})

	sets.Charm = {}

	sets.TreasureHunter = {
	    legs={ name="Herculean Trousers", augments={'Attack+8','Mag. Acc.+13 "Mag.Atk.Bns."+13','"Treasure Hunter"+2','Accuracy+16 Attack+16',}},
		waist="Chaac Belt",
	}
end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end

--Adjust custom precast actions
function pretarget_custom(spell,action)

end
-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return equipSet
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return equipSet
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return equipSet
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return equipSet
end

--Function is called when a self command is issued
function self_command_custom(command)
	Smart_Ammo()
end

-- Function is called whn lua is unloaded
function user_file_unload()
	send_command('lua u hovershot')
end

function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()
	if player.sub_job == 'WAR' then
		if not buffactive['Berserk'] and ja_recasts[1] == 0 then
			buff = "Berserk"
		elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
			buff = "Aggressor"
		elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
			buff = "Warcry"
		end
	end
	return buff
end

function check_buff_SP()
	buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

function Smart_Ammo ()
	for i = 1, #Ranged_Weapons do
		if state.WeaponMode.value == Ranged_Weapons[i].WeaponMode then
			if state.RAMode.value ~= Ranged_Weapons[i].Type then
				state.RAMode:set(Ranged_Weapons[i].Type)
				windower.add_to_chat(8,'Ammo Mode is ['..state.RAMode.value..']')
				get_sets()
			end
			log('Ammo Mode is ['..state.RAMode.value..']')
			equip({ammo=Ammo.RA})
			return
		end
	end
end