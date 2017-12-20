%main mission profile script
function MSSN = MissionBuild(phaselist,startuparr,taxiarr,takeoffarr,climbarr,cruisearr,...
    descentarr,loiterarr,approacharr,landingarr,shutdownarr,genstrct)
clc
%inputs
%altitude index
ST_ALT_i = genstrct.alt.ind.ST_ALT_i;
TA_ALT_i = genstrct.alt.ind.TA_ALT_i;
TO_ALT_i = genstrct.alt.ind.TO_ALT_i;
CL1_ALT_i = genstrct.alt.ind.CL1_ALT_i;
CL2_ALT_i = genstrct.alt.ind.CL2_ALT_i;
CR_ALT_i = genstrct.alt.ind.CR_ALT_i;
DE1_ALT_i =genstrct.alt.ind.DE1_ALT_i;
DE2_ALT_i =genstrct.alt.ind.DE2_ALT_i;
LO_ALT_i =genstrct.alt.ind.LO_ALT_i;
AP1_ALT_i =genstrct.alt.ind.AP1_ALT_i;
AP2_ALT_i =genstrct.alt.ind.AP2_ALT_i;
SD_ALT_i =genstrct.alt.ind.SD_ALT_i;

%run index
startup_i = 1;
taxi_i = 1;
TO_i = 1;
climb_i = 1;
cruise_i = 1;
desc_i = 1;
loiter_i = 1;
appr_i = 1;
land_i = 1;
SD_i = 1;

%M.genstrct.phaselist = 
alt = genstrct.alt.values;
handles.MSSN.gen.faults=zeros(1,5);
N_ENG = genstrct.eng.num;
N_mssnphase = size(phaselist);
MSSN = initmssn(N_ENG);
t = 0;
% MSSN.gen.phys(1)=genstrct.phys(1);
% MSSN.gen.phys(2)=genstrct.phys(2);
% MSSN.gen.phys(3)=genstrct.phys(3);
% MSSN.gen.phys(4)=genstrct.phys(4);
% MSSN.gen.phys(5)=genstrct.phys(5);
% MSSN.gen.phys(6)=genstrct.phys(6);
% MSSN.gen.phys(7)=genstrct.phys(7);
% MSSN.gen.phys(8)=genstrct.phys(8);
% MSSN.gen.phys(9)=genstrct.phys(9);
% MSSN.gen.phys(10)=genstrct.phys(10);
% MSSN.gen.phys(11)=genstrct.phys(11);
% MSSN.gen.phys(12)=genstrct.phys(12);
% MSSN.gen.phys(13)=genstrct.phys(13);
% MSSN.gen.phys(14)=genstrct.phys(14);
% MSSN.gen.phys(15)=genstrct.phys(15);
for i = 1:N_mssnphase(1)
    if strcmp(phaselist(i),'Startup') == 1
            disp('startup')
            j = startup_i;
            MSSN_temp = startup(t,alt(ST_ALT_i(j)),N_ENG,startuparr(j,3),startuparr(j,1)...
                ,startuparr(j,2));
            t = MSSN_temp.gen.time(end)+1;
            MSSN = Concat(MSSN,MSSN_temp,N_ENG);
            startup_i = startup_i+1;
    elseif strcmp(phaselist(i),'Taxi') == 1
            disp('taxi')
            j = taxi_i;
            MSSN_temp = taxi(t,alt(TA_ALT_i(j)),N_ENG,taxiarr(j,3),taxiarr(j,1),taxiarr(j,2));
            t = MSSN_temp.gen.time(end)+1;
            MSSN = Concat(MSSN,MSSN_temp,N_ENG);
            taxi_i = taxi_i+1;
    elseif strcmp(phaselist(i),'Takeoff') == 1
            disp('take off')
            j = TO_i;
            MSSN_temp = takeoff(t,alt(TO_ALT_i(j)),N_ENG,takeoffarr(j,3),takeoffarr(j,2),takeoffarr(j,1));%takeoff()
            t = MSSN_temp.gen.time(end)+1;
            MSSN = Concat(MSSN,MSSN_temp,N_ENG);
            TO_i = TO_i+1;
            CLTO_i = TO_i;
            %takeoff()
    elseif strcmp(phaselist(i),'Climb') == 1
            disp('climb')
            j = climb_i;
            if CLTO_i > 1
                MSSN_temp = climb(t,alt(CL1_ALT_i(j)),alt(CL2_ALT_i(j)),N_ENG,climbarr(j,5)...
                    ,MSSN.eng.pack(end),takeoffarr(TO_i,2),climbarr(j,3),climbarr(j,4));%climb()
                t = MSSN_temp.gen.time(end)+1;
                MSSN = Concat(MSSN,MSSN_temp,N_ENG);
                CLTO_i = 1;
            else
                MSSN_temp = stepclimb(t,alt(CL1_ALT_i(j)),alt(CL2_ALT_i(j)),N_ENG...
                    ,climbarr(j,5),climbarr(j,3),climbarr(j,4));%climb()
                t = MSSN_temp.gen.time(end)+1;
                MSSN = Concat(MSSN,MSSN_temp,N_ENG);
            end
            climb_i = climb_i+1;
            %climb()
    elseif strcmp(phaselist(i),'Cruise') == 1
            disp('cruise')
            j = cruise_i;
            MSSN_temp = cruise(t,alt(CR_ALT_i(j)),N_ENG,cruisearr(j,2),cruisearr(j,1)); %cruise()
            t = MSSN_temp.gen.time(end)+1;
            MSSN = Concat(MSSN,MSSN_temp,N_ENG);
            cruise_i = cruise_i+1;
            %cruise()
    elseif strcmp(phaselist(i),'Descent') == 1
        

