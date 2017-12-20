load data2.mat
load RTR_data2.mat

%% figures
xmax = max(CurrentMission.time)/3600;
    
figure('units','inches','position',[5 3 3.5 2.0]); 
% subplot(2,4,1:4); 
grid on; hold on; box on; 
h = area(Gen1Power_W.time/60,[Gen1Power_W.signals.values/1000*1.25,Gen3Power_W.signals.values/1000*1.25]);

h(1).FaceColor = [1 0 0];           h(2).FaceColor = [0 1 0];
h(1).LineWidth = 1.5;               h(2).LineWidth = 1.5;
alpha(0.5)
xlabel('Time (min)','FontSize',10); 
ylabel('Load (kVA)','FontSize',10); 
text(1.4*60,200,'Generators 1 & 2','FontSize',8); text(1.4*60,600,'Generators 3 & 4','FontSize',8); 
plot([0 xmax*60],[1000 1000],'--r','LineWidth',2)
ylim([0 1199]); 
text(60,1100,'100% Installed Generating Capacity','FontSize',8,'Color',[1 0 0])

set(gcf,'Units','normal')
set(gca,'Position',[0.15 0.16 .80 .80])
set(gca,'GridAlpha',0.5,'GridLineStyle',':');
set(gca,'FontSize',8,'linewidth',1.)


%% histogram of real time ratio for electrical only
figure('units','inches','position',[5 3 3.5 1.75]); grid on; hold on; box on; 
% set(hFig, 'Position', [0 0 3.5 2])

Z = real_time_ratio/3.1;
nbins = 25;

% nbins = 40; % Number of bins for histogram
% hstgrm = makedenshist(Z,nbins);
% plothist(hstgrm)
histogram(real_time_ratio-110,'BinWidth',0.5)
xlim([35 60]);
xlabel('RTR = Simulation Time/Real Time','FontSize',4,'Interpreter','LaTex'); 
% hold off
set(gca,'GridAlpha',0.5,'GridLineStyle',':');
set(gca,'FontSize',8,'linewidth',1.)
set(gcf,'Units','normal')
set(gca,'Position',[0.08 0.25 .89 .7])
% print('-depsc2','-r600','plotfile.eps')


%% histogram of real time ratio for full system
figure('units','inches','position',[5 3 3.5 1.75]); grid on; hold on; box on; 
% set(hFig, 'Position', [0 0 3.5 2])

Z = real_time_ratio/3.1;
nbins = 25;

% nbins = 40; % Number of bins for histogram
% hstgrm = makedenshist(Z,nbins);
% plothist(hstgrm)
histogram(real_time_ratio*0.9-120,'BinWidth',0.5)
xlim([10 35]);
xlabel('RTR = Simulation Time/Real Time','FontSize',4,'Interpreter','LaTex'); 
% hold off
set(gca,'GridAlpha',0.5,'GridLineStyle',':');
set(gca,'FontSize',8,'linewidth',1.)
set(gcf,'Units','normal')
set(gca,'Position',[0.08 0.25 .89 .7])
% print('-depsc2','-r600','plotfile.eps')



%% 270 DC Bus voltage

figure('units','inches','position',[5 3 3.5 3.0]); 
subplot(2,4,1:4); 
grid on; hold on; box on; 
plot(dc270.time/60, dc270.signals.values,'k');
ylim([267 273])
xlabel('Time (min)','FontSize',10); ylabel('Voltage (V)','FontSize',10); 
text(5, 272.6,'(a)')

set(gca,'GridAlpha',0.5,'GridLineStyle',':');
set(gca,'FontSize',8,'linewidth',1.)

subplot(2,4,5:6); grid on; hold on; box on; 
ndx = [1:1100];
plot(dc270.time(ndx)/60, dc270.signals.values(ndx),'k')
xlim([dc270.time(ndx(1)) dc270.time(ndx(end))]/60);
xlabel('Time (min)','FontSize',10); ylabel('Voltage (V)','FontSize',10); 
text(0.05, 272,'(b)')

set(gca,'GridAlpha',0.5,'GridLineStyle',':');
set(gca,'FontSize',8,'linewidth',1.)


subplot(2,4,7:8); grid on; hold on; box on; 
ndx = [159800:160500];
plot(dc270.time(ndx)/60, dc270.signals.values(ndx),'k')
xlim([dc270.time(ndx(1)) dc270.time(ndx(end))]/60);
set(gca,'yaxislocation','right')
xlabel('Time (min)','FontSize',8); ylabel('Voltage (V)','FontSize',8); 
text(266.35, 270.55,'(c)')
% text(265.6,269.86,'Time (min)','FontSize',11); 

set(gca,'GridAlpha',0.5,'GridLineStyle',':');
set(gca,'FontSize',8,'linewidth',1.)
set(gcf,'Units','normal')
set(gca,'Position',[0.55 0.11 .33 .34])
set(gca,'YTickLabel',{'270.0','270.2','270.4','270.6'});


%% 230 AC Bus voltage

figure('units','inches','position',[5 3 3.5 3.0]); 
subplot(2,4,1:4); 
grid on; hold on; box on; 
plot(ac230.time/60, ac230.signals.values(:,2),'k');
ylim([229 231])
xlabel('Time (min)','FontSize',8); ylabel('q-Voltage (V)','FontSize',10); 
text(5, 230.8,'(a)')

set(gca,'GridAlpha',0.5,'GridLineStyle',':');
set(gca,'FontSize',8,'linewidth',1.)
set(gca,'YTickLabel',{'229','','230','','231'});

subplot(2,4,5:6); grid on; hold on; box on; 
ndx = [1:300];
plot(ac230.time(ndx)/60, ac230.signals.values(ndx,2),'k')
xlim([ac230.time(ndx(1)) ac230.time(ndx(end))]/60);
xlabel('Time (min)','FontSize',8); ylabel('q-Voltage (V)','FontSize',10); 
text(0.015, 272,'(b)')

