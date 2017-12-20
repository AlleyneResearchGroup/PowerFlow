function [MSSN ] = MonotonicFix(MSSN)
MSSN.gen.time(1)=[];
MSSN.gen.state(1)=[];
MSSN.cond.time(1)=[];
MSSN.cond.alt(1)=[];
MSSN.cond.mach(1)=[];
MSSN.eng.time(1)=[];
MSSN.eng.apu(1)=[];
MSSN.eng.aputh(1)=[];
MSSN.eng.apugen(1)=[];
MSSN.eng.bleed(1)=[];
MSSN.eng.pack(1)=[];
MSSN.el.time(1)=[];
MSSN.el.navcom(1)=[];
MSSN.el.autop(1)=[];
MSSN.el.taxilit(1)=[];
MSSN.el.landinglit(1)=[];
MSSN.el.flaps(1)=[];
MSSN.hyd.time(1)=[];
MSSN.hyd.lndgr(1)=[];
MSSN.pnu.time(1)=[];
MSSN.pnu.pres(1)=[];

if MSSN.gen.N_ENG==2
MSSN.eng.Eng1(1)=[];
MSSN.eng.Eng2(1)=[];
MSSN.eng.EngThrust1(1)=[];
MSSN.eng.EngThrust2(1)=[];
MSSN.eng.Gen1(1)=[];
MSSN.eng.Gen2(1)=[];
MSSN.eng.Gen3(1)=[];
MSSN.eng.Gen4(1)=[];
elseif MSSN.gen.N_ENG==4
MSSN.eng.Eng1(1)=[];
MSSN.eng.Eng2(1)=[];
MSSN.eng.Eng3(1)=[];
MSSN.eng.Eng4(1)=[];
MSSN.eng.EngThrust1(1)=[];
MSSN.eng.EngThrust2(1)=[];
MSSN.eng.EngThrust3(1)=[];
MSSN.eng.EngThrust4(1)=[];
MSSN.eng.Gen1(1)=[];
MSSN.eng.Gen2(1)=[];
MSSN.eng.Gen3(1)=[];
MSSN.eng.Gen4(1)=[];   
MSSN.eng.Gen5(1)=[];
MSSN.eng.Gen6(1)=[];
MSSN.eng.Gen7(1)=[];
MSSN.eng.Gen8(1)=[];   
end
MSSN=MSSN;
end

