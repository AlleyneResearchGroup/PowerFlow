% Columns correspond to wall number
% Rows correspond to fuel tank fraction filled (ascending)
%  Wall number:         1   2   3   4   5   6
%                   0.0
%                   0.1
%                   ...
%                   1.0
%
% area dimensions are currently locked at 11x6 -- updates will need to be
% applied in the mask init of the tank model
%
% Column 1: top of tank; column 2: bottom of tank

oiltankdata.leftsystank = [ ...
         0         0         0         0         0         0;
         0    0.9800    0.0770    0.0440    0.0330    0.0778;
         0    0.9800    0.1540    0.0880    0.0660    0.1556;
         0    0.9800    0.2310    0.1320    0.0990    0.2333;
         0    0.9800    0.3080    0.1760    0.1320    0.3111;
         0    0.9800    0.3850    0.2200    0.1650    0.3889;
         0    0.9800    0.4620    0.2640    0.1980    0.4667;
         0    0.9800    0.5390    0.3080    0.2310    0.5445;
         0    0.9800    0.6160    0.3520    0.2640    0.6222;
         0    0.9800    0.6930    0.3960    0.2970    0.7000;
    0.9800    0.9800    0.7700    0.4400    0.3300    0.7778    ];
    
oiltankdata.rightsystank = [ ...
         0         0         0         0         0         0;
         0    0.9800    0.0770    0.0440    0.0330    0.0778;
         0    0.9800    0.1540    0.0880    0.0660    0.1556;
         0    0.9800    0.2310    0.1320    0.0990    0.2333;
         0    0.9800    0.3080    0.1760    0.1320    0.3111;
         0    0.9800    0.3850    0.2200    0.1650    0.3889;
         0    0.9800    0.4620    0.2640    0.1980    0.4667;
         0    0.9800    0.5390    0.3080    0.2310    0.5445;
         0    0.9800    0.6160    0.3520    0.2640    0.6222;
         0    0.9800    0.6930    0.3960    0.2970    0.7000;
    0.9800    0.9800    0.7700    0.4400    0.3300    0.7778    ];
    
