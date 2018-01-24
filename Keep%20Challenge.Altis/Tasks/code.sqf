/*
house1M : 2,3,7,2,2,9              7(3)
coastM : 2,3,2,2,2,7                  2(3)
reconM : 2,3,7,2,2,4              7(3)
hideoutM : 2,2,7,2,2,3           7(2)
house2M : 2,2,2,2,2,0                  2(2)
hotelM : 2,2,5,2,1,9                  5(2)
villageM : 2,2,6,2,1,6                 6(2)
House3M : 2,3,6,2,1,7                 6(3)


BulrushM :  242224

2-2 : hideoutM,house2M,hotelM,villageM
2-3 :House3M,reconM,coastM,house1M

3-7 house1M,reconM, hideoutM
3-2 coastM,house2M
3-6 villageM ,House3M
3-5 hotelM


0.메뉴얼.
우린 NATO의 특작대로서,알티스 시민들의 FIA에 대한 악감정을 만들기 위한 작전을 수행 중이다.
작전은 사흘 동안 진행되며, 매일 아침 암호화된 지령문이 도착한다. FIA가 우리의 행적을 조사하고 있으니, 지령을 수행하지 못할 경우 FIA놈들이 바로 쳐들어오겠지.
산속 내 예배소에 암호를 송신하는 라디오가 있다. 절대로 파괴되지 말아야 한다.

암호표는 다음과 같다.


지령의 핵심 동사이다. 양과 뱀,그리고 염소는 동사의 심볼들이며, 멋들어지기도 하고 어울리기도 한다. 근데 꼭 이런 식으로 전달해야 하나?
핵심 동사이니만큼, 잘못된 행동을 할 경우..는 작전을 아에 망쳐버리게 되겠지.
"좌표값" 에 염소가 있을 경우 "" 는  "청소"와 같다.
"좌표값" 에 개가 있을 경우 ""는  "암살"과 같다.
"좌표값" 에 양이 있을 경우 "" 는  "보호"와 같다.

해야 할 행동의 위치를 말하는 좌표값이다. 동사를 확인 할 위치의 좌표값과, 행동을 해야 할 위치의 좌표값 두개가 주어진다.
6개의 좌표값 중, 맨 앞 숫자는 반드시 2이다. 2가 아니라면 꽤나 멀리 이동해야겠는걸.


플레이어가 4명 이하일 경우, 두 번째 좌표값은  3과 같다.
플레이어가 4명 이상일 경우, 두 번째 좌표값은  2와 같다.

넷,다섯번째 좌표값은 반드시 2,2나 2,1중 하나다.

세 번째 좌표값은,

지역 랜덤선택- 해당 위치의
1.적의 수.
2.양의 수.
3.상자 내 아이템의 수. with 지뢰

여섯번째 좌표값은,

2(0),7(3),5(9),6(6)                       2
2(7),6(7),7(4),7(9)                       3

플레이어가 4명이상일경우, 세 번째 좌표값이 짝수일 경우 4를 더하거나 빼라. 더해서 10 이상인 경우, 그 값에서 4를 빼라. 홀수인 경우,3번째 좌표값에 4를 더하거나, 더한 값이 10 이상일 경우, 빼라.
플레이어가 4명 이하일경우 세 번째 좌표값이 짝수인 경우 10에서 두 번째 좌표값을 빼라. 홀수인 경우, 6번째 좌표값은 4와 9 중 하나다.

3번째 날 이후 마지막 날의 탈출로 좌표는,
첫번째로 작전이 진행된 지역의 좌표값에서 2002를 뺀 좌표의 값이다.해당 위치에서 연막탄을 던질 것.

if (house2)의 경우, 보트 생성.





세 번째 좌표값이 7 일 경우,  넷,다섯번째 좌표값은 2,2이다.
셋,넷,다섯번째 좌표값이 2일 경우, 6번째 좌표값은 0혹은 7이다.
넷,다섯번째 좌표값이 2,2일 경우,6번째 좌표값은 0.3,4,6,7,9 중 하나다.
넷,다섯번째 좌표값이 2,1일 경우,6번째 좌표값은 6,7,9 중 하나다.

// 예시
1.첫 번째 날.
*/

Task7Code = {
T7Missioncount = 0;
[2035,8,7,6,30,0,0,0,0,0,0,0,0,0] remoteExec ["Naturefnc"];
T7dataterminal = createVehicle ["Land_DataTerminal_01_F",[24219,22631.4,0],[],0,"none"]; ObjectsToCleanup pushback T7dataterminal;
T7dataterminal setposATL [24219,22631.4,0.131756]; T7dataterminal setdir 90;
T7dataterminal addEventHandler ["killed", "systemchat 'destroyed'"];
};

