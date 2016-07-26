clear Mission
%% Mission profile

FAN.PR = 5.0;
FAN.gamma = 1.4;
FAN.TR = FAN.PR^((FAN.gamma-1)/FAN.gamma);

% throttle multiplier for engine oil heat load - max = 250kW
eng_mult = 150;

% Radar multiplier for Radar heat load - max = 250kW
Radar_mult = 250;


no_mssn = 1;

plot_yes = 1;
if plot_yes; figure; grid on; hold on; box on; end;

for i = 1:no_mssn
    
    % set random generator seed
    rng(i*10);

    % Call rand.
    x = (rand(10,1)-0.5)*2;
    y = (rand(11,1));
    
%     if i == no_mssn; x = 0; end;
    
    % Mission phases: gnd  to  climb  cruise supersonic loiter climb cruise
    % descent landing

    Mission(i).time     = ... 
            cumsum([0    1800  20   900   8000  700    4500   1180    900 ]) ;

    Mission(i).alt      = [100  100  100  9000  9000  12500  12500   500  500  ];

    Mission(i).Mach     = [0.1  0.1  0.1  0.85  0.85  0.8  0.8   0.5  0.1  ];
    
    
    Mission(i).tvec    = [0     1000 1500 1800 2720 4000 4500 6500 8000 10700 13000 16000 17000 18000] ;
    Mission(i).tvec2   = [0     3600     7200     10800      14400    18000] ;
    
    % loads estimated based upon PNNL tech. report 21382
    Mission(i).V270dc.ECS   = 320*[0.5  0.5  1.0  1.0  0.8  0.8  0.8  0.8  0.8  0.8  0.8  0.8  0.6  0.6];   % ECS/pressurization
    Mission(i).V270dc.Hyd   = 40* [0.0  0.5  1.0  1.0  0.8  0.5  0.5  0.5  0.5  0.8  0.5  0.5  0.9  0.9];   % hydraulics
    Mission(i).V270dc.Eqip  = 40* [0.5  0.8  0.8  0.9  0.8  1.0  1.0  1.0  1.0  1.0  1.0  1.0  0.8  0.8];   % equipment cooling
    Mission(i).V270dc.ECSf  = 32* [0.5  0.8  0.8  0.6  0.8  1.0  1.0  1.0  1.0  1.0  1.0  1.0  0.8  0.8];   % ECS fans
       
    Mission(i).V115ac.ICS   = 40* [0.0  1.0  1.0  1.0  1.0  1.0  1.0  0.9  0.9  0.9  0.9  0.9  1.0  1.0];   % intercomm sys?
    Mission(i).V115ac.var   = 140*[0.5  0.5  0.5  0.6  0.6  0.8  1.0  1.0  1.0  1.0  1.0  0.8  0.7  0.6];   % various systems
    
    Mission(i).V28dc.FCntrl = 14* [0.0  1.0  1.0  1.0  1.0  1.0  1.0  0.9  0.9  0.9  0.9  0.9  1.0  1.0];   % flight controls
    Mission(i).V28dc.var    = 20* [1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  0.8  0.8];   % various systems
    
    Mission(i).V230ac.Ice   = 60* [0.0  0.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0];   % ice protection
    Mission(i).V230ac.Gal   = 120*[1.0  1.0  1.0  0.9  0.9  0.9  0.9  0.9  0.9  0.5  0.1  0.1  0.1  0.1];   % galleys
    Mission(i).V230ac.FuP   = 32* [0.0  0.5  0.5  1.0  1.0  1.0  0.7  0.7  0.7  0.7  0.7  0.7  0.5  0.5];   % fuel pumps
    Mission(i).V230ac.fAC   = 60* [0.0  1.0  1.0  0.5  0.5  0.9  0.9  0.8  0.7  0.7  0.7  0.7  0.6  0.6];   % forward cargo AC
    
    Mission(i).V270dc = sum(cell2mat(struct2cell(Mission(i).V270dc)));
    Mission(i).V28dc = sum(cell2mat(struct2cell(Mission(i).V28dc)));
    Mission(i).V230ac = sum(cell2mat(struct2cell(Mission(i).V230ac)));
    Mission(i).V115ac = sum(cell2mat(struct2cell(Mission(i).V115ac)));
    
    xmax = max(Mission(i).time)/3600;
    
    if i ~= no_mssn; clr = [0.4 0.4 0.4]; else clr = [0 0 0]; end;
    
    if 1 == 1
        iEnd = length(Mission(i).tvec)*2;

        Mission(i).time2(1:2:iEnd)  = Mission(i).tvec;
        Mission(i).time2(2:2:iEnd)  =[ Mission(i).tvec(2:end) Mission(i).tvec(end) ];
        Mission(i).V270(1:2:iEnd)   = Mission(i).V270dc;
        Mission(i).V270(2:2:iEnd) = Mission(i).V270dc;
        Mission(i).V28(1:2:iEnd)    = Mission(i).V28dc;
        Mission(i).V28(2:2:iEnd)  = Mission(i).V28dc;
        Mission(i).V230(1:2:iEnd)   = Mission(i).V230ac;
        Mission(i).V230(2:2:iEnd) = Mission(i).V230ac;
        Mission(i).V115(1:2:iEnd)   = Mission(i).V115ac;
        Mission(i).V115(2:2:iEnd) = Mission(i).V115ac;
        
        xlim([0 xmax]); ylim([0 1090]); xlabel('Mission Time [hr.]');
    else
        iEnd = length(Mission(i).tvec2)*2;
        ndx = [1 2 3 5 13 13];
        
        Mission(i).time2(1:2:iEnd)  = Mission(i).tvec2;
        Mission(i).time2(2:2:iEnd)  =[ Mission(i).tvec2(2:end) Mission(i).tvec2(end) ];
        Mission(i).V270(1:2:iEnd)   = Mission(i).V270dc(ndx);
        Mission(i).V270(2:2:iEnd) = Mission(i).V270dc(ndx);
        Mission(i).V28(1:2:iEnd)    = Mission(i).V28dc(ndx);
        Mission(i).V28(2:2:iEnd)  = Mission(i).V28dc(ndx);
        Mission(i).V230(1:2:iEnd)   = Mission(i).V230ac(ndx);
        Mission(i).V230(2:2:iEnd) = Mission(i).V230ac(ndx);
        Mission(i).V115(1:2:iEnd)   = Mission(i).V115ac(ndx);
        Mission(i).V115(2:2:iEnd) = Mission(i).V115ac(ndx);
        