climbNo = sum(strcmp(phaselist,'Climb'));

   disp('descent')
            j = desc_i;
            MSSN_temp = descent(t,alt(DE1_ALT_i(j)),alt(DE2_ALT_i(j)),N_ENG...
                ,descentarr(j,2),descentarr(j,1));%descent()
            t = MSSN_temp.gen.time(end)+1;
            MSSN = Concat(MSSN,MSSN_temp,N_ENG);
            desc_i = desc_i+1;
            %descent()
    elseif strcmp(phaselist(i),'Loiter') == 1
            disp('loiter')
            j = loiter_i;
            MSSN_temp = loiter(t,alt(LO_ALT_i(j)),N_ENG,loiterarr(j,2),loiterarr(j,1));%loiter()
            t = MSSN_temp.gen.time(end)+1;
            MSSN = Concat(MSSN,MSSN_temp,N_ENG);
            loiter_i = loiter_i+1;
            %loiter()
    elseif strcmp(phaselist(i),'Approach') == 1
            disp('approach')
            j = appr_i;
            MSSN_temp = approach(t,alt(AP1_ALT_i(j)),alt(AP2_ALT_i(j)),N_ENG,approacharr(j,4),...
                approacharr(j,1),approacharr(j,2),approacharr(j,3));%approach()
            t = MSSN_temp.gen.time(end)+1;
            MSSN = Concat(MSSN,MSSN_temp,N_ENG);
            appr_i = appr_i+1;
            %approach()
    elseif strcmp(phaselist(i),'Landing') == 1
            disp('landing')
            j = land_i;
            MSSN_temp = landing(t,alt(AP2_ALT_i(j)),N_ENG,landingarr(j,2),landingarr(j,1));%landing()
            t = MSSN_temp.gen.time(end)+1;
            MSSN = Concat(MSSN,MSSN_temp,N_ENG);
            land_i = land_i+1;
            %landing()
    elseif strcmp(phaselist(i),'Shutdown') == 1
            disp('shutdown')
            j = SD_i;
            MSSN_temp = shutdown(t,alt(SD_ALT_i(j)),N_ENG,shutdownarr(j,3)...
                ,shutdownarr(j,1),shutdownarr(j,2));%shutdown()
            t = MSSN_temp.gen.time(end)+1;
            MSSN = Concat(MSSN,MSSN_temp,N_ENG);
            SD_i = SD_i+1;
            %taxishutdown()
   end
end

end

function Mssn_Param = startup(t_st,TO_alt,N_ENG,thr_set,t_board,Gpower)
startt = 180;
interimt = 5*60;
t_startup = t_st + startt + t_board + interimt;
state_eng = zeros(1,3);
thr_eng = thr_set*ones(1,3);
Mssn_Param.gen.fault=[0,0,0,0];
Mssn_Param.gen.time = [t_st,t_startup]; %time (seconds)
Mssn_Param.gen.state = [1,1]; %mission state

Mssn_Param.cond.time = [t_st,t_startup]; %time (seconds)
Mssn_Param.cond.alt = [TO_alt,TO_alt]; %altitude
Mssn_Param.cond.mach = [0,0]; %mach number

Mssn_Param.eng.time = [t_st,t_st+180,t_startup];%time (seconds)
Mssn_Param.eng.apu = ~Gpower * ones(1,3); %apu on/off is 1 or 0 and the 3rd row;
Mssn_Param.eng.apugen = ~Gpower * ones(1,3); %apu generator on/off is 1 or 0 and the 4th row;
Mssn_Param.eng.aputh = ~Gpower * [0 1 1]; %apu thermal systems on/off is 1 or 0
for n = 1:N_ENG
    eval(['Mssn_Param.eng.Eng' num2str(n) ' = state_eng;']);
    eval(['Mssn_Param.eng.EngThrust' num2str(n) ' = thr_eng;']);
end
for n = 1:2*N_ENG
    eval(['Mssn_Param.eng.Gen' num2str(n) ' = state_eng;']);
end
Mssn_Param.eng.bleed = zeros(1,3); %engine thermal bleed on/off
Mssn_Param.eng.pack = [0,0,0]; %engine Pack on/off

Mssn_Param.el.time = [t_st,t_startup]; %time (seconds)
Mssn_Param.el.navcom = zeros(1,2); %NAV/COMM on/off
Mssn_Param.el.autop = zeros(1,2); %Autopilot on/of
Mssn_Param.el.taxilit = ones(1,2); %Taxi lights on/off
Mssn_Param.el.landinglit = ones(1,2); %landing lights on/off
Mssn_Param.el.flaps = zeros(1,2); %flaps setting in degrees