T7OpenTerminal = {
params ["_object","_caller","_id"];
_object = _this select 0;
_caller = _this select 1;
_id = _this select 2;
[_object , _id] remoteExec ["removeaction"];
[_object,3] call BIS_fnc_dataTerminalAnimate;
sleep 30;
[_object,0] call BIS_fnc_dataTerminalAnimate;
};


Task7Script ={
T7Missioncount = T7Missioncount + 1;
settimeMultiplier 60;

T7dataterminal RemoteExec ["removeallactions"];
[[T7dataterminal,["Recive Data","[_this select 0,_this select 1,_this select 2] spawn OpenTerminal"]],"addAction",true] call BIS_fnc_MP;

[2035,8,(7 + T7Missioncount),6,30,random 1,random 1,random 0.7,random 0.3,random 3,0,0,0,0] remoteExec ["Naturefnc"];
[] spawn Task7Start;
 //1day = 24min == 1hour = 1min
sleep 780;
//task : sun down. come back home.
//[] spawn Task7night;
};

Task7Night = {
_defend = true;
//now it's 19:00 pm. need to sleep 11 hour.
//settimeMultiplier 120; //1day = 12min == 1hour = 30sec
settimeMultiplier 90; //1day = 18min == 1hour = 45sec
//Task maybe Defend
if (!T7MissionComplete) then {
sleep random 400;
_rpos1 = round(random 400) -200; if (_rpos1 >= 0) then {_rpos1 = _rpos1 + 100};
_rpos2 = round(random 400) -200; if (_rpos2 <= 0) then {_rpos2 = _rpos2 - 100};
_Gpos = T7dataterminal modeltoworld [_rpos1,_rpos2,1];
_fiagroup = [_Gpos, Centereast,(configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad")] call BIS_fnc_spawnGroup;
_fiagroup2 = [(T7dataterminal modeltoworld [_rpos2,_rpos1,1]),(configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam")] call BIS_fnc_spawnGroup;

	_fiagroupwp =_fiagroup addWaypoint [position T7dataterminal, 1];
	_fiagroupwp setWaypointType "MOVE";
	_fiagroup setBehaviour "STEALTH";
	
	_fiagroupwp2 =_fiagroup2 addWaypoint [position T7dataterminal, 1];
	_fiagroupwp2 setWaypointType "MOVE";
	_fiagroup2 setBehaviour "STEALTH";
	
	_trg = createTrigger ["EmptyDetector", position T7dataterminal];
	_trg setTriggerArea [3,3, 0, true];
	_trg setTriggerActivation ["EAST", "PRESENT", false];
	_trg setTriggerStatements ["this",
	"
	CreateVehicle ['Bo_GBU12_LGB',position T7dataterminal,[],0,'none'];
	T7dataterminal setdamage 1;
	deletevehicle thistrigger;
	",
	""];
	waituntil {!_defend};
	deletevehicle _trg;
}; // maybe need else to T7MissionComplete for rest
sleep 495;
_defend = false;
// sun opening
[] spawn Task7Script;
};

Task7Start = {
//task Good morning
_T7Allp = ["Task7hideoutM","Task7house2M","Task7hotelM","Task7villageM","Task7House3M","Task7reconM","Task7coastM","Task7house1M"];


 _23 = ["Task7House3M","Task7reconM","Task7coastM","Task7house1M"];
 _22 = ["Task7hideoutM","Task7house2M","Task7hotelM","Task7villageM"];
 
	if (count playableunits < 5) then {
	_mainObject = ([_23] call bis_fnc_selectrandom);
		} else {
	_mainObject = ([_22] call bis_fnc_selectrandom);
	};

 _t7allp = +_T7Allp;
 _t7allp = _t7allp - _mainObject;
/*
house1M : 2,3,7,2,2,9              7(3)
coastM : 2,3,2,2,2,7                  2(3)
reconM : 2,3,7,2,2,4              7(3)
hideoutM : 2,2,7,2,2,3           7(2)
house2M : 2,2,2,2,2,0                  2(2)
hotelM : 2,2,5,2,1,9                  5(2)
villageM : 2,2,6,2,1,6                 6(2)
House3M : 2,3,6,2,1,7                 6(3)

*/
switch (_mainObject) do {
		case "Task7House3M": {
			systemchat "2,3,6,2,1,7";
			[6,_t7allp,_mainObject] call Task7Evidence;
			
		};
		case "Task7reconM": {
			systemchat "2,3,7,2,2,4  ";
			[7,_t7allp,_mainObject] call Task7Evidence;
			};
		case "Task7coastM": {
			systemchat "2,3,2,2,2,7";
			[2,_t7allp,_mainObject] call Task7Evidence;
			};
		case "Task7house1M": {
			systemchat " 2,3,7,2,2,9";
			[7,_t7allp,_mainObject] call Task7Evidence;
			};
		case "Task7hideoutM": {
			systemchat "2,2,7,2,2,3";
			[7,_t7allp,_mainObject] call Task7Evidence;
			};
		case "Task7house2M": {
			systemchat "2,2,2,2,2,0";
			[2,_t7allp,_mainObject] call Task7Evidence;
			};
		case "Task7hotelM": {
			systemchat "2,2,5,2,1,9";
			[5,_t7allp,_mainObject] call Task7Evidence;
			};
		case "Task7villageM": {
			systemchat "2,2,6,2,1,6";
			[6,_t7allp,_mainObject] call Task7Evidence;
			};
	default { systemchat "switch do ERROR" };
	};
	if (T7Missioncount == 0) then {T7first = _mainObject};
	T7Missioncount = T7Missioncount + 1;
};
 
 Task7Mission = {
params ["_object","_mainObject"];
_object = _this select 0;
_mainObject = _this select 1;
T7MissionComplete = false;
 _groupcfg = [
							(configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad"),
							(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam"),
							(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),
							(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad"),
							(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Motorized_MTP" >> "HAF_MotInf_Team"),
							["C_man_1","C_man_polo_1_F_euro","C_man_polo_1_F_asia","O_G_Soldier_SL_F","O_G_engineer_F","O_G_Soldier_TL_F","O_G_Soldier_AR_F","I_G_medic_F"],
							["C_man_1","C_man_polo_5_F_asia","C_man_polo_6_F_afro","C_man_p_shorts_1_F","C_man_p_fugitive_F","C_man_shorts_2_F","I_Soldier_AT_F","I_medic_F","I_Soldier_LAT_F","I_Soldier_M_F"],
							["C_man_1","O_Soldier_AR_F","C_man_polo_6_F_afro","O_Soldier_SL_F","C_man_p_fugitive_F","O_officer_F","O_Soldier_SL_F","O_soldier_M_F","O_Soldier_F","O_Soldier_lite_F"]
							];
switch (_object) do {
		case "Goat_random_F": {
		//Clear mission
		_sr = _groupcfg call bis_fnc_selectrandom;
		//if (T7Missioncount == 0) then {_rp = T7first} else {_rp = _mainObject;};
		_Cleargroup = [Getmarkerpos _mainObject, Centereast,_sr] call BIS_fnc_spawnGroup;
		[_Cleargroup] call T7Clear;
		};
		case "Sheep_random_F": {
		//save mission
		_sr = _groupcfg call bis_fnc_selectrandom;
		_savegroup = [Getmarkerpos _mainObject, Centereast,_sr] call BIS_fnc_spawnGroup;
		[_savegroup,_mainObject] call T7save;
		};
		case "Alsatian_Random_F": {
		//Assasinate mission
		_group = Creategroup east;
		_groupcfg = ["O_officer_F","B_officer_F","I_officer_F","O_G_officer_F","C_man_1","C_man_polo_5_F_asia","C_man_polo_6_F_afro","C_man_p_shorts_1_F","C_man_p_fugitive_F","C_man_shorts_2_F"];
		_sr = _groupcfg call bis_fnc_selectrandom;
		_officer = _group CreateUnit [_sr,getMarkerpos _mainObject,[],0,"NONE"];
		_officer addEventHandler ["killed", "T7MissionComplete = true"];
		_sr = _groupcfg call bis_fnc_selectrandom;
		_savegroup = [Getmarkerpos _mainObject, Centereast,_sr] call BIS_fnc_spawnGroup;
		};
	default { systemchat "Task7Mission switch do ERROR" };
	};
};
 
T7Clear = {
params ["_object"];
_object = _this select 0;
T7Clearkillcount = 0;
T7Clearcount = count units _object;
{_x addEventHandler ["killed", "T7Clearkillcount = T7Clearkillcount + 1;"]; } foreach units _object;
waituntil {T7Clearkillcount == T7Clearcount};
T7MissionComplete = true;
};

T7save = {
params ["_object","_objectposition"];
_object = _this select 0;
_objectposition = _this select 1;
_groupcfg = ["O_officer_F","B_officer_F","I_officer_F","O_G_officer_F","C_man_1","C_man_polo_5_F_asia","C_man_polo_6_F_afro","C_man_p_shorts_1_F","C_man_p_fugitive_F","C_man_shorts_2_F"];
_sr = _groupcfg call bis_fnc_selectrandom;
_group = Creategroup west;
_officer = _group CreateUnit [_sr,getMarkerpos _objectposition,[],0,"NONE"];
_officer addEventHandler ["killed", "T7MissionComplete = false"];
_officer setCaptive true;
_animarray = ["HubBriefing_scratch","HubBriefing_scratch","HubBriefing_scratch","passenger_flatground_2_Idle_Unarmed","HubSittingChairA_idle3","HubSittingChairB_idle2","HubSittingChairC_idle1","HubStandingUC_idle3","InBaseMoves_patrolling2","InBaseMoves_patrolling1","InBaseMoves_HandsBehindBack1","LaceyTest2a"];
_animsr = _animarray call bis_fnc_selectrandom;
[_officer,_animsr] spawn SwitchAnim;
if ( ["HubSittingChair",_animsr] call BIS_fnc_inString) then {
//attach chairs
_chair = createVehicle ["Land_RattanChair_01_F",GetposATL _officer,[],0,"none"];
_officer attachto [_chair,[0,-0.13,-0.55]]; _officer setdir 180;
	};
{_x addEventHandler ["killed", "T7Clearkillcount = T7Clearkillcount + 1;"]; } foreach units _object;
waituntil {T7Clearkillcount == T7Clearcount};
T7MissionComplete = true;
};
 
 
 Task7Enemies = {
 params ["_allp"];
_allp = _this select 0;

 _n = (count _allp) + 1;
 _groupcfg = [
							(configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad"),
							(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam"),
							(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),
							(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad"),
							(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Motorized_MTP" >> "HAF_MotInf_Team"),
							["C_man_1","C_man_polo_1_F_euro","C_man_polo_1_F_asia","O_G_Soldier_SL_F","O_G_engineer_F","O_G_Soldier_TL_F","O_G_Soldier_AR_F","I_G_medic_F"],
							["C_man_1","C_man_polo_5_F_asia","C_man_polo_6_F_afro","C_man_p_shorts_1_F","C_man_p_fugitive_F","C_man_shorts_2_F","I_Soldier_AT_F","I_medic_F","I_Soldier_LAT_F","I_Soldier_M_F"],
							["C_man_1","O_Soldier_AR_F","C_man_polo_6_F_afro","O_Soldier_SL_F","C_man_p_fugitive_F","O_officer_F","O_Soldier_SL_F","O_soldier_M_F","O_Soldier_F","O_Soldier_lite_F"]
							];
 	for [{_t=1}, {_t<_n}, {_t=_t+1}] do
		{
			_rp = _allp select (_t - 1);
			_sr = _groupcfg call bis_fnc_selectrandom;
			waituntil {!isnil "_sr"};
			_patrol = [Getmarkerpos _rp, Centereast,_sr] call BIS_fnc_spawnGroup;
			[Getmarkerpos _rp,units _patrol,50,true,true,true,true] call Zen_OccupyHouse;
		};
 };
 
 
 
Task7Evidence = {
params ["_third","_allp","_mainObject"];
_third = _this select 0;
_allp = _this select 1;
_mainObject = _this select 2;

 _sr1 = ([_allp] call bis_fnc_selectrandom);
 [_third,_sr1] spawn _Task7goat;



	_Task7goat = {
	params ["_n","_pos"];
	_n = _this select 0;
	_pos = _this select 1;
	_animals = ["Goat_random_F","Sheep_random_F","Alsatian_Random_F"];
	_animal = ([_animals] call bis_fnc_selectrandom);
	_group = creategroup west;
	for [{_i=0}, {_i<_n}, {_i=_i+1}] do
		{
			_group createunit [_animal,getMarkerpos _pos,[],0,"NONE"];
		};
	[_group] spawn Trackwaypoint;
	[_animal,_mainObject] call Task7Mission;
	
	//maybe Subtraction the goat position
[_allp] call Task7Enemies;
	};
};
	







