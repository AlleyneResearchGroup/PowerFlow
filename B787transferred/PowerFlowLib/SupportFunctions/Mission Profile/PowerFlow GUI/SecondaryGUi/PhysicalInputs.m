function varargout = PhysicalInputs(varargin)
% PHYSICALINPUTS MATLAB code for PhysicalInputs.fig
%      PHYSICALINPUTS, by itself, creates a new PHYSICALINPUTS or raises the existing
%      singleton*.
%
%      H = PHYSICALINPUTS returns the handle to a new PHYSICALINPUTS or the handle to
%      the existing singleton*.
%
%      PHYSICALINPUTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHYSICALINPUTS.M with the given input arguments.
%
%      PHYSICALINPUTS('Property','Value',...) creates a new PHYSICALINPUTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PhysicalInputs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PhysicalInputs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PhysicalInputs

% Last Modified by GUIDE v2.5 22-Nov-2015 19:16:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PhysicalInputs_OpeningFcn, ...
                   'gui_OutputFcn',  @PhysicalInputs_OutputFcn, ...
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


% --- Executes just before PhysicalInputs is made visible.
function PhysicalInputs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PhysicalInputs (see VARARGIN)

% Choose default command line output for PhysicalInputs
handles.output = hObject;
M=evalin('base','M');
% Update handles structure


handles.M = M
guidata(hObject, handles);

% UIWAIT makes PhysicalInputs wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PhysicalInputs_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function latitude_Callback(hObject, eventdata, handles)
% hObject    handle to latitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of latitude as text
%        str2double(get(hObject,'String')) returns contents of latitude as a double


% --- Executes during object creation, after setting all properties.
function latitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to latitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sref_Callback(hObject, eventdata, handles)
% hObject    handle to sref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sref as text
%        str2double(get(hObject,'String')) returns contents of sref as a double


% --- Executes during object creation, after setting all properties.
function sref_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function longitude_Callback(hObject, eventdata, handles)
% hObject    handle to longitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of longitude as text
%        str2double(get(hObject,'String')) returns contents of longitude as a double


% --- Executes during object creation, after setting all properties.
function longitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to longitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxElevatorDeflection_Callback(hObject, eventdata, handles)
% hObject    handle to MaxElevatorDeflection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxElevatorDeflection as text
%        str2double(get(hObject,'String')) returns contents of MaxElevatorDeflection as a double


% --- Executes during object creation, after setting all properties.
function MaxElevatorDeflection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxElevatorDeflection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wn_Callback(hObject, eventdata, handles)
% hObject    handle to wn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wn as text
%        str2double(get(hObject,'String')) returns contents of wn as a double


% --- Executes during object creation, after setting all properties.
function wn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MinElevatorDeflection_Callback(hObject, eventdata, handles)
% hObject    handle to MinElevatorDeflection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MinElevatorDeflection as text
%        str2double(get(hObject,'String')) returns contents of MinElevatorDeflection as a double


% --- Executes during object creation, after setting all properties.
function MinElevatorDeflection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MinElevatorDeflection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bref_Callback(hObject, eventdata, handles)
% hObject    handle to bref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bref as text
%        str2double(get(hObject,'String')) returns contents of bref as a double


% --- Executes during object creation, after setting all properties.
function bref_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zeta_Callback(hObject, eventdata, handles)
% hObject    handle to zeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zeta as text
%        str2double(get(hObject,'String')) returns contents of zeta as a double


% --- Executes during object creation, after setting all properties.
function zeta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxRudderDeflection_Callback(hObject, eventdata, handles)
% hObject    handle to MaxRudderDeflection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxRudderDeflection as text
%        str2double(get(hObject,'String')) returns contents of MaxRudderDeflection as a double


% --- Executes during object creation, after setting all properties.
function MaxRudderDeflection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxRudderDeflection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MinRudderDeflection_Callback(hObject, eventdata, handles)
% hObject    handle to MinRudderDeflection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MinRudderDeflection as text
%        str2double(get(hObject,'String')) returns contents of MinRudderDeflection as a double


