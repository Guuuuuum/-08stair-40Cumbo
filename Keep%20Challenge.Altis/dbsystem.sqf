Missioncount = 0;

if (isServer) then {
call compile preProcessFile "\inidbi\init.sqf";

 playernicknames = [];
 PlayerID = [];
 publicvariable "playernicknames";
};
enableSaving [false, false];
addplayerlist = {
params ["_profilename"];
_profilename = _this select 0;
 playernicknames - [_profilename];
 playernicknames pushback _profilename;
 publicvariable "playernicknames";
//All ever connected players list
 _plist = ["Playerlist", "players","Players", "ARRAY"] call iniDB_read;
 _plist = _plist - [_profilename];
_plist append [_profilename];
["Playerlist", "players","Players",_plist] call iniDB_write;
 };
 
 PlayerlistNow = {
	params ["_name","_id"];
	_name = _this select 0;
	_id = _this select 1;
	_temp = compile "_name = _id";
	[] call _temp;
	
	if (!(_name in playerID)) then {
	
		playerID pushback _name;
	};
 };
 // need to rewrite by onPlayerConnected
[profilename] remoteExec ["addplayerlist",2]; 
[profilename,clientOwner] RemoteExec ["PlayerlistNow",2];
execVM "globalscoreboard.sqf";
execVM "weaponsave.sqf";

 //{ need to excuted by GLOBAL. excute when saving rank in EndofMission
 Writeinfo = {
params ["_profilename","_player"];
 _profilename = _this select 0;
_player = _this select 1;
_nickwithscore = ["Playerlist", "players", _profilename, "ARRAY"] call iniDB_read;
// make db to first connected player
_isitnil = _nickwithscore select 1;
	if (isNil "_isitnil") then {
		_nickwithscore set [0,_profilename];
		_nickwithscore set [1,0];
		_nickwithscore set [2,0];
		["Playerlist", "players",_profilename,_nickwithscore] call iniDB_write;
	};
//add Cumbo
_nickwithscore = ["Playerlist", "players", _profilename, "ARRAY"] call iniDB_read;
	if (_nickwithscore select 1 < score _player) then
	{
		_nickwithscore set [1,score _player];
		["Playerlist", "players",_profilename,_nickwithscore] call iniDB_write;
	};
//add Stair
	if (_nickwithscore select 2 < Missioncount) then
	{
		_nickwithscore set [2,Missioncount];
		["Playerlist", "players",_profilename,_nickwithscore] call iniDB_write;
	};
//} foreach playernicknames;
};
[profilename,player] remoteExec ["Writeinfo",2];// IMPORTANT!! IT'S SAVE PLAYER's INFO
everConnected = {
  

};
 //};
 //[] remoteExec ["addplayerlist"];
//_players = ["playerlist",getPlayerUID player, profilename,profilenamesteam] call iniDB_write;