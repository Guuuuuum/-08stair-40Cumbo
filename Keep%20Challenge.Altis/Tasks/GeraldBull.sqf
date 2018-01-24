
Task1GeraldBull = {
[] spawn Task1Object;
[] spawn Tasktype1;
Task1Markers = ["Task1tgM","Task1aM","Task1postM","Task1startM","Task1imM","task1campM"]; Publicvariable "Task1Markers";
{_x setpos Getmarkerpos "Task1StartM"} foreach allplayers;
};
Task1_addaction = {
	_object = (_this select 0);
	if (_object == note) then
	{
	_object addaction ["Take","[] call Task1Description2"];
	}
	else
	{
	Task1campfire addaction ["sleep 2 hours","[] remoteExec ['Task1rest2',2]",nil,1,true,true]; 
	Task1campfire addaction ["sleep 4 hours","[] remoteExec ['Task1rest4',2]",nil,1,true,true];
	Task1campfire addaction ["sleep 6 hours","[] remoteExec ['Task1rest6',2]",nil,1,true,true];
	};
};

Task1Object = {
_Task1post = createVehicle ["Land_Cargo_Tower_V3_F",getMarkerpos "Task1postM",[],0,"none"]; ObjectsToCleanup pushback _Task1post;
_opgrp = ["O_Soldier_F","O_Soldier_AR_F","O_HMG_01_high_F","O_soldier_UAV_F","O_Soldier_AA_F","O_Soldier_AT_F","O_soldier_M_F","O_Soldier_GL_F","O_medic_F"];
for [{_gn=0}, {_gn<9}, {_gn=_gn+1}] do
{
    _Task1postunits = _opgrp select _gn;
    ["Task1postM",EAST,30,0.1,[_Task1postunits],-1] spawn SBGF_fnc_garrison;
};
_group = creategroup east;
_Task1imcar = createVehicle ["C_Van_01_transport_F",getMarkerpos "Task1imM",[],0,"none"]; _Task1imcar setPosATL (_Task1imcar modelToWorld[0,0,1]); ObjectsToCleanup pushback _Task1imcar;
_Task1table = createVehicle ["Land_CampingTable_small_F",getMarkerpos "Task1tableM",[],0,"none"]; ObjectsToCleanup pushback _Task1table; note = createVehicle ["Land_Map_F",getMarkerpos "Task1tableM",[],0,"none"]; note setVariable ["_noteV",note,true]; publicVariable "note";note attachto [_Task1table,[0,0,0.45]];  [[note],"Task1_addaction",true,true] call BIS_fnc_MP;_Task1table setPosATL (_Task1table modelToWorld[0,0,2]);
_Task1imagent = createVehicle ["C_man_polo_2_F_euro",getMarkerpos "Task1imM",[],0,"none"]; _Task1imagent setdamage 1;
_Task1imrecon = [getMarkerPos "Task1tableM", CenterEast,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconSentry")] call BIS_fnc_spawnGroup;
_Task1c = createVehicle ["CamoNet_OPFOR_open_F",getMarkerpos "Task1aM",[],0,"none"]; ObjectsToCleanup pushback _Task1c;
_Task1a = createVehicle ["O_CargoNet_01_ammo_F",getMarkerpos "Task1aM",[],0,"none"]; ObjectsToCleanup pushback _Task1a;
_Task1b = createVehicle ["Land_BagBunker_Small_F",getMarkerpos "Task1bM",[],0,"none"]; _Task1b setdir 270; ObjectsToCleanup pushback _Task1b;
_Task1hmg = createVehicle ["O_HMG_01_high_F",getMarkerpos "Task1bM",[],0,"none"]; ObjectsToCleanup pushback _Task1hmg; _task1hmgg = _group createunit ["O_support_MG_F",getMarkerpos "Task1bM",[],0,"NONE"];  _task1hmgg moveinAny _Task1hmg; _task1hmg attachto [_Task1b,[0.3,-0.8,0.5]];  _Task1b setPosATL (_Task1b modelToWorld[0,0,2.8]); detach _Task1hmg; _Task1hmg setPosATL (_Task1b modelToWorld[0.3,-0.7,-0.4]); _Task1hmg setdir 90;
_Task1p1 = [getMarkerPos "Task1p1M", CenterEast,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
_Task1p2 = [getMarkerPos "Task1p2M", CenterEast,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
_Task1ad = [getMarkerPos "Task1aM", CenterEast,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam")] call BIS_fnc_spawnGroup;
_Task1p1wp =_Task1p1 addWaypoint [getMarkerpos "Task1startM", 0];
_Task1p1wp setWaypointType "SENTRY";
_Task1p2wp =_Task1p2 addWaypoint [getMarkerpos "Task1p1M", 0];
_Task1p2wp setWaypointType "SENTRY";
_Task1p1 setBehaviour "SAFE";
_Task1p2 setBehaviour "SAFE";
_Task1p1 setSpeedMode "LIMITED";
_Task1p2 setSpeedMode "LIMITED";
_Task1tgd = [getMarkerPos "Task1tgM", CenterEast,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam")] call BIS_fnc_spawnGroup;
Task1tgh = createVehicle ["C_scientist_F",getMarkerpos "Task1tgM",[],0,"none"];Task1tgh setVariable ["_Task1tghV",Task1tgh,true]; publicVariable "Task1tgh";
Task1campfire = createVehicle ["Land_Campfire_F",getMarkerpos "Task1campM",[],0,"none"]; Task1campfire setVariable ["Task1campfireV",Task1campfire,true]; publicVariable "Task1campfire"; ObjectsToCleanup pushback Task1campfire;
[[Task1campfire],"Task1_addaction",true,true] call BIS_fnc_MP;
};

Tasktype1 = {
//setDate [1990, 3, 22, 3, 0];
[1990,3,22,3,0,0,0,0,0,0,0,0,0,0] call naturefnc;
sleep 4;
[west,["T1"],[localize "STR_T1_Description",localize "STR_Gerald Bull","Move"],getMarkerpos "Task1imM",true,1,true,"Search",true] call bis_fnc_taskCreate; TasksToCleanup pushback "T1";
sleep 1;
[west,["T1_1","T1"],[localize "STR_T1_CampingD",localize "STR_T1_Camping","Move"],getMarkerpos "Task1campM","CREATED" ,2,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T1_1";
[true,["Task1startM","Task1imM","task1campM"]] call setMarkervisible;
[false,["Task1tgM","Task1aM","Task1postM"]] call setMarkervisible;
Task1tgh addEventHandler ["killed", "[] spawn Tasktype1_1"];
};

Task1Description2 = {
deletevehicle note;
["T1",true,[localize "STR_T1_2_Description",localize "STR_Gerald Bull","Move"],Task1tgh,"AUTOASSIGNED",0,true,true,"",true] call BIS_fnc_setTask;
[true,["Task1postM","Task1aM","Task1tgM"]] call setMarkervisible;
};

Tasktype1_1 = {
["T1",true,[localize "STR_T1_3_Description",localize "STR_Gerald Bull","Move"],objNull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
["T1_1"] call BIS_fnc_taskSetCurrent;
    _Task1tracker = [getMarkerPos "Task1imM", CenterEast,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam")] call BIS_fnc_spawnGroup;
	{_x enablefatigue false} count Units _Task1tracker;_trackwp = _Task1tracker addwaypoint [position (allplayers select 0),0]; _trackwp setwaypointType "MOVE";
	while {!Missionend} do {
    sleep 2; _trackwp setWaypointPosition [position (allplayers select 0), 0];
	};
};
Task1endobject = {
	Task1boat1= createVehicle ["B_Boat_Transport_01_F",getMarkerpos "Task1esM",[],0,"none"]; Task1boat1 setdir 180; ObjectsToCleanup pushback Task1boat1;
	Task1boat2= createVehicle ["B_Boat_Transport_01_F",getMarkerpos "Task1esM",[],0,"none"]; Task1boat2 setdir 180; Task1boat2 setPosATL (Task1boat1 modelToWorld[0,-6,0]); ObjectsToCleanup pushback Task1boat2;
	sleep 5;
	if  (isNil "Task1rested2") then {[] spawn Task1endTask};
};
Task1endTask = {
    ["T1_2",true,[localize "STR_T1_escape",localize "STR_T1_escaped","Move"],getMarkerpos "Task1esM","ASSIGNED",0,true,true,"",true] call BIS_fnc_setTask;
	_escapewithboat = true;
	while {_escapewithboat}
	do {
	sleep 2;
		if (count crew Task1boat1 + count crew Task1boat2 == count playableunits)
		then {
			_escapewithboat = false;
			sleep 5;
			[] spawn Task1escape;
			}
		else {}
	}; 
};
Task1escape = {
	    ["T1_2",true,[localize "STR_T1_escapedD",localize "STR_T1_escaped","Move"],getMarkerpos "Task1esM","SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
		[] spawn EndOfmission;
		[false,Task1Markers] call setMarkervisible;
	};
Task1rest2 = {
    Task1campfire remoteExec ["removeAllActions"];
	sleeptime = 2; publicvariable "sleeptime";
	[[],"SleepEffect",true,true] call BIS_fnc_MP;
	Task1rested2 = true; publicVariable "Task1rested2";
		Task1rest2sub = {
	    [west,["T1_1_1"],[localize "STR_T1_DestroyHeliD",localize "STR_T1_DestroyHeli",localize "Move"],getMarkerpos "Task1AAM","ASSIGNED" ,3,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T1_1_1";
		_Task1AAnet = createVehicle ["CamoNet_OPFOR_open_F",getMarkerpos "Task1AAM",[],0,"none"]; ObjectsToCleanup pushback _Task1AAnet;
		[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "Task1AAM",getMarkerpos "Task1AAM"] call CreatePatrol;
		AA1 = createVehicle ["O_static_AA_F",getMarkerpos "Task1AAM",[],0,"none"]; ObjectsToCleanup pushback AA1; AA1 allowdamage false; publicvariable "AA1";
		AA2 = createVehicle ["O_static_AA_F",getMarkerpos "Task1AAM",[],0,"none"]; AA2 setPosATL (AA1 modelToWorld[2,2,0]); ObjectsToCleanup pushback AA2; AA2 allowdamage false; publicvariable "AA2";
		Task1kaiman = createVehicle ["O_Heli_Attack_02_F",getMarkerpos "Task1esM",[],0,"FLY"]; echo "Task1Kaiman spawned"; ObjectsToCleanup pushback Task1kaiman; Task1kaiman setPosATL (Task1kaiman modelToWorld[0,0,100]);publicVariable "Task1kaiman"; Task1kaiman setdir 180;
		_group = creategroup east;
		_task1pilot = _group CreateUnit ["O_helipilot_F",getMarkerpos "Task1esM",[],0,"NONE"]; _task1pilot moveInAny Task1kaiman;
		_task1pilot2 = _group CreateUnit ["O_helicrew_F",getMarkerpos "Task1esM",[],0,"NONE"];  _task1pilot2 moveInAny Task1kaiman; [_task1pilot2] join _task1pilot;_kaimanwp = group _task1pilot addWaypoint [getMarkerpos "Task1esM", 0]; _kaimanwp setWaypointType "MOVE"; _task1pilot flyinHeight 150; Task1kaiman flyinHeight 150; 
		AAgetin = {
		if not (getPosATL Task1kaiman select 2 < 5) then {["T1_1_1",true,[localize "STR_T1_DestroyheliD",localize "STR_T1_DestroyHeli","Destroy"],Task1kaiman,"ASSIGNED",0,true,true,"",true] call BIS_fnc_setTask}
		};
		{
		AA1 addeventHandler ["Getin","[] spawn AAgetin"];
		AA2 addeventHandler ["Getin","[] spawn AAgetin"];
		} remoteExec ["bis_fnc_call"]; 
		["T1_1",true,[localize "STR_T1_CampingD",localize "STR_T1_Camping","Move"],getMarkerpos "Task1esM","SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
		sleep 3;
		_ak = 0; while {_ak <= 0} do {sleep 2; if (getPosATL Task1kaiman select 2 < 5 or not alive Task1kaiman) then {
		[] spawn Task1endTask;
		["T1_1_1",true,[localize "STR_T1_destroyhelisucceeded",localize "STR_T1_DestroyHeli","Destroy"],objnull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
		[west,["T1_2","T1"],[localize "STR_T1_escape",localize "STR_T1_escaped","Move"],getMarkerpos "Task1esM","ASSIGNED" ,2,true,"",true] call bis_fnc_taskCreate; 
		TasksToCleanup pushback "T1_2";		_ak = _ak + 1} else {}}
	    };
	[] spawn Task1rest2sub;
	sleep 2;
	[] spawn Task1endobject;
	[getMarkerpos "task1roadblock2M",180,0] call Createroadblock;
	[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "Task1roadblock2M",getMarkerpos "task1roadblock1M"] call CreatePatrol;
	[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "Task1roadblock1M",getMarkerpos "task1roadblock2M"] call CreatePatrol;
};
Task1rest4  ={
    Task1campfire remoteExec ["removeAllActions"];
	sleeptime = 4; publicvariable "sleeptime";
	[[],"SleepEffect",true,true] call BIS_fnc_MP;
	call Task1endobject;
	["T1_1",true,[localize "STR_T1_CampingD",localize "STR_T1_Camping","Move"],getMarkerpos "Task1esM","SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
	[west,["T1_2","T1"],[localize "STR_T1_escape",localize "STR_T1_escaped","Move"],getMarkerpos "Task1esM","ASSIGNED" ,2,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T1_2";
	[getMarkerpos "task1roadblock1M",180,0] call Createroadblock;
	[getMarkerpos "task1roadblock2M",180,0] call Createroadblock;
	[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "Task1roadblock2M",getMarkerpos "task1roadblock1M"] call CreatePatrol;
	[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "Task1roadblock1M",getMarkerpos "task1campM"] call CreatePatrol;
	[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "Task1esM",getMarkerpos "task1roadblock1M"] call CreatePatrol;
	[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "Task1roadblock1M",getMarkerpos "task1roadblock2M"] call CreatePatrol;
	[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "Task1esM",getMarkerpos "Task1esM"] call CreatePatrol;
};
Task1rest6 = {
    Task1campfire remoteExec ["removeAllActions"];
	sleeptime = 6; publicvariable "sleeptime";
	[[],"SleepEffect",true,true] call BIS_fnc_MP;
	call Task1endobject;
	["T1_1",true,[localize "STR_T1_CampingD",localize "STR_T1_Camping","Move"],getMarkerpos "Task1esM","SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
	[west,["T1_2","T1"],[localize "STR_T1_escape",localize "STR_T1_escaped","Move"],getMarkerpos "Task1esM","ASSIGNED" ,2,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T1_2";
	[getMarkerpos "task1roadblock1M",180,0] call Createroadblock;
	[getMarkerpos "task1roadblock2M",180,0] call Createroadblock;
	[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "Task1roadblock2M",getMarkerpos "task1roadblock1M"] call CreatePatrol;
	[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "Task1roadblock1M",getMarkerpos "task1roadblock2M"] call CreatePatrol;
	sleep 20;
    _Task1tracker = [getMarkerPos "Task1TrackerM", CenterEast,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_ReconSquad")] call BIS_fnc_spawnGroup;
	{_x enablefatigue false} count Units _Task1tracker;_trackwp = _Task1tracker addwaypoint [position (allplayers select 0),0]; _trackwp setwaypointType "MOVE";
	while {!Missionend} do {
    sleep 2; _trackwp setWaypointPosition [position (allplayers select 0), 0];
	};
};

SleepEffect = {
	[0,"BLACK",5,1] call BIS_fnc_fadeEffect;
	publicvariable "sleeptime";
	_hourlater = format ["%1 Hours later...",sleeptime];
	switch (sleeptime) do {
    case 2: {
	setDate [1990, 3, 22, 5, 0];
	1 setFog [0.3,0.3,5]; skipTime -24; 86400 setOvercast 0.7; skipTime 24; 5 setrain 0.2;
	sleep 5;
		};
    case 4: {
	setDate [1990, 3, 22, 7, 0];
	1 setFog 0.5;
	sleep 6; 
		};
	case 6: {
 	setDate [1990, 3, 22, 9, 0];
	setWind [10, 10, true]; 1 setWindForce 0.7;
    sleep 6; 
		};
	};
	[[[_hourlater,"<t align = 'center' shadow = '0' size = '0.7' font='PuristaBold'>%1</t>"]]] spawn BIS_fnc_typeText;
	[1,"BLACK",5,1] call BIS_fnc_fadeEffect;
};