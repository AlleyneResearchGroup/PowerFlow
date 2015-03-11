function varargout=waterloo(option)
% WATERLOO adds Project Waterloo folders to the MATLAB path
% (and Java class paths with the full project installed)
%
% Example:
%       waterloo()
%           Loads all of Project waterloo
%
% To add components individually, or incrementally, supply an input argument
% which is the sum of the following
%      1 for the Graphics Library
%      2 for the Swing Library
%      4 for the Utilities functions
%      8 for the platform specific features
% Thus, waterloo(15) would be equivalent to waterloo() with no arguments
%
% If present, the kcl.jar file will be added to the MATLAB dynamic
% Java class path (not available e.g. on the TMW FEX distribution - visit
% the full project page at the URL below).
%
% ---------------------------------------------------------------------
% Part of the sigTOOL Project and Project Waterloo from King's College
% London.
% http://sigtool.sourceforge.net/
% http://sourceforge.net/projects/waterloo/
%
% Contact: ($$)sigtool(at)kcl($$).ac($$).uk($$)
%
% Author: Malcolm Lidierth 12/10
% Copyright The Author & King's College London 2011-
% ---------------------------------------------------------------------

% Use the Java System Property to store a flag - avoids use of persistent
% variable (which will be reset on clear classes - a pain when developing
% code).

wversion=1.07;

if nargin==1 && ischar(option) && strcmpi(option, 'version')
    d=dir(which('waterloo.m'));
    fprintf('Project Waterloo [Version=%g Dated:%s]\n', wversion, d.date);
    if nargout>0;varargout{1}=wversion;end
    return
end
    
if nargin==0
    option=15;
end
option=uint16(option);

loaded=java.lang.System.getProperty('Waterloo.MCODELoaded');
if ~isempty(loaded)
    loaded=uint16(str2double(loaded));
    and=bitxor(loaded,option);
    option=bitand(and, option);
end

% Option selection
Graphics=bitget(option,1);
Swing=bitget(option,2);
Utilities=bitget(option,3);
Platform=bitget(option,4);

d=dir(which('waterloo.m'));
if option
    % Get the main waterloo folder path
    thisFolder=fileparts(which('waterloo.m'));
    
    % Note that with incremental additions, addpath may be called for
    % folders that are already added, but this is harmless
    
    % Now install those components that are present
    folder=fullfile(thisFolder, 'Waterloo Graphics Library');
    if isdir(folder) && Graphics
        addpath(genpath(folder));
        fprintf('\nProject Waterloo Graphics Library loaded\n');
    end
    
    folder=fullfile(thisFolder, 'Waterloo Swing Library');
    if isdir(folder) && Swing
        addpath(genpath(folder));
        fprintf('\nProject Waterloo Swing Library loaded\n');
    end
    
    folder=fullfile(thisFolder, 'Utilities');
    if isdir(folder) && Utilities
        addpath(genpath(folder));
        fprintf('\nProject Waterloo Utilities loaded\n');
    end
    
    folder=fullfile(thisFolder, 'platform', computer());
    if isdir(folder) && Platform
        addpath(genpath(folder));
        fprintf('\nProject Waterloo Platform Library loaded [%s]\n', computer());
    end
    
    % Set the isLoaded flag
    java.lang.System.setProperty('Waterloo.MCODELoaded',...
        num2str(bitor(option,uint16(str2double(java.lang.System.getProperty('Waterloo.MCODELoaded'))))));
    
    fprintf('\nProject Waterloo [Version=%g Dated:%s]\n', wversion, d.date);
    
    % Add kcl.jar to the dynamic java class path if it's not there already
    folder=fullfile(thisFolder, 'private', 'Java1.6', 'kcl', 'dist');
    if isdir(folder)
        m=methods('kcl.waterloo.graphics.GJGraph');
        % m will be empty if not on class path...
        if isempty(m)
            % so add it
            if exist(fullfile(folder, 'kcl-matlab.jar'),'file')
                javaaddpath(fullfile(folder, 'kcl-matlab.jar'));
                javaaddpath(fullfile(folder, 'lib', 'swingx-all-1.6.3-SNAPSHOT.jar'));
            elseif exist(fullfile(folder, 'kcl.jar'),'file')
                javaaddpath(fullfile(folder, 'kcl.jar'));
            end
            java.lang.System.setProperty('Waterloo.JavaLoaded', 'true');
            fprintf('\nProject Waterloo Java files added to MATLAB Java class path\n');
            
            % Dev only

        end
    else
        fprintf('\nProject Waterloo Java folder not found. To access all features of this library download the full\nand free GNU GPLv3 licensed version from http://sourceforge.net/projects/waterloo/\n');
    end
else
    fprintf('\nProject Waterloo option(s) already loaded [Version=%g Dated:%s]\n', wversion, d.date);
end

return
end


