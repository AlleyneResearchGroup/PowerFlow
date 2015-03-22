function varargout = Main(varargin)
% MAIN MATLAB code for Main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main

% Last Modified by GUIDE v2.5 06-Mar-2015 00:28:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main (see VARARGIN)

% Choose default command line output for Main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Run.
function Run_Callback(hObject, eventdata, handles)
% hObject    handle to Run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%uiopen('Batch1.mat')
clear handles.MSSN


BatchArray = evalin('base','BatchArray');
N = length(BatchArray);
GTool.setTheme ('blue') ;
g=GTabContainer(figure(),'top') ;
for i = 1:N
    M=load(BatchArray{i});
   M = M.M;
   assignin('base','M',M);
   altindex(hObject,handles)
    assignin('base','M',M);
    
    if i==1
MSSN1 = MissionBuild(M.phaselist,M.startuparr,M.taxiarr,M.takeoffarr,M.climbarr,M.cruisearr,...
    M.descentarr,M.loiterarr,M.approacharr,M.landingarr,M.shutdownarr,M.genstrct);
assignin('base','MSSN1',MSSN1);
g.addTab(BatchArray{i});
h=GAccordion (g.getComponentAt(1));
h.addTab('Altitude');
axes('Parent',h.getComponentAt(1));
plot(MSSN1.cond.time,MSSN1.cond.alt)
axis([0,MSSN1.cond.time(end),0,1.1*max(MSSN1.cond.alt)])
ylabel('Feet')
xlabel('Time (Sec)')
title('Altitude')

h.addTab('Mach');
axes('Parent',h.getComponentAt(2));
plot(MSSN1.cond.time,MSSN1.cond.mach)
axis([0,MSSN1.cond.time(end),0,1.1*max(MSSN1.cond.mach)])
title('Mach')
xlabel('Time (Sec)')

h.addTab('APU');
axes('Parent',h.getComponentAt(3));
plot(MSSN1.eng.time,MSSN1.eng.apu)
axis([0,MSSN1.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('APU')

h.addTab('Engine Status');
axes('Parent',h.getComponentAt(4));
if isfield(MSSN1.eng,'Eng3')==0;
plot(MSSN1.eng.time,MSSN1.eng.Eng1)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Eng2)
elseif isfield(MSSN1.eng,'Eng3')==1;
 plot(MSSN1.eng.time,MSSN1.eng.Eng1)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Eng2)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Eng3)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Eng4)
