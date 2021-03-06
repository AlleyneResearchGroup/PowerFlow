function [MSSN_out] = LandingFail(MSSN,M,CruiseTime,CruiseThrust,DescentRate,DescentThrust,ApproachDescentRate,ApproachThrust,LandingThrust,ApproachAlt,LandingAlt,Flap1,Flap2)
t_fail=MSSN.gen.faults(1);

fail=MSSN.gen.faults(2);
fail_loc=MSSN.gen.faults(3);
T_mult=MSSN.gen.faults(4);
LandData=MSSN.gen.faults(5);

t_ind = find(MSSN.eng.time > MSSN.gen.faults(1),1,'first')
t_ind_cond = find(MSSN.cond.time > MSSN.gen.faults(1),1,'first');
t_ind_gen = find(MSSN.gen.time > MSSN.gen.faults(1),1,'first');
t_ind_pnu=find(MSSN.gen.time>MSSN.gen.faults(1),1,'first');


GroundPower=1;
%MSSN.gen.time=[MSSN.eng.time(1:t_ind-1), t_fail, MSSN.eng.time(t_ind:end)];%time (seconds)
MSSN.eng.apu = [MSSN.eng.apu(1:t_ind-1), 0, MSSN.eng.apu(t_ind:end)]; %apu on/off is 1 or 0 and the 3rd row;
MSSN.eng.apugen = [MSSN.eng.apugen(1:t_ind-1), 0, MSSN.eng.apugen(t_ind:end)]; %apu generator on/off is 1 or 0 and the 4th row;
MSSN.eng.aputh = [MSSN.eng.aputh(1:t_ind-1), 0, MSSN.eng.aputh(t_ind:end)];%apu thermal systems on/off is 1 or 0
th = MSSN.eng.EngThrust1(t_ind-1);
t_descend=t_fail+(CruiseTime*60);
C_alt=MSSN.cond.alt(t_ind_cond);
Cur_state=MSSN.gen.state(t_ind_gen);
Cur_pres=MSSN.pnu.pres(t_ind_pnu);
N_ENG=MSSN.gen.N_ENG;

