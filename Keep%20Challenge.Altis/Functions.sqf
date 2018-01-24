/*
_Task1postunits = ["Task1postM",EAST,30,1,["O_Soldier_F","O_Soldier_AR_F","O_HMG_01_high_F","O_soldier_UAV_F","O_Soldier_AA_F","O_Soldier_AT_F","O_soldier_M_F","O_Soldier_GL_F","O_medic_F"],-1] spawn SBGF_fnc_garrison; 

garrison = {
private ["_garrisonM","_side","_radius","_units"]
*/

/*Garrison 1
_mem = Units this;
Garrison 2
_Task1post = createVehicle ["Land_Cargo_Tower_V3_F",getMarkerpos "Task1postM",[],0,"none"]; ObjectsToCleanup pushback _Task1post;
_opgrp = ["O_Soldier_F","O_Soldier_AR_F","O_HMG_01_high_F","O_soldier_UAV_F","O_Soldier_AA_F","O_Soldier_AT_F","O_soldier_M_F","O_Soldier_GL_F","O_medic_F"];
for [{_gn=0}, {_gn<9}, {_gn=_gn+1}] do
{
    _Task1postunits = _opgrp select _gn;
    ["Task1postM",EAST,30,0.1,[_Task1postunits],-1] spawn SBGF_fnc_garrison;
	};
*/

Zen_OccupyHouse = compileFinal preprocessFileLineNumbers "Zen_OccupyHouse.sqf"; //Garrison Teleport

CreatePatrol = {
	private ["_groupcfg","_pos","_destination"];
	_groupcfg= _this select 0;
	_pos = _this select 1;
	_destination = _this select 2;
	_patrol = [_pos, CenterEast,_groupcfg] call BIS_fnc_spawnGroup;
	_patrolwp =_patrol addWaypoint [_destination, 1];
	_patrolwp setWaypointType "MOVE";
	_patrolwpC = _patrol addwaypoint [position leader _patrol,1];_patrolwpC setwaypointType "CYCLE";
	_patrol setBehaviour "SAFE";
	_patrol setSpeedMode "LIMITED";
	_patrol;
	};
Trackwaypoint = {
params ["_wp"];
_wp = _this select 0;
while {!Missionend} do {
    {_x domove GetposATL (playableunits select 0)} foreach _wp;
	sleep 20;
	};
};
Createroadblock = {
private ["_pos","_dir","_gundir"];
_group = createGroup east;
_pos = _this select 0;
_dir = _this select 1;
_gundir = _this select 2;
_bunker = createVehicle ["Land_BagBunker_Small_F",_pos,[],0,"none"]; _bunker  setdir _dir; ObjectsToCleanup pushback _bunker;
_hmg = createVehicle ["O_HMG_01_high_F",_pos,[],0,"none"]; _gunner = _group createunit ["O_support_MG_F",_pos,[],0,"NONE"];  _gunner moveinAny _hmg;  _hmg  setdir _gundir;
_barrier = createVehicle ["RoadBarrier_F",_pos,[],0,"none"]; _barrier attachto [_bunker,[7,-5,-1.6]]; detach _barrier; ObjectsToCleanup pushback _barrier;
};
setMarkervisible = {
	private ["_visible","_markernames"];
	_visible= _this select 0;
	_markernames = _this select 1;
	{if (_visible) then {
	_x setMarkerSize [1,1]}
	else
	{_x setMarkerSize [0,0]};
	} foreach _markernames;
};

UnitDisableAI = {
	private ["_unit","_boolean"];
	_unit= _this select 0;
	_boolean= _this select 1;
	If (_boolean) then
	{
	_unit disableAI "MOVE";
	_unit disableAI "ANIM";
	_unit disableAI "FSM";
	}
	else
	{
	_unit enableAI "MOVE";
	_unit enableAI "ANIM";
	_unit enableAI "FSM";
	};
};

