function varargout = FaultLanding(varargin)
% FAULTLANDING MATLAB code for FaultLanding.fig
%      FAULTLANDING, by itself, creates a new FAULTLANDING or raises the existing
%      singleton*.
%
%      H = FAULTLANDING returns the handle to a new FAULTLANDING or the handle to
%      the existing singleton*.
%
%      FAULTLANDING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FAULTLANDING.M with the given input arguments.
%
%      FAULTLANDING('Property','Value',...) creates a new FAULTLANDING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FaultLanding_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FaultLanding_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FaultLanding

% Last Modified by GUIDE v2.5 18-Sep-2014 16:06:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FaultLanding_OpeningFcn, ...
                   'gui_OutputFcn',  @FaultLanding_OutputFcn, ...
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


% --- Executes just before FaultLanding is made visible.
function FaultLanding_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FaultLanding (see VARARGIN)

% Choose default command line output for FaultLanding
handles.output = hObject;
% Update handles structure
handles.MSSN = evalin('base','MSSN');
handles.M=evalin('base','M');
guidata(hObject, handles);

% UIWAIT makes FaultLanding wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FaultLanding_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function LndAlt_Callback(hObject, eventdata, handles)
% hObject    handle to LndAlt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LndAlt as text
%        str2double(get(hObject,'String')) returns contents of LndAlt as a double


% --- Executes during object creation, after setting all properties.
function LndAlt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LndAlt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CrTime_Callback(hObject, eventdata, handles)
% hObject    handle to CrTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CrTime as text
%        str2double(get(hObject,'String')) returns contents of CrTime as a double


% --- Executes during object creation, after setting all properties.
function CrTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CrTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CrThr_Callback(hObject, eventdata, handles)
% hObject    handle to CrThr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CrThr as text
%        str2double(get(hObject,'String')) returns contents of CrThr as a double


% --- Executes during object creation, after setting all properties.
function CrThr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CrThr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DesRate_Callback(hObject, eventdata, handles)
% hObject    handle to DesRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DesRate as text
%        str2double(get(hObject,'String')) returns contents of DesRate as a double


% --- Executes during object creation, after setting all properties.
function DesRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DesRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DesThr_Callback(hObject, eventdata, handles)
% hObject    handle to DesThr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DesThr as text
%        str2double(get(hObject,'String')) returns contents of DesThr as a double


% --- Executes during object creation, after setting all properties.
function DesThr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DesThr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AppDesRate_Callback(hObject, eventdata, handles)
% hObject    handle to AppDesRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AppDesRate as text
%        str2double(get(hObject,'String')) returns contents of AppDesRate as a double


% --- Executes during object creation, after setting all properties.
function AppDesRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AppDesRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AppThr_Callback(hObject, eventdata, handles)
% hObject    handle to AppThr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AppThr as text
%        str2double(get(hObject,'String')) returns contents of AppThr as a double


% --- Executes during object creation, after setting all properties.
function AppThr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AppThr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AppAlt_Callback(hObject, eventdata, handles)
% hObject    handle to AppAlt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AppAlt as text
%        str2double(get(hObject,'String')) returns contents of AppAlt as a double


% --- Executes during object creation, after setting all properties.
function AppAlt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AppAlt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Flap1_Callback(hObject, eventdata, handles)
% hObject    handle to Flap1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Flap1 as text
%        str2double(get(hObject,'String')) returns contents of Flap1 as a double


% --- Executes during object creation, after setting all properties.
function Flap1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Flap1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Flap2_Callback(hObject, eventdata, handles)
% hObject    handle to Flap2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Flap2 as text
%        str2double(get(hObject,'String')) returns contents of Flap2 as a double


% --- Executes during object creation, after setting all properties.
function Flap2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Flap2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LndThr_Callback(hObject, eventdata, handles)
% hObject    handle to LndThr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LndThr as text
%        str2double(get(hObject,'String')) returns contents of LndThr as a double


% --- Executes during object creation, after setting all properties.
function LndThr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LndThr (see GCBO)
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


CruiseTime=str2double(get(handles.CrTime,'String'));
CruiseThrust=str2double(get(handles.CrThr,'String'));
DescentRate=str2double(get(handles.DesRate,'String'));
DescentThrust=str2double(get(handles.DesThr,'String'));
ApproachDescentRate=str2double(get(handles.AppDesRate,'String'));
ApproachThrust=str2double(get(handles.AppThr,'String'));
LandingThrust=str2double(get(handles.LndThr,'String'));
ApproachAlt=str2double(get(handles.AppAlt,'String'));
LandingAlt=str2double(get(handles.LndAlt,'String'));
Flap1=str2double(get(handles.Flap1,'String'));
Flap2=str2double(get(handles.Flap2,'String'));
MSSN = LandingFail(handles.MSSN,handles.M,CruiseTime,CruiseThrust,DescentRate,DescentThrust,ApproachDescentRate,ApproachThrust,LandingThrust,ApproachAlt,LandingAlt,Flap1,Flap2);
assignin('base', 'MSSN', MSSN)
handles.MSSN= evalin('base','MSSN');
FailString=ResetMissionLeg(handles.MSSN);
assignin('base','FailString',FailString);
close FaultLanding



% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)'
close FaultLanding




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
