enableSaving [false, false];
// Publicvariable "Alltasks";
AllvisibleMarkers = ["Task1tgM","Task1aM","Task1postM","Task1startM","Task1imM","task1campM"]; Publicvariable "AllvisibleMarkers";
[] execVM "Tasks\GeraldBull.sqf";
[] execVM "Tasks\Sprint.sqf";
[] execVM "Tasks\Fortuna.sqf";
[] execVM "Tasks\Split.sqf";
[] execVM "Tasks\Container.sqf";
[] execVM "Tasks\IntoForest.sqf";
[] execVM "Tasks\Falserat.sqf";
[] execVM "Tasks\code.sqf";
[] execVM "Functions.sqf";
[] execVM "Countdown.sqf";
//[] execVM "HeliCapture.sqf";
[] execVM "gamestart.sqf";
[] execVM "Fastrope.sqf";
[] execVM "EndOfmission.sqf";
[] execVM "dbsystem.sqf";

//
["a3\missions_f\video\infantry.ogv","108계단 40단 컴보 Ver.0.1"] call BIS_fnc_titlecard;
[
	[
		["이 서버는 일체 리바이브와 리스폰이 존재하지 않는, 하드코어 서버입니다.","<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t>"],
		["아군과 힘을 합쳐 계속 미션을 수행해나가며,자신이 최강의 플레이어임을 증명하세요","<br/><t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
		["Good luck","<t align = 'center' color='#ff0000' shadow = '1' size = '1.0'>%1</t>"]
	]
] spawn BIS_fnc_typeText;

Missionend = false; Publicvariable "Missionend";
waituntil {time > 3};
Alltasks = [Task1GeraldBull,Task3Fortuna,Task4Split,Task5Container,Task6IntoForest];
publicvariable "Alltasks";

[player,ArsenalBox_1] spawn Weaponsave;
[player,ArsenalBox_2] spawn Weaponsave;

CenterEast = createCenter east;
CenterWest = createCenter west;
Centerindependent = createCenter independent;


enableSaving [ false, false ];
//로딩할때마다 ExecVM으로 컴파일해 로딩 부담을 줄이거나, scriptdone으로 로딩을 기다릴 것.
//[] spawn Gamestart;

/*
while {true} do {
  if (playableunits isEqualto []) then {
  sleep 0.1;
  "end1" call BIS_fnc_endMission;
  };
};
*/