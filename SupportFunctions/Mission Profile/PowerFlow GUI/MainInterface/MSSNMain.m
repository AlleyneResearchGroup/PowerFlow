function varargout = MSSNMain(varargin)
% MSSNMAIN MATLAB code for MSSNMain.fig
%      MSSNMAIN, by itself, creates a new MSSNMAIN or raises the existing
%      singleton*.
%
%      H = MSSNMAIN returns the handle to a new MSSNMAIN or the handle to
%      the existing singleton*.
%
%      MSSNMAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MSSNMAIN.M with the given input arguments.
%
%      MSSNMAIN('Property','Value',...) creates a new MSSNMAIN or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MSSNMain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MSSNMain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MSSNMain

% Last Modified by GUIDE v2.5 26-Feb-2015 19:00:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MSSNMain_OpeningFcn, ...
                   'gui_OutputFcn',  @MSSNMain_OutputFcn, ...
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

% --- Executes just before MSSNMain is made visible.
function MSSNMain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MSSNMain (see VARARGIN)

% Choose default command line output for MSSNMain
%intialization for the gui

handles.output = hObject;

M = load('Defaults.mat');
assignin('base','M',M)
evalin('base','load(''Defaults.mat'')');
handles.M = M.M;
handles.index.build = 0;
evalin('base','');
% Update handles structure
guidata(hObject, handles);
% Rolls Royce logo
logo=axes('Tag','logo','Position',[0.008 0.86 0.16 0.1]);
imshow('Rolls-royce-logo-png.png');
initialize_gui(hObject, handles, false);