%This FOR loop builds the mission after the fault. This includes
%cruise,descent,approach,landing,shutdown.
for ind=1:5
    if ind==1
        t_cruise = t_fail + (CruiseTime)*60;
        state_eng_cruise = ones(1,2);
        thr_eng = CruiseThrust*ones(1,2);

        Mssn_Cruise.gen.time = [t_fail+1,t_cruise]; %time (seconds)
        Mssn_Cruise.gen.state = [5,5]; %mission state
    
        Mssn_Cruise.cond.time = [t_fail+1,t_cruise]; %time (seconds)
        Mssn_Cruise.cond.alt = [C_alt,C_alt]; %altitude
        Mssn_Cruise.cond.mach = [.75,.75]; %mach number

        Mssn_Cruise.eng.time = [t_fail+1,t_cruise];%time (seconds)
        Mssn_Cruise.eng.apu = zeros(1,2); %apu on/off is 1 or 0 and the 3rd row;
        Mssn_Cruise.eng.apugen = zeros(1,2); %apu generator on/off is 1 or 0 and the 4th row;
        Mssn_Cruise.eng.aputh = zeros(1,2); %apu thermal systems on/off is 1 or 0


        Mssn_Cruise.eng.bleed = ones(1,2); %engine thermal bleed on/off
        Mssn_Cruise.eng.pack = [1,1]; %engine Pack on/off

        Mssn_Cruise.el.time = [t_fail,t_cruise]; %time (seconds)
        Mssn_Cruise.el.navcom = ones(1,2); %NAV/COMM on/off
        Mssn_Cruise.el.autop = ones(1,2); %Autopilot on/of
        Mssn_Cruise.el.taxilit = zeros(1,2); %Taxi lights on/off
        Mssn_Cruise.el.landinglit = zeros(1,2); %landing lights on/off
        Mssn_Cruise.el.flaps = zeros(1,2); %flaps setting in degrees

        Mssn_Cruise.hyd.time = [t_fail,t_cruise]; %time (seconds)
        Mssn_Cruise.hyd.lndgr = [0,0]; %landing gear up/down

        Mssn_Cruise.pnu.time = [t_fail,t_cruise]; %time (seconds)
        Mssn_Cruise.pnu.pres = ones(1,2);  %pressurization on/off
    elseif ind==2
       state_eng_descent=ones(1,2);
        end_alt=ApproachAlt;
       desc_rate=DescentRate;
        desc_alt = C_alt-end_alt;
        t_desc = t_cruise + abs(floor((desc_alt/desc_rate)*60));
        
        t_10k = t_cruise +  floor(((C_alt-10000)/desc_rate)*60);
        state_eng = ones(1,2);
        thr_eng = DescentThrust*ones(1,2);

        Mssn_descent.gen.time = [t_cruise+1,t_desc]; %time (seconds)
        Mssn_descent.gen.state = [6,6]; %mission state

        Mssn_descent.cond.time = [t_cruise+1,t_desc]; %time (seconds)
        Mssn_descent.cond.alt = [C_alt,ApproachAlt]; %altitude
        Mssn_descent.cond.mach = [.75,.3]; %mach number

        Mssn_descent.eng.time = [t_cruise+1,t_desc];%time (seconds)
        Mssn_descent.eng.apu = zeros(1,2); %apu on/off is 1 or 0 and the 3rd row;
        Mssn_descent.eng.apugen = zeros(1,2); %apu generator on/off is 1 or 0 and the 4th row;
        Mssn_descent.eng.aputh = zeros(1,2); %apu thermal systems on/off is 1 or 0

        Mssn_descent.eng.bleed = ones(1,2); %engine thermal bleed on/off
        Mssn_descent.eng.pack = [1,1]; %engine Pack on/off

        if t_10k < t_desc
            Mssn_descent.el.time = [t_cruise+1,t_10k,t_desc]; %time (seconds)
            Mssn_descent.el.navcom = ones(1,3); %NAV/COMM on/off
            Mssn_descent.el.autop = ones(1,3); %Autopilot on/of
            Mssn_descent.el.taxilit = zeros(1,3); %Taxi lights on/off
            Mssn_descent.el.landinglit = [0 1 1]; %landing lights on/off
            Mssn_descent.el.flaps = zeros(1,3); %flaps setting in degrees
        else
        
            Mssn_descent.el.time = [t_cruise+1,t_desc]; %time (seconds)
            Mssn_descent.el.navcom = ones(1,2); %NAV/COMM on/off
            Mssn_descent.el.autop = ones(1,2); %Autopilot on/of
            Mssn_descent.el.taxilit = zeros(1,2); %Taxi lights on/off
            Mssn_descent.el.landinglit = zeros(1,2); %landing lights on/off
            Mssn_descent.el.flaps = zeros(1,2); %flaps setting in degrees
        end

        Mssn_descent.hyd.time = [t_cruise+1,t_desc]; %time (seconds)
        Mssn_descent.hyd.lndgr = [0,0]; %landing gear up/down

        Mssn_descent.pnu.time = [t_cruise+1,t_desc]; %time (seconds)
        Mssn_descent.pnu.pres = ones(1,2);  %pressurization on/off
    elseif ind==3;
        t_app = t_desc+floor(((ApproachAlt-LandingAlt)/ApproachDescentRate)*60);
t_lndgr = (t_app-120);
state_eng_approach = ones(1,2);
thr_eng = ApproachThrust*ones(1,2);

Mssn_approach.gen.time = [t_desc+1,t_app]; %time (seconds)
Mssn_approach.gen.state = [8,8]; %mission state

Mssn_approach.cond.time = [t_desc+1,t_app]; %time (seconds)
Mssn_approach.cond.alt = [ApproachAlt, LandingAlt]; %altitude
Mssn_approach.cond.mach = [.3,.27]; %mach number

