%RR_SETPERFSLCT Select files for components
%   RR_SETPERFSLCT populates the GUI for the following PowerFlow
%   components:
%   Fuel Tank, Oil Tank, Air Cooled Oil Cooler
%
%   RR_SETPERFSLCT(mode,err) calls the function.  Currently the only
%   supported mode is 2 and err is ignored as an input.  Set err = 0 for
%   execution.

%   Developed by Matthew Williams - UIUC


function RR_SetPerfSlct(mode,err)
h      = get_param(gcb,'handle');   % Get block handle
blk    = gcb;                       % Current block name
hblock = get(h);                    % Parse out handles structure 

% enter if mode == 1 (not currently used
if mode==1
    %{
    if strcmp(hblock.filedir,'0')==0
        try load(hblock.filedir) ;
        catch
            filedir = which(hblock.filename) ;
            if ~isempty(filedir)&&err==1
                warndlg(['File not found for ' hblock.Name ' in specified directory, updating directory information'],'File Location Warning') ;
                set(h,'filedir',filedir) ;
                load(filedir) ;
            elseif err==1
                errordlg(['Cannot Locate Specified Performance File for ' hblock.Name],'Data File Missing!') ; 
            end
        end
        if exist(hblock.Tag)==1         % Tag name and structure name must be the same in the data file
            eval(['fn = fieldnames(' hblock.Tag ');']) ; % Setup popup menu, assume all performance data popups are second var
            popstr = 'popup(' ;
            for ii=1:length(fn)
                popstr = [popstr fn{ii} '|'] ;
            end
            popstr(end) = ')';
            maskstr = get(h,'MaskStyles') ;
            maskstr{2} = popstr ;
            set(h,'MaskStyles',maskstr) ;
        elseif err==1
            errordlg(['Unable to find ' hblock.Tag ' structure in data file'],'Data File Error') ;
        end
    end
    %}
else    % enter if mode == 2
    if strcmp(get(h,'fileslct'),'on')
        [fn,fp] = uigetfile('*.*','Choose File') ; % If user selected the checkbox, prompt user for file
        if fn~=0
            maskstr = get(h,'MaskValues') ; 
            ind = strcmp(hblock.MaskNames,'fileslct');  maskstr{ind==1} = 'off'; 
            ind = strcmp(hblock.MaskNames,'filename');  maskstr{ind==1} = fn;
            ind = strcmp(hblock.MaskNames,'filedir');  maskstr{ind==1} = [fp fn];
            set(h,'MaskValues',maskstr);    % set mask values to new values
        end
    end
end