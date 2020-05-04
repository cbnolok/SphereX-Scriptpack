TODO:
-Most NPCs here seems to do not have sound and resistances
-resphysical must be added as resistance, it works different than armor
-armor values doesn't even approach to resphysical
-Elemental damages are missing
-Lots of stats/skills does not match uoguide/stratics
-Fixed values on stat/skills must be fixed, not ranged
-There are NPCs with skills they shouldn't even have.
-TAG.BARDING.DIFF missing in most npcs
-KARMA/FAME values does not match
-Mount icons placed here, should be moved to i_char_icons.scp? some of them are duplicated -> remove
-missing FACTIONS 
-Missing CHARDEF (according to defs_height.scp):
    
    091, 092, 093, 09d, 09f
    0a0, 0a1, 0a2, 0a3, 0a4, 0a5, 0a6, 0a8
    0b5, 0b7, 0b8, 0b9, 0ba, 0bf
    0c0, 0c1, 0c2, 0c3, 0c5, 0c6
    010c, 010d, 010e
    0110, 011d
    0132, 0137, 0139, 013b, 013e
    02f1, 02f2, 02f6, 02fc
    0301, 0306, 030b
    031b, 031c, 031d, 031e
    03ca
    03db
-Heights added only until 03ef, we are missing values for HS+ chars

coding guidelines:

-reserved keywords UPPERCASE, values after it in lowercase (use capitals for names).
-Tabs must be changed to 4 white spaces.
-Any property that shares the same value over all objects of it's same ID must be placed on it's block instead of it's triggers (excepting for random values):
    [WHATEVER ] blocks ([CHARDEF in this case]) can only have fixed values, random ones must go inside triggers, eg:
    [CHARDEF xx]
    DAMFIRE=15 // correct
    DAMFIRE={15 25} // incorrect, this one must be placed in ON=@Create
    
    ON=@Create
    DAMFIRE=15 // legit, but not recommended, fixed values for all characters are better placed above, so this prop is not required to be saved
    DAMFIRE={15 25} //correct

Chardef example:
[CHARDEF xxx]
//base defs
DEFNAME=c_char_defname
DEFNAME2=c_old_xx   //DEFNAME2 is allowed, but it's recommended to create a new entry in it's respective core/backwards_compatibility_version.scp with c_old_xx=c_char_defname
NAME=Some Name
ICON=i_xx   // chars without icon set will default to i_pet_whisp
SOUND=snd_xx    //Preferably all chardefs should have sounds

//Fixed values' properties and tags. Fixed only, ranges are not allowed here.
DAM=15,20
DAMFIRE=20
FACTION=faction_demon   // defnames in lowercase
BLOODCOLOR=1
TAG.BARDING.DIFF=95.0

//Aversions, resources, etc
DESIRES=r_dungeon_doom,t_coin,t_gold,t_gem,t_wand,t_potion,t_scroll,t_reagent
AVERSIONS=t_trap,r_civilization
RESOURCES=1 i_reag_blackmoor

//TEVENTS
TEVENTS=e_carnivores

//TSPEECH
TSPEECH=spk_human

//ResDisp*
RESDISPDNID=c_elemental_air
RESLEVEL=2
RESDISPDNHUE=55

//Expansion settings
ERALIMITLOOT=1
ERALIMITGEAR=1
ERALIMITPROPS=1

//GM Tools categories
CATEGORY=Monsters
SUBSECTION=Elementals
DESCRIPTION=Elemental, Example

ON=@Create
    //Even with fixed size, brain, color, fame/karma skills and stats must be added in @Create
    //Brain first
    NPC=<def.brain_monster>
    
    //Fame/karma
    FAME=10000
    KARMA=-10000
    
    //Color, if required
    COLOR=<def.colors_slime>
    
    //Stats
    STR={100 150}
    DEX={120 130}
    INT={15 20}
    MAXHITS={120 160}
    
    //From here, excepting skills, can be placed here for random values or in the [CHARDEF ] block for fixed values.
    //Resistances   //Resphysical is also required, armor can be added for backwards but having armor doesn't mean that resphysical isn't required and viceversa.
    RESPHYSICAL={55 65}
    RESFIRE={30 35}
    RESCOLD={40 45}
    RESPOISON=0 // Any property with a value of 0 should not be added, just remove the whole line
    
    //Damages (if not fixed, fixed values are placed above)
    //DAMPHYSICAL can be added but if it's not present it will be defaulted to RESPHYSICAL = 100 - (RESFIRE+RESCOLD+RESPOISON+RESENERGY)
    DAMCOLD={30 35}
    
    //Skills
    MAGERY={350 500}
    MEDITATION={700}    //RANGES should NEVER be added for a single value, this should be MEDITATION=700
    
    //Other not-fixed properties
    HitLeechLife={35 40}
    
    ITEM=xx //Wearables (clothes, weapons, light sources, hairs, horns...)
    //Only wearables, to prevent loot items from being saved, loaded from/to save files, checked in rescount, forcont, etc over and over and being snopped/stolen? in undefined situations

