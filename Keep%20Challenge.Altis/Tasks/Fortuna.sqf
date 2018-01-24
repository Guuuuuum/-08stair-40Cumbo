Task3Fortuna = {
[] spawn Task3Object;
[] spawn Task3selectRandom1;
setDate [2035, 9, 10, 20, 0];
};

Task3Object = {
_group = creategroup west;
task3truck = createVehicle ["C_Van_01_transport_F",getMarkerpos "Task3StartM",[],0,"none"]; publicvariable "task2heli"; ObjectsToCleanup pushback task3truck;
driver1 = _group createunit ["C_man_p_shorts_1_F_afro",getMarkerpos "Task3StartM",[],0,"NONE"];driver1 moveInDriver task3truck;
_driver2 = _group createunit ["C_man_shorts_2_F_afro",getMarkerpos "Task3StartM",[],0,"NONE"];_driver2 moveInany task3truck;
_truckwp =group driver1 addWaypoint [getMarkerpos "Task3t3M", 0];
_truckwp setWaypointType "MOVE";
task3truck engineon true; task3truck allowdamage false;
{_x moveinAny task3truck} count playableUnits;
desk = createVehicle ["Land_TableDesk_F",getMarkerpos "Task3houseM",[],0,"none"]; ObjectsToCleanup pushback desk; publicvariable "desk";
desk setpos [10631.6,12278.6,1];
desk setdir 223.487;
intel = createVehicle ["Land_Notepad_F",getMarkerpos "Task3houseM",[],0,"none"]; publicVariable "intel";
intel attachto [desk,[0,0,0.45]];  [] remoteExec ["intelRandom"];
[west,["T3"],[localize "STR_T3_FortunaD",localize "STR_T3_Fortuna",localize "STR_recive"],intel,"ASSIGNED" ,3,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T3";
sleep 60;
[driver1,true] call UnitDisableAI; 
{moveOut _x} count playableUnits;
moveout driver1;
};

Task3Object_2 = {
if (!isnil "taken") then {
removeAllactions intelcarrier1;
};
	//Task Return
	["T3",true,[localize "STR_T3_FortunaD",localize "STR_T3_Fortuna","Move"],objnull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
	_group = creategroup west;
	natoRetrive = [getMarkerPos "Task3ReturnM", CenterWest,(configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;publicvariable "natoRetrive";
	task3officer = _group CreateUnit ["B_officer_F",getMarkerpos "Task3ReturnM",[],0,"NONE"]; publicvariable "task3officer";
	[] remoteExec ["Task3delivery"];
	[west,["T3_1"],[localize "STR_T3_ReturnD",localize "STR_T3_Return",localize "STR_Move"],task3officer,"ASSIGNED" ,3,true,"",true] call bis_fnc_taskCreate;  TasksToCleanup pushback "T3_1";
};

Task3delivery = {
task3officer addaction ["Give intel","[] spawn deliveryEvent"];
};

deliveryEvent = {
removeAllactions task3officer;
if (!isNil "event2N") then {
switch (event2N) do {
		case 5: {
					Spyofficer = {
					["T3_1",true,[localize "STR_T3_ReturnD",localize "STR_T3_Return","Move"],objnull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
					[] spawn EndOfmission;
					};
			_group = creategroup east;
			[task3officer] joinsilent _group;
			{[_x] joinsilent _group} foreach units natoRetrive;
			task3officer addEventHandler ["killed", "[] spawn Spyofficer"];
			//need moar situlations
			};
		case 6: {
			backintel = createVehicle ["Land_File1_F",getMarkerpos "Task3houseM",[],0,"none"]; publicVariable "backintel"; ObjectsToCleanup pushback backintel;
			backintel attachto [desk,[0,0,-0.3]];  [] remoteExec ["gobackintel"];
			//goback task;
			[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "Task3houseM",getMarkerpos "Task3houseM"] call CreatePatrol;
			_gobackenemy = [(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),getMarkerPos "Task3houseM",getMarkerpos "Task3houseM"] call CreatePatrol;
			[Getmarkerpos "Task3houseM",units _gobackenemy,20,true,true,true,false] call Zen_OccupyHouse;
			["T3_1",true,[localize "STR_T3_ReturnD",localize "STR_T3_Return","Move"],objnull,"FAILED",0,true,true,"",true] call BIS_fnc_setTask;
			sleep 3;
			["T3_1",true,[localize "STR_T3_gobackD",localize "STR_T3_goback","Move"],backintel,"ASSIGNED",0,true,true,"",true] call BIS_fnc_setTask;
			};	
/*		case nil : {
		[] spawn EndOfmission
		};*/
		default {
		["T3_1",true,[localize "STR_T3_ReturnD",localize "STR_T3_Return","Move"],objnull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
		[] spawn EndOfmission;
			};
		};
	}
		else {
		RemoteExec ["StopCountdown"];
		["T3_1",true,[localize "STR_T3_ReturnD",localize "STR_T3_Return","Move"],objnull,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
		[] spawn EndOfmission;;
	};
};


gobackintel = {
	backintelFn = {
	event2N = 1;
	deletevehicle backintel;
	["T3_1",true,[localize "STR_T3_gobackD",localize "STR_T3_goback","Move"],backintel,"SUCCEEDED",0,true,true,"",true] call BIS_fnc_setTask;
	sleep 1;
	["T3_1",true,[localize "STR_T3_gobackD_1",localize "STR_T3_goback","Move"],task3officer,"ASSIGNED",0,true,true,"",true] call BIS_fnc_setTask;
	//Return again Task
	[] remoteExec ["Task3delivery"];
	};
backintel addaction ["Take","[] call backintelFn"];
};

intelRandom = {
	intel addaction ["Take","[] call Task3selectRandom2"];
};

Task3selectRandom1 = {
		_fia = {
		_FIAunits = [];
		_group = creategroup east;
		_opforFIA = ["O_G_Soldier_F","O_G_Soldier_lite_F","O_G_Soldier_SL_F","O_G_Soldier_AR_F","O_G_medic_F","O_G_Soldier_GL_F","O_G_Soldier_M_F","o_g_soldier_unarmed_f"];
		{_a = _group CreateUnit [_x,getMarkerpos "Task3houseM",[],0,"NONE"]; _FIAunits pushback _a;sleep 0.7} foreach _opforFIA;
		[Getmarkerpos "Task3houseM",_FIAunits,20,true,true,true,false] call Zen_OccupyHouse;
		};
		
		
		_aaf = {
		_aafgroup = [(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad"),getMarkerPos "Task3houseM",getMarkerpos "Task3houseM"] call CreatePatrol;
		[Getmarkerpos "Task3houseM",units _aafgroup,20,true,true,true,false] call Zen_OccupyHouse;
		};
		
		
		_tresure = {
		_ammo1 = createVehicle ["Box_NATO_Wps_F",getMarkerpos "Task3houseM",[],0,"none"]; ObjectsToCleanup pushback _ammo1;
		_ammo1 setpos [10629.6,12273.6,1]; _ammo1 setdir 223.487;
		_ammo2 = createVehicle ["Box_NATO_Ammo_F",getMarkerpos "Task3houseM",[],0,"none"];ObjectsToCleanup pushback _ammo2;
		_ammo2 attachto [_ammo1,[0,0,0.4]];
		_group = creategroup east;
		_opforFIA = ["O_G_Soldier_F","O_G_Soldier_lite_F"];
		{_a = _group CreateUnit [_x,getMarkerpos "Task3houseM",[],0,"NONE"]; _a setpos [10631.6,12276.6,1];sleep 0.7} foreach _opforFIA;
		};
		
		_Boobytrap = {
		sleep 3;
		claymore = createVehicle ["ClaymoreDirectionalMine_Remote_Ammo_Scripted",getMarkerpos "Task3houseM",[],0,"none"]; publicvariable "claymore";
		claymore attachto [desk,[0,0,0.45]];
		claymore attachto [desk,[0.7,-0.32,0.43]];
		claymore setdir 300;
		booby = true; publicvariable "booby";
		};
		
		
	_situation1 = [_fia,_aaf,_tresure,_Boobytrap];
	[_situation1] call Randomfnc;
};

Task3selectRandom2 = {
	deletevehicle intel;
	if (isNil "booby") then {
	}
	else {claymore setdamage 1;};
		_trap = {
		//light off by CSAT
		 {
		_x setHit ["light_1_hitpoint", 0.97];
		_x setHit ["light_2_hitpoint", 0.97];
		_x setHit ["light_3_hitpoint", 0.97];
		_x setHit ["light_4_hitpoint", 0.97];
		} forEach nearestObjects [player, ["Lamps_base_F","PowerLines_base_F","PowerLines_Small_base_F"], 500];
		"lights_off" remoteExec ["playsound"];
		_csatgroup = [(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconPatrol"),getMarkerPos "Task3t1M",getMarkerpos "Task3houseM"] call CreatePatrol; _csatgroup setBehaviour "AWARE";
		_csatgroup2 = [(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconPatrol"),getMarkerPos "Task3t2M",getMarkerpos "Task3houseM"] call CreatePatrol; _csatgroup2 setBehaviour "AWARE";
		_csatgroup3 = [(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconPatrol"),getMarkerPos "Task3t3M",getMarkerpos "Task3houseM"] call CreatePatrol; _csatgroup3 setBehaviour "AWARE";
		_csatgroup4 = [(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconPatrol"),getMarkerPos "Task3t4M",getMarkerpos "Task3houseM"] call CreatePatrol; _csatgroup4 setBehaviour "AWARE";
		[] spawn Task3Object_2;
		};
		
		_bomb = {
		_Task3bombtimeover = {
		charge setdamage 1;
		RemoteExec ["StopCountdown"];
		};
		charge = "DemoCharge_Remote_Ammo_Scripted" createVehicle position player; publicvariable "charge"; ObjectsToCleanup pushback charge;
		charge attachTo [player,[0.1, 0.1, 0.8]];
		charge setVectorDirAndUp [ [0.5, 0, 0], [-0.5, 0.5, 0] ];
		[300,_Task3bombtimeover] spawn Countdown;
		[] spawn Task3Object_2;
		//systemchat "STR_T3_bomb";
		};
		
		_spy = {
		//Task Return
		event2N = 5;
		[] spawn Task3Object_2;

		};
		
		_goback = {
		//Task Return
		event2N = 6;
		[] spawn Task3Object_2;

		};
		
		_taken = {
			takenintel = {
			[intelcarrier1,["Take","[] spawn Task3Object_2"]] remoteExec ["addaction"];
			//intelcarrier1 addaction ["Take","[] spawn Task3Object_2"]
			};
		//Task to new intelcarrier
		event2N = 9;
		taken = true; publicvariable "taken";
		_group = creategroup east;
		intelcarrier1 = _group createunit ["O_recon_F",getMarkerpos "Task3t3M",[],0,"NONE"]; publicvariable "intelcarrier1";
		intelcarrier2 = _group createunit ["O_recon_M_F",getMarkerpos "Task3t3M",[],0,"NONE"];
		_carrierwp = group intelcarrier1 addWaypoint [GetMarkerpos "Task1tableM", 0];
		_carrierwp setWaypointType "MOVE";
		[] remoteExec ["takenIntel"];
		["T3",true,[localize "STR_T3_FortunaD",localize "STR_T3_Fortuna","Move"],objnull,"FAILED",0,true,true,"",true] call BIS_fnc_setTask;
		sleep 3;
		["T3",true,[localize "STR_T3_takenD",localize "STR_T3_taken","Move"],intelcarrier1,"ASSIGNED",0,true,true,"",true] call BIS_fnc_setTask;
		};
		
		
	_situation2 = [_trap,_bomb,_goback,_taken]; //_spy removed
	[_situation2] call Randomfnc;
	[(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad"),getMarkerPos "Task3enemy1M",getMarkerpos "Task3t3M"] call CreatePatrol; 
	
};
