%MssnSimInit

Str = ['[MSSN.eng.Eng1;'];
for i = 2:MSSN.gen.N_ENG;
    if i ~= MSSN.gen.N_ENG
        Str = [Str,'MSSN.eng.Eng',num2str(i),';'];
    else
        Str = [Str,'MSSN.eng.Eng',num2str(i),']'];
    end
end
set_param('SampleMissionProfile/Subsystem/Engine State Table','table',Str)
set_param('SampleMissionProfile/Subsystem/ENGSTATEBus','Inputs',num2str(MSSN.gen.N_ENG));
set_param('SampleMissionProfile/Subsystem/ENGSTATEDemux','Outputs',num2str(MSSN.gen.N_ENG));

Str = ['[MSSN.eng.EngThrust1;'];
for i = 2:MSSN.gen.N_ENG;
    if i ~= MSSN.gen.N_ENG
        Str = [Str,'MSSN.eng.EngThrust',num2str(i),';'];
    else
        Str = [Str,'MSSN.eng.EngThrust',num2str(i),']'];
    end
end
set_param('SampleMissionProfile/Subsystem/Engine Thrust Table','Table',Str)
set_param('SampleMissionProfile/Subsystem/ENGTHRUSTBus','Inputs',num2str(MSSN.gen.N_ENG));
set_param('SampleMissionProfile/Subsystem/ENGTHRUSTDemux','Outputs',num2str(MSSN.gen.N_ENG));

Str = ['[MSSN.eng.Gen1;'];
for i = 2:MSSN.gen.N_GEN;
    if i ~= MSSN.gen.N_GEN
        Str = [Str,'MSSN.eng.Gen',num2str(i),';'];
    else
        Str = [Str,'MSSN.eng.Gen',num2str(i),']'];
    end
end
set_param('SampleMissionProfile/Subsystem/Generator State Table','Table',Str)
set_param('SampleMissionProfile/Subsystem/GENSTATEBus','Inputs',num2str(MSSN.gen.N_GEN));
set_param('SampleMissionProfile/Subsystem/GENSTATEDemux','Outputs',num2str(MSSN.gen.N_GEN));



%If need to add lines:
for i = 3:MSSN.gen.N_GEN
    try
        Str1 = ['GENSTATEDemux/',num2str(i)];
        Str2 = ['GENSTATEBus/',num2str(i)];
        add_line(gcs,Str1,Str2)
    catch
    end
end

for i = 3:MSSN.gen.N_ENG
    try
        Str1 = ['ENGTHRUSTDemux/',num2str(i)];
        Str2 = ['ENGTHRUSTBus/',num2str(i)];
        add_line('SampleMissionProfile/Subsystem',Str1,Str2)
        Str3 = ['ENGSTATEDemux/',num2str(i)];
        Str4 = ['ENGSTATEBus/',num2str(i)];
        add_line('SampleMissionProfile/Subsystem',Str3,Str4)
    catch
    end
end

delete_unnconnected_lines('SampleMissionProfile/Subsystem')