/*
made By Guuuuuum
http://steamcommunity.com/id/NorthKorea/
*/
stopRope = true;
_trg = createTrigger ["EmptyDetector", [0,0,0]];
_trg setTriggerArea [0, 0, 0, false];
_trg setTriggerActivation ["NONE", "PRESENT", true];
_trg setTriggerStatements ["('Helicopter' countType [(vehicle player)] > 0)",
"_heli = vehicle player;_heli removeAction heliaction; _heli RemoveAction heliaction2;
heliaction = _heli addAction ['Start Fastrope','[vehicle player] spawn Ropedrop',[], 4, false, false, '', '(typeof vehicle player == ''B_Heli_Transport_01_F'' or typeof vehicle player == ''B_Heli_Transport_01_camo_F'') && driver vehicle player == player && StopRope'];heliaction2 = _heli addAction ['Stop FastRoping','[vehicle player] spawn Ropestop',[], 4, false, false, '', '(typeof vehicle player == ''B_Heli_Transport_01_F'' or typeof vehicle player == ''B_Heli_Transport_01_camo_F'') && driver vehicle player == player && !stopRope'];",
"_heli = vehicle player;_heli removeAction heliaction;_heli RemoveAction heliaction2; _heli = nil;stopRope = true;"];
Ropedrop = {
params ["_heli"];
_heli = _this select 0;
_heli animateDoor ["Door_R", 1, false];
_heli animateDoor ["Door_L", 1, false];
stopRope = false;
{deletevehicle _x} foreach ropes _heli;
_pendulumLeft = createVehicle ["Land_Rope_01_F",_heli modelToWorld[-1,1,-1],[],0,"none"];
_pendulumRight = createVehicle ["Land_Rope_01_F",_heli modelToWorld[1,1,-1],[],0,"none"];
_ropeLeft = ropeCreate [_heli, [-0.7,2,-0.2], _pendulumLeft, [0, 0, 0], 1];
_ropeRight = ropeCreate [_heli, [0.7,2,-0.2], _pendulumRight, [0, 0, 0], 1];
ropeUnwind [_ropeLeft, 150, (Getpos _heli select 2) + 15];
ropeUnwind [_ropeRight, 150, (Getpos _heli select 2) + 15];
sleep 5;
ropeindex = _heli addEventHandler ["GetOut", {[_this select 0,_this select 2] spawn GetoutRope}];
{ "Fastrope ready" RemoteExec ["hint",_x] } foreach crew _heli;
};

ropestop = {
params ["_heli","_ropes"];
_heli = _this select 0;
_ropes = _this select 1;
_heli animateDoor ["Door_R", 0, false];
_heli animateDoor ["Door_L", 0, false];
{deletevehicle _x} count ropes _heli;
ropestopGlobal = {
	stopRope = true;
	vehicle player removeAllEventHandlers "GetOut";
	};
{RemoteExec ["ropestopGlobal",_x] } foreach crew _heli;
};

GetoutRope = {
	params ["_heli","_xb"];
	_heli = _this select 0;
	_xb = _this select 1;
	_heli = _this select 0;
	_xb = _this select 1;
	if (random 1 > 0.5) then {
	_rope = ropeCreate [_heli, [0.7,2,-0.2], _xb, [0, 0, 0], 2];
	ropeUnwind [_rope, 5, (Getpos _heli select 2) + 5];
	_down = true;
	while {_down} do {if (getPos _xb select 2 < 1.5) then {ropeCut [_rope,0]; _down = false}};
	} else {
	_rope = ropeCreate [_heli, [-0.7,2,-0.2], _xb, [0, 0, 0], 2];
	ropeUnwind [_rope, 5, (Getpos _heli select 2) + 5];
	_down = true;
	while {_down} do {if (getPos _xb select 2 < 1.5) then {ropeCut [_rope,0]; _down = false}};
	};
	//_down = true;
	//while {_down} do {if (getPos _xb select 2 < 1.5) then {ropeCut [_rope,0]; _down = false}};
	};