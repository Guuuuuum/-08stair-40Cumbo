/*TODO

죽으면 UID array(deadlist)에 추가. 킥. join할때(initPlayerServer) deadlist UID에 있을 시 kick.
이벤트핸들러 추가, initPlayerServer Event script
//
트럭 사방으로 3000m의 거리 밖에서 적 자동스폰. 그룹따라 side 설정. 자동 웨이포인트.
트럭,APC탑승보병 연구.
//
Clear script (시체,인벤,잡템). 트럭 근처 (200m)의 차량 잔해는 제외.
alldead 복사. alldead에서 트럭에 가까운 오브젝트는 제외. 나머지 deletevehicle
//
랜덤보급. 낙하산 드랍. 트럭 정수리의 1000m고도에서 투하. 동시에 Trackwaypoint 적 생성.


waitUntil {time > 0};
waitUntil {!isNull player};
//if (Getplayeruid player in deadlist) then {serverCommand format ["#kick %1",name player]; "joined" remoteExec ["systemchat"];};
player setdamage 0.9;
format ["%1 Joined from playerserver",name player] remoteExec ["systemchat"];


//리스폰

1.노 리스폰. 주어진 유닛만 가능.사망시 킥벤

2.노 리스폰. 죽었던사람은 관전으로 전환

3.티켓 제한.
*/

/*
execVM "Functions.sqf";
execVM "emspawn.sqf";

[] spawn {
	supplydrop = true;
	while {supplydrop} do {
	sleep (random 600) + 300;
	execVM "supplydrop.sqf";
	};
};
*/


CenterEast = createCenter east;
CenterWest = createCenter west;
Centerindependent = createCenter independent;

listMaximumPlayers = []; // see in initPlayerServer.sqf
deadlist = [];
allievehicle = [];


deathplayer = {
params ["_player"];
_player = _this select 0;
deadlist pushBackUnique _player;
publicvariable "deadlist";

};

DefineScore = {
_manlist = [];


_checkdead = {
params ["_player"];
_player = _this select 0;
if (_player in deadlist) exitwith {"FF0000"};
if (!(_player in deadlist)) exitwith {"ffffff"};
};

{

_Tcolor = [_x] call _checkdead;
//systemchat _Tcolor;
_mantext = format["<t size='0.7' font='PuristaBold' color='#%2'>%1</t><br/>", _x, _Tcolor];

_manlist pushBackUnique _mantext; 
} foreach listMaximumPlayers;

_parsedtext = _manlist joinString ""; 

//need to define spawned vehicles first
// in vehicle init. set NAME variable first.
allievehicle pushbackuniqle this;







//TotalScore = _parsedtext;
publicvariable "TotalScore";
};









