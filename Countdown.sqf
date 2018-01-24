/*
	Author: Josef Zemanek
	Edit by Guuuuuum
	
	Description:
	Timer for Various use.

	Parameter(s):
		0: Number - Timer colour in HTML format
		1: Function Pointer - Call this function when countdown end.

	Returns:
	Nothing

*/
Countdown = {
params ["_num","_function"];

_num = _this select 0;
_function = _this select 1;

_color =  (["IGUI", "WARNING_RGB"] call BIS_fnc_displayColorGet) call BIS_fnc_colorRGBtoHTML;

BIS_stopTimer = FALSE;
if (isNil "BIS_interruptable") then {
	BIS_interruptable = TRUE;
};

_startTime = time;
_countdown = _num;
RscFiringDrillTime_done = FALSE;

1 cutRsc ["RscFiringDrillTime", "PLAIN"];
while {!BIS_stopTimer && BIS_interruptable} do {
	_t = time - _startTime;
	timeleft = _countdown - _t; Publicvariable "timeleft";
	_timeNowFormat = [timeleft, "MM:SS.MS", TRUE] call BIS_fnc_secondsToString;
	_text = "<t align='left' color='" + _color + "'>";

	_textCurrent = "";
	_colorCurrent = _color;
	_iconCurrent = "A3\Modules_F_Beta\data\FiringDrills\timer_ca";

	_textCurrent = _textCurrent + "<img image='" + _iconCurrent + "' /> ";
	_textCurrent = _textCurrent + (format ["%1:%2<t size='0.8'>.%3</t>", _timeNowFormat select 0, _timeNowFormat select 1, _timeNowFormat select 2]);
	_textCurrent = _textCurrent + "</t>";

	_text  = _text + _textCurrent;

	RscFiringDrillTime_current = parseText _text;
	
	if (timeleft <= 0) then {
		BIS_stopTimer = true;
		[] spawn _function;
		// call Timeover End
		};

	sleep 0.01;
	};
};

StopCountdown = {
	BIS_stopTimer = true;
	playsound "FD_finish_F";
	sleep 5;
	RscFiringDrillTime_done = true;
};