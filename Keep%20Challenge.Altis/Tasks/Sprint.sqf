
Task2Sprint = {
[] spawn Task2Object;
[] spawn Task2HeliStart;
sleep 5;
[west,["T2"],[localize "STR_T2_SprintD",localize "STR_T2_Sprint",localize "STR_Kill"],runner,"ASSIGNED" ,3,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T2";
setDate [2035, 9, 5, 12, 0];
};
Task2HeliStart = {
_group = creategroup west;
task2heli = createVehicle ["B_Heli_Transport_01_F",getMarkerpos "Task2HeliM",[],0,"none"]; publicvariable "task2heli"; ObjectsToCleanup pushback task2heli;
_pilot1 = _group createunit ["B_Helipilot_F",getMarkerpos "Task2HeliM",[],0,"NONE"];_pilot1 moveInDriver task2heli;
_pilot2 = _group createunit ["B_Helipilot_F",getMarkerpos "Task2HeliM",[],0,"NONE"];_pilot2 moveInTurret [task2heli,[0]];
task2heli engineon true; task2heli allowdamage false;
[task2heli,Task2HeliC] remoteExec ["bis_fnc_Unitplay"];
sleep 2;
{_x moveinAny task2heli} count playableUnits;
//[task2heli,Task2HeliC] call bis_fnc_Unitplay;
[_pilot1,true] call UnitDisableAI;
[_pilot2,true] call UnitDisableAI; 
//[task2heli] spawn Task2Stopheli;
sleep 2;
{moveOut _x} count playableUnits;
task2heli lock true;
[180,Task2TimeOver] spawn Countdown; 
// needto put start countdown code
sleep 10;
[runner] spawn Task2Running;
task2Runnerdead = {
		[] spawn Task2Return;
		["T2",true,[localize "STR_T2_1_SprintD",localize "STR_T2_Sprint","Move"],objNull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
		[west,["T2_1","T2"],[localize "STR_T2_EVACD",localize "STR_T2_EVAC",localize "STR_Getin"],task2heli,"ASSIGNED" ,3,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T2_1";
		task2heli lock false;
		_RunnerIsAlive = false
	};
runner addEventHandler ["killed", "[] spawn task2Runnerdead"];
		/*
_RunnerIsAlive = true;
while {_RunnerIsAlive}
do {
sleep 2;
	if (alive runner)
	then {} 
	else {

		}
	}; //need to check local underbar
*/
};
/*
Task2Stopheli = {
private ["_heli"];
_heli = _this select 0;
fixheli = true;
while {fixheli} do {_heli setVelocity [0, 0, 0]};
};
*/
Task2Object = {
_group = creategroup east;
_group2 = creategroup east;
_group3 = creategroup east;
FIAunits = [];
FIAunits2 = [];

//Main Target spawn
runner = _group2 createunit ["O_G_officer_F",getMarkerpos "Task2houseM",[],0,"NONE"];  FIAunits pushback runner; Publicvariable "runner";

//House 1 Garrison spawn
_opforFIA = ["O_G_Soldier_F","O_G_Soldier_lite_F","O_G_Soldier_SL_F","O_G_Soldier_AR_F","O_G_medic_F","O_G_Soldier_GL_F","O_G_Soldier_M_F","o_g_soldier_unarmed_f","O_G_Soldier_F","O_G_Soldier_lite_F","O_G_Soldier_F","O_G_Soldier_lite_F"];
_opforFIA2 = ["O_G_Soldier_F","O_G_Soldier_lite_F","O_G_Soldier_SL_F","O_G_Soldier_AR_F"];
{_a = _group CreateUnit [_x,getMarkerpos "Task2houseM",[],0,"NONE"]; FIAunits pushback _a;sleep 0.7} foreach _opforFIA;
[Getmarkerpos "Task2houseM",FIAunits,20,true,true,true,false] call Zen_OccupyHouse;

//rightside enemy spawn. this cause Heli leave bug
//{_c = _group3 CreateUnit [_x,getMarkerpos "Task2YardM",[],0,"NONE"]} foreach _opforFIA2;

//Runner house 2 spawn
{_b = _group2 CreateUnit [_x,getMarkerpos "Task2runM",[],0,"NONE"]; FIAunits2 pushback _b;sleep 1} foreach _opforFIA2;
[Getmarkerpos "Task2runM",FIAunits2,20,true,true,true,false] call Zen_OccupyHouse;

//Offroad HMG
_task2hmgcar = createVehicle ["O_G_Offroad_01_armed_F",getMarkerpos "Task2hmgM",[],0,"none"]; ObjectsToCleanup pushback _task2hmgcar;
_task2hmgGunner = _group CreateUnit ["o_g_soldier_unarmed_f",getMarkerpos "Task1hmgM",[],0,"NONE"]; _task2hmgGunner moveInGunner _task2hmgcar; 

    Task2switchRun = {
		runner disableAI "ANIM";
		isRunning = true; Publicvariable "isRunning";
		_act = animationState runner;
		while{alive runner and isRunning}
		do
		{runner switchmove "AmovPercMevaSnonWnonDf";
		waitUntil{_act != "AmovPercMevaSnonWnonDf"
		};  
	};
};
	Task2stopRun = {
	if (alive runner) then {
	StopRun = {runner switchmove ""}; [[],"StopRun",true,true] call BIS_fnc_MP;
	runner setpos Getmarkerpos "Task2runM";
	isRunning = false;
	runner enableAI "ANIM";
	};
};
//runner running
    Task2Running = {
	[[],"Task2switchrun",true,true] call BIS_fnc_MP;
	sleep 1;
    [runner,Task2runningC] call bis_fnc_Unitplay;
	[[],"Task2stopRun",true,true] call BIS_fnc_MP;
    };
};

Task2Return = {
//define Heli cargo units
isAwaiting = true;
task2crews = crew task2heli;
	[] spawn {while {isAwaiting} do
		{sleep 2; _cargocrew = crew task2heli - task2crews; 
			if (_cargocrew isEqualto playableunits)
			then {
			task2heli lock true;
			[[],"StopCountdown",true,true] call BIS_fnc_MP;
			{[_x,false] call UnitDisableAI;} foreach task2crews;
			sleep 7;
			["T2_1",true,[localize "STR_T2_EVACD",localize "STR_T2_EVAC","Move"],objNull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
			[[],"EndOfmission",true,true] call BIS_fnc_MP;
			isAwaiting = false;
			}
			else {
			};
		};
	};
};
Task2TimeOver = {
_group = creategroup east;
_task2hmgcar = createVehicle ["O_G_Offroad_01_armed_F",getMarkerpos "Task2roadM",[],0,"none"]; ObjectsToCleanup pushback _task2hmgcar; _task2hmgcar setdir 240;
_task2hmgdriver = _group CreateUnit ["o_g_soldier_unarmed_f",getMarkerpos "Task2roadM",[],0,"NONE"]; _task2hmgdriver moveInDriver _task2hmgcar; 
_task2hmgGunner = _group CreateUnit ["o_g_soldier_unarmed_f",getMarkerpos "Task2roadM",[],0,"NONE"]; _task2hmgGunner moveInGunner _task2hmgcar;
_reinforcewp =_group addWaypoint [Getmarkerpos "Task2houseM", 0];
_reinforcewp setWaypointType "MOVE";
};