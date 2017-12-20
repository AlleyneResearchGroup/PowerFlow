function Mssn_Param = initmssn(N_ENG)
state_eng = 0;
thr_eng = 0;

Mssn_Param.gen.time = 0; %time (seconds)
Mssn_Param.gen.state = 0; %mission state
Mssn_Param.gen.faults=0;

Mssn_Param.cond.time = 0; %time (seconds)
Mssn_Param.cond.alt = 0; %altitude
Mssn_Param.cond.mach = 0; %mach number

Mssn_Param.eng.time = 0;%time (seconds)
Mssn_Param.eng.apu = 0; %apu on/off is 1 or 0 and the 3rd row;
Mssn_Param.eng.apugen = 0; %apu generator on/off is 1 or 0 and the 4th row;
Mssn_Param.eng.aputh = 0; %apu thermal systems on/off is 1 or 0
for n = 1:N_ENG
    eval(['Mssn_Param.eng.Eng' num2str(n) ' = state_eng;']);
    eval(['Mssn_Param.eng.EngThrust' num2str(n) ' = thr_eng;']);
end
for n = 1:2*N_ENG
    eval(['Mssn_Param.eng.Gen' num2str(n) ' = state_eng;']);
end
Mssn_Param.eng.bleed = 0; %engine thermal bleed on/off
Mssn_Param.eng.pack = 0; %engine Pack on/off

Mssn_Param.el.time = 0; %time (seconds)
Mssn_Param.el.navcom = 0; %NAV/COMM on/off
Mssn_Param.el.autop = 0; %Autopilot on/of
Mssn_Param.el.taxilit = 0; %Taxi lights on/off
Mssn_Param.el.landinglit = 0; %landing lights on/off
Mssn_Param.el.flaps = 0; %flaps setting in degrees

Mssn_Param.hyd.time = 0; %time (seconds)
Mssn_Param.hyd.lndgr = 0; %landing gear up/down

Mssn_Param.pnu.time = 0; %time (seconds)
Mssn_Param.pnu.pres = 0;  %pressurization on/off
end