%         xlim([0 xmax]); ylim([-190 1090]); 
%         set(gca,'xtick',[Mission(i).tvec2])
%         set(gca,'xticklabel',[])
%         text(500,-100,'Pre-Flight'); 
%         text(4000,-100,'Start/Taxi'); 
%         message = sprintf('Takeoff &\n   Climb');
%         text(7650,-100,message); 
%         text(11700,-100,'Cruise'); 
%         message = sprintf('Descent &\n  Landing');
%         text(14800,-100,message); 
%         xlabel('Mission Phase');
    end
    
    
    if plot_yes;
       
%         subplot(3,1,1:2); grid on; hold on; box on;
%         plot(Mission(i).time,Mission(i).alt,'-','Color',clr); xlim([0 xmax])
%         ylabel('[m]'); title('Altitude'); ylim([0 15000]);
        
%         plotyy(Mission(i).time,Mission(i).alt,Mission(i).time,Mission(i).Mach,'-','Color',clr,'LineWidth',2); xlim([0 xmax])
%         ylabel('[~]'); title('Mach Number'); ylim([0 1.2]);
        
        PF = 0.95;  % power factor
        
        h =  area(Mission(i).time2/3600,1/PF*[Mission(i).V28;Mission(i).V270;Mission(i).V230;Mission(i).V115]'); 
        plot([0 xmax],[1000 1000],'--r','LineWidth',2)
        
        
        ylabel('Electrical Load [kVA]'); 
        h(1).FaceColor = [1 1 0];         h(2).FaceColor = [0 .4 0];
        h(3).FaceColor = [1 0 0];         h(4).FaceColor = [0 0 1];
        
        h = legend('28VDC','270VDC','230VAC','115VAC','Orientation','Horizontal','Location','NorthOutside');
        text(4100/3600,1050,'100% Installed Generating Capacity','Color',[1 0 0])
        
    end
end

CurrentMission = Mission(i);

clearvars  x y clr no_mssn plot_yes  xmax



%%

% RTR = zeros(100,1);
% for i = 1:100
%     seed = i;
%     tic
%     sim Boeing787_debug
%     RTR(seed) = 18000/toc;
% end
% 
% 
% 
% 


