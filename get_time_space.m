function [] = get_time_space(t,plaza,v,vmax,l,v_s,a,M)
[L,W]=size(plaza);% The size of the lane

% time_space = [];
% time_space_1 = [];
% time_space_2 = [];
time_space_truck = [];
time_space_truck_1 = [];
time_space_truck_2 = [];
time_space_car = [];
time_space_car_1 = [];
time_space_car_2 = [];

for lanes=2:W-1;
%     temp=find(plaza(:,lanes)==1);
    temp_truck = find(l(:,lanes)==12);
    temp_car = find(l(:,lanes)==6);
    nn_truck = length(temp_truck);
    nn_car = length(temp_car);
    for k = 1:nn_truck
        i = temp_truck(k);
        time_space_truck = [time_space_truck; [lanes,t,i,v(i,lanes)]];
        if (lanes == 2)
            time_space_truck_1 = [time_space_truck_1; [lanes,t,i,v(i,lanes)]];
        elseif (lanes == 3)
            time_space_truck_2 = [time_space_truck_2; [lanes,t,i,v(i,lanes)]];
        end
    end
    for k = 1:nn_car
        i = temp_car(k);
        time_space_car = [time_space_car; [lanes,t,i,v(i,lanes)]];
        if (lanes == 2)
            time_space_car_1 = [time_space_car_1; [lanes,t,i,v(i,lanes)]];
        elseif (lanes == 3)
            time_space_car_2 = [time_space_car_2; [lanes,t,i,v(i,lanes)]];
        end
    end
%     nn=length(temp);
%     for k=1:nn;
%         i=temp(k);
%         time_space = [time_space; [lanes,t,i,v(i,lanes)]];
%         if (lanes == 2)
%             time_space_1 = [time_space_1; [lanes,t,i,v(i,lanes)]];
%         elseif (lanes == 3)
%             time_space_2 = [time_space_2; [lanes,t,i,v(i,lanes)]];
%         end
% 
%     end
end


lane_truck_1 = fopen(['F:\DTA\CA\SDCA\output\lane1_truck.txt'],'at');
lane_truck_2 = fopen(['F:\DTA\CA\SDCA\output\lane2_truck.txt'],'at');
lane_car_1 = fopen(['F:\DTA\CA\SDCA\output\lane1_car.txt'],'at');
lane_car_2 = fopen(['F:\DTA\CA\SDCA\output\lane2_car.txt'],'at');

[r,c]=size(time_space_truck_1);            
for i=1:r
    for j=1:c
        fprintf(lane_truck_1,'%d     ',time_space_truck_1(i,j));
    end 
    fprintf(lane_truck_1,'\n');
end
fclose(lane_truck_1);

[r,c]=size(time_space_truck_2);            
for i=1:r
    for j=1:c
        fprintf(lane_truck_2,'%d     ',time_space_truck_2(i,j));
    end 
    fprintf(lane_truck_2,'\n');
end
fclose(lane_truck_2);

[r,c]=size(time_space_car_1);            
for i=1:r
    for j=1:c
        fprintf(lane_car_1,'%d     ',time_space_car_1(i,j));
    end 
    fprintf(lane_car_1,'\n');
end
fclose(lane_car_1);

[r,c]=size(time_space_car_2);            
for i=1:r
    for j=1:c
        fprintf(lane_car_2,'%d     ',time_space_car_2(i,j));
    end 
    fprintf(lane_car_2,'\n');
end
fclose(lane_car_2);