RefillMagazines = {
player setAmmo [CurrentWeapon player, 200];
_mplayer = primaryWeaponMagazine player select 0;
_a = {_x == _mplayer} count itemsWithMagazines player;
for [{_i=1}, {_i<=_a}, {_i=_i+1}] do
	{
    player removeItem (_mplayer)
	};
player addmagazines [_mplayer,_a];

_splayer = secondaryWeaponMagazine player select 0;
_b = {_x == _splayer} count itemsWithMagazines player;
for [{_i=1}, {_i<=_a}, {_i=_i+1}] do
{
    player removeItem (_splayer)
};
player addmagazines [_splayer,_a];
};

Randomfnc = {
params ["_functions"];
_functions = _this select 0;
_randomtask = _functions call bis_fnc_selectrandom;
//systemchat str _randomtask;
[] spawn _randomtask;
};

Naturefnc = {
params ["_year","_month","_day","_hour","_minit","_overcast","_rain","_fogValue","_fogDecay","_fogBase","_windE","_windN","_gusts","_waves"];
_year = _this select 0;
_month = _this select 1;
_day = _this select 2;
_hour = _this select 3;
_minit = _this select 4;
_overcast = _this select 5;
_rain = _this select 6;
_fogValue = _this select 7;
_fogDecay = _this select 8;
_fogBase = _this select 9;
_windE = _this select 10;
_windN = _this select 11;
_gusts = _this select 12;
_waves = _this select 13;
setDate [_year, _month, _day, _hour, _minit];
1 setovercast _overcast;
1 setrain _rain;
1 setfog [_fogValue,_fogDecay, _fogBase];
setwind [_windE,_windN,true];
1 setgusts _gusts;
1 setWindForce _gusts;
1 setWindStr _gusts;
1 setwaves _waves;
forceWeatherChange;
//[2035,8,1,12,0,0,0,0,0,0,0,0,0,0] call naturefnc
};

Arty = {
params ["_pos"];
_pos = _this select 0;
(vehicle player) setfuel 0;
(vehicle player) removeAllEventHandlers "GetIn";
_sc = createVehicle ["B_MBT_01_mlrs_F",[22906.8,16735.1,-0.0440264],[],0,"none"];
createVehicleCrew _sc;
_sc doArtilleryFire  [_pos,"12Rnd_230mm_rockets",12];
_sc2 = createVehicle ["B_MBT_01_mlrs_F",[22906.8,16735.1,-0.0440264],[],0,"none"];
createVehicleCrew _sc2;
_sc2 doArtilleryFire  [_pos,"12Rnd_230mm_rockets",12];
_sc3 = createVehicle ["B_MBT_01_mlrs_F",[22906.8,16735.1,-0.0440264],[],0,"none"];
createVehicleCrew _sc3;
_sc3 doArtilleryFire  [_pos,"12Rnd_230mm_rockets",12];
_sc4 = createVehicle ["B_MBT_01_mlrs_F",[22906.8,16735.1,-0.0440264],[],0,"none"];
createVehicleCrew _sc4;
_sc4 doArtilleryFire  [_pos,"12Rnd_230mm_rockets",12];
_ETA = _sc getArtilleryETA [_pos,"12Rnd_230mm_rockets"];
_Crossroad = [West,"HQ"];
[_Crossroad, format ["it's Raining. ETA %1.",_ETA]] RemoteExec ["Sidechat"];
sleep _ETA;
{{deletevehicle _x} foreach crew _x; deletevehicle _x} foreach [_sc,_sc2,_sc3,_sc4];
RainDrop = RainDrop + 1; publicVariable "RainDrop";
};

TasksAddtoRemove = {
params ["_task"];
_task = _this select 0;
TasksToCleanup pushback _task;
Publicvariable "TasksToCleanup";
};

