function varargout = DefineWalkthrough(varargin)
% DEFINEWALKTHROUGH MATLAB code for DefineWalkthrough.fig
%      DEFINEWALKTHROUGH, by itself, creates a new DEFINEWALKTHROUGH or raises the existing
%      singleton*.
%
%      H = DEFINEWALKTHROUGH returns the handle to a new DEFINEWALKTHROUGH or the handle to
%      the existing singleton*.
%
%      DEFINEWALKTHROUGH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEFINEWALKTHROUGH.M with the given input arguments.
%
%      DEFINEWALKTHROUGH('Property','Value',...) creates a new DEFINEWALKTHROUGH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DefineWalkthrough_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DefineWalkthrough_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DefineWalkthrough

% Last Modified by GUIDE v2.5 12-Oct-2015 19:17:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DefineWalkthrough_OpeningFcn, ...
                   'gui_OutputFcn',  @DefineWalkthrough_OutputFcn, ...
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


% --- Executes just before DefineWalkthrough is made visible.
function DefineWalkthrough_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DefineWalkthrough (see VARARGIN)

% Choose default command line output for DefineWalkthrough
handles.output = hObject;
%M = load('Defaults.mat');
%assignin('base','M',M)
M=evalin('base','M');
handles.M = M;
handles.index.build = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DefineWalkthrough wait for user response (see UIRESUME)
% uiwait(handles.figure1);
MissionsLegs=evalin('base','MissionsLegs');
set(handles.Definelist,'string',MissionsLegs);

% --- Outputs from this function are returned to the command line.
function varargout = DefineWalkthrough_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
PhysicalInputsWalkthrough

% --- Executes on button press in Help.
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Select a leg in the mission in the drop down menu in the top left. Define the paramaters and click define. Once all are defined click Build.');

% --- Executes on button press in Next.
function Next_Callback(hObject, eventdata, handles)
% hObject    handle to Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
AnalyzeWalkthrough

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


% --- Executes on button press in DefineCancel.
function DefineCancel_Callback(hObject, eventdata, handles)
% hObject    handle to DefineCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
MissionsLegs=evalin('base','MissionsLegs');
if numel(MissionsLegs)>val
    new_list=a(val+1);
    set(handles.Definelist,'value',val+1);
    varopt(handles,new_list,val+1,'on');
    set(handles.Time,'string','Time');
    set(handles.ThrustSet,'string','Thrust');
    set(handles.Alt,'string','Altitude');
    set(handles.ClimbRate,'string','Rate');
    set(handles.DescentRate,'string','Rate');
    set(handles.FlapSet1,'string','Flap Angle');
    set(handles.FlapSet2,'string','Flap Angle');
end


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
function TaxiEng_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TaxiEng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FlapSet1_Callback(hObject, eventdata, handles)
% hObject    handle to FlapSet1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FlapSet1 as text
%        str2double(get(hObject,'String')) returns contents of FlapSet1 as a double


% --- Executes during object creation, after setting all properties.
function FlapSet1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FlapSet1 (see GCBO)
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
set(handles.FlapSet1,'Visible',on_off)
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
    set(handles.FlapSet1,'Visible',on_off)
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
    set(handles.FlapSet1,'Visible',on_off)
    set(handles.degtxt,'Visible',on_off)
    set(handles.FlapSettxt2,'Visible',on_off)
    set(handles.FlapSet2,'Visible',on_off)
    set(handles.degtxt2,'Visible',on_off)
elseif strncmp(list,'Landing',3) == 1
    set(handles.Thrusttxt,'Visible',on_off)
    set(handles.ThrustSet,'Visible',on_off)
    set(handles.percent,'Visible',on_off)
    set(handles.FlapSettxt1,'Visible',on_off)
    set(handles.FlapSet1,'Visible',on_off)
    set(handles.degtxt,'Visible',on_off)
elseif strncmp(list,'Shutdown',3) == 1
    set(handles.Timetxt,'Visible',on_off)
    set(handles.Time,'Visible',on_off)
    set(handles.Minutes,'Visible',on_off)
    set(handles.GroundPower,'Visible',on_off)