Mssn_Param.hyd.time = [t_st,t_startup]; %time (seconds)
Mssn_Param.hyd.lndgr = [1,1]; %landing gear up/down

Mssn_Param.pnu.time = [t_st,t_startup]; %time (seconds)
Mssn_Param.pnu.pres = zeros(1,2);  %pressurization on/off
end

function Mssn_Param = taxi(t_st,TO_alt,N_ENG,thr_set,t_taxi,eng_taxi)
t_taxi = t_st + t_taxi;
state_eng = ones(1,2);
thr_eng = thr_set*ones(1,2);
if eng_taxi == 1
    if N_ENG == 2
        taxi_eng_set = [0 1];
    elseif N_ENG == 3
        taxi_eng_set = [0 1 0];
    elseif N_ENG == 4
        taxi_eng_set = [0 1 1 0];
    end
else
    taxi_eng_set = ones(1,N_ENG);
end

Mssn_Param.gen.time = [t_st,t_taxi]; %time (seconds)
Mssn_Param.gen.state = [2,2]; %mission state

Mssn_Param.cond.time = [t_st,t_taxi]; %time (seconds)
Mssn_Param.cond.alt = [TO_alt,TO_alt]; %altitude
Mssn_Param.cond.mach = [.02,.02]; %mach number

Mssn_Param.eng.time = [t_st,t_taxi];%time (seconds)
Mssn_Param.eng.apu = zeros(1,2); %apu on/off is 1 or 0 and the 3rd row;
Mssn_Param.eng.apugen = zeros(1,2); %apu generator on/off is 1 or 0 and the 4th row;
Mssn_Param.eng.aputh = zeros(1,2); %apu thermal systems on/off is 1 or 0
for n = 1:N_ENG
    eval(['Mssn_Param.eng.Eng' num2str(n) ' = taxi_eng_set(n)*state_eng;']);
    eval(['Mssn_Param.eng.EngThrust' num2str(n) ' = taxi_eng_set(n)*thr_eng;']);
end
for n = 1:2*N_ENG
    eval(['Mssn_Param.eng.Gen' num2str(n) ' = taxi_eng_set(ceil(n/2))*state_eng;']);
end

Mssn_Param.eng.bleed = ones(1,2); %engine thermal bleed on/off
Mssn_Param.eng.pack = [1,1]; %engine Pack on/off

Mssn_Param.el.time = [t_st,t_taxi]; %time (seconds)
Mssn_Param.el.navcom = ones(1,2); %NAV/COMM on/off
Mssn_Param.el.autop = zeros(1,2); %Autopilot on/of
Mssn_Param.el.taxilit = ones(1,2); %Taxi lights on/off
Mssn_Param.el.landinglit = ones(1,2); %landing lights on/off
Mssn_Param.el.flaps = zeros(1,2); %flaps setting in degrees

Mssn_Param.hyd.time = [t_st,t_taxi]; %time (seconds)
Mssn_Param.hyd.lndgr = [1,1]; %landing gear up/down

Mssn_Param.pnu.time = [t_st,t_taxi]; %time (seconds)
Mssn_Param.pnu.pres = zeros(1,2);  %pressurization on/off
end

function Mssn_Param = takeoff(t_st,TO_alt,N_ENG,thr_set,flapset,t_TOrun)
t_TO = t_st + t_TOrun;
state_eng = ones(1,2);
thr_eng = thr_set*ones(1,2);

Mssn_Param.gen.time = [t_st,t_TO]; %time (seconds)
Mssn_Param.gen.state = [3,3]; %mission state

Mssn_Param.cond.time = [t_st,t_TO]; %time (seconds)
Mssn_Param.cond.alt = [TO_alt,TO_alt]; %altitude
Mssn_Param.cond.mach = [.02,.2]; %mach number

Mssn_Param.eng.time = [t_st,t_TO];%time (seconds)
Mssn_Param.eng.apu = zeros(1,2); %apu on/off is 1 or 0 and the 3rd row;
Mssn_Param.eng.apugen = zeros(1,2); %apu generator on/off is 1 or 0 and the 4th row;
Mssn_Param.eng.aputh = zeros(1,2); %apu thermal systems on/off is 1 or 0
for n = 1:N_ENG
    eval(['Mssn_Param.eng.Eng' num2str(n) ' = state_eng;']);
    eval(['Mssn_Param.eng.EngThrust' num2str(n) ' = thr_eng;']);
end
for n = 1:2*N_ENG
    eval(['Mssn_Param.eng.Gen' num2str(n) ' = state_eng;']);
end
Mssn_Param.eng.bleed = ones(1,2); %engine thermal bleed on/off
if thr_set > 91
    Mssn_Param.eng.pack = [0,0]; %engine Pack on/off
else
    Mssn_Param.eng.pack = [1,1]; %engine Pack on/off
end

Mssn_Param.el.time = [t_st,t_TO]; %time (seconds)
Mssn_Param.el.navcom = ones(1,2); %NAV/COMM on/off
Mssn_Param.el.autop = zeros(1,2); %Autopilot on/of
Mssn_Param.el.taxilit = ones(1,2); %Taxi lights on/off
Mssn_Param.el.landinglit = ones(1,2); %landing lights on/off
Mssn_Param.el.flaps = flapset * ones(1,2); %flaps setting in degrees

