

aircraft = {'B_737','Emb_145'};
loads = {'rudder','ailerons','landing_gear','elevator','thrust_rev'};
phase = {'startup','taxi','takeoff','climb','cruise','descend','loiter','approach','landing','landing taxi', 'shutdown', 'idle'};
phasetime = {'15000','15000','15000','15000','15000','15000','15000','15000','15000','15000','15000','15000'};
high = {'0.1','0.1','.4','.6','0.25','0.25','0.25','1','.75','0.25','0.25','0.25'};
low = {'0.05','.05','.1','0.05','0.05','0.05','0.05','.5','.5','0.05','0.05','0.05'};

for i=1:size(aircraft,2)
    for j = 1:size(loads,2)
        for k = 1:size(phase,2)
            eval(['HydraulicLoad.',aircraft{i},'.',loads{j},'(',num2str(k),',1:',phasetime{k},') = ',low{k},' + rand(1,',phasetime{k},')*',high{k}]);
        end
    end
end

clear i j k aircraft loads phase phasetime high low
clc