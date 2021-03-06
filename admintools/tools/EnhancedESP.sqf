_str = parseText format ["%1<br/>Enhanced ESP <t color='#45b711'>ON</t>"];
hint _str;

 if (isNil "markPos") then {markPos = true;} else {markPos = !markPos};

if(isNil "markers") then { markers = []};


player addweapon "ItemMap";
player addweapon "ItemGPS";

//GLOBAL VARS START

//SLEEP
GlobalSleep=0.5;//Sleep between update markers
//SLEEP

//----------------------#Players#--------------------------
AddPlayersToMap=true;
AddPlayersToScreen=true;
PlayersMarkerType=["x_art"];
PlayerMarkerColor=[1,0,0,1];//two in the fourth degree is equal to sixteen, so there are 16 colors
PlayerShowBloodInt=true;
PlayerShowDistance=true;
TheThicknessOfThePointPlayer=0.7;
//----------------------#Players#--------------------------

//----------------------#Zombies#--------------------------
AddZombieToMap=true;
ZombieVisibleDistance=100;
ZombieMarkerType="vehicle";
ZombieMarkerColor="ColorGreen";
ZombieName="Zombie";
//----------------------#Zombies#--------------------------
//----------------------#Vehicles#-------------------------
AddVehicleToMap=true;
VehicleMarkerType="vehicle";
VehicleMarkerColor="ColorBlue";
//----------------------#Vehicles#-------------------------

//----------------------#Tents#----------------------------
AddTentsToMap=true;
TentsMarkerType="vehicle";
TentsMarkerColor="ColorYellow";
//----------------------#Tents#----------------------------

//----------------------#Crashes#--------------------------
AddCrashesToMap=true;
CrashesMarkerType="vehicle";
CrashesMarkerColor="ColorRed";
//----------------------#Crashes#--------------------------

//GLOBAL VARS END

