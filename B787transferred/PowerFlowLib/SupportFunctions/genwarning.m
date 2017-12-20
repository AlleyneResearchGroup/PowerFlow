function y=genwarning(u)
faultsig = u(1);
auxbus   = u(2);
flag     = u(3);

if (faultsig==0 && flag == 0)
    if auxbus==2
        h = warndlg({'Voltage fault on Generator bus 2 output';'Bus power switched to APU';'This message will close in 5 seconds'});
        uiwait(h,5);
        if ishandle(h)~=0
            close(h);
        end
    end
    flag = 1;
end

y(1) = flag;