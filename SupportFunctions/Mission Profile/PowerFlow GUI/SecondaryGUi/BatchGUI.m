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

% Last Modified by GUIDE v2.5 03-Apr-2015 17:45:07

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
handles.BuildBatch=0;

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
if isempty(BatchArray{1})==1
    warndlg('Load a mission')
else
L=0;
for i = 1:N
   L=L+1; 
   M=load(BatchArray{i});
   M = M.M;
   assignin('base','M',M);
   altindex(hObject,handles)
   assignin('base','M',M);
    
eval(['MSSN' num2str(i) '= MissionBuild(M.phaselist,M.startuparr,M.taxiarr,M.takeoffarr,M.climbarr,M.cruisearr, M.descentarr,M.loiterarr,M.approacharr,M.landingarr,M.shutdownarr,M.genstrct)']);
MSSN_str=horzcat('MSSN',num2str(L));

assignin('base',MSSN_str,eval(['MSSN' num2str(i)]));

guidata(hObject, handles);
end
end


% --- Executes on button press in BuildBatch.
function BuildBatch_Callback(hObject, eventdata, handles)
% hObject    handle to BuildBatch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[BatchFile] = uiputfile('Batch1.mat','Save Batch name');
N = str2double(get(handles.NumMSSN, 'string'));
if isnan(N)==1
    warndlg('That is not a number')
else
Batch = cell(N,1);
B=1;
for i = 1:N
    A = uigetfile('*.mat','Select the input file');
    C=horzcat('MSSN',num2str(i));
    if strcmp(num2str(A),'0') == 1
        B=0;
        break
    end
    Batch(i,:) = cellstr(A);
   
end
if B == 1
   %save('Batch','Batch')
end
assignin('base','BatchArray',Batch);
end


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




% --- Executes on button press in SaveBatch.
function SaveBatch_Callback(hObject, eventdata, handles)
% hObject    handle to SaveBatch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Batch=evalin('base','BatchArray');
uisave('Batch','Batch')


