
/*
reinforce spawn problom with ammobox Task waypoint.
Ending.
*/



Task6IntoForest = {
[] spawn Task6Object;
[] spawn Task6Script;
[] spawn Task6FIAUnits;
};

Task6Object = {
_group = createGroup east;
//rocks
_rocks = "Land_Pier_wall_F" createvehicle [0,0,0]; _rocks setposATL [3884.43,18218.3,0]; _rocks setdir 203.811; ObjectsToCleanup pushback _rocks;
//house
_house = "Land_Slum_House03_F" createvehicle [0,0,0]; _house setposATL [3937.24,18346.2,-3.8147e-006]; _house setdir 338.602; ObjectsToCleanup pushback _house;
//stair
_stair = "Land_Pier_addon" createvehicle [0,0,0]; _stair setposATL [3837.88,18162.8,1.90735e-006]; _stair setdir 35.5367; ObjectsToCleanup pushback _stair;
_stair = "Land_Pier_addon" createvehicle [0,0,0]; _stair setposATL [3884.71,18222.9,0]; _stair setdir 210.466; ObjectsToCleanup pushback _stair;
_stair = "Land_Pier_addon" createvehicle [0,0,0]; _stair setposATL [3883.76,18225.6,4.42783]; _stair setdir 209.33; ObjectsToCleanup pushback _stair;
_stair = "Land_Pier_addon" createvehicle [0,0,0]; _stair setposATL [3883.25,18227.8,9.10206]; _stair setdir 209.33; ObjectsToCleanup pushback _stair;
_stair = "Land_Canal_Wall_10m_F" createvehicle [0,0,0]; _stair setposATL [3890.23,18228.5,11.7992]; _stair setdir 207.805; ObjectsToCleanup pushback _stair;
_stair = "Land_i_Stone_HouseSmall_V3_F" createvehicle [0,0,0]; _stair setposATL [4004.58,18358.7,1.00688]; _stair setdir 61.6192; ObjectsToCleanup pushback _stair;
//garage
_garage = "Land_GarbageBags_F" createvehicle [0,0,0]; _garage  setposATL [3965.58,18345.4,-0.197201]; _garage setdir 35.5367; ObjectsToCleanup pushback _garage;
_garage = "Land_GarbageBags_F" createvehicle [0,0,0]; _garage setposATL [3968.14,18345.3,0.594257]; _garage setdir 35.5367; ObjectsToCleanup pushback _garage;
_garage = "Land_GarbageWashingMachine_F" createvehicle [0,0,0]; _garage setposATL [3966.88,18346.6,0.290253]; _garage setdir 35.5367; ObjectsToCleanup pushback _garage;
_garage = "Land_GarbagePallet_F" createvehicle [0,0,0]; _garage setposATL [3968.23,18343.2,0.151775]; _garage setdir 35.5367; ObjectsToCleanup pushback _garage;
_garage = "Land_Tyres_F" createvehicle [0,0,0]; _garage setposATL [3967,18344.6,0.028656]; _garage setdir 35.5367; ObjectsToCleanup pushback _garage;
_garage = "Land_FishingGear_01_F" createvehicle [0,0,0]; _garage setposATL [3966.12,18343.2,0.102814]; _garage setdir 35.5367; ObjectsToCleanup pushback _garage; 
_oil = "CargoNet_01_barrels_F" createvehicle [0,0,0]; _oil setposATL [3950.33,18343.4,0.0354691]; _oil setdir 279.493; ObjectsToCleanup pushback _oil;
//container with random
_container = "Land_Cargo20_red_F" createvehicle [0,0,0];_container  setposATL [3956.37,18338.9,0.129719]; ObjectsToCleanup pushback _container;
//selectrandom 50cal and ammobox
	if (random 1 > 0.5) then {
_gunner = _group createunit ["B_G_Soldier_GL_F",[3958.23,18339,0.250088],[],0,"NONE"];  [_gunner] join _group;
_50cal = "I_HMG_01_high_F" createvehicle [0,0,0]; _50cal setposATL [3958.23,18339,0.250088]; _50cal setdir 282.115; ObjectsToCleanup pushback _50cal;
_gunner moveinAny _50cal;
	} else {
_ammo = "IG_supplyCrate_F" createvehicle [0,0,0]; _ammo setposATL [3958.23,18339,0.250088]; _ammo setdir 90; ObjectsToCleanup pushback _ammo;
	};
//ammo cache with buildings
_tower = "Land_Castle_01_tower_F" createvehicle [0,0,0]; _tower setposATL [4067.69,18624.8,0]; _tower setdir 338.598; ObjectsToCleanup pushback _tower;
_gunner = _group createunit ["B_G_Soldier_GL_F",[3958.23,18339,0.250088],[],0,"NONE"];
_50cal = "I_HMG_01_high_F" createvehicle [0,0,0]; _50cal setposATL [4068.15,18623.4,18.2011]; _50cal setdir 169.11; ObjectsToCleanup pushback _50cal;
_gunner moveinAny _50cal; [_gunner] join _group;
//house
_slum1 = "Land_Slum_House02_F" createvehicle [0,0,0]; _slum1 setposATL [4382.88,18373.7,0]; _slum1 setdir 184.023; ObjectsToCleanup pushback _slum1;
_slum2 = "Land_Slum_House01_F" createvehicle [0,0,0]; _slum2 setposATL [4377.56,18376.9,0]; _slum2 setdir 184.27; ObjectsToCleanup pushback _slum2;
_slum3 = "Land_Slum_House03_F" createvehicle [0,0,0]; _slum3 setposATL [4379.19,18382.6,0]; ObjectsToCleanup pushback _slum3;
_slum4 = "Land_cargo_addon02_V1_F" createvehicle [0,0,0]; _slum4 setposATL [4381.13,18379.2,0.00202179]; ObjectsToCleanup pushback _slum4;
};