% --- Executes during object creation, after setting all properties.
function MinRudderDeflection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MinRudderDeflection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mass_Callback(hObject, eventdata, handles)
% hObject    handle to mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass as text
%        str2double(get(hObject,'String')) returns contents of mass as a double


% --- Executes during object creation, after setting all properties.
function mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MinAileronDeflection_Callback(hObject, eventdata, handles)
% hObject    handle to MinAileronDeflection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MinAileronDeflection as text
%        str2double(get(hObject,'String')) returns contents of MinAileronDeflection as a double


% --- Executes during object creation, after setting all properties.
function MinAileronDeflection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MinAileronDeflection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxAileronDeflection_Callback(hObject, eventdata, handles)
% hObject    handle to MaxAileronDeflection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxAileronDeflection as text
%        str2double(get(hObject,'String')) returns contents of MaxAileronDeflection as a double


% --- Executes during object creation, after setting all properties.
function MaxAileronDeflection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxAileronDeflection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cbar_Callback(hObject, eventdata, handles)
% hObject    handle to cbar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cbar as text
%        str2double(get(hObject,'String')) returns contents of cbar as a double


% --- Executes during object creation, after setting all properties.
function cbar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cbar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function heading_Callback(hObject, eventdata, handles)
% hObject    handle to heading (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of heading as text
%        str2double(get(hObject,'String')) returns contents of heading as a double


% --- Executes during object creation, after setting all properties.
function heading_CreateFcn(hObject, eventdata, handles)
% hObject    handle to heading (see GCBO)
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
if isnan(str2double(get(handles.latitude,'string')))==1 | ...
isnan(str2double(get(handles.longitude,'string')))== 1 | isnan(str2double(get(handles.heading,'string')))==1 | ...
isnan(str2double(get(handles.sref,'string')))== 1 | isnan(str2double(get(handles.bref,'string')))==1 | ...
isnan(str2double(get(handles.cbar,'string')))== 1 | isnan(str2double(get(handles.wn,'string')))==1 | ...
isnan(str2double(get(handles.zeta,'string')))== 1 | isnan(str2double(get(handles.MaxAileronDeflection,'string')))==1 | ...
isnan(str2double(get(handles.MaxElevatorDeflection,'string')))== 1 | isnan(str2double(get(handles.MaxRudderDeflection,'string')))==1 | ...
isnan(str2double(get(handles.MinAileronDeflection,'string')))== 1 | isnan(str2double(get(handles.MinElevatorDeflection,'string')))==1 | ...
isnan(str2double(get(handles.MinRudderDeflection,'string')))== 1 | isnan(str2double(get(handles.mass,'string')))==1
msgbox ('Please define all physical inputs');

else
handles.M.genstrct.phys(1)=str2double(get(handles.latitude,'string'));
handles.M.genstrct.phys(2)=str2double(get(handles.longitude,'string'));
handles.M.genstrct.phys(3)=str2double(get(handles.heading,'string'));
handles.M.genstrct.phys(4)=str2double(get(handles.sref,'string'));
handles.M.genstrct.phys(5)=str2double(get(handles.bref,'string'));
handles.M.genstrct.phys(6)=str2double(get(handles.cbar,'string'));
handles.M.genstrct.phys(7)=str2double(get(handles.wn,'string'));
handles.M.genstrct.phys(8)=str2double(get(handles.zeta,'string'));
handles.M.genstrct.phys(9)=str2double(get(handles.MaxAileronDeflection,'string'));
handles.M.genstrct.phys(10)=str2double(get(handles.MaxElevatorDeflection,'string'));
handles.M.genstrct.phys(11)=str2double(get(handles.MaxRudderDeflection,'string'));
handles.M.genstrct.phys(12)=str2double(get(handles.MinAileronDeflection,'string'));
handles.M.genstrct.phys(13)=str2double(get(handles.MinElevatorDeflection,'string'));
handles.M.genstrct.phys(14)=str2double(get(handles.MinRudderDeflection,'string'));
handles.M.genstrct.phys(15)=str2double(get(handles.mass,'string'));
M=handles.M
assignin('base','M',M)  
close
end





% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
