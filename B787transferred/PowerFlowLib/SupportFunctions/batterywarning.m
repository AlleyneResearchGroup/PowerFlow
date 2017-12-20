function y=batterywarning(u)
v1     = u(1);
vaux   = u(2);
v2     = u(3);
enable = u(4);
flag1  = u(5);
flagaux= u(6);
flag2  = u(7);
logtime = u(8);

if (v1<=18 && flag1==0 && enable==1)
    h = warndlg({'Battery 1 voltage below 18 V! ';'Pause simulation and try increasing battery modules';'This message will close in 5 seconds'});
    fid = fopen('logFile','a+');
    % Write the error to file
    fprintf(fid,'\n Battery 1 voltage below 18 V at %f seconds\n',logtime);
    uiwait(h,5);
    if ishandle(h)~=0
        close(h);
    end
    flag1 = 1;
end

if (vaux<=18 && flagaux==0 && enable==1)
    h = warndlg({'Aux Battery voltage below 18 V! ';'Pause simulation and try increasing battery modules';'This message will close in 5 seconds'});
    fid = fopen('logFile','a+');
    % Write the error to file
    fprintf(fid,'\n Aux Battery voltage below 18 V at %f seconds\n',logtime);
    uiwait(h,5);
    if ishandle(h)~=0
        close(h);
    end
    flagaux = 1;
end

if (v2<=18 && flag2==0 && enable==1)
    h = warndlg({'Battery 2 voltage below 18 V! ';'Pause simulation and try increasing battery modules';'This message will close in 5 seconds'});
    fid = fopen('logFile','a+');
    % Write the error to file
    fprintf(fid,'\n Aux Battery voltage below 18 V at %f seconds\n',logtime);
    uiwait(h,5);
    if ishandle(h)~=0
        close(h);
    end
    flag2 = 1;
end
y(1) = flag1;
y(2) = flagaux;
y(3) = flag2;