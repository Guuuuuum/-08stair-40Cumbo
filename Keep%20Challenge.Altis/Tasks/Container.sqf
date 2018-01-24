Task5Container = {
[] call Task5Objects;
[] spawn Task5Script;
};

Task5Objects = {

T5Container = createvehicle ["Land_Cargo20_military_green_F",[18281.8,15492.4,0.0125122],[],0,"none"]; ObjectsToCleanup pushback T5Container; publicvariable "T5Container";

[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry"),[18159.3,15526.1,0.00128937],[18298.5,15533.6,0.00143814]] call CreatePatrol; 
[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry"),[18443.4,15561,0.00120544],[18296.3,15493.4,0.00141907]] call CreatePatrol;
[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),Getmarkerpos "Task5Br2M",Getmarkerpos "Task5GroundZeroM"] call CreatePatrol;
[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),Getmarkerpos "Task5ChurchM",Getmarkerpos "Task5GroundZeroM"] call CreatePatrol;

_postgroup1 = [getMarkerPos "Task5BrM", Centereast,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam")] call BIS_fnc_spawnGroup;
[Getmarkerpos "Task5BrM",units _postgroup1,10,true,true,true,false] call Zen_OccupyHouse;
_postgroup2 = [getMarkerPos "Task5CargoM", Centereast,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam")] call BIS_fnc_spawnGroup;
[Getmarkerpos "Task5CargoM",units _postgroup2,30,true,true,true,false] call Zen_OccupyHouse;
_postgroup3 = [getMarkerPos "Task5BrInM", Centereast,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSquad")] call BIS_fnc_spawnGroup;
[Getmarkerpos "Task5BrInM",units _postgroup3,30,true,true,true,false] call Zen_OccupyHouse;
_postgroup4 = [getMarkerPos "Task5Br2M", Centereast,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam")] call BIS_fnc_spawnGroup;

_group = creategroup east;

T5quad = createvehicle ["C_Quadbike_01_F",[17879.6,15037.9,0.000473022],[],0,"none"]; publicvariable "T5quad";
_tire= createvehicle ["Land_Tyre_F",[17879.6,15035.9,0.000473022],[],0,"none"];
_fire= createvehicle ["FirePlace_burning_F",[17879.6,15035.9,0.000473022],[],0,"none"];
_fire attachto [_tire,[0,0,0.1]];
_Rope = ropeCreate [T5quad, [0,-1,-1.05], _tire, [0, 0, 0], 3];
T5quad addEventHandler ["GetIn", {[_this select 2,_this select 0] spawn T5quadGetin}];

//church
_man1 = createvehicle ["C_man_1",[17895.8,15045.4,0.00143623],[],0,"none"]; ObjectsToCleanup pushback _man1;
[[ _man1,"c5efe_HonzaLoop"],"switchMove"] call BIS_fnc_MP;
_man1 setpos [17895.8,15045.4,0.00143623];
_man1 setdir 268.394;
_man2 = createvehicle ["C_man_polo_1_F",[18428.8,15574.3,-0.00990677],[],0,"none"]; ObjectsToCleanup pushback _man2;
[[ _man2,"c5efe_MichalLoop"],"switchMove"] call BIS_fnc_MP;
_man2 setpos [17895.7,15046,0.00143623];
_man2 setdir 268.394;
_man3 = createvehicle ["C_man_hunter_1_F",[18428.8,15574.3,-0.00990677],[],0,"none"];  ObjectsToCleanup pushback _man3;
[[ _man3,"HubSittingChairB_idle1"],"switchMove"] call BIS_fnc_MP;
_man3 setpos [17896.1,15042.7,0.00143623];
_man3 setdir 90;
_man4 = createvehicle ["C_man_polo_5_F",[18428.8,15574.3,-0.00990677],[],0,"none"]; ObjectsToCleanup pushback _man4;
[[ _man4,"HubSittingChaira_idle1"],"switchMove"] call BIS_fnc_MP;
_man4 setpos [17898.2,15045.7,0.00143623];
_man4 setdir 90;
_man5 = createvehicle ["C_man_w_worker_F",[18428.8,15574.3,-0.00990677],[],0,"none"];  ObjectsToCleanup pushback _man5;
[[ _man5,"HubSittingChairc_idle1"],"switchMove"] call BIS_fnc_MP;
_man5 setpos [17901,15042.8,0.00143623];
_man5 setdir 85;
//barrack trucks
_man1 = createvehicle ["O_Truck_03_covered_F",[18375.8,15287.2,1.00555992],[],0,"none"]; ObjectsToCleanup pushback _man1;
_man1 setdir 247.444;
_man2 = createvehicle ["O_Truck_03_covered_F",[18378.4,15282.4,1.0242519],[],0,"none"]; ObjectsToCleanup pushback _man2;
_man2 setdir 247.444;
_man3 = createvehicle ["O_Truck_03_transport_F",[18381.9,15274,1.0252953],[],0,"none"];  ObjectsToCleanup pushback _man3;
_man3 setdir 247.444;
_man4 = createvehicle ["O_Truck_02_covered_F",[18378,15259.9,1.042923],[],0,"none"]; ObjectsToCleanup pushback _man4;
_man4 setdir 352.503;
_man5 = createvehicle ["O_Truck_02_covered_F",[18373,15259.3,1.0434017],[],0,"none"];  ObjectsToCleanup pushback _man5;
_man5 setdir 352.503;
};




T5quadGetin = {
params ["_player","_veh"];
_player = _this select 0;
_veh = _this select 1;
/*
	if (driver _veh == _player and Raindrop <= 1) then {
	Comnum = [_player,"SteelRain"] call BIS_fnc_addCommMenuItem;
	};
*/
	["T5_quad",true,[localize "STR_T5_QuadD",localize "STR_T5_Quad","Move"],objNull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
	[west,["T5_Steelrain","T5"],[localize "STR_T5_SteelRainD",localize "STR_T5_SteelRain",localize "STR_Move"],Getmarkerpos "Task5Br2M","ASSIGNED" ,3,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T5_Steelrain";
	T5quad RemoveAllEventHandlers "Getin";
};

/*
T4QuadGetOut = {
params ["_player"];
_player = _this select 0;
[_player,Comnum] call BIS_fnc_removeCommMenuItem;
};
*/

Task5Truck = {
_truck = createvehicle ["O_Truck_03_transport_F",GetMarkerpos "Task5TruckM",[],0,"none"]; ObjectsToCleanup pushback _truck; _truck setdir 180;
_truckgroup = [getMarkerPos "Task5truckM", Centereast,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSquad")] call BIS_fnc_spawnGroup;
{_x MoveinAny _truck} count units _truckgroup;
 _wp = _truckgroup addwaypoint [Getmarkerpos "Task5EnteranceM",1]; _wp setwaypointType "GETOUT";_wp2 = _truckgroup addwaypoint [[15513,15760.3,27.9379],1]; _wp2 setwaypointType "MOVE";
 
 _t5trg = createTrigger ["EmptyDetector", [18281.8,15492.4,0.0125122]];
_t5trg setTriggerArea [3,1.2, 0, true];
_t5trg setTriggerActivation ["WEST", "PRESENT", false];
_t5trg setTriggerStatements ["count thislist == count playableunits",
"['T5_Repack',true,[localize 'STR_T5_RepackD',localize 'STR_T5_Repack','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask;
  ['T5',true,[localize 'STR_T5_ContainerD',localize 'STR_T5_Container','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask;
[] spawn EndOfmission;
deletevehicle thistrigger;
",
""];
};


Task5Script = {
[2035,8,1,18,50,0.7,1,0,0,0,0,0,0,0] remoteExec ["Naturefnc"];

for [{_y = 2.5; _s = 0}, {_s + 1 <= count playableunits}, {_y = _y - 1; _s = _s + 1}] do {
	playableunits select _s setpos (T5Container modelToWorld [_y,-0.8,-1.15]);
	sleep 0.1;
	};

[west,["T5"],[localize "STR_T5_ContainerD",localize "STR_T5_Container",localize "STR_Move"],objnull,"Created" ,3,true,"",true] call bis_fnc_taskCreate;  ["T5"] call TasksAddtoRemove;
sleep 1;
[west,["T5_quad","T5"],[localize "STR_T5_QuadD",localize "STR_T5_Quad",localize "STR_Move"],T5quad,"ASSIGNED" ,3,true,"",true] call bis_fnc_taskCreate;  ["T5_quad"] call TasksAddtoRemove;
	
_t5trg = createTrigger ["EmptyDetector", Getmarkerpos "Task5Br2M"];
_t5trg setTriggerArea [5,5, 0, false];
_t5trg setTriggerActivation ["ANY", "PRESENT", false];
_t5trg setTriggerStatements ["T5Quad in thislist",
"if (!([T5_Repack] call bis_fnc_taskexists)) then {
	['T5_Steelrain',true,[localize 'STR_T5_SteelRainD',localize 'STR_T5_SteelRain','Move'],objNull,'SUCCEEDED',0,true,true,'',true] call BIS_fnc_setTask;
	[west,['T5_Repack','T5'],[localize 'STR_T5_RepackD',localize 'STR_T5_Repack',localize 'STR_Move'],[18281.8,15492.4,0.0125122],'ASSIGNED' ,3,true,'',true] call bis_fnc_taskCreate;  TasksToCleanup pushback 'T5_Repack';
	[position T5quad] spawn Arty;
	[] spawn Task5Truck;
	deletevehicle thistrigger;
	}",
""];
};