end
axis([0,MSSN1.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('Engine')

h.addTab('Engine Thrust');
axes('Parent',h.getComponentAt(5));
if isfield(MSSN1.eng,'Eng3')==0;
plot(MSSN1.eng.time,MSSN1.eng.EngThrust1)
hold on
plot(MSSN1.eng.time,MSSN1.eng.EngThrust2)
elseif isfield(MSSN1.eng,'Eng3')==1;
 plot(MSSN1.eng.time,MSSN1.eng.EngThrust1)
hold on
plot(MSSN1.eng.time,MSSN1.eng.EngThrust2)
hold on
plot(MSSN1.eng.time,MSSN1.eng.EngThrust3)
hold on
plot(MSSN1.eng.time,MSSN1.eng.EngThrust4)
end
axis([0,MSSN1.eng.time(end),0,1.1*max(MSSN1.eng.EngThrust1)])
xlabel('Time (Sec)')
ylabel('Thrust kN')
title('Engine Thrust')

h.addTab('Generators');
axes('Parent',h.getComponentAt(6));
if isfield(MSSN1.eng,'Gen5')==0;
plot(MSSN1.eng.time,MSSN1.eng.Gen1)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Gen2)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Gen3)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Gen4)
elseif isfield(MSSN1.eng,'Gen5')==1;
plot(MSSN1.eng.time,MSSN1.eng.Gen1)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Gen2)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Gen3)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Gen4)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Gen5)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Gen6)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Gen7)
hold on
plot(MSSN1.eng.time,MSSN1.eng.Gen8)
end
axis([0,MSSN1.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('Generator Status')
%{
h.addTab('Pack');
axes('Parent',h.getComponentAt(7));
plot(MSSN1.eng.time,MSSN1.eng.pack)
axis([0,MSSN1.eng.time(end),0,1.1])
title('Pack')
xlabel('Time (Sec)')

h.addTab('Landing Gear');
axes('Parent',h.getComponentAt(8));
plot(MSSN1.hyd.time,MSSN1.hyd.lndgr)
axis([0,MSSN1.hyd.time(end),0,1.1])
title('Landing Gear')
xlabel('Time (Sec)')

h.addTab('Flaps');
axes('Parent',h.getComponentAt(9));
plot(MSSN1.el.time,MSSN1.el.flaps)
axis([0,MSSN1.el.time(end),0,1.1*max(MSSN1.el.flaps)])
title('Flaps')
xlabel('Time (Sec)')
ylabel('Angle [Deg]')

h.addTab('NavCom');
axes('Parent',h.getComponentAt(10));
plot(MSSN1.el.time,MSSN1.el.navcom)
axis([0,MSSN1.el.time(end),0,1.1])
title('NavCom')
xlabel('Time (Sec)')

h.addTab('AutoPilot');
axes('Parent',h.getComponentAt(11));
plot(MSSN1.el.time,MSSN1.el.autop)
axis([0,MSSN1.el.time(end),0,1.1])
title('Autopilot')
xlabel('Time (Sec)')

h.addTab('Taxi Light');
axes('Parent',h.getComponentAt(12));
plot(MSSN1.el.time,MSSN1.el.taxilit)
axis([0,MSSN1.el.time(end),0,1.1])
title('Taxi Light')
xlabel('Time (Sec)')

h.addTab('Landing Light');
axes('Parent',h.getComponentAt(13));
plot(MSSN1.el.time,MSSN1.el.landinglit)
axis([0,MSSN1.el.time(end),0,1.1])
title('Landing Light')
xlabel('Time (Sec)')

h.addTab('Pressure');
axes('Parent',h.getComponentAt(14));
plot(MSSN1.pnu.time,MSSN1.pnu.pres)
axis([0,MSSN1.pnu.time(end),0,1.1])
title('Pressure')
xlabel('Time (Sec)')

h.addTab('State');
axes('Parent',h.getComponentAt(15));
plot(MSSN1.gen.time,MSSN1.gen.state)
axis([0,MSSN1.gen.time(end),0,1.1*max(MSSN1.gen.state)])
title('State')
xlabel('Time (Sec)')
%}
    elseif i==2
MSSN2 = MissionBuild(M.phaselist,M.startuparr,M.taxiarr,M.takeoffarr,M.climbarr,M.cruisearr,...
    M.descentarr,M.loiterarr,M.approacharr,M.landingarr,M.shutdownarr,M.genstrct);
assignin('base','MSSN2',MSSN2);
MSSN2=evalin('base','MSSN2');

g.addTab(BatchArray{i});
h=GAccordion (g.getComponentAt(2));
h.addTab('Altitude');
axes('Parent',h.getComponentAt(1));
plot(MSSN2.cond.time,MSSN2.cond.alt)
axis([0,MSSN2.cond.time(end),0,1.1*max(MSSN2.cond.alt)])
ylabel('Feet')
xlabel('Time (Sec)')
title('Altitude')

h.addTab('Mach');
axes('Parent',h.getComponentAt(2));
plot(MSSN2.cond.time,MSSN2.cond.mach)
axis([0,MSSN2.cond.time(end),0,1.1*max(MSSN2.cond.mach)])
title('Mach')
xlabel('Time (Sec)')

h.addTab('APU');
axes('Parent',h.getComponentAt(3));
plot(MSSN2.eng.time,MSSN2.eng.apu)
axis([0,MSSN2.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('APU')

h.addTab('Engine Status');
axes('Parent',h.getComponentAt(4));
if isfield(MSSN2.eng,'Eng3')==0;
plot(MSSN2.eng.time,MSSN2.eng.Eng1)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Eng2)
elseif isfield(MSSN2.eng,'Eng3')==1;
 plot(MSSN2.eng.time,MSSN2.eng.Eng1)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Eng2)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Eng3)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Eng4)
