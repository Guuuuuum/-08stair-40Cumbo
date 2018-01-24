ObjectsToCleanup = [];  Publicvariable "ObjectsToCleanup";
TasksToCleanup = []; Publicvariable "TasksToCleanup";
Missionend = false;
publicvariable "Missionend";
EndOfmission=  {
[] remoteExec ["EndOfmissioneffect"];
sleep 42;
[2035,(ceil random 12),(ceil random 30),12,50,0,0,0,0,0,0,0,0,0] remoteExec ["Naturefnc"];
[] remoteExecCall ["Gamestart", 2];
[profilename,player] remoteExec ["Writeinfo",2];// IMPORTANT!! IT'S SAVE PLAYER's INFO
};
EndOfmissioneffect = {
if (Alltasks isEqualto []) then
	{
	[] remoteExec ["Endofgame"]; 
	}
else {
	[player,ArsenalBox_1] spawn Weaponsave;
	[player,ArsenalBox_2] spawn Weaponsave;
Missionend = true; publicvariable "Missionend";
{_x setdamage 0; _x allowdamage false;} foreach allplayers;
//End Effects.
  _layerInterlacing = "BIS_fnc_endMission_interlacing" call bis_fnc_rscLayer;
  _layerStatic = "BIS_fnc_endMission_static" call bis_fnc_rscLayer;
  _layerEnd = "BIS_fnc_endMission_end" call bis_fnc_rscLayer;
  _layerStatic cutrsc ["RscStatic","plain"];
  sleep 0.3;
  _layerEnd cutrsc ["RscMissionEnd","plain"];
  sleep 9; 
  _layerStatic cutrsc ["RscStatic","plain"]; 
  sleep 0.5;
  _layerInterlacing cutrsc ["RscInterlacing","plain"];
  sleep 0.5;
  _layerInterlacing cutrsc ["Default","plain"]; //Remove Effects before
  [0,"WHITE",4,1] call BIS_fnc_fadeEffect;
  sleep 3.5;
	[
		[
			["CODENAME :","align = 'down' shadow = '0' size = '0.7' font='PuristaBold'","#aaaaaa"],
			[format ["%1",profilename],"align = 'down' shadow = '0' size = '0.7'","#333333"],
			["","<br/>"],
			["MISSION COMPLETE","align = 'down' shadow = '0' size = '1.0'","#0c0c0c"]
		]
	] spawn BIS_fnc_typeText2;
	sleep 12;
	[[
		["<t color='#2F4074' size = '.8'>Mission will be continue soon","<t align = 'down' shadow = '0' size = '0.7' font='PuristaBold'>%1</t>"]]
] call BIS_fnc_typeText;
// Cleanup
{deletevehicle _x} count ObjectsToCleanup;
ObjectsToCleanup = [];
{deletevehicle _x} count allunits;
{deletevehicle vehicle _x} count allunits;
{deletevehicle _x} count allDead;
{deleteVehicle _x} count allMissionObjects "WeaponHolder";
{[_x] call bis_fnc_deleteTask} count TasksToCleanup;
TasksToCleanup = []; Publicvariable "TasksToCleanup";
{[_x] call bis_fnc_deleteTask} foreach ([player] call bis_fnc_tasksUnit);
sleep 8;
//[] remoteExec ["Gamestart", 2]; 
//[] spawn Gamestart; //only MUSE BE excuted on server once
{_x setdamage 0; _x allowdamage true;} foreach allplayers;
[1,"WHITE",4,1] spawn BIS_fnc_fadeEffect;
Missionend = false;
publicvariable "Missionend";
	};
};



Endofgame = {
[0,"BLACK",6,1] call BIS_fnc_fadeEffect;
_stair = format [
"<t color='#869702' size = '.6'>
%1계단
<br/>
%2단 컴보
</t>",Missioncount,score player];
[_stair,
-1,0.1,10,1,0,789
] spawn BIS_fnc_dynamicText;
[1,"BLACK",4,1] call BIS_fnc_fadeEffect;
[profilename,player] spawn globalscoreboard;
[] call bis_fnc_endmission;
};