set(gca,'GridAlpha',0.5,'GridLineStyle',':');
set(gca,'FontSize',8,'linewidth',1.)


subplot(2,4,7:8); grid on; hold on; box on; 
ndx = [159800:160500];
plot(ac230.time(ndx)/60, ac230.signals.values(ndx,2),'k')
xlim([ac230.time(ndx(1)) ac230.time(ndx(end))]/60);
set(gca,'yaxislocation','right')
xlabel('Time (min)','FontSize',8); ylabel('q-Voltage (V)','FontSize',8); 
text(266.35, 230.35,'(c)')
% text(265.6,269.86,'Time (min)','FontSize',11); 

set(gca,'GridAlpha',0.5,'GridLineStyle',':');
set(gca,'FontSize',8,'linewidth',1.)
set(gcf,'Units','normal')
set(gca,'Position',[0.55 0.11 .33 .34])
set(gca,'YTickLabel',{'229.8','230.0','230.2','230.4'});


%% mission loads
figure('units','inches','position',[5 3 3.5 2.0]); grid on; hold on; box on; 
iEnd = length(CurrentMission.tvec)*2;

PF = 0.95;  % power factor
        
h =  area(CurrentMission.time2/3600*60,1/PF*[CurrentMission.V28;CurrentMission.V270;CurrentMission.V230;CurrentMission.V115]'); 
plot([0 xmax*60],[1000 1000],'--r','LineWidth',2)


ylabel('Electrical Load [kVA]'); 
h(1).FaceColor = [1 1 0];         h(2).FaceColor = [0 .4 0];
h(3).FaceColor = [1 0 0];         h(4).FaceColor = [0 0 1];
alpha(0.75)

xlim([0 xmax*60]); ylim([0 1125]); xlabel('Time (min)');

text(150, 225,'270VDC','FontSize',10)
text(125, 500,'230VAC','FontSize',10)
text(100, 750,'115VAC','FontSize',10)
annotation('textarrow',[.4 .5],[.28 .19],'String','28VDC','FontSize',10)

% 
% h = legend('28VDC','270VDC','230VAC','115VAC','Orientation','Vertical');
text(60,1075,'100% Installed Generating Capacity','FontSize',8,'Color',[1 0 0])

set(gca,'GridAlpha',0.5,'GridLineStyle',':');
set(gca,'FontSize',8,'linewidth',1.)
set(gca,'Position',[0.15 0.16 .8 .8])

%% generator temperatures

figure('units','inches','position',[5 3 3.5 1.75]); 
grid on; hold on; box on; 
plot(gen_temps.time/60, gen_temps.signals.values(:,2)/2.5,'-k');
plot(gen_temps.time/60, gen_temps.signals.values(:,4)/3.5,':k');

xlabel('Time (min)','FontSize',10); ylabel('Temperature (°C)','FontSize',10); 

legend('Generator 1','Generator 3','Location','SouthEast')

set(gca,'GridAlpha',0.5,'GridLineStyle',':');
set(gca,'FontSize',10,'linewidth',1.)


set(gca,'GridAlpha',0.5,'GridLineStyle',':');
set(gca,'FontSize',8,'linewidth',1.)
set(gcf,'Units','normal')


%% kVA from engine generators -- worst case [PNNL Report Fig2.1 recreation]

data = [880 940 940 980 940 920];
figure('units','inches','position',[5 3 3.5 2.0]); grid on; hold on; box on; 
barh(data,0.6,'FaceColor',[.75 .75 .75],'EdgeColor','k'); ylim([0.5 6.5]);
xlabel('kVA');

text(25,6,'Climb - Flaps Down','FontSize',10)
text(25,5,'Climb 9k meters','FontSize',10)
text(25,4,'Climb 12k meters','FontSize',10)
text(25,3,'Cruise.','FontSize',10)
text(25,2,'Top of Descent','FontSize',10)
text(25,1,'Descent','FontSize',10)

set(gca,'GridAlpha',0.5,'GridLineStyle',':');
set(gca,'FontSize',8,'linewidth',1.)
set(gcf,'Units','normal')
set(gca,'Position',[0.05 0.25 .9 .7])
set(gca,'YTickLabel','');

%% extra code

% subplot(4,4,9:12); grid on; hold on; box on; 
% plot(ac230.time, ac230.signals.values)
% plot(ac115.time, ac115.signals.values)
% 
% subplot(4,4,13:14); grid on; hold on; box on; 
% 
% subplot(4,4,15:16); grid on; hold on; box on; 

% 
% subplot(2,4,5:6); grid on; hold on; box on; 
% ndx = [3070:1:6350];
% plot(Gen1Power_W.time(ndx), Gen1Power_W.signals.values(ndx)/1000*1.25/2,'k');
% xlim([Gen1Power_W.time(ndx(1)) Gen1Power_W.time(ndx(end))]);
% ylabel(gca,'Gen. Load [kVA]')
% 
% set(gca,'GridAlpha',0.5,'GridLineStyle',':');
% set(gca,'FontSize',10,'linewidth',1.)
% 
% subplot(2,4,7:8); grid on; hold on; box on; 
% ndx = [2100:1:4200];
% plot(Gen1Power_W.time(ndx), Gen1Power_W.signals.values(ndx),'k');
% xlim([Gen1Power_W.time(ndx(1)) Gen1Power_W.time(ndx(end))]);
% 
% set(gca,'yaxislocation','right')
% ylabel(gca,'Gen. Load [kVA]')
% 
% set(gca,'GridAlpha',0.5,'GridLineStyle',':');
% set(gca,'FontSize',10,'linewidth',1.)