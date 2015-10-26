tic
sim('Boeing737Sample_updatedCopy.mdl')
time_ex = toc
save('2013_03_22_SAE.mat')
close all
%%
load('2013_03_22_SAE_data2.mat')

data1 = reshape(Gen1Power_W.signals.values(1,1,:)/1000,size(Gen1Power_W.signals.values(1,1,:),3),1);
data2 = reshape(Gen2Power_W.signals.values(1,1,:)/1000,size(Gen2Power_W.signals.values(1,1,:),3),1);
data3 = Tot_Gen_Loss_W.signals.values/1000;
data4 = LeftPackPower_W.signals.values/1000;
data5 = RightPackPower_W.signals.values/1000;
data6 = smooth(sum(hydload.signals.values,2),20);
data = [data5+data4 data3+data2+data1 data6]';
datasum = sum(data,1);

%fh = figure;
figure(fh)
h = area(Gen1Power_W.time/3600,data(1:size(data,1),:)');

set(h(1),'FaceColor',[255 0 0]/255);    
set(h(2),'FaceColor',[112 173 71]/255);
set(h(3),'FaceColor',[0 0 .0]);
% set(h(4),'FaceColor',[.1 .1 .6]);
% set(h(5),'FaceColor',[1 .9 .4]);
% set(h(6),'FaceColor',[.5 .5 .5]);


grid on;

xlabel('Mission Time [hr]');
ylabel('Power [kW]');
legend('Pneumatic','Electrical','Hydraulic','Location','SouthOutside','Orientation','Horizontal')

%fh_ = figure;
figure(fh_)
datanew = [data(1,:)./datasum; data(2,:)./datasum; data(3,:)./datasum ]; %; data(4,:)./datasum; data(5,:)./datasum; data(6,:)./datasum ];
h = area(Gen1Power_W.time/3600,100.*datanew');

set(h(1),'FaceColor',[255 0 0]/255);    
set(h(2),'FaceColor',[112 173 71]/255);
set(h(3),'FaceColor',[0 0 .0]);
% set(h(1),'FaceColor',[1 .1 .1]);
% set(h(2),'FaceColor',[.1 .3 1]);
% set(h(3),'FaceColor',[1 .5 .1]);
% set(h(4),'FaceColor',[.1 .1 .6]);
% set(h(5),'FaceColor',[1 .9 .4]);
% set(h(6),'FaceColor',[.5 .5 .5]);

grid on;
%setgrid('xy','yx');
xlabel('Mission Time [hr]');
ylabel('Consumed Power [%]'); ylim([0 100]);
legend('Pneumatic','Electrical','Hydraulic','Location','SouthOutside','Orientation','Horizontal')
set(findall(gcf,'-property','FontSize'),'FontSize',12)
set(findall(gcf,'-property','Fontname'),'Fontname','Times New Roman')
%{
load('2013_03_22_SAE.mat')
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

plot(hydload.time/3600,sum(data,2),'k')
ylabel('Power [kW]')
xlabel('Mission Time [hrs]')
xlim([0 5.3])
set(findall(gcf,'-property','FontSize'),'FontSize',10)
set(findall(gcf,'-property','Fontname'),'Fontname','Times New Roman')
%}


clear data data1 data2 data3 data4 data5 data6 datanew h 