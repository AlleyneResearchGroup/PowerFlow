load('2013_03_22_SAE_data2.mat')
j=0;
h=subplot(2,1,1); hold on;

for i = 1:2:21
    j=j+1
    if mod(j,2)==1
    patch([MSSN.gen.time(i) MSSN.gen.time(i+1) MSSN.gen.time(i+1) MSSN.gen.time(i)]/3600,[0 0 60000 60000],[.95 .95 .95], 'EdgeColor','none')
    elseif mod(j,2)==0   
    patch([MSSN.gen.time(i) MSSN.gen.time(i+1) MSSN.gen.time(i+1) MSSN.gen.time(i)]/3600,[0 0 60000 60000],[.92 .92 .92], 'EdgeColor','none')
    end         
end
set(gca,'YTick',[0:10:50])

set(gca, 'Layer', 'top')
xlabel('Mission Time [Hr.]')
ylabel('Altitude [1000 x Ft.]')
axis([0 36960/(2*3600) 0 56000/1000])
r=550*MSSN.eng.EngThrust1/1000
a=plot (MSSN.cond.time/3600, MSSN.cond.alt/1000,'linewidth',2,'color','k')
b=plot(MSSN.eng.time/3600,r ,'k-.','linewidth',2)

legend([a,b],'Altitude','Thrust','Orientation','Horizontal')
axesPosition = get(gca,'Position');  
 hNewAxes = axes('Position',axesPosition,...  %# Place a new axes on top...
                'Color','none',...           %#   ... with no background color
                'YLim',[0 100],...            %#   ... and a different scale
                'YAxisLocation','right',...  %#   ... located on the right
                'XTick',[],...               %#   ... with no x tick marks
                'Box','off');                %#   ... and no surrounding box
ylabel(hNewAxes,'Engine Thrust [%]');  %# Add a label to the right y axis
set(findall(gcf,'-property','Fontname'),'Fontname','Times New Roman')
set(findall(gcf,'-property','FontSize'),'FontSize',10)