% --- Executes on button press in View.
function View_Callback(hObject, eventdata, handles)
% hObject    handle to View (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear handles.MSSN


BatchArray = evalin('base','BatchArray');
N = length(BatchArray);
L=0;
for i = 1:N
   L=L+1; 
   M=load(BatchArray{i});
   M = M.M;
   assignin('base','M',M);
   altindex(hObject,handles)
   assignin('base','M',M);
    
eval(['MSSN' num2str(i) '= MissionBuild(M.phaselist,M.startuparr,M.taxiarr,M.takeoffarr,M.climbarr,M.cruisearr, M.descentarr,M.loiterarr,M.approacharr,M.landingarr,M.shutdownarr,M.genstrct)']);
MSSN_str=horzcat('MSSN',num2str(L));

assignin('base',MSSN_str,eval(['MSSN' num2str(i)]));

guidata(hObject, handles);
end

BatchArray = evalin('base','BatchArray');
N = length(BatchArray);


if get(handles.AltitudeButton,'Value') == 0 && get(handles.MachButton,'Value')==0 && ...
        get(handles.APUButton,'Value') == 0 && get(handles.EnginesButton,'Value')==0 && ...
        get(handles.EngineThrustButton,'Value') == 0 && get(handles.GenButton,'Value')==0 && ...
        get(handles.PackButton,'Value') == 0 && get(handles.LandingGearButton,'Value')==0 && ...
        get(handles.FlapButton,'Value') == 0 && get(handles.NavcomButton,'Value')==0 && ...
        get(handles.AutopilotButton,'Value') == 0 && get(handles.TaxiLightButton,'Value')==0 && ...
        get(handles.LandingLightButton,'Value') == 0 && get(handles.PressureButton,'Value')==0
  warndlg('You must select at least one paramter to View.');
else
    
count=0;

    if get(handles.AltitudeButton,'Value') == 1
        count=count+1;
    end
    if get(handles.MachButton,'Value')==1 
        count=count+1;
    end
    if get(handles.APUButton,'Value') == 1
           count=count+1;
    end
    if get(handles.EnginesButton,'Value')==1
        count=count+1;
    end
       if get(handles.EngineThrustButton,'Value') == 1
           count=count+1;
       end
       if get(handles.GenButton,'Value')==1
           count=count+1;
       end
      if  get(handles.PackButton,'Value') == 1 
          count=count+1;
      end
      if get(handles.LandingGearButton,'Value')==1
          count=count+1;
      end
      if  get(handles.FlapButton,'Value') == 1 
          count=count+1;
      end
      if get(handles.NavcomButton,'Value')==1 
          count=count+1;
      end
        if get(handles.AutopilotButton,'Value') == 1
            count=count+1;
        end
        if get(handles.TaxiLightButton,'Value')==1
            count=count+1;
        end
       if get(handles.LandingLightButton,'Value') == 1
           count=count+1;
       end
       if get(handles.PressureButton,'Value')==1
           count=count+1;
       end

 
GTool.setTheme ('blue') ;
g=GTabContainer(figure(1),'top'); 


for i = 1:N
tab=0;  
eval(['MSSN=MSSN' num2str(i)])



g.addTab(BatchArray{i});
h=GAccordion (g.getComponentAt(i));

if i>1
% axes('Parent',h.getComponentAt(i));
end

if  get(handles.AltitudeButton,'Value')==1
   tab=tab+1;

h.addTab('Altitude');
figure(1)
axes('Parent',h.getComponentAt(tab));
plot(MSSN.cond.time,MSSN.cond.alt)
axis([0,MSSN.cond.time(end),0,1.1*max(MSSN.cond.alt)])
ylabel('Feet')
xlabel('Time (Sec)')
title('Altitude')
end

if get(handles.MachButton,'Value')==1
    tab=tab+1;
h.addTab('Mach');
axes('Parent',h.getComponentAt(tab));
plot(MSSN.cond.time,MSSN.cond.mach)
axis([0,MSSN.cond.time(end),0,1.1*max(MSSN.cond.mach)])
title('Mach')
xlabel('Time (Sec)')
end

if get(handles.APUButton,'Value')==1
    tab=tab+1;
h.addTab('APU');
axes('Parent',h.getComponentAt(tab));
plot(MSSN.eng.time,MSSN.eng.apu)
axis([0,MSSN.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('APU')
end

if get(handles.EnginesButton,'Value')==1
     tab=tab+1;
 h.addTab('Engine Status');
axes('Parent',h.getComponentAt(tab));
if isfield(MSSN1.eng,'Eng3')==0;
plot(MSSN.eng.time,MSSN.eng.Eng1)
hold on
plot(MSSN.eng.time,MSSN.eng.Eng2)
elseif isfield(MSSN1.eng,'Eng3')==1;
 plot(MSSN.eng.time,MSSN.eng.Eng1)
hold on
plot(MSSN.eng.time,MSSN.eng.Eng2)
hold on
plot(MSSN.eng.time,MSSN.eng.Eng3)
hold on
plot(MSSN.eng.time,MSSN.eng.Eng4)
end
axis([0,MSSN.eng.time(end),0,1.1])
xlabel('Time (Sec)')
end

if get(handles.EngineThrustButton,'Value')==1
     tab=tab+1;
h.addTab('Engine Thrust');
axes('Parent',h.getComponentAt(tab));
if isfield(MSSN.eng,'Eng3')==0;
plot(MSSN.eng.time,MSSN.eng.EngThrust1)
hold on
plot(MSSN.eng.time,MSSN.eng.EngThrust2)
elseif isfield(MSSN1.eng,'Eng3')==1;
 plot(MSSN.eng.time,MSSN.eng.EngThrust1)
hold on
plot(MSSN.eng.time,MSSN.eng.EngThrust2)
hold on
plot(MSSN.eng.time,MSSN.eng.EngThrust3)
hold on
plot(MSSN.eng.time,MSSN.eng.EngThrust4)
end
axis([0,MSSN.eng.time(end),0,1.1*max(MSSN.eng.EngThrust1)])
xlabel('Time (Sec)')
ylabel('Thrust kN')
title('Engine Thrust')
end

if get(handles.GenButton,'Value')==1
     tab=tab+1;
h.addTab('Generators');
axes('Parent',h.getComponentAt(tab));
if isfield(MSSN1.eng,'Gen5')==0;
plot(MSSN.eng.time,MSSN.eng.Gen1)
hold on
plot(MSSN.eng.time,MSSN.eng.Gen2)
hold on
plot(MSSN.eng.time,MSSN.eng.Gen3)
hold on
plot(MSSN.eng.time,MSSN.eng.Gen4)
elseif isfield(MSSN.eng,'Gen5')==1;
plot(MSSN.eng.time,MSSN.eng.Gen1)
hold on
plot(MSSN.eng.time,MSSN.eng.Gen2)
hold on
plot(MSSN.eng.time,MSSN.eng.Gen3)
hold on
plot(MSSN.eng.time,MSSN.eng.Gen4)
hold on
plot(MSSN.eng.time,MSSN.eng.Gen5)
hold on
plot(MSSN.eng.time,MSSN.eng.Gen6)
hold on
plot(MSSN.eng.time,MSSN.eng.Gen7)
hold on
plot(MSSN.eng.time,MSSN.eng.Gen8)
end
axis([0,MSSN.eng.time(end),0,1.1])
xlabel('Time (Sec)')
title('Generator Status')
end

if tab == 6 && count >= 7 && i==1 
    g2=GTabContainer(figure(2),'top');
end
if tab == 6 && count >= 7
    tab=0; 

g2.addTab(BatchArray{i});
h2=GAccordion (g2.getComponentAt(i));
end


if get(handles.PackButton,'Value')==1
    tab=tab+1;
    if count < 7
h.addTab('Pack');
axes('Parent',h.getComponentAt(tab));
plot(MSSN.eng.time,MSSN.eng.pack)
axis([0,MSSN.eng.time(end),0,1.1])
title('Pack')
xlabel('Time (Sec)')

    elseif count > 6
figure(2)        
h2.addTab('Pack')
axes('Parent',h2.getComponentAt(tab));
plot(MSSN.eng.time,MSSN.eng.pack)
axis([0,MSSN.eng.time(end),0,1.1])
title('Pack')
xlabel('Time (Sec)')
    
    end
end

if get(handles.LandingGearButton,'Value')==1
    tab=tab+1;
    if count <7
h.addTab('Landing Gear');
axes('Parent',h.getComponentAt(tab));
plot(MSSN.hyd.time,MSSN.hyd.lndgr)
axis([0,MSSN.hyd.time(end),0,1.1])
title('Landing Gear')
xlabel('Time (Sec)')
    elseif count >6
      figure(2)     
        h2.addTab('Landing Gear');
axes('Parent',h2.getComponentAt(tab));
plot(MSSN.hyd.time,MSSN.hyd.lndgr)
axis([0,MSSN.hyd.time(end),0,1.1])
title('Landing Gear')
xlabel('Time (Sec)')
    end
end

if get(handles.FlapButton,'Value')==1
    tab=tab+1;
    if count <7
h.addTab('Flaps');
axes('Parent',h.getComponentAt(tab));
plot(MSSN.el.time,MSSN.el.flaps)
axis([0,MSSN.el.time(end),0,1.1*max(MSSN.el.flaps)])
title('Flaps')
xlabel('Time (Sec)')
ylabel('Angle [Deg]')
    elseif count >6
        figure(2)   
        h2.addTab('Flaps');
axes('Parent',h2.getComponentAt(tab));
plot(MSSN.el.time,MSSN.el.flaps)
axis([0,MSSN.el.time(end),0,1.1*max(MSSN.el.flaps)])
title('Flaps')
xlabel('Time (Sec)')
ylabel('Angle [Deg]')
    end
end

if get(handles.NavcomButton,'Value')==1
    tab=tab+1;
    if count <7
h.addTab('NavCom');
axes('Parent',h.getComponentAt(tab));
plot(MSSN.el.time,MSSN.el.navcom)
axis([0,MSSN.el.time(end),0,1.1])
title('NavCom')
xlabel('Time (Sec)')
    elseif count >6
        figure(2)   
        h2.addTab('NavCom');
axes('Parent',h2.getComponentAt(tab));
plot(MSSN.el.time,MSSN.el.navcom)
axis([0,MSSN.el.time(end),0,1.1])
title('NavCom')
xlabel('Time (Sec)')
    end
end

if get(handles.AutopilotButton,'Value')==1
    tab=tab+1;
    if count < 7
h.addTab('AutoPilot');
axes('Parent',h.getComponentAt(tab));
plot(MSSN.el.time,MSSN.el.autop)
axis([0,MSSN.el.time(end),0,1.1])
title('Autopilot')
xlabel('Time (Sec)')
    elseif count>6
        figure(2)   
        h2.addTab('AutoPilot');
axes('Parent',h2.getComponentAt(tab));
plot(MSSN.el.time,MSSN.el.autop)
axis([0,MSSN.el.time(end),0,1.1])
title('Autopilot')
xlabel('Time (Sec)')
    end
end

if get(handles.TaxiLightButton,'Value')==1
    tab=tab+1;
    if count <7
h.addTab('Taxi Light');
axes('Parent',h.getComponentAt(tab));
plot(MSSN.el.time,MSSN.el.taxilit)
axis([0,MSSN.el.time(end),0,1.1])
title('Taxi Light')
xlabel('Time (Sec)')
    elseif count>6
        figure(2)   
        h2.addTab('Taxi Light');
axes('Parent',h2.getComponentAt(tab));
plot(MSSN.el.time,MSSN.el.taxilit)
axis([0,MSSN.el.time(end),0,1.1])
title('Taxi Light')
xlabel('Time (Sec)')
    end
end
if tab == 6 && count >=13 && i==1 
    g3=GTabContainer(figure(3),'top');
end
if tab == 6 && count >= 13
    tab=0; 
g3.addTab(BatchArray{i});
h3=GAccordion (g3.getComponentAt(i));
end

if get(handles.LandingLightButton,'Value')==1
    tab=tab+1;
    if count <7
h.addTab('Landing Light');
axes('Parent',h.getComponentAt(tab));
plot(MSSN.el.time,MSSN.el.landinglit)
axis([0,MSSN.el.time(end),0,1.1])
title('Landing Light')
xlabel('Time (Sec)')
    elseif count>6 && count < 13
        figure(2)   
        h2.addTab('Landing Light');
axes('Parent',h2.getComponentAt(tab));
plot(MSSN.el.time,MSSN.el.landinglit)
axis([0,MSSN.el.time(end),0,1.1])
title('Landing Light')
xlabel('Time (Sec)')
    elseif count > 12
         h3.addTab('Landing Light');
         figure(3)   
axes('Parent',h3.getComponentAt(tab));
plot(MSSN.el.time,MSSN.el.landinglit)
axis([0,MSSN.el.time(end),0,1.1])
title('Landing Light')
xlabel('Time (Sec)')
        
    end
end

if get(handles.PressureButton,'Value')==1
    tab=tab+1;
    if count <7
h.addTab('Pressure');
axes('Parent',h.getComponentAt(tab));
plot(MSSN1.pnu.time,MSSN1.pnu.pres)
axis([0,MSSN1.pnu.time(end),0,1.1])
title('Pressure')
xlabel('Time (Sec)')
    elseif count>6 && count < 13
        figure(2)   
        h2.addTab('Pressure');
axes('Parent',h2.getComponentAt(tab));
plot(MSSN1.pnu.time,MSSN1.pnu.pres)
axis([0,MSSN1.pnu.time(end),0,1.1])
title('Pressure')
xlabel('Time (Sec)')
    elseif count>12
        figure(3)   
          h3.addTab('Pressure');
axes('Parent',h3.getComponentAt(tab));
plot(MSSN1.pnu.time,MSSN1.pnu.pres)
axis([0,MSSN1.pnu.time(end),0,1.1])
title('Pressure')
xlabel('Time (Sec)')
    end

end
end
end


% --- Executes on button press in AltitudeButton.
function AltitudeButton_Callback(hObject, eventdata, handles)
% hObject    handle to AltitudeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AltitudeButton


% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiopen('load');



% --- Executes on button press in MachButton.
function MachButton_Callback(hObject, eventdata, handles)
% hObject    handle to MachButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MachButton


% --- Executes on button press in EngineThrustButton.
function EngineThrustButton_Callback(hObject, eventdata, handles)
% hObject    handle to EngineThrustButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of EngineThrustButton



% --- Executes on button press in APUButton.
function APUButton_Callback(hObject, eventdata, handles)
% hObject    handle to APUButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of APUButton


% --- Executes on button press in EnginesButton.
function EnginesButton_Callback(hObject, eventdata, handles)
% hObject    handle to EnginesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of EnginesButton


% --- Executes on button press in PackButton.
function PackButton_Callback(hObject, eventdata, handles)
% hObject    handle to PackButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PackButton


% --- Executes on button press in LandingGearButton.
function LandingGearButton_Callback(hObject, eventdata, handles)
% hObject    handle to LandingGearButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LandingGearButton



% --- Executes on button press in NavcomButton.
function NavcomButton_Callback(hObject, eventdata, handles)
% hObject    handle to NavcomButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NavcomButton


% --- Executes on button press in AutopilotButton.
function AutopilotButton_Callback(hObject, eventdata, handles)
% hObject    handle to AutopilotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AutopilotButton


% --- Executes on button press in TaxiLightButton.
function TaxiLightButton_Callback(hObject, eventdata, handles)
% hObject    handle to TaxiLightButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TaxiLightButton


% --- Executes on button press in LandingLightButton.
function LandingLightButton_Callback(hObject, eventdata, handles)
% hObject    handle to LandingLightButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LandingLightButton


% --- Executes on button press in PressureButton.
function PressureButton_Callback(hObject, eventdata, handles)
% hObject    handle to PressureButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PressureButton



% --- Executes on button press in GenButton.
function GenButton_Callback(hObject, eventdata, handles)
% hObject    handle to GenButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GenButton


% --- Executes on button press in FlapButton.
function FlapButton_Callback(hObject, eventdata, handles)
% hObject    handle to FlapButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FlapButton


% --- Executes on button press in SelectAll.
function SelectAll_Callback(hObject, eventdata, handles)
% hObject    handle to SelectAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.SelectAll,'Value')==1
 set(handles.AltitudeButton,'Value',1)
 set(handles.MachButton,'Value',1)
 set(handles.APUButton,'Value',1)
 set(handles.EnginesButton,'Value',1)
 set(handles.EngineThrustButton,'Value',1) 
 set(handles.GenButton,'Value',1)
 set(handles.PackButton,'Value',1)  
 set(handles.LandingGearButton,'Value',1)
 set(handles.FlapButton,'Value',1) 
 set(handles.NavcomButton,'Value',1)
 set(handles.AutopilotButton,'Value',1)
 set(handles.TaxiLightButton,'Value',1)
 set(handles.LandingLightButton,'Value',1) 
 set(handles.PressureButton,'Value',1)
elseif get(handles.SelectAll,'Value')==0
 set(handles.AltitudeButton,'Value',0)
 set(handles.MachButton,'Value',0)
 set(handles.APUButton,'Value',0)
 set(handles.EnginesButton,'Value',0)
 set(handles.EngineThrustButton,'Value',0) 
 set(handles.GenButton,'Value',0)
 set(handles.PackButton,'Value',0)  
 set(handles.LandingGearButton,'Value',0)
 set(handles.FlapButton,'Value',0) 
 set(handles.NavcomButton,'Value',0)
 set(handles.AutopilotButton,'Value',0)
 set(handles.TaxiLightButton,'Value',0)
 set(handles.LandingLightButton,'Value',0) 
 set(handles.PressureButton,'Value',0)
end
% Hint: get(hObject,'Value') returns toggle state of SelectAll