Mssn_Param.hyd.time = [t_st,t_TO]; %time (seconds)
Mssn_Param.hyd.lndgr = [1,1]; %landing gear up/down

Mssn_Param.pnu.time = [t_st,t_TO]; %time (seconds)
Mssn_Param.pnu.pres = zeros(1,2);  %pressurization on/off
end

function Mssn_Param = climb(t_st,TO_alt,C_alt,N_ENG,thr_set,TO_set,flapset,climb_rate,cl_set)
climb_alt = C_alt-TO_alt;
t_climb = t_st + floor((climb_alt/climb_rate)*60);
t_flapup = t_st + floor((400/climb_rate)*60);
t_pres = t_st + (floor(5*rand+10)*60);
t_10k = t_st + floor(((10000-TO_alt)/climb_rate)*60);
state_eng = ones(1,3);
thr_eng = thr_set*ones(1,3);

Mssn_Param.gen.time = [t_st,t_climb]; %time (seconds)
Mssn_Param.gen.state = [4,4]; %mission state

Mssn_Param.cond.time = [t_st,t_climb]; %time (seconds)
Mssn_Param.cond.alt = [TO_alt, C_alt]; %altitude
Mssn_Param.cond.mach = [.2,.75]; %mach number

Mssn_Param.eng.time = [t_st,t_flapup,t_climb];%time (seconds)
Mssn_Param.eng.apu = zeros(1,3); %apu on/off is 1 or 0 and the 3rd row;
Mssn_Param.eng.apugen = zeros(1,3); %apu generator on/off is 1 or 0 and the 4th row;
Mssn_Param.eng.aputh = zeros(1,3); %apu thermal systems on/off is 1 or 0
for n = 1:N_ENG
    eval(['Mssn_Param.eng.Eng' num2str(n) ' = state_eng;']);
    eval(['Mssn_Param.eng.EngThrust' num2str(n) ' = thr_eng;']);
end
for n = 1:2*N_ENG
    eval(['Mssn_Param.eng.Gen' num2str(n) ' = state_eng;']);
end
Mssn_Param.eng.bleed = ones(1,3); %engine thermal bleed on/off
Mssn_Param.eng.pack = [TO_set,1,1]; %engine Pack on/off
if t_10k < t_climb
    Mssn_Param.el.time = [t_st,t_flapup,t_10k,t_climb]; %time (seconds)
    Mssn_Param.el.navcom = ones(1,4); %NAV/COMM on/off
    Mssn_Param.el.autop = cl_set * ones(1,4); %Autopilot on/of
    Mssn_Param.el.taxilit = zeros(1,4); %Taxi lights on/off
    Mssn_Param.el.landinglit = [1,1,0,0]; %landing lights on/off
    Mssn_Param.el.flaps = [flapset,0,0,0]; %flaps setting in degrees
else
    Mssn_Param.el.time = [t_st,t_flapup,t_climb]; %time (seconds)
    Mssn_Param.el.navcom = ones(1,3); %NAV/COMM on/off
    Mssn_Param.el.autop = cl_set * ones(1,3); %Autopilot on/of
    Mssn_Param.el.taxilit = zeros(1,3); %Taxi lights on/off
    Mssn_Param.el.landinglit = [1,1,1]; %landing lights on/off
    Mssn_Param.el.flaps = [flapset,0,0]; %flaps setting in degrees
end

Mssn_Param.hyd.time = [t_st,t_climb]; %time (seconds)
Mssn_Param.hyd.lndgr = [0,0]; %landing gear up/down

Mssn_Param.pnu.time = [t_st,t_pres,t_climb]; %time (seconds)
Mssn_Param.pnu.pres = [0,1,1];  %pressurization on/off

end

function Mssn_Param = stepclimb(t_st,Start_alt,C_alt,N_ENG,thr_set,climb_rate,cl_set)
climb_alt = C_alt-Start_alt;
t_climb = t_st + floor((climb_alt/climb_rate)*60);
t_10k = t_st + floor(((10000-Start_alt)/climb_rate)*60);
state_eng = ones(1,2);
thr_eng = thr_set*ones(1,2);

Mssn_Param.gen.time = [t_st,t_climb]; %time (seconds)
Mssn_Param.gen.state = [4,4]; %mission state

Mssn_Param.cond.time = [t_st,t_climb]; %time (seconds)
Mssn_Param.cond.alt = [Start_alt, C_alt]; %altitude
Mssn_Param.cond.mach = [.75,.75]; %mach number

Mssn_Param.eng.time = [t_st,t_climb];%time (seconds)
Mssn_Param.eng.apu = zeros(1,2); %apu on/off is 1 or 0 and the 3rd row;
Mssn_Param.eng.apugen = zeros(1,2); %apu generator on/off is 1 or 0 and the 4th row;
Mssn_Param.eng.aputh = zeros(1,2); %apu thermal systems on/off is 1 or 0
for n = 1:N_ENG
    eval(['Mssn_Param.eng.Eng' num2str(n) ' = state_eng;']);
    eval(['Mssn_Param.eng.EngThrust' num2str(n) ' = thr_eng;']);
