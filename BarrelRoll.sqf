/*
made By Guuuuuum
https://youtu.be/OkSTad2Q--Q
http://steamcommunity.com/id/NorthKorea/
*/

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