end
axis([0,MSSN2.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('Engine')

h.addTab('Engine Thrust');
axes('Parent',h.getComponentAt(5));
if isfield(MSSN2.eng,'Eng3')==0;
plot(MSSN2.eng.time,MSSN2.eng.EngThrust1)
hold on
plot(MSSN2.eng.time,MSSN2.eng.EngThrust2)
elseif isfield(MSSN2.eng,'Eng3')==1;
 plot(MSSN2.eng.time,MSSN2.eng.EngThrust1)
hold on
plot(MSSN2.eng.time,MSSN2.eng.EngThrust2)
hold on
plot(MSSN2.eng.time,MSSN2.eng.EngThrust3)
hold on
plot(MSSN2.eng.time,MSSN2.eng.EngThrust4)
end
axis([0,MSSN2.eng.time(end),0,1.1*max(MSSN2.eng.EngThrust1)])
xlabel('Time (Sec)')
ylabel('Thrust kN')
title('Engine Thrust')

h.addTab('Generators');
axes('Parent',h.getComponentAt(6));
if isfield(MSSN2.eng,'Gen5')==0;
plot(MSSN2.eng.time,MSSN2.eng.Gen1)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Gen2)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Gen3)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Gen4)
elseif isfield(MSSN2.eng,'Gen5')==1;
plot(MSSN2.eng.time,MSSN2.eng.Gen1)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Gen2)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Gen3)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Gen4)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Gen5)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Gen6)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Gen7)
hold on
plot(MSSN2.eng.time,MSSN2.eng.Gen8)
end
axis([0,MSSN2.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('Generator Status')
%{
h.addTab('Pack');
axes('Parent',h.getComponentAt(7));
plot(MSSN2.eng.time,MSSN2.eng.pack)
axis([0,MSSN2.eng.time(end),0,1.1])
title('Pack')
xlabel('Time (Sec)')

h.addTab('Landing Gear');
axes('Parent',h.getComponentAt(8));
plot(MSSN2.hyd.time,MSSN2.hyd.lndgr)
axis([0,MSSN2.hyd.time(end),0,1.1])
title('Landing Gear')
xlabel('Time (Sec)')

h.addTab('Flaps');
axes('Parent',h.getComponentAt(9));
plot(MSSN2.el.time,MSSN2.el.flaps)
axis([0,MSSN2.el.time(end),0,1.1*max(MSSN2.el.flaps)])
title('Flaps')
xlabel('Time (Sec)')
ylabel('Angle [Deg]')

h.addTab('NavCom');
axes('Parent',h.getComponentAt(10));
plot(MSSN2.el.time,MSSN2.el.navcom)
axis([0,MSSN2.el.time(end),0,1.1])
title('NavCom')
xlabel('Time (Sec)')

h.addTab('AutoPilot');
axes('Parent',h.getComponentAt(11));
plot(MSSN2.el.time,MSSN2.el.autop)
axis([0,MSSN2.el.time(end),0,1.1])
title('Autopilot')
xlabel('Time (Sec)')

h.addTab('Taxi Light');
axes('Parent',h.getComponentAt(12));
plot(MSSN2.el.time,MSSN2.el.taxilit)
axis([0,MSSN2.el.time(end),0,1.1])
title('Taxi Light')
xlabel('Time (Sec)')

h.addTab('Landing Light');
axes('Parent',h.getComponentAt(13));
plot(MSSN2.el.time,MSSN2.el.landinglit)
axis([0,MSSN2.el.time(end),0,1.1])
title('Landing Light')
xlabel('Time (Sec)')

h.addTab('Pressure');
axes('Parent',h.getComponentAt(14));
plot(MSSN2.pnu.time,MSSN2.pnu.pres)
axis([0,MSSN2.pnu.time(end),0,1.1])
title('Pressure')
xlabel('Time (Sec)')

h.addTab('State');
axes('Parent',h.getComponentAt(15));
plot(MSSN2.gen.time,MSSN2.gen.state)
axis([0,MSSN2.gen.time(end),0,1.1*max(MSSN2.gen.state)])
title('State')
xlabel('Time (Sec)')
%}
    elseif i==3;
MSSN3 = MissionBuild(M.phaselist,M.startuparr,M.taxiarr,M.takeoffarr,M.climbarr,M.cruisearr,...
    M.descentarr,M.loiterarr,M.approacharr,M.landingarr,M.shutdownarr,M.genstrct);
assignin('base','MSSN3',MSSN3);
MSSN3=evalin('base','MSSN3');

g.addTab(BatchArray{i});
h=GAccordion (g.getComponentAt(3));
h.addTab('Altitude');
axes('Parent',h.getComponentAt(1));
plot(MSSN3.cond.time,MSSN3.cond.alt)
axis([0,MSSN3.cond.time(end),0,1.1*max(MSSN3.cond.alt)])
ylabel('Feet')
xlabel('Time (Sec)')
title('Altitude')

h.addTab('Mach');
axes('Parent',h.getComponentAt(2));
plot(MSSN3.cond.time,MSSN3.cond.mach)
axis([0,MSSN3.cond.time(end),0,1.1*max(MSSN3.cond.mach)])
title('Mach')
xlabel('Time (Sec)')

h.addTab('APU');
axes('Parent',h.getComponentAt(3));
plot(MSSN3.eng.time,MSSN3.eng.apu)
axis([0,MSSN3.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('APU')

h.addTab('Engine Status');
axes('Parent',h.getComponentAt(4));
if isfield(MSSN3.eng,'Eng3')==0;
plot(MSSN3.eng.time,MSSN3.eng.Eng1)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Eng2)
elseif isfield(MSSN3.eng,'Eng3')==1;
 plot(MSSN3.eng.time,MSSN3.eng.Eng1)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Eng2)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Eng3)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Eng4)
