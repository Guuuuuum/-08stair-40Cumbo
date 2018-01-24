class global_scoreboard
{
	idd=-1;
	movingenable=false;
	onLoad = "_this ExecVM 'globalscoreboard.sqf'"; 
	
	class controls 
	{
class _sbFrame: RscFrame
{
	idc = 1800;
	x = 0.396875 * safezoneW + safezoneX;
	y = 0.225 * safezoneH + safezoneY;
	w = 0.20625 * safezoneW;
	h = 0.55 * safezoneH;
};
class _sblistboxNickname: RscListbox
{
	idc = 1500;
	x = 0.407187 * safezoneW + safezoneX;
	y = 0.291 * safezoneH + safezoneY;
	w = 0.0825 * safezoneW;
	h = 0.396 * safezoneH;
};
class _sblistboxStair: RscListbox
{
	idc = 1501;
	x = 0.505156 * safezoneW + safezoneX;
	y = 0.291 * safezoneH + safezoneY;
	w = 0.0309375 * safezoneW;
	h = 0.396 * safezoneH;
};
class _sblistboxCumbo: RscListbox
{
	idc = 1502;
	x = 0.551562 * safezoneW + safezoneX;
	y = 0.291 * safezoneH + safezoneY;
	w = 0.0360937 * safezoneW;
	h = 0.396 * safezoneH;
};
class _sbcencer: RscButtonMenuCancel
{
	x = 0.561875 * safezoneW + safezoneX;
	y = 0.72 * safezoneH + safezoneY;
	w = 0.0360937 * safezoneW;
	h = 0.044 * safezoneH;
};
class _sbtext: RscText
{
	idc = 1000;
	text = "Global Scoreboard"; //--- ToDo: Localize;
	x = 0.408749 * safezoneW + safezoneX;
	y = 0.235074 * safezoneH + safezoneY;
	w = 0.176875 * safezoneW;
	h = 0.044 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
    };
};
