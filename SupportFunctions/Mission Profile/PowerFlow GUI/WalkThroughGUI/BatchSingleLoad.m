function varargout = BatchSingleLoad(varargin)
% BATCHSINGLELOAD MATLAB code for BatchSingleLoad.fig
%      BATCHSINGLELOAD, by itself, creates a new BATCHSINGLELOAD or raises the existing
%      singleton*.
%
%      H = BATCHSINGLELOAD returns the handle to a new BATCHSINGLELOAD or the handle to
%      the existing singleton*.
%
%      BATCHSINGLELOAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCHSINGLELOAD.M with the given input arguments.
%
%      BATCHSINGLELOAD('Property','Value',...) creates a new BATCHSINGLELOAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BatchSingleLoad_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BatchSingleLoad_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BatchSingleLoad

% Last Modified by GUIDE v2.5 12-Oct-2015 19:12:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BatchSingleLoad_OpeningFcn, ...
                   'gui_OutputFcn',  @BatchSingleLoad_OutputFcn, ...
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


% --- Executes just before BatchSingleLoad is made visible.
function BatchSingleLoad_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BatchSingleLoad (see VARARGIN)

% Choose default command line output for BatchSingleLoad
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BatchSingleLoad wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BatchSingleLoad_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse press over figure background.
function figure1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close 
OpeningGUI

% --- Executes on button press in Help.
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'Choose of the 3 options:' 'Build a unique single mission' 'Load a mission that has been previously built' 'Batch together several previosuly built missions'});

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in BuildSingle.
function BuildSingle_Callback(hObject, eventdata, handles)
% hObject    handle to BuildSingle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
ChooseLegsWalkthrough

% --- Executes on button press in LoadMission.
function LoadMission_Callback(hObject, eventdata, handles)
% hObject    handle to LoadMission (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
M = load('Defaults.mat');
assignin('base','M',M)
evalin('base','load(''Defaults.mat'')');
uiopen('load');
handles.M = M;
close 
DefineWalkthrough

% --- Executes on button press in Batch.
function Batch_Callback(hObject, eventdata, handles)
% hObject    handle to Batch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
BatchGUIWalkthrough
