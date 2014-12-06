% tic
% sim('Boeing737Sample_updatedCopy.mdl')
% toc

close all

load('Benchmark_data.mat')
%Elapsed time is 5785.585284 seconds.
figure
subplot(3,1,1)
data = Gen1Power_W.signals.values(1,1,:)/1000;
plot(Gen1Power_W.time/3600,reshape(data,size(data,3),1),'k')
ylabel('Gen1 [kW]')
xlim([0 5.3])
ylim([0 60])
subplot(3,1,2)
data = Gen2Power_W.signals.values(1,1,:)/1000;
plot(Gen2Power_W.time/3600,reshape(data,size(data,3),1),'k')
ylabel('Gen2 [kW]')
xlim([0 5.3])
subplot(3,1,3)
data = Tot_Gen_Loss_W.signals.values/1000;
plot(Tot_Gen_Loss_W.time/3600,data,'k')
ylabel('Gen. Losses [kW]')
xlabel('Mission Time [hrs]')
xlim([0 5.3])
set(findall(gcf,'-property','FontSize'),'FontSize',10)
set(findall(gcf,'-property','Fontname'),'Fontname','Times New Roman')

figure
subplot(2,1,1)
data = LeftPackPower_W.signals.values/1000;
plot(LeftPackPower_W.time/3600,data,'k')
ylabel('Left Pack [kW]')
xlim([0 5.3])
subplot(2,1,2)
data = RightPackPower_W.signals.values/1000;
plot(RightPackPower_W.time/3600,data,'k')
ylabel('Right Pack [kW]')
xlabel('Mission Time [hrs]')
xlim([0 5.3])
set(findall(gcf,'-property','FontSize'),'FontSize',10)
set(findall(gcf,'-property','Fontname'),'Fontname','Times New Roman')

figure
subplot(2,1,1)
plot(MSSN.cond.time/3600,MSSN.cond.alt,'k')
ylabel('Altitude [ft]')
axis([0 5.3 0 35000])
subplot(2,1,2)
plot(MSSN.cond.time/3600,MSSN.cond.mach,'k')
ylabel('Mach #')
xlabel('Mission Time [hrs]')
xlim([0 5.3])
set(findall(gcf,'-property','FontSize'),'FontSize',10)
set(findall(gcf,'-property','Fontname'),'Fontname','Times New Roman')


figure
data = hydload.signals.values;

plot(hydload.time/3600,data,'k')
ylabel('Power [kW]')
xlabel('Mission Time [hrs]')
xlim([0 5.3])
set(findall(gcf,'-property','FontSize'),'FontSize',10)
set(findall(gcf,'-property','Fontname'),'Fontname','Times New Roman')