end
axis([0,MSSN3.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('Engine')

h.addTab('Engine Thrust');
axes('Parent',h.getComponentAt(5));
if isfield(MSSN3.eng,'Eng3')==0;
plot(MSSN3.eng.time,MSSN3.eng.EngThrust1)
hold on
plot(MSSN3.eng.time,MSSN3.eng.EngThrust2)
elseif isfield(MSSN3.eng,'Eng3')==1;
 plot(MSSN3.eng.time,MSSN3.eng.EngThrust1)
hold on
plot(MSSN3.eng.time,MSSN3.eng.EngThrust2)
hold on
plot(MSSN3.eng.time,MSSN3.eng.EngThrust3)
hold on
plot(MSSN3.eng.time,MSSN3.eng.EngThrust4)
end
axis([0,MSSN3.eng.time(end),0,1.1*max(MSSN3.eng.EngThrust1)])
xlabel('Time (Sec)')
ylabel('Thrust kN')
title('Engine Thrust')

h.addTab('Generators');
axes('Parent',h.getComponentAt(6));
if isfield(MSSN3.eng,'Gen5')==0;
plot(MSSN3.eng.time,MSSN3.eng.Gen1)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Gen2)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Gen3)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Gen4)
elseif isfield(MSSN3.eng,'Gen5')==1;
plot(MSSN3.eng.time,MSSN3.eng.Gen1)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Gen2)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Gen3)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Gen4)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Gen5)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Gen6)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Gen7)
hold on
plot(MSSN3.eng.time,MSSN3.eng.Gen8)
end
axis([0,MSSN3.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('Generator Status')
%{
h.addTab('Pack');
axes('Parent',h.getComponentAt(7));
plot(MSSN3.eng.time,MSSN3.eng.pack)
axis([0,MSSN3.eng.time(end),0,1.1])
title('Pack')
xlabel('Time (Sec)')

h.addTab('Landing Gear');
axes('Parent',h.getComponentAt(8));
plot(MSSN3.hyd.time,MSSN3.hyd.lndgr)
axis([0,MSSN3.hyd.time(end),0,1.1])
title('Landing Gear')
xlabel('Time (Sec)')

h.addTab('Flaps');
axes('Parent',h.getComponentAt(9));
plot(MSSN3.el.time,MSSN3.el.flaps)
axis([0,MSSN3.el.time(end),0,1.1*max(MSSN3.el.flaps)])
title('Flaps')
xlabel('Time (Sec)')
ylabel('Angle [Deg]')

h.addTab('NavCom');
axes('Parent',h.getComponentAt(10));
plot(MSSN3.el.time,MSSN3.el.navcom)
axis([0,MSSN3.el.time(end),0,1.1])
title('NavCom')
xlabel('Time (Sec)')

h.addTab('AutoPilot');
axes('Parent',h.getComponentAt(11));
plot(MSSN3.el.time,MSSN3.el.autop)
axis([0,MSSN3.el.time(end),0,1.1])
title('Autopilot')
xlabel('Time (Sec)')

h.addTab('Taxi Light');
axes('Parent',h.getComponentAt(12));
plot(MSSN3.el.time,MSSN3.el.taxilit)
axis([0,MSSN3.el.time(end),0,1.1])
title('Taxi Light')
xlabel('Time (Sec)')

h.addTab('Landing Light');
axes('Parent',h.getComponentAt(13));
plot(MSSN3.el.time,MSSN3.el.landinglit)
axis([0,MSSN3.el.time(end),0,1.1])
title('Landing Light')
xlabel('Time (Sec)')

h.addTab('Pressure');
axes('Parent',h.getComponentAt(14));
plot(MSSN3.pnu.time,MSSN3.pnu.pres)
axis([0,MSSN3.pnu.time(end),0,1.1])
title('Pressure')
xlabel('Time (Sec)')

h.addTab('State');
axes('Parent',h.getComponentAt(15));
plot(MSSN3.gen.time,MSSN3.gen.state)
axis([0,MSSN3.gen.time(end),0,1.1*max(MSSN3.gen.state)])
title('State')
xlabel('Time (Sec)')
%}
    elseif i==4;
MSSN4 = MissionBuild(M.phaselist,M.startuparr,M.taxiarr,M.takeoffarr,M.climbarr,M.cruisearr,...
    M.descentarr,M.loiterarr,M.approacharr,M.landingarr,M.shutdownarr,M.genstrct);
assignin('base','MSSN4',MSSN4);
MSSN4=evalin('base','MSSN4');

g.addTab(BatchArray{i});
h=GAccordion (g.getComponentAt(4));
h.addTab('Altitude');
axes('Parent',h.getComponentAt(1));
plot(MSSN4.cond.time,MSSN4.cond.alt)
axis([0,MSSN4.cond.time(end),0,1.1*max(MSSN4.cond.alt)])
ylabel('Feet')
xlabel('Time (Sec)')
title('Altitude')

h.addTab('Mach');
axes('Parent',h.getComponentAt(2));
plot(MSSN4.cond.time,MSSN4.cond.mach)
axis([0,MSSN4.cond.time(end),0,1.1*max(MSSN4.cond.mach)])
title('Mach')
xlabel('Time (Sec)')

h.addTab('APU');
axes('Parent',h.getComponentAt(3));
plot(MSSN4.eng.time,MSSN4.eng.apu)
axis([0,MSSN4.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('APU')

h.addTab('Engine Status');
axes('Parent',h.getComponentAt(4));
if isfield(MSSN4.eng,'Eng3')==0;
plot(MSSN4.eng.time,MSSN4.eng.Eng1)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Eng2)
elseif isfield(MSSN4.eng,'Eng3')==1;
 plot(MSSN4.eng.time,MSSN4.eng.Eng1)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Eng2)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Eng3)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Eng4)
