/*
made By Guuuuuum
https://youtu.be/tbefslvAlVY
http://steamcommunity.com/id/NorthKorea/
*/

stopRope = true;
_trg = createTrigger ["EmptyDetector", [0,0,0]];
_trg setTriggerArea [0, 0, 0, false];
_trg setTriggerActivation ["NONE", "PRESENT", true];
_trg setTriggerStatements ["vehicle player isKindof 'helicopter'",
"
[true] spawn MovedInHeli
",

"
[false] spawn MovedInHeli
"];


MovedInHeli = {
params ["_status"];
_status = _this select 0;
if (_status) then {
if ( (typeof vehicle player == "B_Heli_Transport_01_F" or typeof vehicle player == "B_Heli_Transport_01_camo_F") && (!(driver vehicle player == player) && !(gunner vehicle player == player) && !(commander vehicle player == player)) ) then {
Tiedrappel = player addAction [
	"Tie rope for Rappel down",
	{[vehicle player] spawn TieRope; vehicle player RemoveAction (_this select 2)},
	[], 4, false, false, "",
	"StopRope"
	]; 
	};
	} else {
	if (!isnil "Tiedrappel") then { player removeAction Tiedrappel};
	};
};



TieRope = {
params ["_heli"];
_heli = _this select 0;

_heli animateDoor ["Door_R", 1, false];	
_heli animateDoor ["Door_L", 1, false];
stopRope = false;


_eh = _heli addEventHandler ["GetOut", {[_this select 0,_this select 2] spawn GetoutRope}];
systemchat "Ropes tied well. good to go";

_untie = player addAction [
	"Untie rope",
	{
	[vehicle player,objnull] spawn ropestop;
	player RemoveAction (_this select 2)
	},
	[], 4, false, false, "",
	"(typeof vehicle player == 'B_Heli_Transport_01_F' or typeof vehicle player == 'B_Heli_Transport_01_camo_F') && (!(driver vehicle player == player) && !(gunner vehicle player == player) && !(commander vehicle player == player)) && !StopRope"
	];
waituntil {stopRope or !(vehicle player isKindof "helicopter") or !(alive player)};
player removeAction _untie;
_heli removeEventHandler ["Getout", _eh];
};



ropestop = {
params ["_heli","_rope"];
_heli = _this select 0;
_rope = _this select 1;

	stopRope = true;
if (!isNull ropeAttachedTo player) then {deletevehicle _rope};
if (!isNull _rope) then {
	ropeunwind [_rope,8,0.5];
	waituntil {ropeLength _rope < 1};
	deletevehicle _rope
	};
	
if ([[],ropeAttachedObjects _heli] call bis_fnc_arraycompare) then {
		_heli animateDoor ["Door_R", 0, false];
		_heli animateDoor ["Door_L", 0, false];
	};
};


/*
player addeventhandler ["GetOutMan",{
if ((_this select 1) == "cargo" and (_this select 2) isKindof "helicopter") then {};//spawn  something; can be use AFTER 1.57

}];
*/


rappelcountfnc = {
	
	if (isNil "rapdc") then {rapdc = 0} else
		{	if (rapdc == 0) then {rapdc = 1} else {rapdc = 0}};
		//nil 왼쪽. 다음 0 오른쪽. 다음 1 왼쪽. 다음 0 오른쪽.

};

GetoutRope = {
	params ["_rappelheli","_xb"];
	rappelheli = _this select 0;
	_xb = _this select 1;
	stopRope = false;
	
	
	//right,left repeat. be private only for heli crews.
	

	
	{[] RemoteExec ["rappelcountfnc",_x]}foreach (crew rappelheli); // surely it doesn't work to first jumper.
	

	if (isNil "rapdc") then {hangrope = ropeCreate [rappelheli, [-0.7,2,-0.2], _xb, [0, 0, 0], 2];};
	if (rapdc == 0) then {
	hangrope = ropeCreate [rappelheli, [0.7,2,1], _xb, [0, 0, 0], 2];
	} else {
	hangrope = ropeCreate [rappelheli, [-0.7,2,1], _xb, [0, 0, 0], 2];
};
	
	

	

	
	
	
	_deh = (findDisplay 46) displayAddEventHandler 
		["KeyDown", "
	_keyDown = _this select 1; 
	if (_keyDown == " + str (17) + ") then { [] call rappeldown };
	if (_keyDown == " + str (31) + ") then { [] call rappelclimb };
	false;
"];
	
_release = _xb addAction ["Release Rope"," [" + str _deh + "] call cutaction; player RemoveAction (_this select 2);",nil,0,true,true];
waituntil {stopRope or !(alive player)};
//player removeAction _untie;
(findDisplay 46) displayRemoveEventHandler ["KeyDown", _deh];
player removeAction _release;

};

cutaction = {
	params ["_deh"];
	_deh = _this select 0;
	
	ropecut [hangrope,ropeLength hangrope];//ropeLength hangrope
	[rappelheli,hangrope] spawn ropestop;
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", _deh];
};

rappeldown = {

		if ((getPosATL player select 2 > 0.5)) then	{
		
			ropeUnwind [hangrope,5,1,true];

			};

		
		};
	
rappelclimb = {

				if ((GetposATL player select 2) < 1) then {player setVelocity [(velocity vehicle player) select 0, (velocity vehicle player) select 1, 3]};

				if ((GetposATL rappelheli select 2) - (GetposATL player select 2) < 1.2) then {
					rappelheli animateDoor ["Door_R", 1, false];
					rappelheli animateDoor ["Door_L", 1, false];		
					player action ["getInCargo", rappelheli];
					[rappelheli,hangrope] spawn ropestop;
				};
				if ((getPosATL player select 2 > 1)) then	{
				ropeUnwind [hangrope,1,-1,true];
			};
	};
