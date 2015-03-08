load('SAEmissionProfile.mat')
j=0;
h=subplot(2,1,1); hold on;
for i = 2:2:22
    j=j+1
    if mod(j,2)==1
    patch([MSSN.gen.time(i) MSSN.gen.time(i+1) MSSN.gen.time(i+1) MSSN.gen.time(i)],[0 0 30000 30000],[.95 .95 .95], 'EdgeColor','none')
    elseif mod(j,2)==0   
    patch([MSSN.gen.time(i) MSSN.gen.time(i+1) MSSN.gen.time(i+1) MSSN.gen.time(i)],[0 0 30000 30000],[.92 .92 .92], 'EdgeColor','none')
    end         
end
xlabel('Mission Time [sec.]')
ylabel('Altitude (Ft.)')
axis([0 10710 0 30000])

plot (MSSN.cond.time, MSSN.cond.alt+1,'linewidth',2,'color','r')
plot(MSSN.eng.time, 250*MSSN.eng.EngThrust1,'linewidth',2)
axesPosition = get(gca,'Position');  
 hNewAxes = axes('Position',axesPosition,...  %# Place a new axes on top...
                'Color','none',...           %#   ... with no background color
                'YLim',[0 100],...            %#   ... and a different scale
                'YAxisLocation','right',...  %#   ... located on the right
                'XTick',[],...               %#   ... with no x tick marks
                'Box','off');                %#   ... and no surrounding box
ylabel(hNewAxes,'Engine Thrust %');  %# Add a label to the right y axis
set(findall(gcf,'-property','Fontname'),'Fontname','Times New Roman')
set(findall(gcf,'-property','FontSize'),'FontSize',10)