% UIWAIT makes MSSNMain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MSSNMain_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Build.
function Build_Callback(hObject, eventdata, handles)
% hObject    handle to Build (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear handles.MSSN
phaselist = cellstr(get(handles.MSSNList,'String'));
if strcmp(phaselist(1),'') == 1
    warndlg('You must load a mission.','Warning');
else
altindex(hObject,handles)
M = handles.M;
handles.MSSN = MissionBuild(phaselist,M.startuparr,M.taxiarr,M.takeoffarr,M.climbarr,M.cruisearr,...
    M.descentarr,M.loiterarr,M.approacharr,M.landingarr,M.shutdownarr,M.genstrct);
handles.MSSN.gen.N_ENG = M.genstrct.eng.num;
handles.MSSN.gen.N_GEN = M.genstrct.eng.num*2;

handles.index.build = 1;
handles.MSSN.gen.faults=[0,0,0,0,0];
startup_check=size(handles.M.startuparr);
taxi_check=size(handles.M.taxiarr);
takeoff_check=size(handles.M.takeoffarr);
climb_check=size(handles.M.climbarr);
cruise_check=size(handles.M.cruisearr);
descent_check=size(handles.M.descentarr);
loiter_check=size(handles.M.loiterarr);
approach_check=size(handles.M.approacharr);
landing_check=size(handles.M.landingarr);
shutdown_check=size(handles.M.shutdownarr);

% Checks if the user has input values for the phases
for i=1:startup_check(1)
    for j=1:startup_check(2)
    startup_indic=isnan(handles.M.startuparr(i,j));
        if startup_indic==1
          warndlg('You must define mission at startup.','Warning!') 
      return;
        end
    end
end
for i=1:taxi_check(1)
    for j=1:taxi_check(2)
        taxi_indic=isnan(handles.M.taxiarr(i,j));
            if taxi_indic==1
      warndlg('You must define mission at taxi.','Warning!')
      return;
            end
    end
end
for i=1:takeoff_check(1)
    for j=1:takeoff_check(2)
    takeoff_indic=isnan(handles.M.takeoffarr(i,j));
        if takeoff_indic==1
      warndlg('You must define mission at takeoff.','Warning!')
      return;
        end
    end
end
for i=1:climb_check(1)
    for j=1:climb_check(2)
    climb_indic=isnan(handles.M.climbarr(i,j));
         if climb_indic==1 
        warndlg('You must define mission during climb.', 'Warning!')
        return;
       
        end
    end
end
for i=1:cruise_check(1)
    for j=1:cruise_check(2)
        cruise_indic=isnan(handles.M.cruisearr(i,j));
            if cruise_indic==1
      warndlg('You must define mission at cruise.','Warning!')
      return;
            end
  
    end
end
for i=1:descent_check(1)
    for j=1:descent_check(2)
    descent_indic=isnan(handles.M.descentarr(i,j));
        if descent_indic==1
      warndlg('You must define mission at descent.','Warning!')
      return;
        end
    
    end
end
for i=1:loiter_check(1)
    for j=1:loiter_check(2)
        loiter_indic=isnan(handles.M.loiterarr(i,j));
            if loiter_indic==1
      warndlg('You must define mission at loiter.','Warning!')
      return;
            end
    end
end
for i=1:approach_check(1)
    for j=1:approach_check(2)
        approach_indic=isnan(handles.M.approacharr(i,j));
            if approach_indic==1
      warndlg('You must define mission at approach.','Warning!')
      return;
            end
    end
end
for i=1:landing_check(1)
    for j=1:landing_check(2)
    landing_indic=isnan(handles.M.landingarr(i,j));
        if landing_indic==1
      warndlg('You must define mission at landing.','Warning!')
      return;
        end
    end
end
for i=1:shutdown_check(1)
    for j=1:shutdown_check(2)
        shutdown_indic=isnan(handles.M.shutdownarr(i,j));
            if shutdown_indic==1
      warndlg('You must define mission at shutdown.','Warning!')
      return;
            end
    end
end
for i=1:length(handles.M.genstrct.alt.values)
    alt_indic=isnan(handles.M.genstrct.alt.values(i));
        if alt_indic==1
      warndlg('You must define the altitudes.','Warning!')
      return;
        end

end
    
%Resets the mission plot with the given input values
guidata(hObject,handles)
cla(handles.MSSNPLT,'reset')
ind = get(handles.GraphSelect,'value');
plotfcn(ind,handles)
assignin('base', 'MSSN', handles.MSSN)
a=get(handles.MSSNList,'String');
c = relist(a);
set(handles.GraphSelect2,'String',c)


[handles.MSSN ] = MonotonicFix(handles.MSSN);
assignin('base', 'MSSN', handles.MSSN)
end


% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Closes the GUI
a = get(handles.Definelist,'string');
val = get(handles.Definelist,'Value');
empty = isempty(a);

if empty == 1   
initialize_gui(gcbf, handles, true);
close all
elseif empty==0
Savebuild
end
% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the Cancel flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to Cancel the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end

guidata(handles.figure1, handles);


% --- Executes on selection change in Definelist.
function Definelist_Callback(hObject, eventdata, handles)
% hObject    handle to Definelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Definelist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Definelist
varoptalloff(handles)
a = get(handles.Definelist,'string');
val = get(handles.Definelist,'Value');
list = a(val);
%Varopt changes which define boxes and shown
varopt(handles,list,val,'on');

altindex(hObject,handles);
%Defiens the text in the boxes given the situation.
definestatestext(hObject, handles);




% --- Executes during object creation, after setting all properties.
function Definelist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Definelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in MSSNList.
function MSSNList_Callback(hObject, eventdata, handles)
% hObject    handle to MSSNList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns MSSNList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MSSNList


% --- Executes during object creation, after setting all properties.
function MSSNList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MSSNList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Standard.
function Standard_Callback(hObject, eventdata, handles)
% hObject    handle to Standard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Loads a standard mission
load('Input.mat')
handles.M = M;
set(handles.MSSNList,'String',M.phaselist)
c = relist(M.phaselist);
set(handles.Definelist,'String',c)
altindex(hObject,handles)




% --- Executes on button press in InputSave.
function InputSave_Callback(hObject, eventdata, handles)
% hObject    handle to InputSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
M = handles.M;
M.phaselist = get(handles.MSSNList,'String');
uisave('M','Input1')


% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Loads a selected mission
uiopen('load');
handles.M = M;
set(handles.MSSNList,'String',M.phaselist)
c = relist(M.phaselist);
set(handles.Definelist,'String',c)
altindex(hObject,handles)
set(handles.GraphSelect2,'String',c)



% --- Executes on button press in Addleg.
function Addleg_Callback(hObject, eventdata, handles)
% hObject    handle to Addleg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in DefineCancel.
function DefineCancel_Callback(hObject, eventdata, handles)
% hObject    handle to DefineCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancels define button
a = get(handles.Definelist,'string');
val = get(handles.Definelist,'Value');
list = a(val);
varopt(handles,list,val,'off');
guidata(hObject,handles)


% --- Executes on button press in Defineexec.
function Defineexec_Callback(hObject, eventdata, handles)
% hObject    handle to Defineexec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

definestates(hObject,handles)  
a = get(handles.Definelist,'string');
val = get(handles.Definelist,'Value');
list = a(val);
varopt(handles,list,val,'off');

% This determines the text within the boxes
if numel(get(handles.MSSNList,'string'))>val
    new_list=a(val+1);
    set(handles.Definelist,'value',val+1);
    varopt(handles,new_list,val+1,'on');
    set(handles.Time,'string','Time');
    set(handles.ThrustSet,'string','Thrust');
    set(handles.Alt,'string','Altitude');
    set(handles.ClimbRate,'string','Rate');
    set(handles.DescentRate,'string','Rate');
    set(handles.FlapSet,'string','Flap Angle');
    set(handles.FlapSet2,'string','Flap Angle');
end

% --- Executes on button press in BuildSave.
function BuildSave_Callback(hObject, eventdata, handles)
% hObject    handle to BuildSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.index.build == 1
    MSSN = handles.MSSN;
    uisave('MSSN','Output1')
    guidata(hObject,handles)
else
    errordlg('Build a Mission Before Saving','Data Error');
end




% --- Executes on selection change in PhaseList.
function PhaseList_Callback(hObject, eventdata, handles)
% hObject    handle to PhaseList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PhaseList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PhaseList


% --- Executes during object creation, after setting all properties.
function PhaseList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PhaseList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addphase.
function addphase_Callback(hObject, eventdata, handles)
% hObject    handle to addphase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get current value of FlightPhaseMenu
%Reorganizes the string in the mission phase listbox
contents = cellstr(get(handles.PhaseList,'String'));
val = contents{get(handles.PhaseList,'Value')};

C = get(handles.PhaseList,{'string','value'});
C = C{1}(C{2});
contents2 = cellstr(get(handles.MSSNList,'String'));
if strcmp(contents2(1),'') == 1
    curr_str = [contents2(2:end);C];
    else
    curr_str = [contents2;C];
end

set(handles.MSSNList,'String',curr_str);
c = relist(curr_str);
set(handles.Definelist,'String',curr_str)
b = size(curr_str);
set(handles.MSSNList,'value', b(1))
guidata(hObject,handles)


% --- Executes on button press in removephase.
function removephase_Callback(hObject, eventdata, handles)
% hObject    handle to removephase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Removes a phase from the mission phase listbox
a = get(handles.MSSNList,'string');
temp = char(a);
index = get(handles.MSSNList,'Value');
temp(index,:) = [];
set(handles.MSSNList,'value', (index-1==0)+index-1)
set(handles.MSSNList,'string',cellstr(temp))
c = relist(cellstr(temp));
set(handles.Definelist,'String',c)
index = get(handles.Definelist,'Value');
set(handles.Definelist,'value', (index-1==0)+index-1)


% --- Executes on button press in moveup.
function moveup_Callback(hObject, eventdata, handles)
% hObject    handle to moveup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(handles.MSSNList,'string');
b = get(handles.MSSNList,'Value');
a([b (b-1==0)+b-1]) = a([(b-1==0)+b-1 b]);
set(handles.MSSNList,'value', (b-1==0)+b-1)
set(handles.MSSNList,'string',cellstr(a))
c = relist(a);
set(handles.Definelist,'String',c)


% --- Executes on button press in movedown.
function movedown_Callback(hObject, eventdata, handles)
% hObject    handle to movedown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(handles.MSSNList,'string');
b = get(handles.MSSNList,'Value');
a([b b+1]) = a([b+1 b]);
set(handles.MSSNList,'value', b+1)
set(handles.MSSNList,'string',cellstr(a))
c = relist(a);
set(handles.Definelist,'String',c)


function Time_Callback(hObject, eventdata, handles)
% hObject    handle to Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time as text
%        str2double(get(hObject,'String')) returns contents of Time as a double

% --- Executes during object creation, after setting all properties.
function Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ThrustSet_Callback(hObject, eventdata, handles)
% hObject    handle to ThrustSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ThrustSet as text
%        str2double(get(hObject,'String')) returns contents of ThrustSet as a double

% --- Executes during object creation, after setting all properties.
function ThrustSet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ThrustSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in GroundPower.
function GroundPower_Callback(hObject, eventdata, handles)
% hObject    handle to GroundPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of GroundPower

% --- Executes on selection change in TaxiEng.
function TaxiEng_Callback(hObject, eventdata, handles)
% hObject    handle to TaxiEng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns TaxiEng contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TaxiEng

% --- Executes during object creation, after setting all properties.
function TaxiEng_CreateFcn(hObject, eventdata, ~)
% hObject    handle to TaxiEng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FlapSet_Callback(hObject, eventdata, handles)
% hObject    handle to FlapSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of FlapSet as text
%        str2double(get(hObject,'String')) returns contents of FlapSet as a double

% --- Executes during object creation, after setting all properties.
function FlapSet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FlapSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ClimbRate_Callback(hObject, eventdata, handles)
% hObject    handle to ClimbRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of ClimbRate as text
%        str2double(get(hObject,'String')) returns contents of ClimbRate as a double

% --- Executes during object creation, after setting all properties.
function ClimbRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ClimbRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function DescentRate_Callback(hObject, eventdata, handles)
% hObject    handle to DescentRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of DescentRate as text
%        str2double(get(hObject,'String')) returns contents of DescentRate as a double

% --- Executes during object creation, after setting all properties.
function DescentRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DescentRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FlapSet2_Callback(hObject, eventdata, handles)
% hObject    handle to FlapSet2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of FlapSet2 as text
%        str2double(get(hObject,'String')) returns contents of FlapSet2 as a double

% --- Executes during object creation, after setting all properties.
function FlapSet2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FlapSet2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Alt_Callback(hObject, eventdata, handles)
% hObject    handle to Alt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Alt as text
%        str2double(get(hObject,'String')) returns contents of Alt as a double

% --- Executes during object creation, after setting all properties.
function Alt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Alt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in Fault.
function Fault_Callback(hObject, eventdata, handles)
% hObject    handle to Fault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.index.build == 1
    h = FaultGui;
    waitfor(h);
    handles.MSSN = evalin('base','MSSN');
    %disp('Fin')
   
else
    errordlg('Build a Mission Before Inserting Faults','Data Error');
end
guidata(hObject,handles)

% --- Executes on selection change in GraphSelect.
function GraphSelect_Callback(hObject, eventdata, handles)
% hObject    handle to GraphSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.MSSNPLT,'reset')
ind = get(handles.GraphSelect,'value');
plotfcn(ind,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns GraphSelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from GraphSelect


% --- Executes during object creation, after setting all properties.
function GraphSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GraphSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Batch.
function Batch_Callback(hObject, eventdata, handles)
% hObject    handle to Batch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Doesnt do anything currently but can in the future to run multiple mission
%at a time
BatchGUI



function Neng_Callback(hObject, eventdata, handles)
% hObject    handle to Neng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.M.genstrct.eng.num = str2double(get(handles.Neng,'string'));
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of Neng as text
%        str2double(get(hObject,'String')) returns contents of Neng as a double


% --- Executes during object creation, after setting all properties.
function Neng_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Neng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varoptalloff(handles)
% this function sets all variable options for defining a mission to be
% invisible so that the space is blank
on_off = 'off';
set(handles.Thrusttxt,'Visible',on_off)
set(handles.ThrustSet,'Visible',on_off)
set(handles.percent,'Visible',on_off)
set(handles.Descenttxt,'Visible',on_off)
set(handles.DescentRate,'Visible',on_off)
set(handles.ftmin2,'Visible',on_off)
set(handles.Alttxt,'Visible',on_off)
set(handles.Alt,'Visible',on_off)
set(handles.fttxt,'Visible',on_off)
set(handles.FlapSettxt1,'Visible',on_off)
set(handles.FlapSet,'Visible',on_off)
set(handles.degtxt,'Visible',on_off)
set(handles.FlapSettxt2,'Visible',on_off)
set(handles.FlapSet2,'Visible',on_off)
set(handles.degtxt2,'Visible',on_off)
set(handles.Climbtxt,'Visible',on_off)
set(handles.ClimbRate,'Visible',on_off)
set(handles.ftmin1,'Visible',on_off)
set(handles.GroundPower,'Visible',on_off)
set(handles.Timetxt,'Visible',on_off)
set(handles.Time,'Visible',on_off)
set(handles.Minutes,'Visible',on_off)
set(handles.Sec,'Visible',on_off)
set(handles.TaxiEng,'Visible',on_off)


function varopt(handles,list,val,on_off)
% This function set visiblities on or off, depending on input, for certain
% varibale options based on what the define list value is (depending on
% which mission leg)
M = handles.M;
if val == 1
    set(handles.Alttxt,'Visible',on_off)
    set(handles.Alt,'Visible',on_off)
    set(handles.fttxt,'Visible',on_off)
end
if strncmp(list,'Startup',3) == 1  %Varible options for startup... etc
    set(handles.Timetxt,'Visible',on_off)
    set(handles.Time,'Visible',on_off)
    set(handles.Minutes,'Visible',on_off)
    set(handles.Alttxt,'Visible',on_off)
    set(handles.Alt,'Visible',on_off)
    set(handles.fttxt,'Visible',on_off)
    set(handles.GroundPower,'Visible',on_off)
elseif strncmp(list,'Taxi',3) == 1
    set(handles.Thrusttxt,'Visible',on_off)
    set(handles.ThrustSet,'Visible',on_off)
    set(handles.percent,'Visible',on_off)
    set(handles.TaxiEng,'Visible',on_off)
    set(handles.Timetxt,'Visible',on_off)
    set(handles.Time,'Visible',on_off)
    set(handles.Minutes,'Visible',on_off)
elseif strncmp(list,'Takeoff',3) == 1
    set(handles.Thrusttxt,'Visible',on_off)
    set(handles.ThrustSet,'Visible',on_off)
    set(handles.percent,'Visible',on_off)
    set(handles.Timetxt,'Visible',on_off)
    set(handles.Time,'Visible',on_off)
    set(handles.Sec,'Visible',on_off)
    set(handles.FlapSettxt1,'Visible',on_off)
    set(handles.FlapSet,'Visible',on_off)
    set(handles.degtxt,'Visible',on_off)
elseif strncmp(list,'Climb',3) == 1
    set(handles.Thrusttxt,'Visible',on_off)
    set(handles.ThrustSet,'Visible',on_off)
    set(handles.percent,'Visible',on_off)
    set(handles.Climbtxt,'Visible',on_off)
    set(handles.ClimbRate,'Visible',on_off)
    set(handles.ftmin1,'Visible',on_off)
    set(handles.Alttxt,'Visible',on_off)
    set(handles.Alt,'Visible',on_off)
    set(handles.fttxt,'Visible',on_off)
elseif strncmp(list,'Cruise',3) == 1
    set(handles.Thrusttxt,'Visible',on_off)
    set(handles.ThrustSet,'Visible',on_off)
    set(handles.percent,'Visible',on_off)
    set(handles.Timetxt,'Visible',on_off)
    set(handles.Time,'Visible',on_off)
    set(handles.Minutes,'Visible',on_off)
elseif strncmp(list,'Descent',3) == 1
    set(handles.Thrusttxt,'Visible',on_off)
    set(handles.ThrustSet,'Visible',on_off)
    set(handles.percent,'Visible',on_off)
    set(handles.Descenttxt,'Visible',on_off)
    set(handles.DescentRate,'Visible',on_off)
    set(handles.ftmin2,'Visible',on_off)
    set(handles.Alttxt,'Visible',on_off)
    set(handles.Alt,'Visible',on_off)
    set(handles.fttxt,'Visible',on_off)
elseif strncmp(list,'Loiter',3) == 1
    set(handles.Thrusttxt,'Visible',on_off)
    set(handles.ThrustSet,'Visible',on_off)
    set(handles.percent,'Visible',on_off)
    set(handles.Timetxt,'Visible',on_off)
    set(handles.Time,'Visible',on_off)
    set(handles.Minutes,'Visible',on_off)
elseif strncmp(list,'Approach',3) == 1
    set(handles.Thrusttxt,'Visible',on_off)
    set(handles.ThrustSet,'Visible',on_off)
    set(handles.percent,'Visible',on_off)
    set(handles.Descenttxt,'Visible',on_off)
    set(handles.DescentRate,'Visible',on_off)
    set(handles.ftmin2,'Visible',on_off)
    set(handles.Alttxt,'Visible',on_off)
    set(handles.Alt,'Visible',on_off)
    set(handles.fttxt,'Visible',on_off)
    set(handles.FlapSettxt1,'Visible',on_off)
    set(handles.FlapSet,'Visible',on_off)
    set(handles.degtxt,'Visible',on_off)
    set(handles.FlapSettxt2,'Visible',on_off)
    set(handles.FlapSet2,'Visible',on_off)
    set(handles.degtxt2,'Visible',on_off)
elseif strncmp(list,'Landing',3) == 1
    set(handles.Thrusttxt,'Visible',on_off)
    set(handles.ThrustSet,'Visible',on_off)
    set(handles.percent,'Visible',on_off)
    set(handles.FlapSettxt1,'Visible',on_off)
    set(handles.FlapSet,'Visible',on_off)
    set(handles.degtxt,'Visible',on_off)
elseif strncmp(list,'Shutdown',3) == 1
    set(handles.Timetxt,'Visible',on_off)
    set(handles.Time,'Visible',on_off)
    set(handles.Minutes,'Visible',on_off)
    set(handles.GroundPower,'Visible',on_off)
end

function str = relist(in_str)
% This function relists the mission list into the define list while
% appending integer values to the end of phases that occur more than once
% (i.e. Taxi 1, Taxi 2, Taxi3... etc.)
phaseNo(1) = sum(strncmp(in_str,'Startup',3));
phaseNo(2) = sum(strncmp(in_str,'Taxi',3));
phaseNo(3) = sum(strncmp(in_str,'Takeoff',3));
phaseNo(4) = sum(strncmp(in_str,'Climb',3));
phaseNo(5) = sum(strncmp(in_str,'Cruise',3));
phaseNo(6) = sum(strncmp(in_str,'Descent',3));
phaseNo(7) = sum(strncmp(in_str,'Loiter',3));
phaseNo(8) = sum(strncmp(in_str,'Approach',3));
phaseNo(9) = sum(strncmp(in_str,'Landing',3));
phaseNo(10) = sum(strncmp(in_str,'Shutdown',3));
ind0 = find(phaseNo > 1);
for i = 1:length(ind0)
    switch ind0(i)
        case 1
            ind1 = find(strncmp(in_str,'Startup',3));
            for j = 1:length(ind1)
                in_str{ind1(j)} = ['Startup ' int2str(j)];
            end
        case 2
            ind2 = find(strncmp(in_str,'Taxi',3));
            for j = 1:length(ind2)
                in_str{ind2(j)} = ['Taxi ' int2str(j)];
            end
        case 3
            ind3 = find(strncmp(in_str,'Takeoff',3));
            for j = 1:length(ind3)
                in_str{ind3(j)} = ['Takeoff ' int2str(j)];
            end
        case 4
            ind4 = find(strncmp(in_str,'Climb',3));
            for j = 1:length(ind4)
                in_str{ind4(j)} = ['Climb ' int2str(j)];
            end
        case 5
            ind5 = find(strncmp(in_str,'Cruise',3));
            for j = 1:length(ind5)
                in_str{ind5(j)} = ['Cruise ' int2str(j)];
            end
        case 6
            ind6 = find(strncmp(in_str,'Descent',3));
            for j = 1:length(ind6)
                in_str{ind6(j)} = ['Descent ' int2str(j)];
            end
        case 7
            ind7 = find(strncmp(in_str,'Loiter',3));
            for j = 1:length(ind7)
                in_str{ind7(j)} = ['Loiter ' int2str(j)];
            end
        case 8
            ind8 = find(strncmp(in_str,'Approach',3));
            for j = 1:length(ind8)
                in_str{ind8(j)} = ['Approach ' int2str(j)];
            end
        case 9
            ind9 = find(strncmp(in_str,'Landing',3));
            for j = 1:length(ind9)
                in_str{ind9(j)} = ['Landing ' int2str(j)];
            end
        case 10
            ind10 = find(strncmp(in_str,'Shutdown',3));
            for j = 1:length(ind10)
                in_str{ind10(j)} = ['Shutdown ' int2str(j)];
            end
    end
end
str = in_str;

function definestates(hObject, handles)
% This function is the function allowing for the data entered by the user
% to be saved into the input Variable.  The function reads the type of
% mission phase based on the first three letters and then reads the
% appropriate data from the visible varible options and saves the data to
% the handle.M input structured varible.
a = get(handles.Definelist,'string');
val = get(handles.Definelist,'Value');

empty_check=isempty(a);
if empty_check==1
    warndlg('You must select a mission leg before you can define.','Warning!')
    else
list = a(val);
if val == 1  % Reads the altitude value of the first phase (regardless of phase type)
    ALT = str2double(get(handles.Alt,'string'));
    handles.M.genstrct.alt.values(1) = ALT;
end
if strncmp(list,'Startup',3) == 1
    % In case of multple phases of the same type, the next few lines of
    % code read the last character of the define list entry.  in the case
    % of "startup" that would be a "p".  In the case of "Cruise 2" that
    % would be a "2".  If the vaule is a leter or a "1" the code defines
    % the varible to the first input slot for that particular mission
    % phase.  if the number is a 2 or greater then the code defines the
    % data to the appropriate slot (2,3,4,...etc).
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        handles.M.startuparr(1,1) = 60*str2double(get(handles.Time,'string'));
        handles.M.startuparr(1,2) = get(handles.GroundPower,'value');
        handles.M.startuparr(1,3) = 0;
        
    else
        handles.M.startuparr(ident,1) = 60*str2double(get(handles.Time,'string'));
        handles.M.startuparr(ident,2) = get(handles.GroundPower,'value');
        handles.M.startuparr(ident,3) = 0;
    end

elseif strncmp(list,'Taxi',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        handles.M.taxiarr(1,1) = 60*str2double(get(handles.Time,'string'));
        handles.M.taxiarr(1,2) = get(handles.TaxiEng,'value')-1;
        handles.M.taxiarr(1,3) = str2double(get(handles.ThrustSet,'string'));
    else
        handles.M.taxiarr(ident,1) = 60*str2double(get(handles.Time,'string'));
        handles.M.taxiarr(ident,2) = get(handles.TaxiEng,'value')-1;
        handles.M.taxiarr(ident,3) = str2double(get(handles.ThrustSet,'string'));
    end
elseif strncmp(list,'Takeoff',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        handles.M.takeoffarr(1,1) = str2double(get(handles.Time,'string'));
        handles.M.takeoffarr(1,2) = str2double(get(handles.FlapSet,'string'));
        handles.M.takeoffarr(1,3) = str2double(get(handles.ThrustSet,'string'));
    else
        handles.M.takeoffarr(ident,1) = str2double(get(handles.Time,'string'));
        handles.M.takeoffarr(ident,2) = str2double(get(handles.FlapSet,'string'));
        handles.M.takeoffarr(ident,3) = str2double(get(handles.ThrustSet,'string'));
    end
elseif strncmp(list,'Climb',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        handles.M.climbarr(1,3) = str2double(get(handles.ClimbRate,'string'));
        handles.M.climbarr(1,4) = 1;
        handles.M.climbarr(1,5) = str2double(get(handles.ThrustSet,'string'));
        % In the case of a climb, descent, or approach, the altitude of the
        % aircraft changes and the new altitdue must be recorded.  On
        % Climb, Descent, or Approach phases the following additional line
        % are added
        ALT = str2double(get(handles.Alt,'string'));
        CLI = handles.M.genstrct.alt.ind.CL2_ALT_i(1);
        handles.M.genstrct.alt.values(CLI) = ALT;
    else
        handles.M.climbarr(ident,3) = str2double(get(handles.ClimbRate,'string'));
        handles.M.climbarr(ident,4) = 1;
        handles.M.climbarr(ident,5) = str2double(get(handles.ThrustSet,'string'));
        ALT = str2double(get(handles.Alt,'string'));
        CLI = handles.M.genstrct.alt.ind.CL2_ALT_i(ident);
        handles.M.genstrct.alt.values(CLI) = ALT;
    end
elseif strncmp(list,'Cruise',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        handles.M.cruisearr(1,1) = 60*str2double(get(handles.Time,'string'));
        handles.M.cruisearr(1,2) = str2double(get(handles.ThrustSet,'string'));
    else
        handles.M.cruisearr(ident,1) = 60*str2double(get(handles.Time,'string'));
        handles.M.cruisearr(ident,2) = str2double(get(handles.ThrustSet,'string'));
    end
elseif strncmp(list,'Descent',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        handles.M.descentarr(1,1) = str2double(get(handles.DescentRate,'string'));
        handles.M.descentarr(1,2) = str2double(get(handles.ThrustSet,'string'));
        ALT = str2double(get(handles.Alt,'string'));
        DEI = handles.M.genstrct.alt.ind.DE2_ALT_i(1)
        handles.M.genstrct.alt.values(DEI) = ALT;
    else
        handles.M.descentarr(ident,1) = str2double(get(handles.DescentRate,'string'));
        handles.M.descentarr(ident,2) = str2double(get(handles.ThrustSet,'string'));
        ALT = str2double(get(handles.Alt,'string'));
        DEI = handles.M.genstrct.alt.ind.DE2_ALT_i(ident);
        handles.M.genstrct.alt.values(DEI) = ALT;
    end
elseif strncmp(list,'Loiter',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        handles.M.loiterarr(1,1) = 60*str2double(get(handles.Time,'string'));
        handles.M.loiterarr(1,2) = str2double(get(handles.ThrustSet,'string'));
    else
        handles.M.loiterarr(ident,1) = 60*str2double(get(handles.Time,'string'));
        handles.M.loiterarr(ident,2) = str2double(get(handles.ThrustSet,'string'));
    end
elseif strncmp(list,'Approach',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        handles.M.approacharr(1,1) = str2double(get(handles.DescentRate,'string'));
        handles.M.approacharr(1,2) = str2double(get(handles.FlapSet,'string'));
        handles.M.approacharr(1,3) = str2double(get(handles.FlapSet2,'string'));
        handles.M.approacharr(1,4) = str2double(get(handles.ThrustSet,'string'));
        ALT = str2double(get(handles.Alt,'string'));
        API = handles.M.genstrct.alt.ind.AP2_ALT_i(1);
        handles.M.genstrct.alt.values(API) = ALT;
    else
        handles.M.approacharr(ident,1) = str2double(get(handles.DescentRate,'string'));
        handles.M.approacharr(ident,2) = str2double(get(handles.FlapSet,'string'));
        handles.M.approacharr(ident,3) = str2double(get(handles.FlapSet2,'string'));
        handles.M.approacharr(ident,4) = str2double(get(handles.ThrustSet,'string'));
        ALT = str2double(get(handles.Alt,'string'));
        API = handles.M.genstrct.alt.ind.AP2_ALT_i(ident);
        handles.M.genstrct.alt.values(API) = ALT;
    end
elseif strncmp(list,'Landing',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        handles.M.landingarr(1,1) = str2double(get(handles.FlapSet,'string'));
        handles.M.landingarr(1,2) = str2double(get(handles.ThrustSet,'string'));
    else
        handles.M.landingarr(ident,1) = str2double(get(handles.FlapSet,'string'));
        handles.M.landingarr(ident,2) = str2double(get(handles.ThrustSet,'string'));
    end
elseif strncmp(list,'Shutdown',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        handles.M.shutdownarr(1,1) = 60*str2double(get(handles.Time,'string'));
        handles.M.shutdownarr(1,2) = get(handles.GroundPower,'value');
        handles.M.shutdownarr(1,3) = 0;
    else
        handles.M.shutdownarr(ident,1) = 60*str2double(get(handles.Time,'string'));
        handles.M.shutdownarr(ident,2) = get(handles.GroundPower,'value');
        handles.M.shutdownarr(ident,3) = 0;
    end
end
end
assignin('base', 'M', handles.M)
guidata(hObject,handles)


function altindex(hObject,handles)
% this function indexes the altitudes so that the right altitude is used
% for each phase.  the altitudes or simply kept in a standard array such as
% the following [0, 10000, 35000, 3000, 0].  Each phase must know which
% altitude or altitudes to operate at, hence each gets indices
MSSNlist = cellstr(get(handles.MSSNList,'String'));
M = handles.M;
j = 1;
N_mssnphase = size(MSSNlist);
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

function definestatestext(hObject, handles)
%This function is used to display the current input values of the mission
%in order to making the rebuild process easier. The code finds the
%respective values and displays in on the GUI
a = get(handles.Definelist,'string');
val = get(handles.Definelist,'Value');
list = a(val);
 
if strncmp(list,'Startup',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
 
if real == 0 || nan == 1 || ident == 1
        if handles.index.build==1
        set(handles.Time,'string',num2str(handles.M.startuparr(1,1)/60));
        set(handles.GroundPower,'value',handles.M.startuparr(1,2));
        set(handles.Alt,'string',num2str(handles.M.genstrct.alt.values(1)));
        else
        set(handles.Time,'string','Time');
        set(handles.Alt,'string','Altitude'); 
        set(handles.GroundPower,'value',0)
        end
       
else
        if handles.index.build==1
        set(handles.Time,'string',num2str(handles.M.startuparr(ident,1)/60));
        set(handles.GroundPower,'value',handles.M.startuparr(ident,2));
        else
        set(handles.Time,'string','Time');
        set(handles.Alt,'string','Altitude'); 
        set(handles.GroundPower,'value',0)
        end
    end
    
elseif strncmp(list,'Taxi',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        if handles.index.build==1
        set(handles.Time,'string',num2str(handles.M.taxiarr(1,1)/60));
        set(handles.ThrustSet,'string',num2str(handles.M.taxiarr(1,3)));
        else
        set(handles.Time,'string','Time');
        set(handles.Alt,'string','Altitude'); 
        set(handles.GroundPower,'value',0)
        end
    else
        if handles.index.build==1
        set(handles.Time,'string',num2str(handles.M.taxiarr(ident,1)/60));
        set(handles.ThrustSet,'string',handles.M.taxiarr(ident,3));
        else
        set(handles.Time,'string','Time');
        set(handles.Alt,'string','Altitude'); 
        set(handles.GroundPower,'value',0)
        end
    end
elseif strncmp(list,'Takeoff',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        if handles.index.build==1
        set(handles.Time,'string',num2str(handles.M.takeoffarr(1,1)));
        set(handles.FlapSet,'string',num2str(handles.M.takeoffarr(1,2)));
        set(handles.ThrustSet,'string',num2str(handles.M.takeoffarr(1,3)));
        else
        set(handles.Time,'string','Time');
        set(handles.Alt,'string','Altitude'); 
        set(handles.GroundPower,'value',0)
        end
    else
        if handles.index.build==1
        set(handles.Time,'string',num2str(handles.M.takeoffarr(ident,1)));
        set(handles.FlapSet,'string',num2str(handles.M.takeoffarr(ident,2)));
        set(handles.ThrustSet,'string',num2str(handles.M.takeoffarr(ident,3)));
        else
        set(handles.Time,'string','Time');
        set(handles.Alt,'string','Altitude'); 
        set(handles.GroundPower,'value',0)
        end
        
    end
elseif strncmp(list,'Climb',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        if handles.index.build==1
        set(handles.ClimbRate,'string',num2str(handles.M.climbarr(1,3)));
        set(handles.ThrustSet,'string',num2str(handles.M.climbarr(1,5)));
        % In the case of a climb, descent, or approach, the altitude of the
        % aircraft changes and the new altitdue must be recorded.  On
        % Climb, Descent, or Approach phases the following additional line
        % are added 
        CLI = handles.M.genstrct.alt.ind.CL2_ALT_i(1);
        set(handles.Alt,'string',handles.M.genstrct.alt.values(CLI));
         else
           set(handles.ClimbRate,'string','Rate');
           set(handles.Alt,'string','Altitude'); 
           set(handles.ThrustSet,'string','Thrust');
         end
    else
        if handles.index.build==1
        set(handles.ClimbRate,'string',num2str(handles.M.climbarr(ident,3)));
        set(handles.ThrustSet,'string',num2str(handles.M.climbarr(ident,5)));
        % In the case of a climb, descent, or approach, the altitude of the
        % aircraft changes and the new altitdue must be recorded.  On
        % Climb, Descent, or Approach phases the following additional line
        % are added 
        CLI = handles.M.genstrct.alt.ind.CL2_ALT_i(ident);
        set(handles.Alt,'string',handles.M.genstrct.alt.values(CLI));
         else
           set(handles.ClimbRate,'string','Rate');
           set(handles.Alt,'string','Altitude'); 
           set(handles.ThrustSet,'string','Thrust');
         end
    end
elseif strncmp(list,'Cruise',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        if handles.index.build==1
        set(handles.Time,'string',num2str(handles.M.cruisearr(1,1)/60));
        set(handles.ThrustSet,'string',num2str(handles.M.cruisearr(1,2)));
        else
           set(handles.Time,'string','Time');
           set(handles.ThrustSet,'string','Thrust'); 
        end
    else
        if handles.index.build==1
        set(handles.Time,'string',num2str(handles.M.cruisearr(ident,1)/60));
        set(handles.ThrustSet,'string',num2str(handles.M.cruisearr(ident,2)));
        else
           set(handles.Time,'string','Time');
           set(handles.ThrustSet,'string','Thrust'); 
        end
    end
elseif strncmp(list,'Descent',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        if handles.index.build==1
        set(handles.DescentRate,'string',num2str(handles.M.descentarr(1,1)));
        set(handles.ThrustSet,'string',num2str(handles.M.descentarr(1,2)));
        DEI = handles.M.genstrct.alt.ind.DE2_ALT_i(1);
        set(handles.Alt,'string',num2str(handles.M.genstrct.alt.values(DEI)));
        else
           set(handles.DescentRate,'string','Rate');
           set(handles.ThrustSet,'string','Thrust'); 
        end
    else
        if handles.index.build==1
        set(handles.DescentRate,'string',num2str(handles.M.descentarr(ident,1)));
        set(handles.ThrustSet,'string',num2str(handles.M.descentarr(ident,2)));
        DEI = handles.M.genstrct.alt.ind.DE2_ALT_i(ident);
        set(handles.Alt,'string',num2str(handles.M.genstrct.alt.values(DEI)));
        else
           set(handles.DescentRate,'string','Rate');
           set(handles.ThrustSet,'string','Thrust'); 
        end
    end
elseif strncmp(list,'Loiter',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        if handles.index.build==1
       
        set(handles.Time,'string',num2str(handles.M.loiterarr(1,1)/60));
        set(handles.ThrustSet,'string',num2str(handles.M.loiterarr(1,2)));
        else
            set(handles.Time,'string','Time');
           set(handles.ThrustSet,'string','Thrust'); 
        end
    else
       if handles.index.build==1
        set(handles.Time,'string',num2str(handles.M.loiterarr(ident,1)/60));
        set(handles.ThrustSet,'string',num2str(handles.M.loiterarr(ident,2)));
        else
            set(handles.Time,'string','Time');
           set(handles.ThrustSet,'string','Thrust'); 
        end
    end
elseif strncmp(list,'Approach',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        if handles.index.build==1
          API = handles.M.genstrct.alt.ind.AP2_ALT_i(1);
          set(handles.Alt,'string',handles.M.genstrct.alt.values(API));
          set(handles.DescentRate,'string',num2str(handles.M.approacharr(1,1)));
          set(handles.ThrustSet,'string',num2str(handles.M.approacharr(1,4)));
          set(handles.FlapSet,'string',num2str(handles.M.approacharr(1,2)));
          set(handles.FlapSet2,'string',num2str(handles.M.approacharr(1,3)));
        else
            set(handles.Alt,'string','Altitude');
            set(handles.ThrustSet,'string','Thrust');
            set(handles.FlapSet,'string','Flaps');
            set(handles.DescentRate,'string','Rate');
        end
    else
        if handles.index.build==1
          API = handles.M.genstrct.alt.ind.AP2_ALT_i(ident);
          set(handles.Alt,'string',handles.M.genstrct.alt.values(API));
          set(handles.DescentRate,'string',num2str(handles.M.approacharr(ident,1)));
          set(handles.ThrustSet,'string',num2str(handles.M.approacharr(ident,4)));
          set(handles.FlapSet,'string',num2str(handles.M.approacharr(ident,2)));
          set(handles.FlapSet2,'string',num2str(handles.M.approacharr(ident,3)));
        else
            set(handles.Alt,'string','Altitude');
            set(handles.ThrustSet,'string','Thrust');
            set(handles.FlapSet,'string','Flaps');
            set(handles.DescentRate,'string','Rate');
        end
    end
elseif strncmp(list,'Landing',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        if handles.index.build==1
        set(handles.FlapSet,'string',num2str(handles.M.landingarr(1,1)));
        set(handles.ThrustSet,'string',num2str(handles.M.landingarr(1,2)));
        else
            set(handles.ThrustSet,'string','Thrust');
            set(handles.FlapSet,'string','Flaps');
        end
    else
         if handles.index.build==1
        set(handles.FlapSet,'string',num2str(handles.M.landingarr(ident,1)));
        set(handles.ThrustSet,'string',num2str(handles.M.landingarr(ident,2)));
        else
            set(handles.ThrustSet,'string','Thrust');
            set(handles.FlapSet,'string','Flaps');
        end
    end
elseif strncmp(list,'Shutdown',3) == 1
    ch = char(list);
    ident = str2double(ch(end));
    real = isreal(ident);
    nan = isnan(ident);
    if real == 0 || nan == 1 || ident == 1
        if handles.index.build==1
          set(handles.Time,'string',num2str(handles.M.shutdownarr(1,1)/60));
        else
             set(handles.Time,'string','Time');
        end
    else
         if handles.index.build==1
          set(handles.Time,'string',num2str(handles.M.shutdownarr(ident,1)));
        else
             set(handles.Time,'string','Time');
        end
    end
end


function plotfcn(ind,handles)
% Plotting function.  could also populate the table in the GUI.  Needs
% Completion
a=get(handles.GraphSelect,'value');
str=get(handles.GraphSelect,'string');
list=str(a);

switch ind
    
    case 1
        axes(handles.MSSNPLT)
       
        plot(handles.MSSN.cond.time,handles.MSSN.cond.alt)
        axis([0 handles.MSSN.cond.time(end) -500 1.1*max(handles.MSSN.cond.alt)])
       ylabel('Feet')
        xlabel('Time (Sec)')
        title('Altitude')
    case 2
        axes(handles.MSSNPLT)
        plot(handles.MSSN.cond.time,handles.MSSN.cond.mach)
        axis([0 handles.MSSN.cond.time(end) 0 1.1*max(handles.MSSN.cond.mach)])
        title(list)
        xlabel('Time (Sec)')
        
    case 3
       
        axes(handles.MSSNPLT)
        plot(handles.MSSN.eng.time,handles.MSSN.eng.apu)
        axis([0 handles.MSSN.eng.time(end) 0 1.1])
        xlabel('Time (Sec)')
        title(list)
    case 4
        axes(handles.MSSNPLT)
     
        plot(handles.MSSN.eng.time,handles.MSSN.eng.Eng1)
        hold on
        plot(handles.MSSN.eng.time,handles.MSSN.eng.Eng2,'r')
        hold on
         xlabel('Time (Sec)')
           title(list)
     if handles.MSSN.gen.N_ENG > 2  
        plot(handles.MSSN.eng.time,handles.MSSN.eng.Eng3,'c')
        hold on
        xlabel('Time (Sec)')
          title(list)
     end
     
     if handles.MSSN.gen.N_ENG >3
        plot(handles.MSSN.eng.time,handles.MSSN.eng.Eng4,'m')
        xlabel('Time (Sec)')
        title(list)
     end
        axis([0 handles.MSSN.eng.time(end) 0 1.1])
         xlabel('Time (Sec)')
         title(list)
    case 5
       axes(handles.MSSNPLT)
        plot(handles.MSSN.eng.time,handles.MSSN.eng.EngThrust1)
        hold on
        plot(handles.MSSN.eng.time,handles.MSSN.eng.EngThrust2,'r')
        hold on
         xlabel('Time (Sec)')
         ylabel('Thrust kN')
           title(list)
     if handles.MSSN.gen.N_ENG > 2  
        plot(handles.MSSN.eng.time,handles.MSSN.eng.EngThrust3,'c')
        hold on
         xlabel('Time (Sec)')
         ylabel('Thrust kN')
           title(list)
     end
     
     if handles.MSSN.gen.N_ENG >3
        plot(handles.MSSN.eng.time,handles.MSSN.eng.EngThrust4,'m')
     end
        axis([0 handles.MSSN.eng.time(end) 0 200])
         xlabel('Time (Sec)')
           title(list)
           ylabel('Thrust kN')
    case 6
     axes(handles.MSSNPLT)
        plot(handles.MSSN.eng.time,handles.MSSN.eng.Gen1)
        hold on
        plot(handles.MSSN.eng.time,handles.MSSN.eng.Gen2)
        hold on
        plot(handles.MSSN.eng.time,handles.MSSN.eng.Gen3,'r')
        hold on
        plot(handles.MSSN.eng.time,handles.MSSN.eng.Gen4,'r')
         xlabel('Time (Sec)')
           title(list)
            if handles.MSSN.gen.N_ENG > 2  
        hold on
        plot(handles.MSSN.eng.time,handles.MSSN.eng.Gen5,'c')
        hold on
        plot(handles.MSSN.eng.time,handles.MSSN.eng.Gen6,'c')
         xlabel('Time (Sec)')
           title(list)
            end
            if handles.MSSN.gen.N_ENG>3
        plot(handles.MSSN.eng.time,handles.MSSN.eng.Gen7,'m')
        hold on
          plot(handles.MSSN.eng.time,handles.MSSN.eng.Gen8,'m')
           xlabel('Time (Sec)')
             title(list)
            end
        axis([0 handles.MSSN.eng.time(end) 0 1.1])
        xlabel('Time (Sec)')
          title(list)
    case 7 
        axes(handles.MSSNPLT)
        plot(handles.MSSN.eng.time, handles.MSSN.eng.pack)
                axis([0 handles.MSSN.eng.time(end) 0 1.1])
                 xlabel('Time (Sec)')
                   title(list)
    case 8 
        axes(handles.MSSNPLT)
        plot(handles.MSSN.hyd.time, handles.MSSN.hyd.lndgr)
              axis([0 handles.MSSN.hyd.time(end) 0 1.1])
    xlabel('Time (Sec)')
      title(list)
    case 9 
        axes(handles.MSSNPLT)
        plot(handles.MSSN.el.time, handles.MSSN.el.flaps)
         axis([0 handles.MSSN.el.time(end) 0 25])
          xlabel('Time (Sec)')
            title(list)
    case 10
        axes(handles.MSSNPLT)
        plot(handles.MSSN.el.time, handles.MSSN.el.navcom)
         axis([0 handles.MSSN.el.time(end) 0 1.1])
         xlabel('Time (Sec)') 
           title(list)
    case 11 
        axes(handles.MSSNPLT)
        plot(handles.MSSN.el.time, handles.MSSN.el.autop)
        axis([0 handles.MSSN.el.time(end) 0 1.1])
         xlabel('Time (Sec)')
           title(list)
    case 12
        axes(handles.MSSNPLT)
        plot(handles.MSSN.el.time, handles.MSSN.el.taxilit)
         axis([0 handles.MSSN.el.time(end) 0 1.1])
          xlabel('Time (Sec)')
            title(list)
    case 13
        axes(handles.MSSNPLT)
        plot(handles.MSSN.el.time, handles.MSSN.el.landinglit)
             axis([0 handles.MSSN.el.time(end) 0 1.1])
           xlabel('Time (Sec)')   
             title(list)
     case 14
        axes(handles.MSSNPLT)
        plot(handles.MSSN.pnu.time, handles.MSSN.pnu.pres)
             axis([0 handles.MSSN.pnu.time(end) 0 1.1])
              xlabel('Time (Sec)')
                title(list)
                
    case 16
        axes(handles.MSSNPLT)
        plot(handles.MSSN.gen.time,handles.MSSN.gen.state)
        axis([0 handles.MSSN.gen.time(end) 0 11])
        xlabel('Time (sec)')
        title(list)
            

end


% --- Executes during object creation, after setting all properties.
function MSSNPLT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MSSNPLT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate MSSNPLT


% --- Executes during object deletion, before destroying properties.
function Fault_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to Fault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in GraphSelect2.
function GraphSelect2_Callback(hObject, eventdata, handles)
% hObject    handle to GraphSelect2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.MSSN = evalin('base','MSSN');
val = get(handles.GraphSelect2,'Value');
        str = get(handles.GraphSelect2,'String');
        list=str(val);
 
%Lines 1693-2105 are code that will generate different x limits for the mission 
%plot based on the different phase selected.
if strncmp(list,'Startup',3)==1 
   ch = char(list);
   ident = str2double(ch(end));
   real = isreal(ident);
   nan = isnan(ident);
   if ident==1 || nan==1
   for i=1:length(handles.MSSN.gen.state)
        if handles.MSSN.gen.state(i)==1
          ind_i=i;
          ind2_i=i+1;
          axes(handles.MSSNPLT)
      xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
           return
       end
   end
   elseif ident~=1
       for j=1:ident
         for k=length(handles.MSSN.gen.state(1:ind2_i)):length(handles.MSSN.gen.state)
             if handles.MSSN.gen.state(k)==1
                 ind_k=k
                 ind2_k=k+1
                   axes(handles.MSSNPLT)
                     xlim([handles.MSSN.gen.time(ind_k) handles.MSSN.gen.time(ind2_k)]);
             end
         end
       end
       end
end
   
if strncmp(list,'Taxi',3)==1 
   ch = char(list);
   ident = str2double(ch(end));
   real = isreal(ident);
   nan = isnan(ident);
   z=1; 
    for i=1:length(handles.MSSN.gen.state)
        if handles.MSSN.gen.state(i)==2
          ind_i=i;
          ind2_i=i+1;
       
    
          
          if ident==1 || nan==1 || nan==0 %%Weird bug here. Value at end of taxi comes out as imaginary.
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return

          elseif ident==2 && z>2
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==3 && z>4
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==4 && z>6
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          end
           z=z+1;
        end
    end
end

if strncmp(list,'Takeoff',3)==1 
   ch = char(list);
   ident = str2double(ch(end));
   real = isreal(ident);
   nan = isnan(ident);
   z=1;
  
    for i=1:length(handles.MSSN.gen.state)
        if handles.MSSN.gen.state(i)==3
          ind_i=i;
          ind2_i=i+1;
         
          if (handles.MSSN.gen.time(ind2_i)-handles.MSSN.gen.time(ind_i))==1
              ind_i=i+1;
              ind2_i=i+2;
          end
          
          if ident==1 || nan==1
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return

          elseif ident==2 && z>2
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==3 && z>4
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==4 && z>6
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          end
           z=z+1;
        end
    end
end

if strncmp(list,'Climb',3)==1 
   ch = char(list);
   ident = str2double(ch(end));
   real = isreal(ident);
   nan = isnan(ident);
   z=1;
  
    for i=1:length(handles.MSSN.gen.state)
        if handles.MSSN.gen.state(i)==4
          ind_i=i;
          ind2_i=i+1;
          
          if (handles.MSSN.gen.time(ind2_i)-handles.MSSN.gen.time(ind_i))==1
              ind_i=i+1;
              ind2_i=i+2;
          end
         
          if ident==1 || nan==1
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return

          elseif ident==2 && z>2
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==3 && z>4
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==4 && z>6
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          end
           z=z+1;
        end
    end
end

if strncmp(list,'Cruise',3)==1 
   ch = char(list);
   ident = str2double(ch(end));
   real = isreal(ident);
   nan = isnan(ident);
   z=1;
  
    for i=1:length(handles.MSSN.gen.state)
        if handles.MSSN.gen.state(i)==5
          ind_i=i;
          ind2_i=i+1;
          
          if (handles.MSSN.gen.time(ind2_i)-handles.MSSN.gen.time(ind_i))==1
              ind_i=i+1;
              ind2_i=i+2;
          end
         
          if ident==1 || nan==1
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return

          elseif ident==2 && z>2
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==3 && z>4
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==4 && z>6
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          end
           z=z+1;
        end
    end
end

if strncmp(list,'Descent',3)==1 
   ch = char(list);
   ident = str2double(ch(end));
   real = isreal(ident);
   nan = isnan(ident);
   z=1;
  
    for i=1:length(handles.MSSN.gen.state)
        if handles.MSSN.gen.state(i)==6
          ind_i=i;
          ind2_i=i+1;
        
          if (handles.MSSN.gen.time(ind2_i)-handles.MSSN.gen.time(ind_i))==1
              ind_i=i+1;
              ind2_i=i+2;
          end
         
          if ident==1 || nan==1
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return

          elseif ident==2 && z>2
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==3 && z>4
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==4 && z>6
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          end
           z=z+1;
        end
    end
end

if strncmp(list,'Loiter',3)==1 
   ch = char(list);
   ident = str2double(ch(end));
   real = isreal(ident);
   nan = isnan(ident);
   z=1;
  
    for i=1:length(handles.MSSN.gen.state)
        if handles.MSSN.gen.state(i)==7
          ind_i=i;
          ind2_i=i+1;
          
          if (handles.MSSN.gen.time(ind2_i)-handles.MSSN.gen.time(ind_i))==1
              ind_i=i+1;
              ind2_i=i+2;
          end
         
          if ident==1 || nan==1
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return

          elseif ident==2 && z>2
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==3 && z>4
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==4 && z>6
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          end
           z=z+1;
        end
    end
end

if strncmp(list,'Approach',3)==1 
   ch = char(list);
   ident = str2double(ch(end));
   real = isreal(ident);
   nan = isnan(ident);
   z=1;
  
    for i=1:length(handles.MSSN.gen.state)
        if handles.MSSN.gen.state(i)==8
          ind_i=i;
          ind2_i=i+1;
          
          if (handles.MSSN.gen.time(ind2_i)-handles.MSSN.gen.time(ind_i))==1
              ind_i=i+1;
              ind2_i=i+2;
          end
         
          if ident==1 || nan==1
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return

          elseif ident==2 && z>2
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==3 && z>4
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==4 && z>6
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          end
           z=z+1;
        end
    end
end

if strncmp(list,'Landing',3)==1 
   ch = char(list);
   ident = str2double(ch(end));
   real = isreal(ident);
   nan = isnan(ident);
   z=1;
  
    for i=1:length(handles.MSSN.gen.state)
        if handles.MSSN.gen.state(i)==9
          ind_i=i;
          ind2_i=i+1;
          
          if (handles.MSSN.gen.time(ind2_i)-handles.MSSN.gen.time(ind_i))==1
              ind_i=i+1;
              ind2_i=i+2;
          end
         
          if ident==1 || nan==1
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return

          elseif ident==2 && z>2
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==3 && z>4
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==4 && z>6
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          end
           z=z+1;
        end
    end
end

if strncmp(list,'Shutdown',3)==1 
   ch = char(list);
   ident = str2double(ch(end));
   real = isreal(ident);
   nan = isnan(ident);
   z=1;
  
    for i=1:length(handles.MSSN.gen.state)
        if handles.MSSN.gen.state(i)==10
          ind_i=i;
          ind2_i=i+1;
          
          if (handles.MSSN.gen.time(ind2_i)-handles.MSSN.gen.time(ind_i))==1
              ind_i=i+1;
              ind2_i=i+2;
          end
         
          if ident==1 || nan==1
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return

          elseif ident==2 && z>2
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==3 && z>4
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          elseif ident==4 && z>6
              
          axes(handles.MSSNPLT)
          xlim([handles.MSSN.gen.time(ind_i) handles.MSSN.gen.time(ind2_i)]);
             return
          end
           z=z+1;
        end
    end
end

        guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns GraphSelect2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from GraphSelect2


% --- Executes during object creation, after setting all properties.
function GraphSelect2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GraphSelect2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
  
guidata(hObject,handles)

    
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
initialize_gui(gcbf, handles, true);
close all
MSSNMain


% --- Executes during object creation, after setting all properties.
function logo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%axes(handles.logo)
imshow('Rolls-royce-logo-png.png');
% Hint: place code in OpeningFcn to populate logo


% --- Executes on button press in Update.
function Update_Callback(hObject, eventdata, handles)
% hObject    handle to Update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
phaselist = cellstr(get(handles.MSSNList,'String'));
if strcmp(phaselist(1),'') == 1
    warndlg('You must load a mission before you can update.','Warning');
else
handles.MSSN= evalin('base','MSSN');
guidata(hObject, handles);


%Checks to see if a fault has occured. If so it will update the mission
%plot based on certain criteria.
if handles.MSSN.gen.faults(5)~=0;
    FailString=evalin('base','FailString');
    ind = get(handles.GraphSelect,'value');
    plotfcn(ind,handles)
    FailString=transpose(FailString);
    set(handles.GraphSelect2,'String',FailString)
else
    ind = get(handles.GraphSelect,'value');
    plotfcn(ind,handles)
end
end



% --- Executes on button press in Time_Inquiry.
function Time_Inquiry_Callback(hObject, eventdata, handles)
% hObject    handle to Time_Inquiry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(cellstr(get(handles.MSSNList,'String')),'')==1
    warndlg('You must load a mission before you can analyze.','Warning');
else
    
    %Calls the mission analyze GUI
MissionAnalyzeGUI
end


% --- Executes on mouse press over axes background.
function MSSNPLT_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to MSSNPLT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



        
        


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Time_Inquiry.
function Time_Inquiry_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Time_Inquiry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
