
Task7Falserat = {
 [] spawn Task7Object;
 [] spawn Task7script;
};
Task7Object = {
//dead bodys
_deadbody1 = [[16787.8,12675.6,0.001194], Centereast,(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup; {_x setdamage 1} foreach units _deadbody1;
_deadbody2 = [Getmarkerpos "Task7StartM", Centerwest,(configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;{_x setdamage 1} foreach units _deadbody2;
_deadbody3 = [[16792.4,12651,0.00120163], Centereast,(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup; {_x setdamage 1} foreach units _deadbody3;
//allies
//enemys at villeage
_groupA = [(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry"),[16996.1,12676.1,0.00143433],[16822.2,12712.9,0.00160408]] call CreatePatrol; _groupA setBehaviour "AWARE";
_garri1 = [[16996.1,12676.1,0.00143433], Centereast,(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
[[16996.1,12676.1,0.00143433],units _garri1,30,true,true,true,false] call Zen_OccupyHouse;
_groupA = [(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry"),[16985.4,12649.8,0.00143051],[16822.2,12712.9,0.00160408]] call CreatePatrol; _groupA setBehaviour "AWARE";
_garri1 = [[16985.4,12649.8,0.00143051], Centereast,(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
[[16985.4,12649.8,0.00143051],units _garri1,30,true,true,true,false] call Zen_OccupyHouse;
_groupA = [(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry"),[16944.8,12619.2,0.00133514],[16822.2,12712.9,0.00160408]] call CreatePatrol; _groupA setBehaviour "AWARE";
_garri1 = [[16944.8,12619.2,0.00133514], Centereast,(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
[[16944.8,12619.2,0.00133514],units _garri1,30,true,true,true,false] call Zen_OccupyHouse;
_groupA = [(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry"),[16924.8,12578,0.00143433],[16822.2,12712.9,0.00160408]] call CreatePatrol; _groupA setBehaviour "AWARE";
_garri1 = [[16924.8,12578,0.00143433], Centereast,(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
[[16924.8,12578,0.00143433],units _garri1,30,true,true,true,false] call Zen_OccupyHouse;
//wreak cars
_strider = createvehicle ["I_MRAP_03_F",[16797.7,12664.1,-0.264067],[],0,"none"]; ObjectsToCleanup pushback _strider; _strider setdir 79.3885;_strider setdamage 0.8;
_strider sethit ["wheel_1_1_steering", 1]; _strider sethit ["wheel_2_1_steering", 1];  _strider lock true;
_truck = createvehicle ["C_Van_01_transport_F",[16879.6,12679.4,0.295961],[],0,"none"]; ObjectsToCleanup pushback _truck; _truck setdir 225.055; _truck setfuel 0;
_fuelTube = createvehicle ["FlexibleTank_01_forest_F",[16875.2,12688.1,0.644266],[],0,"none"]; ObjectsToCleanup pushback _fuelTube;_fuelTube allowdamage false;
[_fuelTube,["Grab","roll = true;[_this select 0,_this select 1] spawn Barrelroll;",nil,1.5,true,true]]  RemoteExec ["addaction"];

_truck addEventHandler ["GetIn", {
[west,["T7_Fuel"],[localize "STR_T7_FuelD",localize "STR_T7_Fuel",localize "STR_Move"],position _truck,"CREATED" ,3,true,"",true] call bis_fnc_taskCreate; _truck removeAlleventhandlers "GETIN";}];

waituntil {fuel _truck > 0};
["T7_Fuel",true,[localize "STR_T7_FuelD",localize "STR_T7_Fuel","Move"],objNull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
};

Task7Script = {
[player] remoteExec ["AmbientCombatsound"];
{_x setpos Getmarkerpos "Task7StartM"} foreach allplayers;
[west,["T7"],[localize "STR_T7_FalseRatD",localize "STR_T7_FalseRat",localize "STR_Move"],Getmarkerpos "Task7cemeteryM","ASSIGNED" ,3,true,"",true] call bis_fnc_taskCreate; 
trg = createTrigger ["EmptyDetector", Getmarkerpos "Task7cemeteryM"];
trg setTriggerArea [80, 80, 0, true];
trg setTriggerActivation ["WEST", "PRESENT", false];
trg setTriggerStatements ["this",
"
  [west,['T7_D1','T7'],[localize 'STR_T7_D1D',localize 'STR_T7_D1',localize 'STR_Move'],Getmarkerpos 'Task7cemeteryM','ASSIGNED' ,3,true,"",true] call bis_fnc_taskCreate;  
  [240,Task7D1E] spawn Countdown;
  [] spawn Task7D1;
  [] spawn Task7Defendhint;
",
""];
};
Task7D1 = {
sleep 1;
	_truck2 = createvehicle ["I_Truck_02_transport_F",GetMarkerpos "Task7truckposM",[],0,"none"]; ObjectsToCleanup pushback _truck2; _truck2 setdir 115.487;
	_truck = createvehicle ["I_Truck_02_transport_F",GetMarkerpos "Task7truckposM",[],0,"none"]; ObjectsToCleanup pushback _truck; _truck setdir 115.487;
	_truckgroup = [getMarkerPos "Task7truckposM", Centereast,(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
	{_x MoveinAny _truck} count units _truckgroup;
	units _truckgroup domove Getmarkerpos "Task7dz1m";_wp2 = _truckgroup addwaypoint [Getmarkerpos "Task7dz1M",1]; _wp2 setwaypointType "GETOUT"; _wp3 = _truckgroup addwaypoint [Getmarkerpos "Task7cemeteryM",1]; _wp3 setwaypointType "MOVE";
	while {!Missionend} do {
	_truckgroup = [getMarkerPos "Task7D1E1M", Centereast,(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	_trackwp =_truckgroup addWaypoint [Getmarkerpos "Task7cemeteryM", 1];
	_trackwp setWaypointType "MOVE";
    [units _truckgroup] spawn Trackwaypoint;
	sleep 100;
	};
};
Task7Defendhint = {
	Task7Defending = true;
	while {Task7Defending} do {
		if (count list trg < count playableunits)
		then {
			sleep 1;
			BIS_stopTimer = true; publicvariable "BIS_stopTimer";
			"적의 추가 증원이 오기 전까지는 모든 인원이 모여있어야 합니다!" remoteExec ["hintsilent"];
		} else {
			sleep 1;
			BIS_stopTimer = false; publicvariable "BIS_stopTimer";
		};
	};
};
Task7D1E = {
if (!isServer) Exitwith {};
Task7Defending = false;
deletevehicle trg;

mo1 = createVehicle ["I_Mortar_01_F",[17475.1,12947.4,0.0509586],[],0,"none"]; ObjectsToCleanup pushback mo1;
createVehicleCrew mo1;
mo2 = createVehicle ["I_Mortar_01_F",[17475.1,12947.4,0.0509586],[],0,"none"]; ObjectsToCleanup pushback mo2;
createVehicleCrew mo2;
mo3 = createVehicle ["I_Mortar_01_F",[17475.1,12947.4,0.0509586],[],0,"none"]; ObjectsToCleanup pushback mo3;
createVehicleCrew mo3;
mo4 = createVehicle ["I_Mortar_01_F",[17475.1,12947.4,0.0509586],[],0,"none"]; ObjectsToCleanup pushback mo4;
createVehicleCrew mo4;
mo1 doArtilleryFire [[17389.1,12566.7,0], "8Rnd_82mm_Mo_shells", 8];
mo2 doArtilleryFire [Getmarkerpos "Task7cemeteryM", "8Rnd_82mm_Mo_shells", 8];
mo3 doArtilleryFire [[17321.7,12601.4,0], "8Rnd_82mm_Mo_shells", 8];
mo4 doArtilleryFire [[17280.6,12559.5,0], "8Rnd_82mm_Mo_shells", 8];

["T7_D1",true,[localize "STR_T7_D1D",localize "STR_T7_D1","Move"],objNull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
[west,["T7_D2"],[localize "STR_T7_D2D",localize "STR_T7_D2",localize "STR_Move"],Getmarkerpos "Task7houseM","ASSIGNED" ,3,true,"",true] call bis_fnc_taskCreate; 
[] spawn Task7D2;
//_ETA = mo1 getArtilleryETA [Getmarkerpos "Task7cemeteryM","8Rnd_82mm_Mo_shells"];
};

Task7D2 = {
trg = createTrigger ["EmptyDetector", Getmarkerpos "Task7houseM"];
trg setTriggerArea [50, 50, 0, false];
trg setTriggerActivation ["WEST", "PRESENT", false];
trg setTriggerStatements ["this",
"
  {_x doArtilleryFire [Getmarkerpos 'Task7houseM', '8Rnd_82mm_Mo_Smoke_white', 8] } foreach [mo1,mo2,mo3,mo4];
  ['T7_D2',true,[localize 'STR_T7_D2D',localize 'STR_T7_D2','Move'],objNull,'ASSIGNED',0,true,true,'',true] call BIS_fnc_setTask;
  [240,Task7D2E] spawn Countdown;
  [] spawn Task7Defendhint;
  [] spawn Task7d2C;
",
""];
Task7d2C = {
	_truck = createvehicle ["I_Truck_02_transport_F",GetMarkerpos "Task7truckpos2M",[],0,"none"]; ObjectsToCleanup pushback _truck; _truck setdir -260;
	_truckgroup = [getMarkerPos "Task7truckpos2M", Centereast,(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
	{_x MoveinAny _truck} count units _truckgroup;
	units _truckgroup domove Getmarkerpos "Task7dz2m";_wp2 = _truckgroup addwaypoint [Getmarkerpos "Task7dz2M",1]; _wp2 setwaypointType "GETOUT"; _wp3 = _truckgroup addwaypoint [Getmarkerpos "Task7houseM",1]; _wp3 setwaypointType "MOVE";
	_ifrit = createvehicle ["I_MRAP_03_gmg_F",GetMarkerpos "Task7truckpos2M",[],0,"none"]; ObjectsToCleanup pushback _ifrit; _ifrit setdir -260;
	_ifritgroup = [getMarkerPos "Task7truckpos2M", Centereast,(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	{_x MoveinAny _ifrit} count units _ifritgroup;
	_wp = _ifritgroup addwaypoint [Getmarkerpos "Task7houseM",1];_wp setwaypointType "MOVE";
	};
};

Task7D2E = {
if (!isServer) Exitwith {};
Task7Defending = true;
deletevehicle trg;
['T7_D2',true,[localize 'STR_T7_D2D',localize 'STR_T7_D2','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask;
[west,["T7_MOVE"],[localize "STR_T7_moveD",localize "STR_T7_move",localize "STR_Move"],Getmarkerpos "Task7enterM","ASSIGNED" ,3,true,"",true] call bis_fnc_taskCreate; 

trg = createTrigger ["EmptyDetector", Getmarkerpos "Task7enterM"];
trg setTriggerArea [50, 50, 0, false];
trg setTriggerActivation ["WEST", "PRESENT", false];
trg setTriggerStatements ["this",
"
  ['T7_Move',true,[localize 'STR_T7_moveD',localize 'STR_T7_move','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask;
  {_x doArtilleryFire [Getmarkerpos 'Task7enterM', '8Rnd_82mm_Mo_shells', 8] } foreach [mo1,mo2,mo3,mo4];
  [west,['T7_D3'],[localize 'STR_T7_D3D',localize 'STR_T7_D3',localize 'STR_Move'],Getmarkerpos 'Task7enterM','ASSIGNED' ,3,true,"",true] call bis_fnc_taskCreate; 
  [] spawn Task7LD;
",
""];
Task7LD = {
sleep 40;
		_truck = createvehicle ["I_Truck_02_transport_F",GetMarkerpos "Task7truckpos2M",[],0,"none"]; ObjectsToCleanup pushback _truck; _truck setdir -260;
		_truckgroup = [getMarkerPos "Task7truckpos2M", Centereast,(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
		{_x MoveinAny _truck} count units _truckgroup;
		units _truckgroup domove Getmarkerpos "Task7dz3m";_wp2 = _truckgroup addwaypoint [Getmarkerpos "Task7dz3M",1]; _wp2 setwaypointType "GETOUT"; _wp3 = _truckgroup addwaypoint [Getmarkerpos "Task7enterM",1]; _wp3 setwaypointType "MOVE";
	
		_ugv1 = createvehicle ["I_UGV_01_rcws_F",GetMarkerpos "Task7truckpos2M",[],0,"none"]; ObjectsToCleanup pushback _ugv1; _ugv1 setdir -260; createVehicleCrew _ugv1;
		_wp = group (crew _ugv1 select 0) addwaypoint [Getmarkerpos "Task7enterM",1];_wp setwaypointType "MOVE";
sleep 80;
		_ifrit = createvehicle ["I_MRAP_03_gmg_F",GetMarkerpos "Task7truckpos2M",[],0,"none"]; ObjectsToCleanup pushback _ifrit; _ifrit setdir -260; createVehicleCrew _ifrit;
		_wp = group (crew _ifrit select 0) addwaypoint [Getmarkerpos "Task7enterM",1];_wp setwaypointType "MOVE";
		
sleep 150;
		_ifrit = createvehicle ["I_MRAP_03_gmg_F",GetMarkerpos "Task7truckpos2M",[],0,"none"]; ObjectsToCleanup pushback _ifrit; _ifrit setdir -260; createVehicleCrew _ifrit;
		_ugv2 = createvehicle ["I_UGV_01_rcws_F",GetMarkerpos "Task7truckpos2M",[],0,"none"]; ObjectsToCleanup pushback _ugv2; _ugv2 setdir -260; createVehicleCrew _ugv2;
		_wp = group (crew _ugv2 select 0) addwaypoint [Getmarkerpos "Task7enterM",1];_wp setwaypointType "MOVE";
		_wp = group (crew _ifrit select 0) addwaypoint [Getmarkerpos "Task7enterM",1];_wp setwaypointType "MOVE";
		_truckgroup = [getMarkerPos "Task7truckpos2M", Centereast,(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
		{_x MoveinAny _truck} count units _truckgroup;
		units _truckgroup domove Getmarkerpos "Task7dz3m"; _wp setwaypointType "MOVE";_wp2 = _truckgroup addwaypoint [Getmarkerpos "Task7dz3M",1]; _wp2 setwaypointType "GETOUT"; _wp3 = _truckgroup addwaypoint [Getmarkerpos "Task7enterM",1]; _wp3 setwaypointType "MOVE";
sleep 270;
		_apc1 = createvehicle ["B_MBT_01_TUSK_F",GetMarkerpos "Task7reinforceM",[],0,"none"]; ObjectsToCleanup pushback _apc1; _apc1 setdir 254; createVehicleCrew _apc1; _apc1 allowdamage false;
		_apc2 = createvehicle ["B_APC_Wheeled_01_cannon_F",GetMarkerpos "Task7reinforceM",[],0,"none"]; ObjectsToCleanup pushback _apc2; _apc2 setdir 254; createVehicleCrew _apc2;_apc2 allowdamage false;
		_apc3 = createvehicle ["B_APC_Wheeled_01_cannon_F",GetMarkerpos "Task7reinforceM",[],0,"none"]; ObjectsToCleanup pushback _apc3; _apc3 setdir 254; createVehicleCrew _apc3;_apc3 allowdamage false;
		_wp = group (crew _apc1 select 0) addwaypoint [Getmarkerpos "Task7enterM",1];_wp setwaypointType "MOVE";
		_wp = group (crew _apc2 select 0) addwaypoint [Getmarkerpos "Task7enterM",1];_wp setwaypointType "MOVE";
		_wp = group (crew _apc3 select 0) addwaypoint [Getmarkerpos "Task7enterM",1];_wp setwaypointType "MOVE";
		
		
		
/*// neeeeeed to change to something else way
		_trg = createTrigger ["EmptyDetector", Getmarkerpos "Task7enterM"];
		_trg setTriggerArea [50, 50, 0, false];
		_trg setTriggerActivation ["WEST", "PRESENT", false];
		_trg setTriggerStatements ["_apc1 in (list _trg) or _apc2 in (list _trg)",
"
[] spawn Task7D3E;
deletevehicle thistrigger;
",
""];
*/
waituntil {(_apc1 distance Getmarkerpos "Task7enterM") < 20 or (_apc2 distance Getmarkerpos "Task7enterM") < 20 or (_apc3 distance Getmarkerpos "Task7enterM") < 20};
[] spawn Task7D3E;
	};
};

Task7D3E = {
Task7Defending = false;
['T7_D3',true,[localize 'STR_T7_D3D',localize 'STR_T7_D3','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask;
[] spawn EndOfmission;
sleep 2;
['T7',true,[localize 'STR_T7_FalseRatD',localize 'STR_T7_FalseRat','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask;
};