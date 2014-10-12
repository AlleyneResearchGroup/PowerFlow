function varargout = MissionAnalyzeGUI(varargin)
% MISSIONANALYZEGUI MATLAB code for MissionAnalyzeGUI.fig
%      MISSIONANALYZEGUI, by itself, creates a new MISSIONANALYZEGUI or raises the existing
%      singleton*.
%
%      H = MISSIONANALYZEGUI returns the handle to a new MISSIONANALYZEGUI or the handle to
%      the existing singleton*.
%
%      MISSIONANALYZEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MISSIONANALYZEGUI.M with the given input arguments.
%
%      MISSIONANALYZEGUI('Property','Value',...) creates a new MISSIONANALYZEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MissionAnalyzeGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MissionAnalyzeGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MissionAnalyzeGUI

% Last Modified by GUIDE v2.5 23-Sep-2014 16:36:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MissionAnalyzeGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MissionAnalyzeGUI_OutputFcn, ...
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


% --- Executes just before MissionAnalyzeGUI is made visible.
function MissionAnalyzeGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MissionAnalyzeGUI (see VARARGIN)

% Choose default command line output for MissionAnalyzeGUI
handles.output = hObject;
handles.MSSN = evalin('base','MSSN');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MissionAnalyzeGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MissionAnalyzeGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Analyze.
function Analyze_Callback(hObject, eventdata, handles)
% hObject    handle to Analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Time_input=str2double(get(handles.Time,'String'));
if Time_input>handles.MSSN.gen.time(end)
    warndlg('That is out of the bounds of the mission!','Heads up!');
    return
end

nan=isnan(Time_input);
if nan==1
    warndlg('Please enter a time value','Warning');
elseif nan==0
   
x=cell(1,6);  
y=cell(1,6);
strut_type=cellstr({'gen','cond' ,'eng','el','hyd','pnu'});
    for j=1:6
       type=strut_type(j);
       string=strcat('handles.MSSN.',type,'.time');
       var=char(string);
        current_struct=eval(var);
       
        for i=1:length(current_struct)
       
            cur_time=current_struct(i);
        if cur_time>Time_input
          x{j}=i;
          y{j}=i-1;
          
              break;   
        end
        end
        
    end
gen_time_index=x{1};
gen_prev_time_index=y{1};
cond_time_index=x{2};
cond_prev_time_index=y{2};
eng_time_index=x{3};
eng_prev_time_index=y{3};
el_time_index=x{4};
el_prev_time_index=y{4};
hyd_time_index=x{5};
hyd_prev_time_index=y{5};
pnu_time_index=x{6};
pnu_prev_time_index=y{6}; 

state=handles.MSSN.gen.state(gen_time_index);
if state==4 || state==6 || state==8
    alt1=handles.MSSN.cond.alt(cond_time_index);
    alt2=handles.MSSN.cond.alt(cond_prev_time_index);
    time_difference=Time_input-handles.MSSN.cond.time(cond_prev_time_index);
    step=abs(handles.MSSN.cond.time(cond_time_index)-handles.MSSN.cond.time(cond_prev_time_index));
    Altitude=alt2 + time_difference*((alt1-alt2)/step);
else
    Altitude=handles.MSSN.cond.alt(cond_time_index);  
end
if state==4 || state==6 || state==8
    mach1=handles.MSSN.cond.mach(cond_time_index);
    mach2=handles.MSSN.cond.mach(cond_prev_time_index);
    time_difference=Time_input-handles.MSSN.cond.time(cond_prev_time_index);
    step=abs(handles.MSSN.cond.time(cond_time_index)-handles.MSSN.cond.time(cond_prev_time_index));
    Mach=mach2 + time_difference*((mach1-mach2)/step);
else
    Mach=handles.MSSN.cond.mach(cond_time_index);  
end
        
end

APU=handles.MSSN.eng.apu(eng_time_index);
Pack=handles.MSSN.eng.pack(eng_time_index);
Bleed=handles.MSSN.eng.bleed(eng_time_index);
Navcom=handles.MSSN.el.navcom(el_time_index);
Autop=handles.MSSN.el.autop(el_time_index);
Taxilit=handles.MSSN.el.taxilit(el_time_index);
Landinglit=handles.MSSN.el.landinglit(el_time_index);
Flaps=handles.MSSN.el.flaps(el_time_index);
Landinggear=handles.MSSN.hyd.lndgr(hyd_time_index);
Pressure=handles.MSSN.pnu.pres(pnu_time_index);


N_GEN=handles.MSSN.gen.N_GEN;
N_ENG=handles.MSSN.gen.N_ENG;

for i=1:N_ENG
    Eng(i)=eval(['[handles.MSSN.eng.Eng' num2str(i) '(eng_time_index)];']);
    EngThrust(i)=eval(['[handles.MSSN.eng.EngThrust' num2str(i) '(eng_time_index)];']);

end
for i=1:N_GEN
    Gen(i)=eval(['[handles.MSSN.eng.Gen' num2str(i) '(eng_time_index)];']);
end
Variables1={'State';'Altitude (ft)';'Mach';'Flaps (Deg)';'APU';'Pack';'Bleed';'NavCom';'Autop';...
    'Taxilight';'Landing Light';'Landing Gear';'Pressure'};

Values1_2={APU;Pack;Bleed;Navcom;Autop;Taxilit;Landinglit;...
    Landinggear;Pressure};
for i=1:length(Values1_2)
    if Values1_2{i}==1
        Values1_2{i}='On';
    elseif Values1_2{i}==0
        Values1_2{i}='Off';
    end
end

Values1_1=cellstr(num2str([state;Altitude;Mach;Flaps]));
Values1_2=cellstr(Values1_2);
Values1=vertcat(Values1_1,Values1_2);

colnames1={'Variables','Values'};
set(handles.property_table,'data',[Variables1,Values1],'ColumnName',colnames1);




for i=1:length(Eng)
    a=num2str(i);
    b{i}=strcat('Engine',' ', a);
    c{i}=strcat('Engine',' ',a,' ','Thrust');
    d{i}=num2str(Eng(i));
    e{i}=num2str(EngThrust(i));
    if d{i}~='0'
        d{i}='On';
    elseif d{i}=='0'
        d{i}='Off';
    end
end
Variables2=vertcat(transpose(b),transpose(c));
Values2=vertcat(transpose(d),transpose(e));
colnames2={'Engines','Status'};
set(handles.engine_table,'data',[Variables2,Values2],'ColumnName',colnames2);
 
for i=1:length(Gen)
    a=num2str(i);
    f{i}=strcat('Generator',' ', a);
    g{i}=num2str(Gen(i));
    if g{i}~='0'
        g{i}='On';
    elseif g{i}=='0'
        g{i}='Off';
    end
end
Variables3=vertcat(transpose(f));
Values3=vertcat(transpose(g));
colnames3={'Generators','Status'};
set(handles.generator_table,'data',[Variables3,Values3],'ColumnName',colnames3);
 
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