end
for n = 1:2*N_ENG
    eval(['Mssn_Param.eng.Gen' num2str(n) ' = state_eng;']);
end
Mssn_Param.eng.bleed = ones(1,2); %engine thermal bleed on/off
Mssn_Param.eng.pack = [1,1]; %engine Pack on/off

if t_10k < t_st
    Mssn_Param.el.time = [t_st,t_climb]; %time (seconds)
    Mssn_Param.el.navcom = ones(1,2); %NAV/COMM on/off
    Mssn_Param.el.autop = cl_set * ones(1,2); %Autopilot on/of
    Mssn_Param.el.taxilit = zeros(1,2); %Taxi lights on/off
    Mssn_Param.el.landinglit = zeros(1,2); %landing lights on/off
    Mssn_Param.el.flaps = zeros(1,2); %flaps setting in degrees
else
    Mssn_Param.el.time = [t_st,t_10k,t_climb]; %time (seconds)
    Mssn_Param.el.navcom = ones(1,3); %NAV/COMM on/off
    Mssn_Param.el.autop = cl_set * ones(1,2); %Autopilot on/of
    Mssn_Param.el.taxilit = zeros(1,3); %Taxi lights on/off
    Mssn_Param.el.landinglit = [1 0 0]; %landing lights on/off
    Mssn_Param.el.flaps = zeros(1,3); %flaps setting in degrees
end

Mssn_Param.hyd.time = [t_st,t_climb]; %time (seconds)
Mssn_Param.hyd.lndgr = [0,0]; %landing gear up/down

Mssn_Param.pnu.time = [t_st,t_climb]; %time (seconds)
Mssn_Param.pnu.pres = [1,1];  %pressurization on/off

end

function Mssn_Param = cruise(t_st,C_alt,N_ENG,thr_set,t_cruise)
t_cruise = t_st + t_cruise;
state_eng = ones(1,2);
thr_eng = thr_set*ones(1,2);

Mssn_Param.gen.time = [t_st,t_cruise]; %time (seconds)
Mssn_Param.gen.state = [5,5]; %mission state

Mssn_Param.cond.time = [t_st,t_cruise]; %time (seconds)
Mssn_Param.cond.alt = [C_alt,C_alt]; %altitude
Mssn_Param.cond.mach = [.75,.75]; %mach number

Mssn_Param.eng.time = [t_st,t_cruise];%time (seconds)
Mssn_Param.eng.apu = zeros(1,2); %apu on/off is 1 or 0 and the 3rd row;
Mssn_Param.eng.apugen = zeros(1,2); %apu generator on/off is 1 or 0 and the 4th row;
Mssn_Param.eng.aputh = zeros(1,2); %apu thermal systems on/off is 1 or 0
for n = 1:N_ENG
    eval(['Mssn_Param.eng.Eng' num2str(n) ' = state_eng;']);
    eval(['Mssn_Param.eng.EngThrust' num2str(n) ' = thr_eng;']);
end
for n = 1:2*N_ENG
    eval(['Mssn_Param.eng.Gen' num2str(n) ' = state_eng;']);
end
Mssn_Param.eng.bleed = ones(1,2); %engine thermal bleed on/off
Mssn_Param.eng.pack = [1,1]; %engine Pack on/off

Mssn_Param.el.time = [t_st,t_cruise]; %time (seconds)
Mssn_Param.el.navcom = ones(1,2); %NAV/COMM on/off
Mssn_Param.el.autop = ones(1,2); %Autopilot on/of
Mssn_Param.el.taxilit = zeros(1,2); %Taxi lights on/off
Mssn_Param.el.landinglit = zeros(1,2); %landing lights on/off
Mssn_Param.el.flaps = zeros(1,2); %flaps setting in degrees

Mssn_Param.hyd.time = [t_st,t_cruise]; %time (seconds)
Mssn_Param.hyd.lndgr = [0,0]; %landing gear up/down

Mssn_Param.pnu.time = [t_st,t_cruise]; %time (seconds)
Mssn_Param.pnu.pres = ones(1,2);  %pressurization on/off
end

function Mssn_Param = descent(t_st,C_alt,end_alt,N_ENG,thr_set,desc_rate)
desc_alt = C_alt-end_alt;
t_desc = t_st + floor((desc_alt/desc_rate)*60);
t_10k = t_st + floor(((C_alt-10000)/desc_rate)*60);
state_eng = ones(1,2);
thr_eng = thr_set*ones(1,2);

Mssn_Param.gen.time = [t_st,t_desc]; %time (seconds)
Mssn_Param.gen.state = [6,6]; %mission state

Mssn_Param.cond.time = [t_st,t_desc]; %time (seconds)
Mssn_Param.cond.alt = [C_alt,end_alt]; %altitude
Mssn_Param.cond.mach = [.75,.3]; %mach number