Barrelroll = {

params ["_obj","_player","_act"];
_obj = _this select 0;
_player = _this select 1;
_act = _this select 2;
[_obj,_act] remoteExec ["removeAction"];
_rollA = _player addaction ["Release","roll = false;",nil,1.5,true,true];
while {roll} do {
	if (_obj distance _player < 2.3) then {
		_velocity = [0,0,0];
		_velocityX = (velocity _player select 0);
		_velocityY = (velocity _player select 1);
		_velocityZ = (velocity _player select 2);
		if (_velocityX > 0) then {_velocityX = (ceil _velocityX) - 0.3;_velocity set [0,_velocityX]} else {_velocityX = (floor _velocityX) + 0.3;_velocity set [0,_velocityX]};
		if (_velocityY > 0) then {_velocityY = (ceil _velocityY)  - 0.3;_velocity set [1,_velocityY]} else {_velocityY = (floor _velocityY) + 0.3;_velocity set [1,_velocityY]};
		_velocity set [2,_velocityZ];
		[_obj, _velocity] remoteExec ["setvelocity"]; sleep 0.01;
		};
	};
	waituntil {!roll or !alive player};
	[_player,_rollA] remoteExec ["removeAction"];
	[_obj,["Grab","roll = true;[_this select 0,_this select 1,_this select 2] spawn Barrelroll;",nil,1.5,true,true]]  RemoteExec ["addaction"];
};
//[cursortarget,["Grab","roll = true;[_this select 0,_this select 1,_this select 2] spawn Barrelroll;",nil,1.5,true,true]]  RemoteExec ["addaction"];

AmbientCombatsound = {
_unit = _this select 0;

private ["_explosions"];

_explosions =
[
"BattlefieldExplosions1_3D",
"BattlefieldExplosions2_3D",
"BattlefieldExplosions5_3D"
];

private ["_fireFights"];

_fireFights =
[
"BattlefieldFirefight1_3D",
"BattlefieldFirefight2_3D"
];

	{
[_forEachIndex, _explosions, _fireFights] spawn {
private ["_index","_explosions", "_fireFights"];

_index = _this select 0;

scriptName format ["initAmbientSounds.sqf: random sound playing - [%1]", _index];

_explosions = _this select 1;
_fireFights = _this select 2;

while {!Missionend} do {
sleep (1 + random 59);

private ["_sound"];
_sound = if (random 1 < 0.5) then
			{
_explosions call BIS_fnc_selectRandom
			}
else
			{
_fireFights call BIS_fnc_selectRandom
			};

playSound _sound;
			};
		};
	}
forEach [0,1,2]; 
};

weaponFilter = [];

{
	if (!( ["base",configname _x] call BIS_fnc_inString)
	 and !( ["fake",configname _x] call BIS_fnc_inString)
	 and !( ["snds_f",configname _x] call BIS_fnc_inString)
	 and !( ["SOS",configname _x] call BIS_fnc_inString)
	 and !( ["LRPS",configname _x] call BIS_fnc_inString)
	 and !( ["AMS",configname _x] call BIS_fnc_inString)
	 and !( ["KHS",configname _x] call BIS_fnc_inString)
	 and !( ["Core",configname _x] call BIS_fnc_inString)
	 and !( ["Default",configname _x] call BIS_fnc_inString)
	 and !(configname _x isKindof ["Mgun", configfile >> "CfgWeapons"])
	 
		) 	then {
		weaponFilter pushback (configname _x);
				}
	} forEach ([(configfile >> "CfgWeapons"),0,true] call BIS_fnc_returnChildren);
	
	
magazineFilter = [];
{
	if (!( ["base",configname _x] call BIS_fnc_inString)
	 and !( ["fake",configname _x] call BIS_fnc_inString)
	 and !( ["IED",configname _x] call BIS_fnc_inString)
	 and !( ["CA",configname _x] call BIS_fnc_inString)
	 and !( ["Chaff",configname _x] call BIS_fnc_inString)
	 and !( ["CMChaff",configname _x] call BIS_fnc_inString)
	 and !( ["CMFlare",configname _x] call BIS_fnc_inString)
	 and !( ["Default",configname _x] call BIS_fnc_inString)

	 and !(configname _x isKindof ["VehicleMagazine", configfile >> "CfgMagazines"])
	 
		) 	then {
		magazineFilter pushback (configname _x);
				}
	} forEach ([(configfile >> "CfgMagazines"),0,true] call BIS_fnc_returnChildren);
	
