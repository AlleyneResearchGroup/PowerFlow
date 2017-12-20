function [ Fail_string ] = ResetMissionLeg( MSSN )

%This function resets the mission leg of the lists in order to reflect a
%new mission in case of an emergency landing fault. 
for i=1:length(MSSN.gen.state)
   if length(MSSN.gen.state(1:i))>length(MSSN.gen.state(1:end))
       return
   else
    if MSSN.gen.state(i)==1
        Mission{i}='Startup';
    elseif MSSN.gen.state(i)==2
          Mission{i}='Taxi';
    elseif MSSN.gen.state(i)==3
          Mission{i}='Takeoff';
    elseif MSSN.gen.state(i)==4
          Mission{i}='Climb';
    elseif MSSN.gen.state(i)==5
          Mission{i}='Cruise';
    elseif MSSN.gen.state(i)==6
          Mission{i}='Descent';
    elseif MSSN.gen.state(i)==7
          Mission{i}='Loiter';
    elseif MSSN.gen.state(i)==8
          Mission{i}='Approach';
    elseif MSSN.gen.state(i)==9
          Mission{i}='Landing';
    elseif MSSN.gen.state(i)==10
          Mission{i}='Shutdown';
    end
    end
end
k=0;

for j=2:length(Mission)-1
    if isempty(Mission{j})==1 || (strcmp(Mission{j},Mission{j-1})==1 && strcmp(Mission{j},Mission{j+1})==0)%%This right here.
        
    elseif isempty(Mission{j})==0 || (strcmp(Mission{j},Mission{j-1})==1 && strcmp(Mission{j},Mission{j+1})==1)
        
         k=k+1;
       Mission_string{k}=Mission{j};
    end
end

for v=1:length(Mission_string)-2
   
       if (strcmp(Mission_string{v+2},Mission_string{v}) && strcmp(Mission_string{v+1},Mission_string{v}))
          Mission_string{v}=[];
       end
end
Mission_string;
k=1;
for j=1:length(Mission_string)
    if isempty(Mission_string{j})==1 
        
    elseif isempty(Mission_string{j})==0 
        
         
       Mission_string2{k}=Mission_string{j};
       k=k+1;
    end
end

in_str=Mission_string2;
phaseNo(1) = sum(strncmp(in_str,'Startup',3));
phaseNo(2) = sum(strncmp(in_str,'Taxi',3));
phaseNo(3) = sum(strncmp(in_str,'Takeoff',3));
phaseNo(4) = sum(strncmp(in_str,'Climb',3));
phaseNo(5) = sum(strncmp(in_str,'Cruise',3));
phaseNo(6) = sum(strncmp(in_str,'Descent',3));
phaseNo(7) = sum(strncmp(in_str,'Loiter',3));
phaseNo(8) = sum(strncmp(in_str,'Approach',3));
phaseNo(9) = sum(strncmp(in_str,'Landing',3));
phaseNo(10) = sum(strncmp(in_str,'Shutdown',3));
ind0 = find(phaseNo > 1);
for i = 1:length(ind0)
    switch ind0(i)
        case 1
            ind1 = find(strncmp(in_str,'Startup',3));
            for j = 1:length(ind1)
                in_str{ind1(j)} = ['Startup ' int2str(j)];
            end
        case 2
            ind2 = find(strncmp(in_str,'Taxi',3));
            for j = 1:length(ind2)
                in_str{ind2(j)} = ['Taxi ' int2str(j)];
            end
        case 3
            ind3 = find(strncmp(in_str,'Takeoff',3));
            for j = 1:length(ind3)
                in_str{ind3(j)} = ['Takeoff ' int2str(j)];
            end
        case 4
            ind4 = find(strncmp(in_str,'Climb',3));
            for j = 1:length(ind4)
                in_str{ind4(j)} = ['Climb ' int2str(j)];
            end
        case 5
            ind5 = find(strncmp(in_str,'Cruise',3));
            for j = 1:length(ind5)
                in_str{ind5(j)} = ['Cruise ' int2str(j)];
            end
        case 6
            ind6 = find(strncmp(in_str,'Descent',3));
            for j = 1:length(ind6)
                in_str{ind6(j)} = ['Descent ' int2str(j)];
            end
        case 7
            ind7 = find(strncmp(in_str,'Loiter',3));
            for j = 1:length(ind7)
                in_str{ind7(j)} = ['Loiter ' int2str(j)];
            end
        case 8
            ind8 = find(strncmp(in_str,'Approach',3));
            for j = 1:length(ind8)
                in_str{ind8(j)} = ['Approach ' int2str(j)];
            end
        case 9
            ind9 = find(strncmp(in_str,'Landing',3));
            for j = 1:length(ind9)
                in_str{ind9(j)} = ['Landing ' int2str(j)];
            end
        case 10
            ind10 = find(strncmp(in_str,'Shutdown',3));
            for j = 1:length(ind10)
                in_str{ind10(j)} = ['Shutdown ' int2str(j)];
            end
    end
end
Fail_string=in_str;
end

