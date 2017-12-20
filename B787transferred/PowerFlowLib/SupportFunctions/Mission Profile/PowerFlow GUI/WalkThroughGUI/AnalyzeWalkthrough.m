function varargout = AnalyzeWalkthrough(varargin)
% ANALYZEWALKTHROUGH MATLAB code for AnalyzeWalkthrough.fig
%      ANALYZEWALKTHROUGH, by itself, creates a new ANALYZEWALKTHROUGH or raises the existing
%      singleton*.
%
%      H = ANALYZEWALKTHROUGH returns the handle to a new ANALYZEWALKTHROUGH or the handle to
%      the existing singleton*.
%
%      ANALYZEWALKTHROUGH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYZEWALKTHROUGH.M with the given input arguments.
%
%      ANALYZEWALKTHROUGH('Property','Value',...) creates a new ANALYZEWALKTHROUGH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnalyzeWalkthrough_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnalyzeWalkthrough_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnalyzeWalkthrough

% Last Modified by GUIDE v2.5 12-Oct-2015 19:54:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnalyzeWalkthrough_OpeningFcn, ...
                   'gui_OutputFcn',  @AnalyzeWalkthrough_OutputFcn, ...
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


% --- Executes just before AnalyzeWalkthrough is made visible.
function AnalyzeWalkthrough_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnalyzeWalkthrough (see VARARGIN)

% Choose default command line output for AnalyzeWalkthrough
handles.output = hObject;
handles.MSSN= evalin('base','MSSN');
MissionsLegs= evalin('base','MissionsLegs');
set(handles.GraphSelect2,'String',MissionsLegs)
ind = get(handles.GraphSelect,'value');
plotfcn(ind,handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnalyzeWalkthrough wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AnalyzeWalkthrough_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Fault.
function Fault_Callback(hObject, eventdata, handles)
% hObject    handle to Fault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    h = FaultGui;
    waitfor(h);
    handles.MSSN = evalin('base','MSSN');

% --- Executes on button press in Update.
function Update_Callback(hObject, eventdata, handles)
% hObject    handle to Update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.MSSN= evalin('base','MSSN');
guidata(hObject, handles);

% --- Executes on button press in TimeInquiry.
function TimeInquiry_Callback(hObject, eventdata, handles)
% hObject    handle to TimeInquiry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MissionAnalyzeGUI

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

% --- Executes during object creation, after setting all properties.
function GraphSelect2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GraphSelect2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
DefineWalkthrough

% --- Executes on button press in Help.
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('This is the analyze GUI. The mission profile can be found in the top left. The parameters and mission legs can be chosen in the mission controls. To insert a fault, click fault and click update. To inquire the data at a specific point in time click time inquiry.');

% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    MSSN = handles.MSSN;
    uisave('MSSN','Output1')

% --- Executes on button press in ReturnToMain.
function ReturnToMain_Callback(hObject, eventdata, handles)
% hObject    handle to ReturnToMain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
OpeningGUI

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