While {markPos} do {
If (AddPlayersToMap) then {
{
(group _x) addGroupIcon PlayersMarkerType;
if (PlayerShowBloodInt && PlayerShowDistance) then {
BloodVal=round(_x getVariable["USEC_BloodQty",12000]);
/*
If (BloodVal>=11000) then {
ColorHp="#5ED533";
};
If (BloodVal>=8000 && BloodVal<11000) then {
ColorHp="#C3EE4F";
};
If (BloodVal>=4000 && BloodVal<8000) then {
ColorHp="#CE6F27";
};
If (BloodVal>=2000 && BloodVal<4000) then {
ColorHp="#CD480F";
};
If (BloodVal>=1000 && BloodVal<2000) then {
ColorHp="#CE0F35";
};
If (BloodVal<1000) then {
ColorHp="#FF0303";
};
_text=parseText format ["%1(<t color='%4'>%2</t>)<br/><t align='center'>%3</t>",name _x, BloodVal,round(player distance _x),(str ColorHp)];
*/
(group _x) setGroupIconParams [PlayerMarkerColor, format["%1(%2)-%3",name _x,BloodVal,round(player distance _x)],TheThicknessOfThePointPlayer,true];
};
If (PlayerShowBloodInt && !PlayerShowDistance) then {
BloodVal=round(_x getVariable["USEC_BloodQty",12000]);
/*
If (BloodVal>=11000) then {
ColorHp="#5ED533";
};
If (BloodVal>=8000 && BloodVal<11000) then {
ColorHp="#C3EE4F";
};
If (BloodVal>=4000 && BloodVal<8000) then {
ColorHp="#CE6F27";
};
If (BloodVal>=2000 && BloodVal<4000) then {
ColorHp="#CD480F";
};
If (BloodVal>=1000 && BloodVal<2000) then {
ColorHp="#CE0F35";
};
If (BloodVal<1000) then {
ColorHp="#FF0303";
};
_text=parseText format ["%1(<t color='ColorHP'>%2</t>)",name _x, BloodVal];
*/
(group _x) setGroupIconParams [PlayerMarkerColor, format ["%1(%2)",name _x, BloodVal],TheThicknessOfThePointPlayer,true];
};
If (PlayerShowDistance && !PlayerShowBloodInt) then {
//_text=parseText format ["%1<br/><t align='center'>%2</t>",name _x,round(player distance _x)];
(group _x) setGroupIconParams [PlayerMarkerColor, format["%1-%2", name _x,round(player distance _x)],TheThicknessOfThePointPlayer,true];
};
if (!PlayerShowBloodInt && !PlayerShowDistance) then {
//_text=parseText format ["%1",name _x];
(group _x) setGroupIconParams [PlayerMarkerColor, format ["%1",name _x],TheThicknessOfThePointPlayer,true];
};
ParamsPlayersMarkers=[true,AddPlayersToScreen];
setGroupIconsVisible ParamsPlayersMarkers;
} forEach allUnits;
};


If (AddZombieToMap) then {
_pos = getPos player;
_zombies = _pos nearEntities ["zZombie_Base",ZombieVisibleDistance];
_zmcount= count _zombies;
k=0;

_markcount = count markers;
for "k" from 0 to (_markcount -1) do
{
deleteMarkerLocal ("zmMarker"+ (str k));
};

for "k" from 0 to _zmcount do {

_text = format ["zmMarker%1", k];
markers set [k, _text];
zm = _zombies select k;
if(alive zm) then {
pos = position zm;
deleteMarkerLocal ("zmMarker"+ (str k));
MarkerZm = "zmMarker" + (str k);
ParamsZm=[MarkerZm,pos];
MarkerZm = createMarkerLocal ParamsZm;
MarkerZm setMarkerTypeLocal ZombieMarkerType;
MarkerZm setMarkerPosLocal (pos);
MarkerZm setMarkerColorLocal(ZombieMarkerColor);
MarkerZm setMarkerTextLocal ZombieName;
};
};
};

If (AddVehicleToMap) then {
vehList = allmissionobjects "LandVehicle" + allmissionobjects "Air" + allmissionobjects "Boat";
j = count vehList;
i = 0;

for "i" from 0 to j do
{
veh = vehList select i;
_name = gettext (configFile >> "CfgVehicles" >> (typeof veh) >> "displayName");

pos = position veh;
deleteMarkerLocal ("vehMarker"+ (str i));
MarkerVeh = "vehMarker" + (str i);
ParamsVeh=[MarkerVeh,pos];
MarkerVeh = createMarkerLocal ParamsVeh;
MarkerVeh setMarkerTypeLocal VehicleMarkerType;
MarkerVeh setMarkerPosLocal (pos);
MarkerVeh setMarkerColorLocal(VehicleMarkerColor);
MarkerVeh setMarkerTextLocal format ["%1",_name];
};
};

If (AddTentsToMap) then {
tentList = allmissionobjects "Land_A_tent";
j1 = count tentList;
i1 = 0;

for "i1" from 0 to j1 do
{
tent = tentList select i1;
_name = gettext (configFile >> "CfgVehicles" >> (typeof tent) >> "displayName");
pos = position tent;
deleteMarkerLocal ("tentMarker"+ (str i1));
MarkerTent = "tentMarker" + (str i1);
ParamsTent=[MarkerTent,pos];
MarkerTent = createMarkerLocal ParamsTent;
MarkerTent setMarkerTypeLocal TentsMarkerType;
MarkerTent setMarkerPosLocal (pos);
MarkerTent setMarkerColorLocal(TentsMarkerColor);
MarkerTent setMarkerTextLocal format ["%1",_name];
};
};
If (AddCrashesToMap) then {
crashList = allmissionobjects "UH1Wreck_DZ";
j2 = count tentList;
i2 = 0;

for "i2" from 0 to j2 do
{
crash = crashList select i2;
_name = gettext (configFile >> "CfgVehicles" >> (typeof crash) >> "displayName");
pos = position crash;
deleteMarkerLocal ("crashMarker"+ (str i2));
MarkerCrash = "crashMarker" + (str i2);
ParamsCrash=[MarkerCrash,pos];
MarkerCrash = createMarkerLocal ParamsCrash;
MarkerCrash setMarkerTypeLocal CrashesMarkerType;
MarkerCrash setMarkerPosLocal (pos);
MarkerCrash setMarkerColorLocal(CrashesMarkerColor);
MarkerCrash setMarkerTextLocal format ["%1",_name];
};
};
sleep GlobalSleep;
{
clearGroupIcons (group _x);
} forEach allUnits;
};


if(!markPos) then {

If (AddPlayersToMap) then {
{
clearGroupIcons (group _x);
} forEach allUnits;
};

If (AddZombieToMap) then {
_count = count markers;
for "k" from 0 to (_count -1) do
{
deleteMarkerLocal ("zmMarker"+ (str k));
};
};

If (AddVehicleToMap) then {
for "i" from 0 to j do
{
veh = vehList select i;
deleteMarkerLocal ("vehMarker"+ (str i));
};
};

If (AddTentsToMap) then {
for "i1" from 0 to j1 do
{
tent = tentList select i1;
deleteMarkerLocal ("tentMarker"+ (str i1));
};
};

If (AddCrashesToMap) then {
for "i2" from 0 to j2 do
{
crash = crashList select i2;
deleteMarkerLocal ("crashMarker"+ (str i2));
};
};
sleep 0.5;
};
