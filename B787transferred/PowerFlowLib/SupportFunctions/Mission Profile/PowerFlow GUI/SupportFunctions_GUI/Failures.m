function[ MSSN_out ] = Failures(MSSN,t_fail,fail,fail_loc,T_mult,LandData)
t_ind = find(MSSN.eng.time > t_fail,1,'first');
MSSN.gen.faults(1)=t_fail;
MSSN.gen.faults(2)=fail;
MSSN.gen.faults(3)=fail_loc;
MSSN.gen.faults(4)=T_mult;
MSSN.gen.faults(5)=LandData;
if LandData == 0 
    MSSN.eng.time = [MSSN.eng.time(1:t_ind-1), t_fail,t_fail, MSSN.eng.time(t_ind:end)];%time (seconds)
    MSSN.eng.apu = [MSSN.eng.apu(1:t_ind-1), 0,0, MSSN.eng.apu(t_ind:end)]; %apu on/off is 1 or 0 and the 3rd row;
    MSSN.eng.apugen = [MSSN.eng.apugen(1:t_ind-1), 0,0, MSSN.eng.apugen(t_ind:end)]; %apu generator on/off is 1 or 0 and the 4th row;
    MSSN.eng.aputh = [MSSN.eng.aputh(1:t_ind-1), 0,0, MSSN.eng.aputh(t_ind:end)];%apu thermal systems on/off is 1 or 0
    th = MSSN.eng.EngThrust1(t_ind-1);
    for n = 1:MSSN.gen.N_ENG
        eval(['MSSN.eng.Eng' num2str(n) ' = [MSSN.eng.Eng' num2str(n) ...
            '(1:t_ind-1), 1,1, MSSN.eng.Eng' num2str(n) '(t_ind:end)];']);
        eval(['MSSN.eng.EngThrust' num2str(n) ' = [MSSN.eng.EngThrust' num2str(n) ...
            '(1:t_ind-1), th,th, MSSN.eng.EngThrust' num2str(n) '(t_ind:end)];']);
    end
    for n = 1:MSSN.gen.N_GEN
        eval(['MSSN.eng.Gen' num2str(n) ' = [MSSN.eng.Gen' num2str(n) ...
            '(1:t_ind-1), 1,1, MSSN.eng.Gen' num2str(n) '(t_ind:end)];']);
    end
    MSSN.eng.bleed = [MSSN.eng.bleed(1:t_ind-1), 1,1, MSSN.eng.bleed(t_ind:end)]; %engine thermal bleed on/off
    MSSN.eng.pack = [MSSN.eng.pack(1:t_ind-1), 1,1, MSSN.eng.pack(t_ind:end)]; %engine Pack on/off

    if fail == 1;
        k = fail_loc;
        for i = 1:MSSN.gen.N_ENG
            if i ~= k
                eval(['a = T_mult*MSSN.eng.EngThrust' num2str(i) '(t_ind+1:end);']);
                b = 100*ones(1,length(a));
                eval(['MSSN.eng.EngThrust' num2str(i) '(t_ind+1:end)' ...
                    '= min([a;b],[],1);']);
            end
        end
        state_eng = zeros(1,length(MSSN.eng.time(t_ind+1:end)));
        eval(['MSSN.eng.Eng' num2str(k) '(t_ind+1:end)' ' = state_eng;']);
        eval(['MSSN.eng.EngThrust' num2str(k) '(t_ind+1:end)' ' = state_eng;']);
        state_gen = zeros(1,length(MSSN.eng.time(t_ind+1:end)));
        eval(['MSSN.eng.Gen' num2str(k) '(t_ind+1:end)' ' = state_gen;']);
    elseif fail == 2;
        k = fail_loc;
        state_gen = zeros(1,length(MSSN.eng.time(t_ind+1:end)));
        eval(['MSSN.eng.Gen' num2str(k) '(t_ind+1:end)' ' = state_gen;']);
    end
    MSSN_out = MSSN;

    
    
    
    
    
    
    
    
    
    
    
elseif LandData == 1
t_ind = find(MSSN.eng.time > t_fail,1,'first');
MSSN.eng.time = [MSSN.eng.time(1:t_ind-1), t_fail, MSSN.eng.time(t_ind:end)];%time (seconds)
    MSSN.eng.apu = [MSSN.eng.apu(1:t_ind-1), 0, MSSN.eng.apu(t_ind:end)]; %apu on/off is 1 or 0 and the 3rd row;
    MSSN.eng.apugen = [MSSN.eng.apugen(1:t_ind-1), 0, MSSN.eng.apugen(t_ind:end)]; %apu generator on/off is 1 or 0 and the 4th row;
    MSSN.eng.aputh = [MSSN.eng.aputh(1:t_ind-1), 0, MSSN.eng.aputh(t_ind:end)];%apu thermal systems on/off is 1 or 0
    th = MSSN.eng.EngThrust1(t_ind-1);
    for n = 1:MSSN.gen.N_ENG
        eval(['MSSN.eng.Eng' num2str(n) ' = [MSSN.eng.Eng' num2str(n) ...
            '(1:t_ind-1), 1, MSSN.eng.Eng' num2str(n) '(t_ind:end)];']);
        eval(['MSSN.eng.EngThrust' num2str(n) ' = [MSSN.eng.EngThrust' num2str(n) ...
            '(1:t_ind-1), th, MSSN.eng.EngThrust' num2str(n) '(t_ind:end)];']);
    end
    for n = 1:MSSN.gen.N_GEN
        eval(['MSSN.eng.Gen' num2str(n) ' = [MSSN.eng.Gen' num2str(n) ...
            '(1:t_ind-1), 1, MSSN.eng.Gen' num2str(n) '(t_ind:end)];']);
    end
    MSSN.eng.bleed = [MSSN.eng.bleed(1:t_ind-1), 1, MSSN.eng.bleed(t_ind:end)]; %engine thermal bleed on/off
    MSSN.eng.pack = [MSSN.eng.pack(1:t_ind-1), 1, MSSN.eng.pack(t_ind:end)]; %engine Pack on/off

    if fail == 1;
        k = fail_loc;
        for i = 1:MSSN.gen.N_ENG
            if i ~= k
                eval(['a = T_mult*MSSN.eng.EngThrust' num2str(i) '(t_ind:end);']);
                b = 100*ones(1,length(a));
                eval(['MSSN.eng.EngThrust' num2str(i) '(t_ind:end)' ...
                    '= min([a;b],[],1);']);
            end
        end
        state_eng = zeros(1,length(MSSN.eng.time(t_ind:end)));
        eval(['MSSN.eng.Eng' num2str(k) '(t_ind:end)' ' = state_eng;']);
        eval(['MSSN.eng.EngThrust' num2str(k) '(t_ind:end)' ' = state_eng;']);
    elseif fail == 2;
        k = fail_loc;
        state_gen = zeros(1,length(MSSN.eng.time(t_ind:end)));
        eval(['MSSN.eng.Gen' num2str(k) '(t_ind:end)' ' = state_gen;']);
    end


    MSSN_out = MSSN;
    assignin('base','MSSN',MSSN_out);
end
end


