%LOADFLUIDPROPS loads fluid properties into the MATLAB workspace
%   POWERFLOW_AUTO_INSTALL is automatically called by the Simulink block
%   FluidComponent Properties in the Support Functions/Tools sublibrary of
%   the PowerFlow toolset.

%   Developed by Matthew Williams - UIUC

h      = get_param(gcb,'handle');
blk    = gcb ;
hblock = get(h);    

% load fuel properties and set to fluid #1
load(hblock.fuelprop);
assignin('base','FuelProp',FuelProp)
assignin('base','F1',FuelProp)

% load oil properties and set to fluid #2
load(hblock.oilprop);
assignin('base','OilProp',OilProp)
assignin('base','F2',OilProp)

% load air properties - named MoistAirProp
load(hblock.airprop);
assignin('base','AirProp',AirProp)

% load pump properties - named PumpProp
load(hblock.pumpprop);
assignin('base','PumpProp',PumpProp)

% load fan properties - named fanProp
load(hblock.fanprop);
assignin('base','Fanmap',Fanmap)

% load compressor properties - named CompProp
load(hblock.compprop);
assignin('base','CompProp',CompProp)

clear h blk hblock FuelProp OilProp 