Mssn_Param.eng.time = [t_st,t_desc];%time (seconds)
Mssn_Param.eng.apu = zeros(1,2); %apu on/off is 1 or 0 and the 3rd row;
Mssn_Param.eng.apugen = zeros(1,2); %apu generator on/off is 1 or 0 and the 4th row;
Mssn_Param.eng.aputh = zeros(1,2); %apu thermal systems on/off is 1 or 0
for n = 1:N_ENG
    eval(['Mssn_Param.eng.Eng' num2str(n) ' = state_eng;']);
    eval(['Mssn_Param.eng.EngThrust' num2str(n) ' = thr_eng;']);
end
for n = 1:2*N_ENG
    eval(['Mssn_Param.eng.Gen' num2str(n) ' = state_eng;']);
end
Mssn_Param.eng.bleed = ones(1,2); %engine thermal bleed on/off
Mssn_Param.eng.pack = [1,1]; %engine Pack on/off

if t_10k < t_desc
    Mssn_Param.el.time = [t_st,t_10k,t_desc]; %time (seconds)
    Mssn_Param.el.navcom = ones(1,3); %NAV/COMM on/off
    Mssn_Param.el.autop = ones(1,3); %Autopilot on/of
    Mssn_Param.el.taxilit = zeros(1,3); %Taxi lights on/off
    Mssn_Param.el.landinglit = [0 1 1]; %landing lights on/off
    Mssn_Param.el.flaps = zeros(1,3); %flaps setting in degrees
else
    Mssn_Param.el.time = [t_st,t_desc]; %time (seconds)
    Mssn_Param.el.navcom = ones(1,2); %NAV/COMM on/off
    Mssn_Param.el.autop = ones(1,2); %Autopilot on/of
    Mssn_Param.el.taxilit = zeros(1,2); %Taxi lights on/off
    Mssn_Param.el.landinglit = zeros(1,2); %landing lights on/off
    Mssn_Param.el.flaps = zeros(1,2); %flaps setting in degrees
end

Mssn_Param.hyd.time = [t_st,t_desc]; %time (seconds)
Mssn_Param.hyd.lndgr = [0,0]; %landing gear up/down

Mssn_Param.pnu.time = [t_st,t_desc]; %time (seconds)
Mssn_Param.pnu.pres = ones(1,2);  %pressurization on/off
end

function Mssn_Param = loiter(t_st,Lo_alt,N_ENG,thr_set,t_loit)
t_loit = t_st + t_loit;
state_eng = ones(1,2);
thr_eng = thr_set*ones(1,2);

Mssn_Param.gen.time = [t_st,t_loit]; %time (seconds)
Mssn_Param.gen.state = [7,7]; %mission state

Mssn_Param.cond.time = [t_st,t_loit]; %time (seconds)
Mssn_Param.cond.alt = [Lo_alt,Lo_alt]; %altitude
Mssn_Param.cond.mach = [.3,.3]; %mach number

Mssn_Param.eng.time = [t_st,t_loit];%time (seconds)
Mssn_Param.eng.apu = zeros(1,2); %apu on/off is 1 or 0 and the 3rd row;
Mssn_Param.eng.apugen = zeros(1,2); %apu generator on/off is 1 or 0 and the 4th row;
Mssn_Param.eng.aputh = zeros(1,2); %apu thermal systems on/off is 1 or 0
for n = 1:N_ENG
    eval(['Mssn_Param.eng.Eng' num2str(n) ' = state_eng;']);
    eval(['Mssn_Param.eng.EngThrust' num2str(n) ' = thr_eng;']);
end
for n = 1:2*N_ENG
    eval(['Mssn_Param.eng.Gen' num2str(n) ' = state_eng;']);
end
Mssn_Param.eng.bleed = ones(1,2); %engine thermal bleed on/off
Mssn_Param.eng.pack = [1,1]; %engine Pack on/off

Mssn_Param.el.time = [t_st,t_loit]; %time (seconds)
Mssn_Param.el.navcom = ones(1,2); %NAV/COMM on/off
Mssn_Param.el.autop = ones(1,2); %Autopilot on/of
Mssn_Param.el.taxilit = zeros(1,2); %Taxi lights on/off
Mssn_Param.el.landinglit = ones(1,2); %landing lights on/off
Mssn_Param.el.flaps = zeros(1,2); %flaps setting in degrees

Mssn_Param.hyd.time = [t_st,t_loit]; %time (seconds)
Mssn_Param.hyd.lndgr = [0,0]; %landing gear up/down

Mssn_Param.pnu.time = [t_st,t_loit]; %time (seconds)
Mssn_Param.pnu.pres = ones(1,2);  %pressurization on/off
end

function Mssn_Param = approach(t_st,Lo_alt,Lnd_alt,N_ENG,thr_set,app_desc,flapset1,flapset2)
t_app = t_st+floor(((Lo_alt-Lnd_alt)/app_desc)*60);
t_lndgr = (t_app-120);
state_eng = ones(1,2);
thr_eng = thr_set*ones(1,2);

Mssn_Param.gen.time = [t_st,t_app]; %time (seconds)
Mssn_Param.gen.state = [8,8]; %mission state

Mssn_Param.cond.time = [t_st,t_app]; %time (seconds)
Mssn_Param.cond.alt = [Lo_alt, Lnd_alt]; %altitude
Mssn_Param.cond.mach = [.3,.27]; %mach number