Mssn_approach.eng.time = [t_desc+1,t_app];%time (seconds)
Mssn_approach.eng.apu = [0,0]; %apu on/off is 1 or 0 and the 3rd row;
Mssn_approach.eng.apugen = [0,0]; %apu generator on/off is 1 or 0 and the 4th row;
Mssn_approach.eng.aputh = [0,0]; %apu thermal systems on/off is 1 or 0

Mssn_approach.eng.bleed = [1,1]; %engine thermal bleed on/off
Mssn_approach.eng.pack = [1,1]; %engine Pack on/off

Mssn_approach.el.time = [t_desc+1,t_lndgr,t_app]; %time (seconds)
Mssn_approach.el.navcom = ones(1,3); %NAV/COMM on/off
Mssn_approach.el.autop = zeros(1,3); %Autopilot on/of
Mssn_approach.el.taxilit = zeros(1,3); %Taxi lights on/off
Mssn_approach.el.landinglit = ones(1,3); %landing lights on/off
Mssn_approach.el.flaps = [Flap1,Flap2,Flap2]; %flaps setting in degrees

Mssn_approach.hyd.time = [t_desc+1,t_lndgr,t_app]; %time (seconds)
Mssn_approach.hyd.lndgr = [0,1,1]; %landing gear up/down

Mssn_approach.pnu.time = [t_desc+1,t_app]; %time (seconds)
Mssn_approach.pnu.pres = [1,1];  %pressurization on/off
    elseif ind==4
      t_lnd = t_app + 40;
state_eng_landing = ones(1,2);
thr_eng = LandingThrust*ones(1,2);

Mssn_landing.gen.time = [t_app+1,t_lnd]; %time (seconds)
Mssn_landing.gen.state = [9,9]; %mission state

Mssn_landing.cond.time = [t_app+1,t_lnd]; %time (seconds)
Mssn_landing.cond.alt = [LandingAlt,LandingAlt]; %altitude
Mssn_landing.cond.mach = [.27,.02]; %mach number

Mssn_landing.eng.time = [t_app+1,t_lnd];%time (seconds)
Mssn_landing.eng.apu = zeros(1,2); %apu on/off is 1 or 0 and the 3rd row;
Mssn_landing.eng.apugen = zeros(1,2); %apu generator on/off is 1 or 0 and the 4th row;
Mssn_landing.eng.aputh = zeros(1,2); %apu thermal systems on/off is 1 or 0

Mssn_landing.eng.bleed = ones(1,2); %engine thermal bleed on/off
Mssn_landing.eng.pack = [1,1]; %engine Pack on/off

Mssn_landing.el.time = [t_app+1,t_lnd]; %time (seconds)
Mssn_landing.el.navcom = ones(1,2); %NAV/COMM on/off
Mssn_landing.el.autop = zeros(1,2); %Autopilot on/of
Mssn_landing.el.taxilit = ones(1,2); %Taxi lights on/off
Mssn_landing.el.landinglit = ones(1,2); %landing lights on/off
Mssn_landing.el.flaps = Flap2 * ones(1,2); %flaps setting in degrees

Mssn_landing.hyd.time = [t_app+1,t_lnd]; %time (seconds)
Mssn_landing.hyd.lndgr = [1,1]; %landing gear up/down

Mssn_landing.pnu.time = [t_app+1,t_lnd]; %time (seconds)
Mssn_landing.pnu.pres = zeros(1,2);  %pressurization on/off  
    elseif ind==5
        t_deboard=25*60;
        t_deboard = t_lnd + t_deboard;
state_eng_shutdown = zeros(1,2);
thr_set=0;
Gpower=1;
thr_eng = thr_set*ones(1,2);

Mssn_shutdown.gen.time = [t_lnd+1,t_deboard]; %time (seconds)
Mssn_shutdown.gen.state = [10,10]; %mission state

Mssn_shutdown.cond.time = [t_lnd+1,t_deboard]; %time (seconds)
Mssn_shutdown.cond.alt = [LandingAlt,LandingAlt]; %altitude
Mssn_shutdown.cond.mach = [0,0]; %mach number

