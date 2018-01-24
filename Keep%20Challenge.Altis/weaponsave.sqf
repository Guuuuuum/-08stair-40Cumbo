UpdateGears = {
params ["_player","_id"];
_player = _this select 0;
_id = _this select 1;
_pitem = [getPlayerUID _player, "arms", "itemsWithMagazines", "ARRAY"] call iniDB_read;
_pitem = _pitem - (itemsWithMagazines _player) - (assignedItems _player);
_pitem append ((itemsWithMagazines _player) + (assignedItems _player));
[getPlayerUID _player, "arms", "itemsWithMagazines",_pitem] call iniDB_write;
//uniforms. MUSE NEED TO PUT 2 UNIFORMS FIRST. 플레이어 접속시부터 Uniform을 두개로 만들어야 함.
_puniform = [getPlayerUID _player, "arms", "uniform", "ARRAY"] call iniDB_read;
_puniform = _puniform - [uniform _player];
_puniform append [uniform _player];
[getPlayerUID _player, "arms", "uniform",_puniform] call iniDB_write;
//vest
_pvest = [getPlayerUID _player, "arms", "vest", "ARRAY"] call iniDB_read;
_pvest = _pvest - [vest _player];
_pvest append [vest _player];
[getPlayerUID _player, "arms", "vest",_pvest] call iniDB_write;
//headgear
_pheadgear = [getPlayerUID _player, "arms", "headgear", "ARRAY"] call iniDB_read;
_pheadgear = _pheadgear - [headgear _player];
_pheadgear append [headgear _player];
[getPlayerUID _player, "arms", "headgear",_pheadgear] call iniDB_write;
//backpack
_pbackpack = [getPlayerUID _player, "arms", "backpack", "ARRAY"] call iniDB_read;
_pbackpack = _pbackpack - [backpack _player];
_pbackpack append [backpack _player];
[getPlayerUID _player, "arms", "backpack",_pbackpack] call iniDB_write;

// update gears at Arsenal

//now weapons
_pprimary = [getPlayerUID _player, "arms", "primary", "ARRAY"] call iniDB_read;
_pprimary = _pprimary - [primaryWeapon _player];
_pprimary append [primaryWeapon _player];
[getPlayerUID _player, "arms", "primary",_pprimary] call iniDB_write;
//weapon attachments
_pwitem = [getPlayerUID _player, "arms", "primaryweaponitems", "ARRAY"] call iniDB_read;
_pwitemB = primaryweaponitems _player;
_pwitemB = _pwitemB joinstring "-";
_pwitemB = _pwitemB splitstring "-";
_pwitem = _pwitem - _pwitemB;
_pwitem append _pwitemB;
[getPlayerUID _player, "arms", "primaryweaponitems",_pwitem] call iniDB_write;
//pistols
_phandgun = [getPlayerUID _player, "arms", "handgun", "ARRAY"] call iniDB_read;
_phandgun = _phandgun - [handgunWeapon  _player];
_phandgun append [handgunWeapon  _player];
[getPlayerUID _player, "arms", "handgun",_phandgun] call iniDB_write;
//handgun items
_phItems = [getPlayerUID _player, "arms", "handgunitems", "ARRAY"] call iniDB_read;
_phItemsB = handgunItems _player;
_phItemsB = _phItemsB joinstring "-";
_phItemsB = _phItemsB splitstring "-";
_phItems = _phItems - _phItemsB;
_phItems append _phItemsB;
[getPlayerUID _player, "arms", "handgunitems",_phItems] call iniDB_write;
//launchers
_psecondary = [getPlayerUID _player, "arms", "secondaryWeapon", "ARRAY"] call iniDB_read;
_psecondary = _psecondary - [secondaryWeapon  _player];
_psecondary append [secondaryWeapon  _player];
[getPlayerUID _player, "arms", "secondaryWeapon",_psecondary] call iniDB_write;




_pitem append _puniform; _pitem append _pvest;_pitem append _pheadgear;
_pweapon = [];
_pweapon append _pprimary;_pweapon append _phandgun; _pweapon append _psecondary;
_pattachment = [];
_pattachment append _pwitem;_pattachment append _phItems;

returnValue = [_pitem,_pbackpack,_pweapon,_pattachment];
str _id RemoteExec ["systemchat"];
	if (!(_id == 2)) then {
		_id publicvariableClient "returnValue";
	};

};
Weaponsave = {
params ["_player","_box"];
_player = _this select 0;
_box = _this select 1;
[_player,clientOwner] remoteExecCall ["UpdateGears",2];
sleep 2;
waituntil {!isNil "returnValue"};
//_returnValue = [_pitem,_pbackpack,_pweapon,_pattachment];
[_box,returnValue select 0,false,true] call BIS_fnc_addVirtualItemCargo;
[_box,returnValue select 2,false,true] call BIS_fnc_addVirtualWeaponCargo;
[_box,returnValue select 0,false,true] call BIS_fnc_addVirtualMagazineCargo;
[_box,returnValue select 3,false,true] call BIS_fnc_addVirtualItemCargo;
[_box,returnValue select 1,false,true] call BIS_fnc_addVirtualBackpackCargo;
};





