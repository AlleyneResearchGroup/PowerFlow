function varargout = ChooseLegsWalkthrough(varargin)
% CHOOSELEGSWALKTHROUGH MATLAB code for ChooseLegsWalkthrough.fig
%      CHOOSELEGSWALKTHROUGH, by itself, creates a new CHOOSELEGSWALKTHROUGH or raises the existing
%      singleton*.
%
%      H = CHOOSELEGSWALKTHROUGH returns the handle to a new CHOOSELEGSWALKTHROUGH or the handle to
%      the existing singleton*.
%
%      CHOOSELEGSWALKTHROUGH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHOOSELEGSWALKTHROUGH.M with the given input arguments.
%
%      CHOOSELEGSWALKTHROUGH('Property','Value',...) creates a new CHOOSELEGSWALKTHROUGH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ChooseLegsWalkthrough_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ChooseLegsWalkthrough_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ChooseLegsWalkthrough

% Last Modified by GUIDE v2.5 12-Oct-2015 17:36:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ChooseLegsWalkthrough_OpeningFcn, ...
                   'gui_OutputFcn',  @ChooseLegsWalkthrough_OutputFcn, ...
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


% --- Executes just before ChooseLegsWalkthrough is made visible.
function ChooseLegsWalkthrough_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ChooseLegsWalkthrough (see VARARGIN)

% Choose default command line output for ChooseLegsWalkthrough
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ChooseLegsWalkthrough wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ChooseLegsWalkthrough_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Choose the mission legs you would like to build the mission with')



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


% --- Executes on button press in addphase.
function addphase_Callback(hObject, eventdata, handles)
% hObject    handle to addphase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
%set(handles.Definelist,'String',curr_str)
b = size(curr_str);
set(handles.MSSNList,'value', b(1))
guidata(hObject,handles)

% --- Executes on button press in removephase.
function removephase_Callback(hObject, eventdata, handles)
% hObject    handle to removephase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(handles.MSSNList,'string');
temp = char(a);
index = get(handles.MSSNList,'Value');
temp(index,:) = [];
set(handles.MSSNList,'value', (index-1==0)+index-1)
set(handles.MSSNList,'string',cellstr(temp))
c = relist(cellstr(temp));
%set(handles.Definelist,'String',c)
%index = get(handles.Definelist,'Value');
%set(handles.Definelist,'value', (index-1==0)+index-1)

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
%set(handles.Definelist,'String',c)


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
%set(handles.Definelist,'String',c)


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


% --- Executes on selection change in MSSNList.
function MSSNList_Callback(hObject, eventdata, handles)
% hObject    handle to MSSNList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns MSSNList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MSSNList


% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close 
BatchSingleLoad

% --- Executes on button press in Next.
function Next_Callback(hObject, eventdata, handles)
% hObject    handle to Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MissionLegs=get(handles.MSSNList,'string');
assignin('base','MissionsLegs',MissionLegs);
close
PhysicalInputsWalkthrough


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
