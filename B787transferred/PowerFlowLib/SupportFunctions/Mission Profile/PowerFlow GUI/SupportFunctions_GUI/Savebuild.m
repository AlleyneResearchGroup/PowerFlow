function varargout = Savebuild(varargin)
% SAVEBUILD MATLAB code for Savebuild.fig
%      SAVEBUILD, by itself, creates a new SAVEBUILD or raises the existing
%      singleton*.
%
%      H = SAVEBUILD returns the handle to a new SAVEBUILD or the handle to
%      the existing singleton*.
%
%      SAVEBUILD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAVEBUILD.M with the given input arguments.
%
%      SAVEBUILD('Property','Value',...) creates a new SAVEBUILD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Savebuild_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Savebuild_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Savebuild

% Last Modified by GUIDE v2.5 17-Sep-2014 22:56:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Savebuild_OpeningFcn, ...
                   'gui_OutputFcn',  @Savebuild_OutputFcn, ...
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

function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the Cancel flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to Cancel the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end
% --- Executes just before Savebuild is made visible.
function Savebuild_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Savebuild (see VARARGIN)

% Choose default command line output for Savebuild
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Savebuild wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Savebuild_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in yes.
function yes_Callback(hObject, eventdata, handles)
% hObject    handle to yes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%uisave('M','Input1')

M = evalin('base','M');
uisave('M','Input')
% --- Executes on button press in no.
function no_Callback(hObject, eventdata, handles)
% hObject    handle to no (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
initialize_gui(gcbf, handles, true);
close all
