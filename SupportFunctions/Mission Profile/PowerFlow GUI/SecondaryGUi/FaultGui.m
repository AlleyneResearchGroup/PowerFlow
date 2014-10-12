function varargout = FaultGui(varargin)
% FAULTGUI MATLAB code for FaultGui.fig
%      FAULTGUI, by itself, creates a new FAULTGUI or raises the existing
%      singleton*.
%
%      H = FAULTGUI returns the handle to a new FAULTGUI or the handle to
%      the existing singleton*.
%
%      FAULTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FAULTGUI.M with the given input arguments.
%
%      FAULTGUI('Property','Value',...) creates a new FAULTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FaultGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FaultGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FaultGui

% Last Modified by GUIDE v2.5 09-Apr-2014 20:14:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FaultGui_OpeningFcn, ...
                   'gui_OutputFcn',  @FaultGui_OutputFcn, ...
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


% --- Executes just before FaultGui is made visible.
function FaultGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FaultGui (see VARARGIN)

% Choose default command line output for FaultGui
handles.output = hObject;
handles.MSSN = evalin('base','MSSN');

set(handles.Faultnum, 'string', num2str((1:handles.MSSN.gen.N_ENG)'));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FaultGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FaultGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Faulttype.
function Faulttype_Callback(hObject, eventdata, handles)
% hObject    handle to Faulttype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(handles.Faulttype,'value');
if a == 2
    set(handles.thrcomptxt,'Visible','off')
    set(handles.ThrComp,'Visible','off')
    set(handles.Faultnum, 'string', num2str((1:handles.MSSN.gen.N_GEN)'));
else
    set(handles.thrcomptxt,'Visible','on')
    set(handles.ThrComp,'Visible','on')
    set(handles.Faultnum, 'string', num2str((1:handles.MSSN.gen.N_ENG)'));
end
% Hints: contents = cellstr(get(hObject,'String')) returns Faulttype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Faulttype


% --- Executes during object creation, after setting all properties.
function Faulttype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Faulttype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Faultnum.
function Faultnum_Callback(hObject, eventdata, handles)
% hObject    handle to Faultnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Faultnum contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Faultnum


% --- Executes during object creation, after setting all properties.
function Faultnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Faultnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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



function ThrComp_Callback(hObject, eventdata, handles)
% hObject    handle to ThrComp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ThrComp as text
%        str2double(get(hObject,'String')) returns contents of ThrComp as a double


% --- Executes during object creation, after setting all properties.
function ThrComp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ThrComp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in Define.
function Define_Callback(hObject, eventdata, handles)
% hObject    handle to Define (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.MSSN = evalin('base','MSSN');
a=get(handles.Landing,'value');
if a==1
  
t_fail = str2double(get(handles.Time, 'String'));
if t_fail>handles.MSSN.gen.time(end)
    warndlg('Please select a time before the mission ends','Warning')
    return
elseif isnan(t_fail)==1
    warndlg('Please input a time variable', 'Warning')
    return
end


fail = get(handles.Faulttype, 'value');
fail_loc = get(handles.Faultnum, 'value');
T_mult = str2double(get(handles.ThrComp, 'string'));
LandData = 0;

MSSN = Failures(handles.MSSN,t_fail,fail,fail_loc,T_mult,LandData);
MSSN.gen.faults(1)=t_fail;
MSSN.gen.faults(2)=fail;
MSSN.gen.faults(3)=fail_loc;
MSSN.gen.faults(4)=T_mult;
MSSN.gen.faults(5)=LandData;
assignin('base', 'MSSN', MSSN)
close FaultGui

elseif a==2


t_fail = str2double(get(handles.Time, 'String'));
fail = get(handles.Faulttype, 'value');
fail_loc = get(handles.Faultnum, 'value');
T_mult = str2double(get(handles.ThrComp, 'string'));
LandData = 1;
handles.MSSN.gen.faults=[t_fail,fail,fail_loc,T_mult,LandData];



assignin('base','MSSN',handles.MSSN);
FaultLanding
close FaultGui


end



% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)'
close FaultGui


% --- Executes on selection change in Landing.
function Landing_Callback(hObject, eventdata, handles)
% hObject    handle to Landing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%a = get(handles.Landing,'value');
%f a == 1
%    set(handles.uipanel2,'Visible','off')
%else
%    set(handles.uipanel2,'Visible','on')

%end
% Hints: contents = cellstr(get(hObject,'String')) returns Landing contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Landing


% --- Executes during object creation, after setting all properties.
function Landing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Landing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
