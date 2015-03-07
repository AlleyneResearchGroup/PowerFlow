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

% Last Modified by GUIDE v2.5 06-Mar-2015 00:28:56

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
for i = 1:N
    M=load(BatchArray{i});
   M = M.M;
   assignin('base','M',M);
   altindex(hObject,handles)
   
    assignin('base','M',M);
MSSN1 = MissionBuild(M.phaselist,M.startuparr,M.taxiarr,M.takeoffarr,M.climbarr,M.cruisearr,...
    M.descentarr,M.loiterarr,M.approacharr,M.landingarr,M.shutdownarr,M.genstrct);
 assignin('base','MSSN1',MSSN1);
guidata(hObject, handles);
    axes(handles.MSSNPLT1)
       
        plot(MSSN1.cond.time,MSSN1.cond.alt)
        axis([0 MSSN1.cond.time(end) -500 1.1*max(MSSN1.cond.alt)])

end


% --- Executes on button press in BuildBatch.
function BuildBatch_Callback(hObject, eventdata, handles)
% hObject    handle to BuildBatch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[BatchFile] = uiputfile('Batch1.mat','Save Batch name');
N = str2double(get(handles.NumMSSN, 'string'));
Batch = cell(N,1);

B=1;
for i = 1:N
    A = uigetfile('*.mat','Select the input file');
    if strcmp(num2str(A),'0') == 1
        B=0;
        break
    end
    Batch(i,:) = cellstr(A);
end
if B == 1
 %   save(BatchFile,'Batch')
end

assignin('base','BatchArray',Batch);

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


