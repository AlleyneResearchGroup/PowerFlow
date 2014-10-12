function init_thermal_sourcesink( mode )
%INIT_THERMAL_SOURCESINK  Initialize source & sink blocks for thermal loads.
%   INIT_THERMAL_SOURCESINK('MODE') initilization functions for thermal
%   source and sink blocks.  Mode == 1 for source blocks. Mode == 2 for
%   sink blocks.

%   Developed by Matthew Williams - UIUC

% get current block parameters
h      = get_param(gcb,'handle');   % Get block handle
blk    = gcb;           % current block name
hblock = get(h);        % Parse out handles structure
k = 1;

if mode == 1    % SOURCE BLOCK INITIALIZATION
    %  searching for all thermal sink goto blocks
    [mdl,rem] = strtok(hblock.Path,'/');    % split model name into mdl
    goto_arr = find_system(mdl,'LookUnderMasks','all','FollowLinks','on','Name','therm_goto');

    % populating array with unique ids in use
    for i = 1:size(goto_arr,1)
        [id,rem] = strtok(get_param(goto_arr(i),'GotoTag'),'_');
        if strcmp(id,hblock.load_loc) == 1;
            fromarr(k) = strcat(id,rem);
            k = k + 1;
        end
    end

    % deleteing all from blocks
    delarr = find_system(gcb,'LookUnderMasks','all','FollowLinks','on','BlockType','From');
    for i=1:size(delarr,1)
        delete_block(delarr{i});
    end
    delete_unconnected_lines(blk);

    % if fromarr exists - enter logic; else give warning that no from
    % blocks exist
    if exist('fromarr') == 1
       
        offset = 40;    % position offset
        busoffset = offset * (size(fromarr,2));
        % creating bus
        try
            add_block('built-in/BusCreator',[blk,'/LoadBus'],'Position',[200,30,205,30+busoffset]);
        catch
            delete_block([blk,'/LoadBus']);
            delete_unconnected_lines(blk)
            add_block('built-in/BusCreator',[blk,'/LoadBus'],'Position',[200,30,205,30+busoffset]); 
        end

        % add a line from the load bus to the output port. if error then
        % the line exists and the catch statement does nothing
        try 
            add_line(blk,'LoadBus/1','Load/1','autorouting','on');   
        catch

        end
        % setting number of inputs for load bus
        set_param([blk,'/LoadBus'],'Inputs',num2str(size(fromarr,2)));


        % creating from tags
        % initial position locations for from tags
        x = 30; y = 0; w = 90; h = 16;

        % generating unique FROM tags
        for i = 1:size(fromarr,2);
            % position moves as each tag is added
            pos = [x, y + (i*offset), x+w, y+h + (i*offset)] ;
            
            % try to add FROM block - if it exists already, an error will
            % cause the catch statement to be executed.  block will be
            % delted and re-added
            try
                add_block('built-in/From',[blk,'/From',num2str(i)],'Position',pos);
            catch
                delete_block([blk,'/From',num2str(i)]);
                delete_unconnected_lines(blk);
                add_block('built-in/From',[blk,'/From',num2str(i)],'Position',pos);
            end
            
            % setting the value of the FROM block to link to a
            % corresponding GOTO tag. Adding a line from the FROM tag to
            % the bus
            set_param([blk,'/From',num2str(i)],'GotoTag',fromarr{i});    
            add_line(blk,['From',num2str(i),'/1'],['LoadBus/',num2str(i)],'autorouting','on')
        end
       
    else    % warning statement if no thermal loads are found
        warning(['No thermal loads are connected to thermal source block: ',blk, ...
            '. No matching GOTO tags were found.  This output will be zero.'])
    end

    % clearing used variables from the workspace
    clear x y w h offset k fromarr loc mdl rem id

elseif mode == 2        % SINK BLOCK INITIALIZATION
    % flag variable declarations
    flg = 1;
    flg2 = 0;

    % if the unique ID is 0, generate a random number for the id and then
    % set the flag to enter while loop checking for repeated unique IDs
    if strcmp(hblock.unq_id,'0') == 1;
        randnum = round(rand(1)*8999) + 1000;
        flg = 0;
    else    % if the id is not zero, then it remains the same
        randnum = hblock.unq_id;
        flg = 1;
    end

    % while loop checking for repeated unique IDs
    while flg == 0

        % determine if random number exists elsewhere in model
        % first searching for all thermal sink goto blocks
        [mdl,rem] = strtok(hblock.Path,'/');
        goto_arr = find_system(mdl,'LookUnderMasks','all','FollowLinks','on','Name','therm_goto');

        % populating array with unique ids in use
        for i = 1:size(goto_arr,1);
            [rem,id(i)] = strtok(get_param(goto_arr(i),'GotoTag'),'_');
        end

        % checking for same numbers in use
        for i = 1:size(goto_arr,1)
            if strcmp(id(i),['_',num2str(randnum)]) == 1;
                randnum = round(rand(1)*8999) + 1000;   % number between 1000 - 9999
                flg2 = 1;
            else
                flg2 = 0;
            end
        end

        % exiting while loop if no duplicates
        if flg2 == 0;
            flg = 1;
        end

    end

    % setting mask values 
    % vals loads all mask values - set_param changes unique id
    vals = get_param(blk,'MaskValues');
    set_param(blk,'MaskValues',[vals(1);vals(2);num2str(randnum)]);

    % setting goto label 
    set_param([blk,'/therm_goto'],'GotoTag',[hblock.load_loc,'_Therm_',num2str(hblock.unq_id)]);
   
    clear flg flg2 vals randnum rem id h blk hblock i mdl

else    % if the wrong mode is input to the function, errors out.
    error(['Incorrect mode selected.  See initialization code in ',blk])
end
