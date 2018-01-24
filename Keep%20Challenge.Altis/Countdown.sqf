/*
	Author: Josef Zemanek

	Description:
	Timer for VR.

	Parameter(s):
		0: STRING (Optional) - Timer colour in HTML format

	Returns:
	Nothing


countdown = 40;
 startTime = time;
 while {true} do {t = time - startTime; sleep 0.01;_timeleft = countdown - t};
*/
Countdown = {
params ["_num","_function"];

_num = _this select 0;
_function = _this select 1;


//_color = [_this,0,(["IGUI", "WARNING_RGB"] call BIS_fnc_displayColorGet) call BIS_fnc_colorRGBtoHTML;,[""]] call BIS_fnc_param;

_color =  (["IGUI", "WARNING_RGB"] call BIS_fnc_displayColorGet) call BIS_fnc_colorRGBtoHTML;

BIS_stopTimer = FALSE;
BIS_interruptable = TRUE;

_startTime = time;
_countdown = _num;
RscFiringDrillTime_done = FALSE;

[1,["RscFiringDrillTime", "PLAIN"]] RemoteExec ["cutRsc"];


while {BIS_interruptable} do {
_t = time - _startTime;
timeleft = _countdown - _t; Publicvariable "timeleft";

if (timeleft <= 0 and !BIS_stopTimer) exitwith {
	BIS_stopTimer = true;
	[] remoteExec ["StopCountdown"];
	BIS_stopTimer = true;
	RscFiringDrillTime_done = true;
	BIS_interruptable = false;
	timeleft = nil;
	[] spawn _function;
	};
if (!BIS_stopTimer) then {
	_timeNowFormat = [timeleft, "MM:SS.MS", TRUE] call BIS_fnc_secondsToString;
	_text = "<t align='left' color='" + _color + "'>";

	_textCurrent = "";
	_colorCurrent = _color;
	_iconCurrent = "A3\Modules_F_Beta\data\FiringDrills\timer_ca";

	_textCurrent = _textCurrent + "<img image='" + _iconCurrent + "' /> ";
	_textCurrent = _textCurrent + (format ["%1:%2<t size='0.8'>.%3</t>", _timeNowFormat select 0, _timeNowFormat select 1, _timeNowFormat select 2]);
	_textCurrent = _textCurrent + "</t>";

	_text  = _text + _textCurrent;
	

	[[_text],{RscFiringDrillTime_current = parseText (_this select 0);}] remoteExec ["bis_fnc_call"]; 
	sleep 0.01;
		};
	};
};

StopCountdown = {
	BIS_stopTimer = true;
	playsound "FD_finish_F";
	sleep 5;
	RscFiringDrillTime_done = true;
};