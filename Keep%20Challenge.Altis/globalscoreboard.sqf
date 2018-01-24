//test.sqf 


//Define idc's for controls for easy access 

//store display, passed from onLoad 
//_display = _this select 0;
 //write all ever connected players
[profilename,player] remoteExecCall ["updatescore",2];
updatescore = {
  params ["_profilename","_player"];
  _profilename = _this select 0;
  _player = _this select 1;
// sort playerlist by Stair
_plist = ["Playerlist", "players","Players", "ARRAY"] call iniDB_read;
plistTolb = [];
{
_nickwithscore = ["Playerlist", "players", _x, "ARRAY"] call iniDB_read;
//filter players
if ((_nickwithscore select 1) >= 10 or (_nickwithscore select 2) >= 3) then {
	plistTolb pushBack _nickwithscore;
	publicvariable "plistTolb";
}
	} foreach _plist;
	
	 //[plistTolb] remoteExecCall ["createSB"];
};
 globalscoreboard = {
 disableSerialization;
 params ["_profilename","_player"];
   _profilename = _this select 0;
  _player = _this select 1;
[_profilename,_player] remoteExecCall ["updatescore",2];
 createDialog "global_scoreboard";
_listBoxNick = 1500;
_listBoxStair = 1501;
_listBoxCumbo = 1502;
// LBadd sorted array
_sortedplist = [plistTolb,[],{_x select 2},"DESCEND"] call bis_fnc_sortby;
{
lbadd [1500,(_x select 0)];
lbadd [1502,str (_x select 2)];
lbadd [1501,str (_x select 1)];
} foreach _sortedplist;
 };

/*
createSB = {
disableSerialization;
  params ["_plistTolb"];
  _plistTolb = _this select 0;

	};*/