end
axis([0,MSSN4.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('Engine')

h.addTab('Engine Thrust');
axes('Parent',h.getComponentAt(5));
if isfield(MSSN4.eng,'Eng3')==0;
plot(MSSN4.eng.time,MSSN4.eng.EngThrust1)
hold on
plot(MSSN4.eng.time,MSSN4.eng.EngThrust2)
elseif isfield(MSSN4.eng,'Eng3')==1;
 plot(MSSN4.eng.time,MSSN4.eng.EngThrust1)
hold on
plot(MSSN4.eng.time,MSSN4.eng.EngThrust2)
hold on
plot(MSSN4.eng.time,MSSN4.eng.EngThrust3)
hold on
plot(MSSN4.eng.time,MSSN4.eng.EngThrust4)
end
axis([0,MSSN4.eng.time(end),0,1.1*max(MSSN4.eng.EngThrust1)])
xlabel('Time (Sec)')
ylabel('Thrust kN')
title('Engine Thrust')

h.addTab('Generators');
axes('Parent',h.getComponentAt(6));
if isfield(MSSN4.eng,'Gen5')==0;
plot(MSSN4.eng.time,MSSN4.eng.Gen1)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Gen2)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Gen3)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Gen4)
elseif isfield(MSSN4.eng,'Gen5')==1;
plot(MSSN4.eng.time,MSSN4.eng.Gen1)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Gen2)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Gen3)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Gen4)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Gen5)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Gen6)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Gen7)
hold on
plot(MSSN4.eng.time,MSSN4.eng.Gen8)
end
axis([0,MSSN4.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('Generator Status')
%{
h.addTab('Pack');
axes('Parent',h.getComponentAt(7));
plot(MSSN4.eng.time,MSSN4.eng.pack)
axis([0,MSSN4.eng.time(end),0,1.1])
title('Pack')
xlabel('Time (Sec)')

h.addTab('Landing Gear');
axes('Parent',h.getComponentAt(8));
plot(MSSN4.hyd.time,MSSN4.hyd.lndgr)
axis([0,MSSN4.hyd.time(end),0,1.1])
title('Landing Gear')
xlabel('Time (Sec)')

h.addTab('Flaps');
axes('Parent',h.getComponentAt(9));
plot(MSSN4.el.time,MSSN4.el.flaps)
axis([0,MSSN4.el.time(end),0,1.1*max(MSSN4.el.flaps)])
title('Flaps')
xlabel('Time (Sec)')
ylabel('Angle [Deg]')

h.addTab('NavCom');
axes('Parent',h.getComponentAt(10));
plot(MSSN4.el.time,MSSN4.el.navcom)
axis([0,MSSN4.el.time(end),0,1.1])
title('NavCom')
xlabel('Time (Sec)')

h.addTab('AutoPilot');
axes('Parent',h.getComponentAt(11));
plot(MSSN4.el.time,MSSN4.el.autop)
axis([0,MSSN4.el.time(end),0,1.1])
title('Autopilot')
xlabel('Time (Sec)')

h.addTab('Taxi Light');
axes('Parent',h.getComponentAt(12));
plot(MSSN4.el.time,MSSN4.el.taxilit)
axis([0,MSSN4.el.time(end),0,1.1])
title('Taxi Light')
xlabel('Time (Sec)')

h.addTab('Landing Light');
axes('Parent',h.getComponentAt(13));
plot(MSSN4.el.time,MSSN4.el.landinglit)
axis([0,MSSN4.el.time(end),0,1.1])
title('Landing Light')
xlabel('Time (Sec)')

h.addTab('Pressure');
axes('Parent',h.getComponentAt(14));
plot(MSSN4.pnu.time,MSSN4.pnu.pres)
axis([0,MSSN4.pnu.time(end),0,1.1])
title('Pressure')
xlabel('Time (Sec)')

h.addTab('State');
axes('Parent',h.getComponentAt(15));
plot(MSSN4.gen.time,MSSN4.gen.state)
axis([0,MSSN4.gen.time(end),0,1.1*max(MSSN4.gen.state)])
title('State')
xlabel('Time (Sec)')
%}
elseif i==5;
MSSN5 = MissionBuild(M.phaselist,M.startuparr,M.taxiarr,M.takeoffarr,M.climbarr,M.cruisearr,...
    M.descentarr,M.loiterarr,M.approacharr,M.landingarr,M.shutdownarr,M.genstrct);
assignin('base','MSSN5',MSSN5);
MSSN5=evalin('base','MSSN5');

g.addTab(BatchArray{i});
h=GAccordion (g.getComponentAt(5));
h.addTab('Altitude');
axes('Parent',h.getComponentAt(1));
plot(MSSN5.cond.time,MSSN5.cond.alt)
axis([0,MSSN5.cond.time(end),0,1.1*max(MSSN5.cond.alt)])
ylabel('Feet')
xlabel('Time (Sec)')
title('Altitude')

h.addTab('Mach');
axes('Parent',h.getComponentAt(2));
plot(MSSN5.cond.time,MSSN5.cond.mach)
axis([0,MSSN5.cond.time(end),0,1.1*max(MSSN5.cond.mach)])
title('Mach')
xlabel('Time (Sec)')

h.addTab('APU');
axes('Parent',h.getComponentAt(3));
plot(MSSN5.eng.time,MSSN5.eng.apu)
axis([0,MSSN5.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('APU')

h.addTab('Engine Status');
axes('Parent',h.getComponentAt(4));
if isfield(MSSN5.eng,'Eng3')==0;
plot(MSSN5.eng.time,MSSN5.eng.Eng1)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Eng2)
elseif isfield(MSSN5.eng,'Eng3')==1;
 plot(MSSN5.eng.time,MSSN5.eng.Eng1)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Eng2)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Eng3)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Eng4)