Mssn_Param.eng.time = [t_st,t_app];%time (seconds)
Mssn_Param.eng.apu = [0,0]; %apu on/off is 1 or 0 and the 3rd row;
Mssn_Param.eng.apugen = [0,0]; %apu generator on/off is 1 or 0 and the 4th row;
Mssn_Param.eng.aputh = [0,0]; %apu thermal systems on/off is 1 or 0
for n = 1:N_ENG
    eval(['Mssn_Param.eng.Eng' num2str(n) ' = state_eng;']);
    eval(['Mssn_Param.eng.EngThrust' num2str(n) ' = thr_eng;']);
end
for n = 1:2*N_ENG
    eval(['Mssn_Param.eng.Gen' num2str(n) ' = state_eng;']);
end
Mssn_Param.eng.bleed = [1,1]; %engine thermal bleed on/off
Mssn_Param.eng.pack = [1,1]; %engine Pack on/off

Mssn_Param.el.time = [t_st,t_lndgr,t_app]; %time (seconds)
Mssn_Param.el.navcom = ones(1,3); %NAV/COMM on/off
Mssn_Param.el.autop = zeros(1,3); %Autopilot on/of
Mssn_Param.el.taxilit = zeros(1,3); %Taxi lights on/off
Mssn_Param.el.landinglit = ones(1,3); %landing lights on/off
Mssn_Param.el.flaps = [flapset1,flapset2,flapset2]; %flaps setting in degrees

Mssn_Param.hyd.time = [t_st,t_lndgr,t_app]; %time (seconds)
Mssn_Param.hyd.lndgr = [0,1,1]; %landing gear up/down

Mssn_Param.pnu.time = [t_st,t_app]; %time (seconds)
Mssn_Param.pnu.pres = [1,1];  %pressurization on/off

end

function Mssn_Param = landing(t_st,Lnd_alt,N_ENG,thr_set,flapset)
t_lnd = t_st + 40;
state_eng = ones(1,2);
thr_eng = thr_set*ones(1,2);

Mssn_Param.gen.time = [t_st,t_lnd]; %time (seconds)
Mssn_Param.gen.state = [9,9]; %mission state

Mssn_Param.cond.time = [t_st,t_lnd]; %time (seconds)
Mssn_Param.cond.alt = [Lnd_alt,Lnd_alt]; %altitude
Mssn_Param.cond.mach = [.27,.02]; %mach number

Mssn_Param.eng.time = [t_st,t_lnd];%time (seconds)
Mssn_Param.eng.apu = zeros(1,2); %apu on/off is 1 or 0 and the 3rd row;
Mssn_Param.eng.apugen = zeros(1,2); %apu generator on/off is 1 or 0 and the 4th row;
Mssn_Param.eng.aputh = zeros(1,2); %apu thermal systems on/off is 1 or 0
for n = 1:N_ENG
    eval(['Mssn_Param.eng.Eng' num2str(n) ' = state_eng;']);
    eval(['Mssn_Param.eng.EngThrust' num2str(n) ' = thr_eng;']);
end
for n = 1:2*N_ENG
    eval(['Mssn_Param.eng.Gen' num2str(n) ' = state_eng;']);
end
Mssn_Param.eng.bleed = ones(1,2); %engine thermal bleed on/off
Mssn_Param.eng.pack = [1,1]; %engine Pack on/off

Mssn_Param.el.time = [t_st,t_lnd]; %time (seconds)
Mssn_Param.el.navcom = ones(1,2); %NAV/COMM on/off
Mssn_Param.el.autop = zeros(1,2); %Autopilot on/of
Mssn_Param.el.taxilit = ones(1,2); %Taxi lights on/off
Mssn_Param.el.landinglit = ones(1,2); %landing lights on/off
Mssn_Param.el.flaps = flapset * ones(1,2); %flaps setting in degrees

Mssn_Param.hyd.time = [t_st,t_lnd]; %time (seconds)
Mssn_Param.hyd.lndgr = [1,1]; %landing gear up/down

Mssn_Param.pnu.time = [t_st,t_lnd]; %time (seconds)
Mssn_Param.pnu.pres = zeros(1,2);  %pressurization on/off
end

function Mssn_Param = shutdown(t_st,Lnd_alt,N_ENG,thr_set,t_deboard,Gpower)
t_deboard = t_st + t_deboard;
state_eng = zeros(1,2);
thr_eng = thr_set*ones(1,2);

Mssn_Param.gen.time = [t_st,t_deboard]; %time (seconds)
Mssn_Param.gen.state = [10,10]; %mission state

Mssn_Param.cond.time = [t_st,t_deboard]; %time (seconds)
Mssn_Param.cond.alt = [Lnd_alt,Lnd_alt]; %altitude
Mssn_Param.cond.mach = [0,0]; %mach number

Mssn_Param.eng.time = [t_st,t_deboard];%time (seconds)
Mssn_Param.eng.apu = ~Gpower * ones(1,2); %apu on/off is 1 or 0 and the 3rd row;
Mssn_Param.eng.apugen = ~Gpower * ones(1,2); %apu generator on/off is 1 or 0 and the 4th row;
Mssn_Param.eng.aputh = ~Gpower * ones(1,2); %apu thermal systems on/off is 1 or 0
for n = 1:N_ENG
    eval(['Mssn_Param.eng.Eng' num2str(n) ' = state_eng;']);
    eval(['Mssn_Param.eng.EngThrust' num2str(n) ' = thr_eng;']);