itemFilter = []; 
{
   if (
   !( ["base",configname _x] call BIS_fnc_inString)
   and !( ["fake",configname _x] call BIS_fnc_inString)
   and ((configname _x isKindof ["Itemcore", configfile >> "CfgWeapons"]))
   
   and !(configname _x isKindof ["Uniform_Base", configfile >> "CfgWeapons"])
   and !(configname _x isKindof ["Vest_NoCamo_Base", configfile >> "CfgWeapons"])
   and !(configname _x isKindof ["Vest_Camo_Base", configfile >> "CfgWeapons"])
   and !(configname _x isKindof ["H_HelmetB", configfile >> "CfgWeapons"])
   )
   then {    itemFilter pushback (configname _x);      } 
   } forEach ([(configfile >> "CfgWeapons"),0,true] call BIS_fnc_returnChildren);

	
	
RandomBoxWeapon = {
params ["_box","_rifle","_pistol","_launcher","_uniform","_vest","_headgear"];
_box = _this select 0;
_rifle = _this select 1;
_pistol = _this select 2;
_launcher = _this select 3;
_uniform = _this select 4;
_vest = _this select 5;
_headgear = _this select 6;

_maxcount = (ceil random 4) + (count allplayers);
_count = 0;
_selectrandom = [];
_randomitem = [];

while {_count <= _maxcount} do {
{


		if (_Rifle) then {
			 if (_x isKindof ["Rifle", configfile >> "CfgWeapons"]) then {
				_selectrandom pushback _x;

					};
			};
			
			
		if (_pistol) then {
				if (_x isKindof ["Pistol", configfile >> "CfgWeapons"]) then {
				_selectrandom pushback _x;

					};
			};
			
			
		if (_launcher) then {
		if (_x isKindof ["Launcher", configfile >> "CfgWeapons"]) then {
				_selectrandom pushback _x;

					};
			};
			
			
		if (_uniform) then {
		if (_x isKindof ["Uniform_Base", configfile >> "CfgWeapons"]) then {
				_selectrandom pushback _x;

					};
			};
			
			
		if (_vest) then {
		if ( 
		(_x isKindof ["Vest_NoCamo_Base", configfile >> "CfgWeapons"])
		or
		(_x isKindof ["Vest_Camo_Base", configfile >> "CfgWeapons"])
		) then {
				_selectrandom pushback _x;

					};
			};
			
			
		if (_headgear) then {
		if (_x isKindof ["H_HelmetB", configfile >> "CfgWeapons"]) then {
				_selectrandom pushback _x;

					};
			};
	} foreach weaponFilter;
	_randomitem = (_selectrandom call bis_fnc_selectrandom);
	_box additemcargoGlobal [_randomitem,1];
	_count = _count + 1;
	};
};


RandomBoxMagazine = {
params ["_box"];
_box = _this select 0;

_maxcount = (ceil random 3) + (count allplayers);
_count = 0;
_selectrandom = [];
_randomitem = [];

while {_count <= _maxcount} do {
{
				_selectrandom pushback _x;
	} foreach magazineFilter;
	_randomitem = (_selectrandom call bis_fnc_selectrandom);
	_box additemcargoGlobal [_randomitem,Ceil(random 5)];
	_count = _count + 1;
	};
};

RandomBoxitem = {
params ["_box"];
_box = _this select 0;

_maxcount = 1;
_count = 0;
_selectrandom = [];
_randomitem = [];

while {_count <= _maxcount} do {
{
				_selectrandom pushback _x;
	} foreach itemFilter;
	_randomitem = (_selectrandom call bis_fnc_selectrandom);
	_box additemcargoGlobal [_randomitem,1];
	_count = _count + 1;
	};
};

SwitchAnim = {
params ["_unit","_act"];
_unit = _this select 0;
_switchmove = _this select 1;
_unit disableAI "ANIM";
[_unit,_switchmove] remoteExec ["switchmove"];
};


//[_obj,"Release","roll = false;",nil,1.5,true,true,"",roll]  RemoteExec ["addaction"];


//defines
RainDrop = 0;publicVariable "RainDrop";

[false,AllvisibleMarkers] call setMarkervisible;