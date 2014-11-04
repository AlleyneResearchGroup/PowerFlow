tic
sim('Boeing737Sample_updatedCopy.mdl')
toc

%Elapsed time is 5785.585284 seconds.
figure
subplot(3,1,1)
data = Gen1Power_W.signals.values(1,1,:)/1000;
plot(Gen1Power_W.time/3600,reshape(data,size(data,3),1))
ylabel('Gen1 [kW]')

subplot(3,1,2)
data = Gen2Power_W.signals.values(1,1,:)/1000;
plot(Gen2Power_W.time/3600,reshape(data,size(data,3),1))
ylabel('Gen2 [kW]')

subplot(3,1,3)
data = Tot_Gen_Loss_W.signals.values/1000;
plot(Tot_Gen_Loss_W.time/3600,data)
ylabel('Gen. Losses [kW]')
xlabel('Mission Time [hrs]')

figure
subplot(2,1,1)
data = LeftPackPower_W.signals.values/1000;
plot(LeftPackPower_W.time/3600,data)
ylabel('Left Pack [kW]')

subplot(2,1,2)
data = RightPackPower_W.signals.values/1000;
plot(RightPackPower_W.time/3600,data)
ylabel('Right Pack [kW]')
xlabel('Mission Time [hrs]')