Mssn_shutdown.eng.time = [t_lnd+1,t_deboard];%time (seconds)
Mssn_shutdown.eng.apu = ~Gpower * ones(1,2); %apu on/off is 1 or 0 and the 3rd row;
Mssn_shutdown.eng.apugen = ~Gpower * ones(1,2); %apu generator on/off is 1 or 0 and the 4th row;
Mssn_shutdown.eng.aputh = ~Gpower * ones(1,2); %apu thermal systems on/off is 1 or 0

Mssn_shutdown.eng.bleed = zeros(1,2); %engine thermal bleed on/off
Mssn_shutdown.eng.pack = [0,0]; %engine Pack on/off

Mssn_shutdown.el.time = [t_lnd+1,t_deboard]; %time (seconds)
Mssn_shutdown.el.navcom = ones(1,2); %NAV/COMM on/off
Mssn_shutdown.el.autop = zeros(1,2); %Autopilot on/of
Mssn_shutdown.el.taxilit = ones(1,2); %Taxi lights on/off
Mssn_shutdown.el.landinglit = ones(1,2); %landing lights on/off
Mssn_shutdown.el.flaps = zeros(1,2); %flaps setting in degrees

Mssn_shutdown.hyd.time = [t_lnd+1,t_deboard]; %time (seconds)
Mssn_shutdown.hyd.lndgr = [1,1]; %landing gear up/down

Mssn_shutdown.pnu.time = [t_lnd+1,t_deboard]; %time (seconds)
Mssn_shutdown.pnu.pres = zeros(1,2);  %pressurization on/off
    end 
end
%The previously built values for the new mission are concacted to the old
%mission after the fault.
MSSN.gen.time=[MSSN.gen.time(1:t_ind_gen-1),t_fail,Mssn_Cruise.gen.time,...
    Mssn_descent.gen.time,Mssn_approach.gen.time,Mssn_landing.gen.time,Mssn_shutdown.gen.time];

MSSN.gen.state=[MSSN.gen.state(1:t_ind_gen-1),Cur_state,Mssn_Cruise.gen.state,...
    Mssn_descent.gen.state,Mssn_approach.gen.state,Mssn_landing.gen.state,Mssn_shutdown.gen.state];

MSSN.cond.time=[MSSN.cond.time(1:t_ind_cond-1),t_fail,Mssn_Cruise.cond.time,...
    Mssn_descent.cond.time,Mssn_approach.cond.time,Mssn_landing.cond.time,Mssn_shutdown.cond.time];

MSSN.cond.alt=[MSSN.cond.alt(1:t_ind_cond-1),C_alt,Mssn_Cruise.cond.alt,Mssn_descent.cond.alt,...
    Mssn_approach.cond.alt,Mssn_landing.cond.alt,Mssn_shutdown.cond.alt];

MSSN.cond.mach=[MSSN.cond.mach(1:t_ind_cond-1),MSSN.cond.mach(t_ind_cond),Mssn_Cruise.cond.mach,Mssn_descent.cond.mach,...
    Mssn_approach.cond.mach,Mssn_landing.cond.mach,Mssn_shutdown.cond.mach];

MSSN.eng.time=[MSSN.eng.time(1:t_ind-1),t_fail,Mssn_Cruise.eng.time,Mssn_descent.eng.time,...
    Mssn_approach.eng.time,Mssn_landing.eng.time,Mssn_shutdown.eng.time];

MSSN.eng.apu=[MSSN.eng.apu(1:t_ind-1),MSSN.eng.apu(t_ind-1),Mssn_Cruise.eng.apu,Mssn_descent.eng.apu,...
    Mssn_approach.eng.apu,Mssn_landing.eng.apu,Mssn_shutdown.eng.apu];