end
axis([0,MSSN5.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('Engine')

h.addTab('Engine Thrust');
axes('Parent',h.getComponentAt(5));
if isfield(MSSN5.eng,'Eng3')==0;
plot(MSSN5.eng.time,MSSN5.eng.EngThrust1)
hold on
plot(MSSN5.eng.time,MSSN5.eng.EngThrust2)
elseif isfield(MSSN5.eng,'Eng3')==1;
 plot(MSSN5.eng.time,MSSN5.eng.EngThrust1)
hold on
plot(MSSN5.eng.time,MSSN5.eng.EngThrust2)
hold on
plot(MSSN5.eng.time,MSSN5.eng.EngThrust3)
hold on
plot(MSSN5.eng.time,MSSN5.eng.EngThrust4)
end
axis([0,MSSN5.eng.time(end),0,1.1*max(MSSN5.eng.EngThrust1)])
xlabel('Time (Sec)')
ylabel('Thrust kN')
title('Engine Thrust')

h.addTab('Generators');
axes('Parent',h.getComponentAt(6));
if isfield(MSSN5.eng,'Gen5')==0;
plot(MSSN5.eng.time,MSSN5.eng.Gen1)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Gen2)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Gen3)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Gen4)
elseif isfield(MSSN5.eng,'Gen5')==1;
plot(MSSN5.eng.time,MSSN5.eng.Gen1)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Gen2)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Gen3)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Gen4)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Gen5)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Gen6)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Gen7)
hold on
plot(MSSN5.eng.time,MSSN5.eng.Gen8)
end
axis([0,MSSN5.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('Generator Status')
%{
h.addTab('Pack');
axes('Parent',h.getComponentAt(7));
plot(MSSN5.eng.time,MSSN5.eng.pack)
axis([0,MSSN5.eng.time(end),0,1.1])
title('Pack')
xlabel('Time (Sec)')

h.addTab('Landing Gear');
axes('Parent',h.getComponentAt(8));
plot(MSSN5.hyd.time,MSSN5.hyd.lndgr)
axis([0,MSSN5.hyd.time(end),0,1.1])
title('Landing Gear')
xlabel('Time (Sec)')

h.addTab('Flaps');
axes('Parent',h.getComponentAt(9));
plot(MSSN5.el.time,MSSN5.el.flaps)
axis([0,MSSN5.el.time(end),0,1.1*max(MSSN5.el.flaps)])
title('Flaps')
xlabel('Time (Sec)')
ylabel('Angle [Deg]')

h.addTab('NavCom');
axes('Parent',h.getComponentAt(10));
plot(MSSN5.el.time,MSSN5.el.navcom)
axis([0,MSSN5.el.time(end),0,1.1])
title('NavCom')
xlabel('Time (Sec)')

h.addTab('AutoPilot');
axes('Parent',h.getComponentAt(11));
plot(MSSN5.el.time,MSSN5.el.autop)
axis([0,MSSN5.el.time(end),0,1.1])
title('Autopilot')
xlabel('Time (Sec)')

h.addTab('Taxi Light');
axes('Parent',h.getComponentAt(12));
plot(MSSN5.el.time,MSSN5.el.taxilit)
axis([0,MSSN5.el.time(end),0,1.1])
title('Taxi Light')
xlabel('Time (Sec)')

h.addTab('Landing Light');
axes('Parent',h.getComponentAt(13));
plot(MSSN5.el.time,MSSN5.el.landinglit)
axis([0,MSSN5.el.time(end),0,1.1])
title('Landing Light')
xlabel('Time (Sec)')

h.addTab('Pressure');
axes('Parent',h.getComponentAt(14));
plot(MSSN5.pnu.time,MSSN5.pnu.pres)
axis([0,MSSN5.pnu.time(end),0,1.1])
title('Pressure')
xlabel('Time (Sec)')

h.addTab('State');
axes('Parent',h.getComponentAt(15));
plot(MSSN5.gen.time,MSSN5.gen.state)
axis([0,MSSN5.gen.time(end),0,1.1*max(MSSN5.gen.state)])
title('State')
xlabel('Time (Sec)')
%}
    end
guidata(hObject, handles);








        

end


% --- Executes on button press in BuildBatch.
function BuildBatch_Callback(hObject, eventdata, handles)
% hObject    handle to BuildBatch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[BatchFile] = uiputfile('Batch1.mat','Save Batch name');
N = str2double(get(handles.NumMSSN, 'string'));
Batch = cell(N,1);

B=1;
for i = 1:N
    A = uigetfile('*.mat','Select the input file');
    if strcmp(num2str(A),'0') == 1
        B=0;
        break
    end
    Batch(i,:) = cellstr(A);
end
if B == 1
   %save(BatchArray,'Batch')
end

assignin('base','BatchArray',Batch);

function NumMSSN_Callback(hObject, eventdata, handles)
% hObject    handle to NumMSSN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumMSSN as text
%        str2double(get(hObject,'String')) returns contents of NumMSSN as a double


% --- Executes during object creation, after setting all properties.
function NumMSSN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumMSSN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function altindex(hObject,handles)
% this function indexes the altitudes so that the right altitude is used
% for each phase.  the altitudes or simply kept in a standard array such as
% the following [0, 10000, 35000, 3000, 0].  Each phase must know which
% altitude or altitudes to operate at, hence each gets indices
M=evalin('base','M');
MSSNlist = M.phaselist

j = 1;
N_mssnphase = size(MSSNlist)
M.genstrct.alt.ind.ST_ALT_i = []; %Startup altitude index
M.genstrct.alt.ind.TA_ALT_i = []; %Taxi altitude index
M.genstrct.alt.ind.TO_ALT_i = []; %Take Off altitude index
M.genstrct.alt.ind.CL1_ALT_i = []; %Climb Starting altitude index
M.genstrct.alt.ind.CL2_ALT_i = []; %Climb final altitude index
M.genstrct.alt.ind.CR_ALT_i = []; %Cruise altitude index
M.genstrct.alt.ind.DE1_ALT_i = []; %Descent Starting altitude index
M.genstrct.alt.ind.DE2_ALT_i = []; %Descent final altitude index
M.genstrct.alt.ind.LO_ALT_i = []; %Loiter altitude index
M.genstrct.alt.ind.AP1_ALT_i = []; %Approach Starting altitude index
M.genstrct.alt.ind.AP2_ALT_i = []; %Approach final altitude index (also 
    % serves as landing altitude index
M.genstrct.alt.ind.SD_ALT_i = []; %Shutdown altitude index
for i = 1:N_mssnphase(1)
    if strncmp(MSSNlist(i),'Startup',3) == 1
        M.genstrct.alt.ind.ST_ALT_i = [M.genstrct.alt.ind.ST_ALT_i j];
    elseif strncmp(MSSNlist(i),'Taxi',3) == 1
        M.genstrct.alt.ind.TA_ALT_i = [M.genstrct.alt.ind.TA_ALT_i j];
    elseif strncmp(MSSNlist(i),'Takeoff',3) == 1
        M.genstrct.alt.ind.TO_ALT_i = [M.genstrct.alt.ind.TO_ALT_i j];
    elseif strncmp(MSSNlist(i),'Climb',3) == 1
        M.genstrct.alt.ind.CL1_ALT_i = [M.genstrct.alt.ind.CL1_ALT_i j];
        M.genstrct.alt.ind.CL2_ALT_i = [M.genstrct.alt.ind.CL2_ALT_i j+1];
        j = j+1;
    elseif strncmp(MSSNlist(i),'Cruise',3) == 1
        M.genstrct.alt.ind.CR_ALT_i = [M.genstrct.alt.ind.CR_ALT_i j];
    elseif strncmp(MSSNlist(i),'Descent',3) == 1
        M.genstrct.alt.ind.DE1_ALT_i = [M.genstrct.alt.ind.DE1_ALT_i j];
        M.genstrct.alt.ind.DE2_ALT_i = [M.genstrct.alt.ind.DE2_ALT_i j+1];
        j = j+1;
    elseif strncmp(MSSNlist(i),'Loiter',3) == 1
        M.genstrct.alt.ind.LO_ALT_i = [M.genstrct.alt.ind.LO_ALT_i j];
    elseif strncmp(MSSNlist(i),'Approach',3) == 1
        M.genstrct.alt.ind.AP1_ALT_i = [M.genstrct.alt.ind.AP1_ALT_i j];
        M.genstrct.alt.ind.AP2_ALT_i = [M.genstrct.alt.ind.AP2_ALT_i j+1];
        j = j+1;
    elseif strncmp(MSSNlist(i),'Shutdown',3) == 1
        M.genstrct.alt.ind.SD_ALT_i = [M.genstrct.alt.ind.SD_ALT_i j];
    end
   
end
handles.M = M;
guidata(hObject,handles)