end

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
        handles.M.takeoffarr(1,2) = str2double(get(handles.FlapSet1,'string'));
        handles.M.takeoffarr(1,3) = str2double(get(handles.ThrustSet,'string'));
    else
        handles.M.takeoffarr(ident,1) = str2double(get(handles.Time,'string'));
        handles.M.takeoffarr(ident,2) = str2double(get(handles.FlapSet1,'string'));
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
        handles.M.approacharr(1,2) = str2double(get(handles.FlapSet1,'string'));
        handles.M.approacharr(1,3) = str2double(get(handles.FlapSet2,'string'));
        handles.M.approacharr(1,4) = str2double(get(handles.ThrustSet,'string'));
        ALT = str2double(get(handles.Alt,'string'));
        API = handles.M.genstrct.alt.ind.AP2_ALT_i(1);
        handles.M.genstrct.alt.values(API) = ALT;
    else
        handles.M.approacharr(ident,1) = str2double(get(handles.DescentRate,'string'));
        handles.M.approacharr(ident,2) = str2double(get(handles.FlapSet1,'string'));
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
        handles.M.landingarr(1,1) = str2double(get(handles.FlapSet1,'string'));
        handles.M.landingarr(1,2) = str2double(get(handles.ThrustSet,'string'));
    else
        handles.M.landingarr(ident,1) = str2double(get(handles.FlapSet1,'string'));
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
MSSNlist=evalin('base','MissionsLegs');
%MSSNlist = cellstr(get(handles.MSSNList,'String'));
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
        set(handles.FlapSet1,'string',num2str(handles.M.takeoffarr(1,2)));
        set(handles.ThrustSet,'string',num2str(handles.M.takeoffarr(1,3)));
        else
        set(handles.Time,'string','Time');
        set(handles.Alt,'string','Altitude'); 
        set(handles.GroundPower,'value',0)
        end
    else
        if handles.index.build==1
        set(handles.Time,'string',num2str(handles.M.takeoffarr(ident,1)));
        set(handles.FlapSet1,'string',num2str(handles.M.takeoffarr(ident,2)));
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
          set(handles.FlapSet1,'string',num2str(handles.M.approacharr(1,2)));
          set(handles.FlapSet2,'string',num2str(handles.M.approacharr(1,3)));
        else
            set(handles.Alt,'string','Altitude');
            set(handles.ThrustSet,'string','Thrust');
            set(handles.FlapSet1,'string','Flaps');
            set(handles.DescentRate,'string','Rate');
        end
    else
        if handles.index.build==1
          API = handles.M.genstrct.alt.ind.AP2_ALT_i(ident);
          set(handles.Alt,'string',handles.M.genstrct.alt.values(API));
          set(handles.DescentRate,'string',num2str(handles.M.approacharr(ident,1)));
          set(handles.ThrustSet,'string',num2str(handles.M.approacharr(ident,4)));
          set(handles.FlapSet1,'string',num2str(handles.M.approacharr(ident,2)));
          set(handles.FlapSet2,'string',num2str(handles.M.approacharr(ident,3)));
        else
            set(handles.Alt,'string','Altitude');
            set(handles.ThrustSet,'string','Thrust');
            set(handles.FlapSet1,'string','Flaps');
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
        set(handles.FlapSet1,'string',num2str(handles.M.landingarr(1,1)));
        set(handles.ThrustSet,'string',num2str(handles.M.landingarr(1,2)));
        else
            set(handles.ThrustSet,'string','Thrust');
            set(handles.FlapSet1,'string','Flaps');
        end
    else
         if handles.index.build==1
        set(handles.FlapSet1,'string',num2str(handles.M.landingarr(ident,1)));
        set(handles.ThrustSet,'string',num2str(handles.M.landingarr(ident,2)));
        else
            set(handles.ThrustSet,'string','Thrust');
            set(handles.FlapSet1,'string','Flaps');
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


% --- Executes on button press in Build.
function Build_Callback(hObject, eventdata, handles)
% hObject    handle to Build (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear handles.MSSN
phaselist = evalin('base','MissionsLegs');
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
%cla(handles.MSSNPLT,'reset')
%ind = get(handles.GraphSelect,'value');
%plotfcn(ind,handles)
assignin('base', 'MSSN', handles.MSSN)
%a=get(handles.MSSNList,'String');
%c = relist(a);
%set(handles.GraphSelect2,'String',c)


[handles.MSSN ] = MonotonicFix(handles.MSSN);
assignin('base', 'MSSN', handles.MSSN)
end
