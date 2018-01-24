Task4Split = {
[] call Task4Object;
[] spawn Task4script;
};

Task4Object = {
officerOffroad = createvehicle ["C_Offroad_01_F",[4679.43,21354.4,0.351685],[],0,"none"]; ObjectsToCleanup pushback officerOffroad; officerOffroad setdir 270; publicvariable "officerOffroad";
officerOffroad lock 3;
_group = creategroup east;
Task4OfficerGuard = [getMarkerPos "Task4TargetM", Centereast,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam")] call BIS_fnc_spawnGroup;publicvariable "Task4OfficerGuard";
task4officer = _group CreateUnit ["O_officer_F",getMarkerpos "Task4TargetM",[],0,"NONE"]; publicvariable "task4officer";
//[Getmarkerpos "Task4TargetM",units Task4OfficerGuard,20,true,true,true,false] call Zen_OccupyHouse; [Getmarkerpos "Task4TargetM",[task4officer],20,true,true,true,false] call Zen_OccupyHouse;
task4officer addEventHandler ["Killed", "
['T4_2',true,[localize 'STR_T4_EscapeD',localize 'STR_T4_Escape','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask; [] spawn Task4end"];
//public vehicles
_truck = createvehicle ["C_Van_01_transport_F",[4580.89,21389.9,0.0157471],[],0,"none"]; ObjectsToCleanup pushback _truck;
_Offroad = createvehicle ["C_Offroad_01_F",[4518.94,21338.9,-0.0549011],[],0,"none"]; ObjectsToCleanup pushback _Offroad;
_quad = createvehicle ["C_Quadbike_01_F",[4540.8,21489.7,-0.00946045],[],0,"none"]; ObjectsToCleanup pushback _quad;
_quad2 = createvehicle ["C_Quadbike_01_F",[5185.94,21040.6,-0.000961304],[],0,"none"]; ObjectsToCleanup pushback _quad2;
_kart = createvehicle ["C_Kart_01_F",[4929.17,21894.1,0.0645752],[],0,"none"]; ObjectsToCleanup pushback _kart;
//AA
_AAI = [(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "task4AAM",getMarkerpos "task4AAM"] call CreatePatrol;
[Getmarkerpos "Task4AAM",units _AAI,50,true,true,true,false] call Zen_OccupyHouse;
_AA = createVehicle ["O_APC_Tracked_02_AA_F",getMarkerpos "Task4AAM",[],0,"none"];ObjectsToCleanup pushback _AA;
_AA engineon true; _AA lock true;
_AA addEventHandler ["Dammaged", "
['T4_AA',true,[localize 'STR_T4_AAD',localize 'STR_T4_AA','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask;
AASucceeded = true;[] spawn Task4SubTaskcheck;"];
_AA addEventHandler ["Killed", "
['T4_AA',true,[localize 'STR_T4_AAD',localize 'STR_T4_AA','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask;
AASucceeded = true;[] spawn Task4SubTaskcheck;"];// need to put complete task with code
//Jammer
_jammer = createvehicle ["Land_DieselGroundPowerUnit_01_F",[4559.68,21492.1,1],[],0,"none"]; ObjectsToCleanup pushback _jammer;
//Task to Jammer
_JM = [(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "Task4jammerM",getMarkerpos "Task4jammerM"] call CreatePatrol;
[Getmarkerpos "Task4jammerM",units _JM,30,true,true,true,false] call Zen_OccupyHouse;
_jammer addEventHandler ["Killed", "
['T4_Jammer',true,[localize 'STR_T4_JammerD',localize 'STR_T4_Jammer','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask;
JammeSucceeded = true; playableUnits joinsilent (playableunits select 0);
group (playableunits select 0) selectleader (playableunits select 0);[] spawn Task4SubTaskcheck;"];
//mineActive
at = createvehicle ["ATMine_Range_Ammo",Getmarkerpos "Task4mineM",[],0,"none"]; at setdir 90; ObjectsToCleanup pushback at;
_pa1 = createMine ["APERSBoundingMine",(at modelToWorld[-1,0,0]), [], 0]; ObjectsToCleanup pushback _pa1;
_pok1 = createMine ["APERSMine",(at modelToWorld[-0.5,1,-0.1]), [], 0]; ObjectsToCleanup pushback _pok1;
_pa2 = createMine ["APERSBoundingMine",(at modelToWorld[0.5,1,-0.2]), [], 0]; ObjectsToCleanup pushback _pa2;
_pok2 = createMine ["APERSMine",(at modelToWorld[1,0,0]), [], 0]; ObjectsToCleanup pushback _pok2;
minefieldClear = true;
minecheck = {
	while {minefieldClear} do {
		if not (alive at)
		then {
		minefieldClear = false;
		sleep 3;
		["T4_mine",true,[localize "STR_T4_mineD",localize "STR_T4_mine","Move"],objNull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
		mineSucceeded = true;
		[] spawn Task4SubTaskcheck;
		//minefield Task Complete
		};
	};
};
[] spawn minecheck;
//study how to define mine defuse (alive-while check)
//FIA
_ammo1 = createvehicle ["IG_supplyCrate_F",[5193.14,21039.6,1],[],0,"none"]; ObjectsToCleanup pushback _ammo1;
_ammo2 = createvehicle ["Box_NATO_Grenades_F",[5193.07,21038.1,1],[],0,"none"]; ObjectsToCleanup pushback _ammo2;
_ammo3 = createvehicle ["Box_Wps_F",[5193.13,21037.2,1],[],0,"none"]; ObjectsToCleanup pushback _ammo3; //it's Randombox
_group = creategroup east;
_FIAunits = [];
_opforFIA = ["O_G_Soldier_F","O_G_Soldier_lite_F","O_G_Soldier_SL_F","O_G_Soldier_AR_F","O_G_medic_F","O_G_Soldier_GL_F","O_G_Soldier_M_F","o_g_soldier_unarmed_f","O_G_Soldier_F","O_G_Soldier_lite_F","O_G_Soldier_F","O_G_Soldier_lite_F"];
{_a = _group CreateUnit [_x,getMarkerpos "Task4FIAM",[],0,"NONE"]; _FIAunits pushback _a;} foreach _opforFIA;
[Getmarkerpos "Task4FIAM",_FIAunits,40,true,true,true,false] call Zen_OccupyHouse;


//roadblock
[getMarkerpos "task4roadblockM",295,115] call Createroadblock;
[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "task4roadblockM",getMarkerpos "task4roadblockM"] call CreatePatrol;
trg = createTrigger ["EmptyDetector", Getmarkerpos "Task4RoadblockM"];
trg setTriggerArea [20, 20, 0, true];
trg setTriggerActivation ["EAST", "PRESENT", true];
ClearRoadblock = false;
Roadblockcheck = {
	while {!ClearRoadblock} do {
		if (count list trg <= 0)
		then {
		ClearRoadblock = true;
		sleep 3;
		["T4_roadblock",true,[localize "STR_T4_roadblockD",localize "STR_T4_roadblock","Move"],objNull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
		RoadblockSucceeded = true;
		[] spawn Task4SubTaskcheck;
		//Roadblock Task Complete
		};
	};
};
[] spawn Roadblockcheck;
// Regroup
trg2 = createTrigger ["EmptyDetector", Getmarkerpos "Task4RegroupM"];
trg2 setTriggerArea [20, 20, 0, true];
trg2 setTriggerActivation ["WEST", "PRESENT", true];
Regroup = false;
Regroupcheck = {
	while {!Regroup} do {
		if (count list trg2 == count playableUnits)
		then {
		Regroup = true;
		sleep 3;
		["T4_Regroup",true,[localize "STR_T4_RegroupD",localize "STR_T4_Regroup","Move"],objNull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
		RegroupSucceeded = true;
		[] spawn Task4SubTaskcheck;
		};
	};
};
[] spawn Regroupcheck;
	//
};

//officer offroad waypoint _wp = (group this) addwaypoint [Getmarkerpos "Task4EscapeM",1]; _wp setwaypointType "MOVE";_wp2 = (group this) addwaypoint [Task4wp1M,1,1]; _wp2 setwaypointType "MOVE";
Task4HALO = {
HALO = true;
while {HALO} do {
if ((getPosATL player select 2) < 80) then {
_parachute = createvehicle ["Steerable_Parachute_F",getPosATL player,[],0,"none"];
player moveInAny _parachute;
[1,"",1,1] spawn BIS_fnc_fadeEffect;
HALO = false;
		};
	};
};
Task4script = {
{
_x setPosATL [4692.1,21378.9,1200];
_x setVelocity [round(random 250) -150, round(random 250) -150, 0];
_group = creategroup west;
[_x] joinsilent _group;
sleep 1;
} count allplayers;

[west,["T4"],[localize "STR_T4_SplitD",localize "STR_T4_Split",localize "STR_Move"],objNull,"Created" ,3,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T4";
sleep 1;
[west,["T4_Regroup","T4"],[localize "STR_T4_RegroupD",localize "STR_T4_Regroup",localize "STR_Move"],getMarkerpos "Task4RegroupM","Created" ,3,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T4_Regroup";
[west,["T4_AA","T4"],[localize "STR_T4_AAD",localize "STR_T4_AA",localize "STR_Move"],getMarkerpos "Task4AAM","Created" ,3,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T4_AA";
[west,["T4_mine","T4"],[localize "STR_T4_mineD",localize "STR_T4_mine",localize "STR_Move"],getMarkerpos "Task4mineM","Created" ,3,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T4_mine";
[west,["T4_roadblock","T4"],[localize "STR_T4_roadblockD",localize "STR_T4_roadblock",localize "STR_Move"],getMarkerpos "Task4roadblockM","Created" ,3,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T4_roadblock";
[west,["T4_Jammer","T4"],[localize "STR_T4_JammerD",localize "STR_T4_Jammer",localize "STR_Move"],getMarkerpos "Task4JammerM","Created" ,3,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T4_Jammer";
[] remoteExec ["Task4HALO"];
};

Task4end = {
playableUnits joinsilent (playableunits select 0);
group (playableunits select 0);group (playableunits select 0) selectleader (playableunits select 0);
[] spawn EndOfmission;
};

Task4Escape = {
//music start
/*
	_Task4heli = createVehicle ["O_Heli_Light_02_unarmed_F",getMarkerpos "Task4escapeM",[],0,"FLY"];  ObjectsToCleanup pushback _Task4heli; _Task4heli setPosATL (_Task4heli modelToWorld[0,0,100]); _Task4heli setdir 180;
	_group = creategroup east;
	_pilot = _group CreateUnit ["O_helipilot_F",getMarkerpos "Task4escapeM",[],0,"NONE"]; _pilot moveInAny _Task4heli; _Task4heli setPilotLight true;
	_pilot2 = _group CreateUnit ["O_helicrew_F",getMarkerpos "Task4escapeM",[],0,"NONE"];  _pilot2 moveInAny _Task4heli; [_pilot2] join _pilot;{_heliwp =  group _pilot addWaypoint [position _x, 0]; _heliwp setWaypointType "MOVE";} count playableunits;  _pilot flyinHeight 150; _Task4heli flyinHeight 150; */
	if (alive task4officer) then {
	[west,["T4_2"],[localize "STR_T4_EscapeD",localize "STR_T4_Escape",localize "STR_Kill"],task4officer,"ASSIGNED" ,3,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T4_2";
	_wp2 = group task4officer addwaypoint [Getmarkerpos "Task4wp1M",1]; _wp2 setwaypointType "MOVE";_wp = group task4officer addwaypoint [Getmarkerpos "Task4EscapeM",1]; _wp setwaypointType "MOVE";
	{_x assignAsCargo officerOffroad} foreach units Task4OfficerGuard;
	{_x moveincargo officerOffroad} foreach units Task4OfficerGuard;
	task4officer assignAsDriver officerOffroad; 
	//[task4officer] join Task4OfficerGuard;
	
	} else
	{
	playableUnits joinsilent (playableunits select 0);
	group (playableunits select 0);group (playableunits select 0) selectleader (playableunits select 0);
	[] spawn EndOfmission;
	deletevehicle trg;
	deletevehicle trg2;};
};
AASucceeded = false;
mineSucceeded = false;
JammeSucceeded = false;
RoadblockSucceeded = false;
Task4SubTaskcheck = {
	if (AASucceeded and mineSucceeded and JammeSucceeded and RoadblockSucceeded) then {
	[] spawn Task4Escape;
	//Tasks
	};
};