MSSN.eng.apugen=[MSSN.eng.apugen(1:t_ind-1),MSSN.eng.apugen(t_ind-1),...
    Mssn_Cruise.eng.apugen,Mssn_descent.eng.apugen,...
    Mssn_approach.eng.apugen,Mssn_landing.eng.apugen,Mssn_shutdown.eng.apugen];

MSSN.eng.aputh=[MSSN.eng.aputh(1:t_ind-1),MSSN.eng.aputh(t_ind-1),Mssn_Cruise.eng.aputh,Mssn_descent.eng.aputh,...
    Mssn_approach.eng.aputh,Mssn_landing.eng.aputh,Mssn_shutdown.eng.aputh];

MSSN.eng.bleed=[MSSN.eng.bleed(1:t_ind-1),MSSN.eng.bleed(t_ind-1),...
    Mssn_Cruise.eng.bleed,Mssn_descent.eng.bleed,...
    Mssn_approach.eng.bleed,Mssn_landing.eng.bleed,Mssn_shutdown.eng.bleed];

MSSN.eng.pack=[MSSN.eng.pack(1:t_ind-1),MSSN.eng.pack(t_ind-1), ...
    Mssn_Cruise.eng.pack,Mssn_descent.eng.pack,...
    Mssn_approach.eng.pack,Mssn_landing.eng.pack,Mssn_shutdown.eng.pack];

MSSN.el.time=[MSSN.el.time(1:t_ind-1),Mssn_Cruise.el.time,Mssn_descent.el.time,...
    Mssn_approach.el.time,Mssn_landing.el.time,Mssn_shutdown.el.time];
MSSN.el.navcom=[MSSN.el.navcom(1:t_ind-1),Mssn_Cruise.el.navcom,Mssn_descent.el.navcom,...
    Mssn_approach.el.navcom,Mssn_landing.el.navcom,Mssn_shutdown.el.navcom];
MSSN.el.autop=[MSSN.el.autop(1:t_ind-1),Mssn_Cruise.el.autop,Mssn_descent.el.autop,...
    Mssn_approach.el.autop,Mssn_landing.el.autop,Mssn_shutdown.el.autop];
MSSN.el.taxilit=[MSSN.el.taxilit(1:t_ind-1),Mssn_Cruise.el.taxilit,Mssn_descent.el.taxilit,...
    Mssn_approach.el.taxilit,Mssn_landing.el.taxilit,Mssn_shutdown.el.taxilit];
MSSN.el.landinglit=[MSSN.el.landinglit(1:t_ind-1),Mssn_Cruise.el.landinglit,Mssn_descent.el.landinglit,...
    Mssn_approach.el.landinglit,Mssn_landing.el.landinglit,Mssn_shutdown.el.landinglit];
MSSN.el.flaps=[MSSN.el.flaps(1:t_ind-1),Mssn_Cruise.el.flaps,Mssn_descent.el.flaps,...
    Mssn_approach.el.flaps,Mssn_landing.el.flaps,Mssn_shutdown.el.flaps];%%% This needs to be split into two pairs of flaps somehow.
MSSN.hyd.lndgr=[MSSN.hyd.lndgr(1:t_ind-1),Mssn_Cruise.hyd.lndgr,Mssn_descent.hyd.lndgr,...
    Mssn_approach.hyd.lndgr,Mssn_landing.hyd.lndgr,Mssn_shutdown.hyd.lndgr];
MSSN.hyd.time=[MSSN.hyd.time(1:t_ind-1),Mssn_Cruise.hyd.time,Mssn_descent.hyd.time,...
    Mssn_approach.hyd.time,Mssn_landing.hyd.time,Mssn_shutdown.hyd.time];
MSSN.pnu.time=[MSSN.pnu.time(1:t_ind_pnu-1),t_fail,Mssn_Cruise.pnu.time,Mssn_descent.pnu.time,...
    Mssn_approach.pnu.time,Mssn_landing.pnu.time,Mssn_shutdown.pnu.time];
