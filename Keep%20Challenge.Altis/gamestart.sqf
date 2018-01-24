//GameStart
//Alltasks = [Task1GeraldBull,Task2Sprint,Task3Fortuna];
Missioncount = 0;
Gamestart = {
//End game when Fully clear missions
	_randomtask = Alltasks call bis_fnc_selectrandom;
	Alltasks = Alltasks - [_randomtask];
	publicvariable "Alltasks";
	[] spawn _randomtask;
	Missioncount  = Missioncount  + 1;
	publicvariable "Missioncount";
	};