ON=@CreateLoot // loot behaviour, created after the char dies
    ITEM=xxx

ON=@NPCRestock//Use this trigger for BUY/SELL templates only on vendors
    ITEM=xx


Basic tips for NPCs

Vendors:
set VENDCAP for their gold cap and VENDGOLD for setting their current amount on the fly.
On each restock they will set VENDGOLD to VENDCAP if VENDGOLD is lower than VENDCAP
Restocks are done each 10 minutes by default unless REGION.TAG.RESTOCKVENDORS=30 is set (in tenths of second, 30 = each 3 seconds) (and only for regions)
REGION.TAG.NORESTOCK or a TAG.NORESTOCK in the vendor prevents any restock
They have a MARKUP value (default = 15) when selling items to players, positive values increases the fee on the final price and negative decreases it.
    eg: MARKUP=30 with a price of 100 will result of a cost of 130gp
        MARKUP=-100 will result in a cost of 0gp
MARKUP can be modified with REGION.TAG.MARKUP or TAG.MARKUP in the vendor.

Stablers:
They determinate how much pets to stable with a formula (look at Char::NPC_StablePetSelect), but the value can be overriden with a TAG.MAXPLAYERPETS.

Dragons:
Their breath* action can be overrided:
TAG.BREATH.HUE to change it's color
TAG.BREATH.DAM to change it's damage (defaulted to (str * 5) / 100 and limited to 1 as min damage and 200 as max
TAG.BREATH.ANIM to change the animation id = IDs must be items as for any other EFFECT animation
TAG.BREATH.TYPE for the type of EFFECT search for EFFECT_TYPE.

Cyclops, Ettins and Ogres:
THROWRANGE=min,max (default=2,9)//Allows them to throw objects
THROWOBJ=id of the item to throw (must have it in their backpack)


AI:
ON=@NPCActFight can override default behaviours
return 1 prevents any action
return 0 prevents special actions
return 0 or no return at all allows default behaviours (magic, archery, walking close/far away and melee, and some more things)
return 2 allows to force some action to the char:
    local.skill sets the skill to use
    local.spell sets the spell to use in case of magic skills (FLAGS=SKF_MAGIC defined on them)

return default (AKA no return at all in the trigger) allows special actions:
*Special actions requires the NPC to have stam >= dex (full stam, or more)
-Breathing for dragons 
-Throwing objects for any other

Misc:
CAN += mt_statue|mt_nonselectable will make the character become untargetable and unmovable 
TAG.STATUE.ANIM=23  //Makes the character to display like executing this anim
TAG.STATUE.FRAME=2  //Stops the character in the given frame from the given TAG.STATUE.ANIM

//ResDisp* // These properties MUST be added for any chardefs newer than classic (T2A must have RESLEVEL 1, LBR = 2, AOS = 3, SE = 4, ML = 5, SA = 6, HS = 7, TOL = 8)
ResLevel=3 //marks this npc to be viewed from clients 3.x or greater
ResDispDnId=c_man //sets the id to send for clients lower than RESLEVEL
ResDispHue=033 // sets a color to send for this character when sent to clients lower than RESLEVEL

//Expansion settings for loot, gears, etc
ERALIMITLOOT=1  // Limits the loot to items from the expansion given or older 1=T2A, 2 = LBR ...
ERALIMITGEAR=1  // The same for wearables (Clothes, weapons, hairs, etc)
ERALIMITPROPS=1 // Prevents this char from having properties from newer expansions, eg ERALIMITPROPS=3 will allow it to have RESFIRE since it's older than AOS but not DAMCHAOS since its newer than AOS