MSSN.pnu.pres=[MSSN.pnu.pres(1:t_ind_pnu-1),Cur_pres,Mssn_Cruise.pnu.pres,Mssn_descent.pnu.pres,...
    Mssn_approach.pnu.pres,Mssn_landing.pnu.pres,Mssn_shutdown.pnu.pres];
state_eng=[0,state_eng_cruise,state_eng_descent,state_eng_approach,state_eng_landing,state_eng_shutdown];

%Lines 273-350 is an algorithm that concacts the engine and generatory
%array. difference is used to determine if the previous or new mission
%arrays are longer or shorter. If shorter then elements must be removed and
%if longer then elements must be added. 

        difference=length(MSSN.eng.Eng1(t_ind:end))-length(MSSN.eng.time(t_ind:end))
        difference_abs_engine=abs(length(MSSN.eng.Eng1(t_ind:end))-length(MSSN.eng.time(t_ind:end))) 
        difference_abs_gen=abs(length(MSSN.eng.Eng1(t_ind:end))-length(MSSN.eng.time(t_ind:end)))
        difference_abs_enginethrust=abs(length(MSSN.eng.EngThrust1(t_ind:end))-length(MSSN.eng.time(t_ind:end)))
        state_eng=zeros(1,length(state_eng))
       
       
if difference <0 || difference == 0
                    if N_ENG<3
                     MSSN.eng.Eng1=horzcat(MSSN.eng.Eng1(1:end),zeros(1,difference_abs_engine));
                     MSSN.eng.Eng2=horzcat(MSSN.eng.Eng2(1:end),zeros(1,difference_abs_engine));
                     MSSN.eng.EngThrust1=horzcat(MSSN.eng.EngThrust1(1:end),zeros(1,difference_abs_enginethrust));   
                     MSSN.eng.EngThrust2=horzcat(MSSN.eng.EngThrust2(1:end),zeros(1,difference_abs_enginethrust));
                     
                     MSSN.eng.Gen1=horzcat(MSSN.eng.Gen1(1:end),ones(1,difference_abs_gen));
                     MSSN.eng.Gen2=horzcat(MSSN.eng.Gen2(1:end),ones(1,difference_abs_gen));
                     MSSN.eng.Gen3=horzcat(MSSN.eng.Gen3(1:end),ones(1,difference_abs_gen));
                     MSSN.eng.Gen4=horzcat(MSSN.eng.Gen4(1:end),ones(1,difference_abs_gen));
                    
                    elseif N_ENG>2
                     MSSN.eng.Eng1=horzcat(MSSN.eng.Eng1(1:end),zeros(1,difference_abs));
                     MSSN.eng.Eng2=horzcat(MSSN.eng.Eng2(1:end),zeros(1,difference_abs));
                     MSSN.eng.EngThrust1=horzcat(MSSN.eng.EngThrust1(1:end),zeros(1,difference_abs));   
                     MSSN.eng.EngThrust2=horzcat(MSSN.eng.EngThrust2(1:end),zeros(1,difference_abs));
                     MSSN.eng.Eng3=horzcat(MSSN.eng.Eng3(1:end),zeros(1,difference_abs));
                     MSSN.eng.Eng4=horzcat(MSSN.eng.Eng4(1:end),zeros(1,difference_abs));
                     MSSN.eng.EngThrust3=horzcat(MSSN.eng.EngThrust3(1:end),zeros(1,difference_abs));   
                     MSSN.eng.EngThrust4=horzcat(MSSN.eng.EngThrust4(1:end),zeros(1,difference_abs));
                     
                     
                     MSSN.eng.Gen1=horzcat(MSSN.eng.Gen1(1:end),ones(1,difference_abs-3),zeros(1,2));
                     MSSN.eng.Gen2=horzcat(MSSN.eng.Gen2(1:end),ones(1,difference_abs-3),zeros(1,2));
                     MSSN.eng.Gen3=horzcat(MSSN.eng.Gen3(1:end),ones(1,difference_abs-3),zeros(1,2));
                     MSSN.eng.Gen4=horzcat(MSSN.eng.Gen4(1:end),ones(1,difference_abs-3),zeros(1,2));
                     MSSN.eng.Gen5=horzcat(MSSN.eng.Gen5(1:end),ones(1,difference_abs-3),zeros(1,2));
                     MSSN.eng.Gen6=horzcat(MSSN.eng.Gen6(1:end),ones(1,difference_abs-3),zeros(1,2));
                     MSSN.eng.Gen7=horzcat(MSSN.eng.Gen7(1:end),ones(1,difference_abs-3),zeros(1,2));
                     MSSN.eng.Gen8=horzcat(MSSN.eng.Gen8(1:end),ones(1,difference_abs-3),zeros(1,2));
                    end