end
for n = 1:2*N_ENG
    eval(['Mssn_Param.eng.Gen' num2str(n) ' = state_eng;']);
end
Mssn_Param.eng.bleed = zeros(1,2); %engine thermal bleed on/off
Mssn_Param.eng.pack = [0,0]; %engine Pack on/off

Mssn_Param.el.time = [t_st,t_deboard]; %time (seconds)
Mssn_Param.el.navcom = ones(1,2); %NAV/COMM on/off
Mssn_Param.el.autop = zeros(1,2); %Autopilot on/of
Mssn_Param.el.taxilit = ones(1,2); %Taxi lights on/off
Mssn_Param.el.landinglit = ones(1,2); %landing lights on/off
Mssn_Param.el.flaps = zeros(1,2); %flaps setting in degrees

Mssn_Param.hyd.time = [t_st,t_deboard]; %time (seconds)
Mssn_Param.hyd.lndgr = [1,1]; %landing gear up/down

Mssn_Param.pnu.time = [t_st,t_deboard]; %time (seconds)
Mssn_Param.pnu.pres = zeros(1,2);  %pressurization on/off
end

function Mssn_Param = Concat(Mssn_Param1,Mssn_Param2,N_ENG)

Mssn_Param.gen.time = [Mssn_Param1.gen.time,Mssn_Param2.gen.time]; %time (seconds)
Mssn_Param.gen.state = [Mssn_Param1.gen.state,Mssn_Param2.gen.state]; %mission state

Mssn_Param.cond.time = [Mssn_Param1.cond.time,Mssn_Param2.cond.time]; %time (seconds)
Mssn_Param.cond.alt = [Mssn_Param1.cond.alt,Mssn_Param2.cond.alt]; %altitude
Mssn_Param.cond.mach = [Mssn_Param1.cond.mach,Mssn_Param2.cond.mach]; %mach number

Mssn_Param.eng.time = [Mssn_Param1.eng.time,Mssn_Param2.eng.time];%time (seconds)
Mssn_Param.eng.apu = [Mssn_Param1.eng.apu,Mssn_Param2.eng.apu]; %apu on/off is 1 or 0 and the 3rd row;
Mssn_Param.eng.apugen = [Mssn_Param1.eng.apugen,Mssn_Param2.eng.apugen]; %apu generator on/off is 1 or 0 and the 4th row;
Mssn_Param.eng.aputh = [Mssn_Param1.eng.aputh,Mssn_Param2.eng.aputh]; %apu thermal systems on/off is 1 or 0
for n = 1:N_ENG
    eval(['Mssn_Param.eng.Eng' num2str(n)...
        ' = [Mssn_Param1.eng.Eng' num2str(n) ',Mssn_Param2.eng.Eng' num2str(n) '];']);
    eval(['Mssn_Param.eng.EngThrust' num2str(n)...
        ' = [Mssn_Param1.eng.EngThrust' num2str(n) ',Mssn_Param2.eng.EngThrust' num2str(n) '];']);
end
for n = 1:2*N_ENG
    eval(['Mssn_Param.eng.Gen' num2str(n)...
        ' = [Mssn_Param1.eng.Gen' num2str(n) ',Mssn_Param2.eng.Gen' num2str(n) '];']);
end
Mssn_Param.eng.bleed = [Mssn_Param1.eng.bleed,Mssn_Param2.eng.bleed]; %engine thermal bleed on/off
Mssn_Param.eng.pack = [Mssn_Param1.eng.pack,Mssn_Param2.eng.pack]; %engine Pack on/off

Mssn_Param.el.time = [Mssn_Param1.el.time,Mssn_Param2.el.time]; %time (seconds)
Mssn_Param.el.navcom = [Mssn_Param1.el.navcom,Mssn_Param2.el.navcom]; %NAV/COMM on/off
Mssn_Param.el.autop = [Mssn_Param1.el.autop,Mssn_Param2.el.autop]; %Autopilot on/of
Mssn_Param.el.taxilit = [Mssn_Param1.el.taxilit,Mssn_Param2.el.taxilit]; %Taxi lights on/off
Mssn_Param.el.landinglit = [Mssn_Param1.el.landinglit,Mssn_Param2.el.landinglit]; %landing lights on/off
Mssn_Param.el.flaps = [Mssn_Param1.el.flaps,Mssn_Param2.el.flaps]; %flaps setting in degrees

Mssn_Param.hyd.time = [Mssn_Param1.hyd.time,Mssn_Param2.hyd.time]; %time (seconds)
Mssn_Param.hyd.lndgr = [Mssn_Param1.hyd.lndgr,Mssn_Param2.hyd.lndgr]; %landing gear up/down

Mssn_Param.pnu.time = [Mssn_Param1.pnu.time,Mssn_Param2.pnu.time]; %time (seconds)
Mssn_Param.pnu.pres = [Mssn_Param1.pnu.pres,Mssn_Param2.pnu.pres];  %pressurization on/off
end


