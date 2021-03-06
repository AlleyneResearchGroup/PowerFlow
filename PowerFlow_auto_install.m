%POWERFLOW_AUTO_INSTALL installs the PowerFlow toolset
%   POWERFLOW_AUTO_INSTALL should be executed after extracting the
%   PowerFlow toolset to the desired installation directory.  When called,
%   the script will install the necessary directories for operation of the
%   PowerFlow toolset.
%
%   See also addpath genpath

%   Developed by Matthew Williams - UIUC

spath  = fileparts(mfilename('fullpath'));    % path of executed script

% installing property tables directory
dir_path{1} = fullfile(spath,'PropertyTables');
if exist(dir_path{1},'dir')
    addpath(genpath(dir_path{1}))
    err(1) = true;
else
    err(1) = false;
end

% installing support functions directory
dir_path{2} = fullfile(spath,'SupportFunctions');
if exist(dir_path{2},'dir')
    addpath(genpath(dir_path{2}))
    err(2) = true;
else
    err(2) = false;
end

% installing documentation directory
dir_path{3} = fullfile(spath,'doc\help');
if exist(dir_path{3},'dir')
    addpath(genpath(dir_path{3}))
    err(3) = true;
else
    err(3) = false;
end

% installing images directory
dir_path{4} = fullfile(spath,'images');
if exist(dir_path{4},'dir')
    addpath(genpath(dir_path{4}))
    err(4) = true;
else
    err(4) = false;
end

% installing doc directory
dir_path{5} = fullfile(spath,'doc');
if exist(dir_path{5},'dir')
    addpath(genpath(dir_path{5}))
    err(5) = true;
else
    err(5) = false;
end


dir_path{6} = spath;
if exist(dir_path{6},'dir')
    addpath(dir_path{6})
    err(6) = true;
else
    err(6) = false;
end


% Error checking
if ( err(1) == false && err(2) == false && err(3) ==  false && err(4) == false && err(5) == false && err(6) == false )
    warning(['PowerFlow_auto_install.m failed to install the necessary '...
        'directories. Administrator privileges may be required. Check', ...
        ' necessary privileges of the installation directory.'])
elseif ( err(1) == false || err(2) == false || err(3) ==  false || err(4) == false || err(5) == false || err(6) == false )
    warning(['One or more directories failed to install.  Manual ',...
        'installation required for the following:'])
    for i=1:6
        if err(i) == false
            disp(dir_path{i})
        end
    end
else
    disp(['Successfully installed the PowerFlow toolset. '...
        'MATLAB/Simulink may need to be restarted.'])
end

savepath      % saves the path     

clear spath dir_path err