elseif difference >0
    for i = 1:MSSN.gen.N_ENG
      eval(['MSSN.eng.Eng' num2str(i) '(t_ind+1:end)' ' =[];']);
      eval(['MSSN.eng.EngThrust' num2str(i) '(t_ind+1:end)' ' = [];']);
    end
    for i = 1:MSSN.gen.N_GEN
      eval(['MSSN.eng.Gen' num2str(i) '(t_ind+1:end)' ' =[];']);
    end
    
     if N_ENG<3
                     MSSN.eng.Eng1=horzcat(MSSN.eng.Eng1(1:end),zeros(1,10));
                     MSSN.eng.Eng2=horzcat(MSSN.eng.Eng2(1:end),zeros(1,10));
                     MSSN.eng.EngThrust1=horzcat(MSSN.eng.EngThrust1(1:end),zeros(1,10));   
                     MSSN.eng.EngThrust2=horzcat(MSSN.eng.EngThrust2(1:end),zeros(1,10));
                     
                     MSSN.eng.Gen1=horzcat(MSSN.eng.Gen1(1:end),zeros(1,10));
                     MSSN.eng.Gen2=horzcat(MSSN.eng.Gen2(1:end),zeros(1,10));
                     MSSN.eng.Gen3=horzcat(MSSN.eng.Gen3(1:end),zeros(1,10));
                     MSSN.eng.Gen4=horzcat(MSSN.eng.Gen4(1:end),zeros(1,10));
      elseif N_ENG>2
                     MSSN.eng.Eng1=horzcat(MSSN.eng.Eng1(1:end),zeros(1,10));
                     MSSN.eng.Eng2=horzcat(MSSN.eng.Eng2(1:end),zeros(1,10));
                     MSSN.eng.EngThrust1=horzcat(MSSN.eng.EngThrust1(1:end),zeros(1,10));   
                     MSSN.eng.EngThrust2=horzcat(MSSN.eng.EngThrust2(1:end),zeros(1,10));
                     MSSN.eng.Eng3=horzcat(MSSN.eng.Eng3(1:end),zeros(1,difference_abs));
                     MSSN.eng.Eng4=horzcat(MSSN.eng.Eng4(1:end),zeros(1,difference_abs));
                     MSSN.eng.EngThrust3=horzcat(MSSN.eng.EngThrust3(1:end),zeros(1,10));   
                     MSSN.eng.EngThrust4=horzcat(MSSN.eng.EngThrust4(1:end),zeros(1,10));
                     
                     
                     MSSN.eng.Gen1=horzcat(MSSN.eng.Gen1(1:end),zeros(1,10));
                     MSSN.eng.Gen2=horzcat(MSSN.eng.Gen2(1:end),zeros(1,10));
                     MSSN.eng.Gen3=horzcat(MSSN.eng.Gen3(1:end),zeros(1,10));
                     MSSN.eng.Gen4=horzcat(MSSN.eng.Gen4(1:end),zeros(1,10));
                     MSSN.eng.Gen5=horzcat(MSSN.eng.Gen5(1:end),zeros(1,10));
                     MSSN.eng.Gen6=horzcat(MSSN.eng.Gen6(1:end),zeros(1,10));
                     MSSN.eng.Gen7=horzcat(MSSN.eng.Gen7(1:end),zeros(1,10));
                     MSSN.eng.Gen8=horzcat(MSSN.eng.Gen8(1:end),zeros(1,10));
                    end         