Task6Script = {
[west,["T6"],[localize "T6_STR_IntoFrorestD",localize "T6_STR_IntoFrorest",localize "STR_Move"],Getmarkerpos "Task6endhouseM","ASSIGNED" ,3,true,"",true] call bis_fnc_taskCreate; 
_truck = "B_Truck_01_covered_F" createvehicle Getmarkerpos "Task6StartM"; _truck setdir 180; 
_group = createGroup west;
_squad = [getMarkerPos "Task6StartM", Centerwest,(configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfSquad")] call BIS_fnc_spawnGroup;
_driver = _group createunit ["B_Soldier_lite_F",Getmarkerpos "Task6StartM",[],0,"NONE"]; _driver moveinDriver _truck;
{_x moveinCargo _truck} foreach units _squad;{_x moveinAny _truck} foreach playableunits;
_truck lockDriver true;
_wpd = group _driver addwaypoint [Getmarkerpos "Task6DismountM",1]; _wpd setwaypointType "MOVE";_wpd setwaypointType "TR UNLOAD"; _wpd setWaypointStatements ["true", "_driver disableAI 'MOVE'"]; 
_wp3 = _squad addwaypoint [Getmarkerpos "Task6FirstM",1];_wp3 setwaypointType "MOVE"; _wp2 = _squad addwaypoint [Getmarkerpos "Task6StairM",1]; _wp2 setwaypointType "MOVE"; _wp = _squad addwaypoint [Getmarkerpos "Task6EndhouseM",1]; _wp setwaypointType "MOVE"; 

//ammo chches
T6Ammocount = 0;
ammo1 = "Box_FIA_Wps_F" createvehicle [0,0,0]; ammo1 setposATL [4066.97,18622.8,18.3349]; ObjectsToCleanup pushback ammo1;
ammo1 addEventHandler ["Killed","
['T6_cache1',true,[localize 'T6_STR_Cache1D',localize 'T6_STR_Cache1','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask; [] spawn Task6AmmoCount;
_cache1r = [Getmarkerpos 'Task6rein1M', Centereast,(configfile >> 'CfgGroups' >> 'West' >> 'Guerilla' >> 'Infantry' >> 'IRG_InfTeam')] call BIS_fnc_spawnGroup;
_wp3 = _cache1r addwaypoint [Getmarkerpos 'Task6Cache1M',1];_wp3 setwaypointType 'MOVE'; _wp2 = _cache1r addwaypoint [Getmarkerpos 'Task6CenterM',1]; _wp2 setwaypointType 'MOVE'; _wp = _cache1r addwaypoint [Getmarkerpos 'Task6EndhouseM',1]; _wp setwaypointType 'MOVE';
"];
ammo2 = "Box_FIA_Support_F" createvehicle [0,0,0]; ammo2 setposATL [4385.38,18650.3,0.267097]; ObjectsToCleanup pushback ammo2;
ammo2 addEventHandler ["Killed", "
['T6_cache2',true,[localize 'T6_STR_Cache2D',localize 'T6_STR_Cache2','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask; [] spawn Task6AmmoCount;
_cache2r = [Getmarkerpos 'Task6rein2M', Centereast,(configfile >> 'CfgGroups' >> 'West' >> 'Guerilla' >> 'Infantry' >> 'IRG_InfTeam')] call BIS_fnc_spawnGroup;
_wp3 = _cache2r addwaypoint [Getmarkerpos 'Task6Cache2M',1];_wp3 setwaypointType 'MOVE'; _wp2 = _cache2r addwaypoint [Getmarkerpos 'Task6CenterM',1]; _wp2 setwaypointType 'MOVE'; _wp = _cache2r addwaypoint [Getmarkerpos 'Task6EndhouseM',1]; _wp setwaypointType 'MOVE';
"];
ammo3 = "Box_FIA_Ammo_F" createvehicle [0,0,0]; ammo3 setposATL [4380.94,18374.4,0.663467]; ObjectsToCleanup pushback ammo3;
ammo3 addEventHandler ["Killed", "
['T6_cache3',true,[localize 'T6_STR_Cache3D',localize 'T6_STR_Cache3','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask; [] spawn Task6AmmoCount;
_cache3r = [Getmarkerpos 'Task6rein3M', Centereast,(configfile >> 'CfgGroups' >> 'West' >> 'Guerilla' >> 'Infantry' >> 'IRG_InfTeam')] call BIS_fnc_spawnGroup;
_wp3 = _cache3r addwaypoint [Getmarkerpos 'Task6Cache3M',1];_wp3 setwaypointType 'MOVE'; _wp2 = _cache3r addwaypoint [Getmarkerpos 'Task6CenterM',1]; _wp2 setwaypointType 'MOVE'; _wp = _cache3r addwaypoint [Getmarkerpos 'Task6EndhouseM',1]; _wp setwaypointType 'MOVE';
"];

//it's got a bug.
_trg = createTrigger ["EmptyDetector", Getmarkerpos "Task6endhouseM"];
_trg setTriggerArea [30,30, 0, true];
_trg setTriggerActivation ["WEST", "PRESENT", false];
_trg setTriggerStatements ["this",
"
[west,['T6_cache1','T6'],[localize 'T6_STR_Cache1D',localize 'T6_STR_Cache1',localize 'STR_Move'],ammo1,'Created' ,3,true,'',true] call bis_fnc_taskCreate; 
[west,['T6_cache2','T6'],[localize 'T6_STR_Cache2D',localize 'T6_STR_Cache2',localize 'STR_Move'],ammo2,'Created' ,3,true,'',true] call bis_fnc_taskCreate; 
[west,['T6_cache3','T6'],[localize 'T6_STR_Cache3D',localize 'T6_STR_Cache3',localize 'STR_Move'],ammo3,'Created' ,3,true,'',true] call bis_fnc_taskCreate; 
deletevehicle thistrigger;
",
"deletevehicle thisTrigger;"];
};

Task6AmmoCount = {
T6Ammocount = T6Ammocount + 1;
if (T6Ammocount == 3) then {
	["T6",true,[localize "T6_STR_IntoFrorestD",localize "T6_STR_IntoFrorest","Move"],objNull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
	[west,["T6_Return"],[localize "T6_STR_ReturnD",localize "T6_STR_Return",localize "STR_Move"],Getmarkerpos "Task6dismountM","ASSIGNED" ,3,true,"",true] call bis_fnc_taskCreate; 
	[] spawn Task6End;
	};
};

Task6End = {

_trg = createTrigger ["EmptyDetector", Getmarkerpos "Task6dismountM"];
_trg setTriggerArea [30,30, 0, true];
_trg setTriggerActivation ["WEST", "PRESENT", false];
_trg setTriggerStatements ["count thislist == count playableunits",
"['T6_Return',true,[localize 'T6_STR_ReturnD',localize 'T6_STR_Return','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask;
[] spawn EndOfmission;
deletevehicle thistrigger;
",
"deletevehicle thisTrigger;"];
};

Task6FIAUnits = {
_group = createGroup east;
//side of container
_squad1 = [[3954.84,18343.6,0.000919342], Centereast,(configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam")] call BIS_fnc_spawnGroup;
_squad2 = [Getmarkerpos "Task6E1M", Centereast,(configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam")] call BIS_fnc_spawnGroup;
[Getmarkerpos "Task6E1M",units _squad2,20,true,true,true,false] call Zen_OccupyHouse;
[(configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam"),Getmarkerpos "Task6stairM",Getmarkerpos "Task6DismountM"] call CreatePatrol; 
//front enterence of container
_squad3 = [[3921.11,18310.8,0.00130081], Centereast,(configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
//stair enemys
_stair1 = _group createunit ["B_G_Soldier_AR_F",[0,0,0],[],0,"NONE"]; _stair1 setdir 180; _stair1 setposATL [3879.52,18225.8,2.56666]; [_stair1] join _group;
_stair2 = _group createunit ["B_G_Soldier_GL_F",[0,0,0],[],0,"NONE"];_stair2 setdir 180;_stair2 setposATL [3886.13,18222.1,2.50822]; [_stair2] join _group;
_stair3 = _group createunit ["B_G_Soldier_M_F",[0,0,0],[],0,"NONE"];_stair3 setdir 180;_stair3 setposATL [3889.65,18224,10.0149]; [_stair3] join _group;

_squad4 = [Getmarkerpos "Task6endhouseM", Centereast,(configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam")] call BIS_fnc_spawnGroup;
[Getmarkerpos "Task6endhouseM",units _squad4,20,true,true,true,false] call Zen_OccupyHouse;

_cache1 = [Getmarkerpos "Task6Cache1M", Centereast,(configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam")] call BIS_fnc_spawnGroup;
_cache2 = [Getmarkerpos "Task6Cache2M", Centereast,(configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam")] call BIS_fnc_spawnGroup;
[Getmarkerpos "Task6Cache2M",units _cache2,50,true,true,true,false] call Zen_OccupyHouse;
_cache3 = [Getmarkerpos "Task6Cache3M", Centereast,(configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam")] call BIS_fnc_spawnGroup;
[Getmarkerpos "Task6Cache3M",units _cache3,50,true,true,true,false] call Zen_OccupyHouse;
};