end
    if fail == 1;
        k = fail_loc;
        for i = 1:MSSN.gen.N_ENG
            if i ~= k
                eval(['a = T_mult*MSSN.eng.EngThrust' num2str(i) '(t_ind+1:end);']);
                b = 100*ones(1,length(a));
                eval(['MSSN.eng.EngThrust' num2str(i) '(t_ind+1:end)' ...
                    '= min([a;b],[],1);']);

                         eval(['MSSN.eng.Eng' num2str(i) '(t_ind+1:end)' ' =ones(1,length(MSSN.eng.Eng1(t_ind+1:end)));']);
                         eval(['MSSN.eng.Eng' num2str(i) '(end-1:end)' ' =zeros(1,2);']); %For Shutdown
                         eval(['MSSN.eng.EngThrust' num2str(i) '(t_ind+1:t_ind+2)' ' =CruiseThrust;']);
                         eval(['MSSN.eng.EngThrust' num2str(i) '(t_ind+3:t_ind+4)' ' =DescentThrust;']);
                         eval(['MSSN.eng.EngThrust' num2str(i) '(t_ind+5:t_ind+6)' ' =ApproachThrust;']);
                         eval(['MSSN.eng.EngThrust' num2str(i) '(t_ind+7:t_ind+8)' ' =LandingThrust;']);
                         eval(['MSSN.eng.EngThrust' num2str(i) '(end-1:end)' ' =zeros(1,2);']); %For Shutdown
           end
        end
        for i=1:MSSN.gen.N_GEN
            if i~=k
              eval(['MSSN.eng.Gen' num2str(i) '(t_ind+1:end)' ' =ones(1,10);']);
              eval(['MSSN.eng.Gen' num2str(i) '(end-1:end)' ' =zeros(1,2);']);
            elseif i==k
            end
        end
                

    elseif fail == 2;
        k = fail_loc;
       for i=1:MSSN.gen.N_GEN
           if i==k
        eval(['MSSN.eng.Gen' num2str(i) '(t_ind+1:end)' ' = zeros(1,length(MSSN.eng.time(t_ind+1:end)));']);
           elseif i~=k
        eval(['MSSN.eng.Gen' num2str(i) '(t_ind+1:end)' ' = ones(1,length(MSSN.eng.time(t_ind+1:end)));']);
        eval(['MSSN.eng.Gen' num2str(i) '(end-1:end)' ' = zeros(1,2);']);
           end
       end
     
        for i = 1:MSSN.gen.N_ENG   
                 eval(['a = T_mult*MSSN.eng.EngThrust' num2str(i) '(t_ind:end);']);
                 b = 100*ones(1,length(a));
                    eval(['MSSN.eng.EngThrust' num2str(i) '(t_ind:end)' ...
                    '= min([a;b],[],1);']);
                        
                         eval(['MSSN.eng.Eng' num2str(i) '(t_ind+1:end)' ' =ones(1,length(MSSN.eng.Eng1(t_ind+1:end)));']);
                         eval(['MSSN.eng.Eng' num2str(i) '(end-1:end)' ' =zeros(1,2);']); %For Shutdown
                         eval(['MSSN.eng.EngThrust' num2str(i) '(t_ind+1:t_ind+2)' ' =CruiseThrust;']);
                         eval(['MSSN.eng.EngThrust' num2str(i) '(t_ind+3:t_ind+4)' ' =DescentThrust;']);
                         eval(['MSSN.eng.EngThrust' num2str(i) '(t_ind+5:t_ind+6)' ' =ApproachThrust;']);
                         eval(['MSSN.eng.EngThrust' num2str(i) '(t_ind+7:t_ind+8)' ' =LandingThrust;']);
                         eval(['MSSN.eng.EngThrust' num2str(i) '(end-1:end)' ' =zeros(1,2);']); %For Shutdown
                             
        end
    end
 %}   
MSSN_out=MSSN;
