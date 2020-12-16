function [time_space] = get_time_space(t,plaza,v,vmax,l,v_s,a,M)
[L,W]=size(plaza);% The size of the lane

time_space = [];
time_space_1 = [];
time_space_2 = [];

for lanes=2:W-1;
    temp=find(plaza(:,lanes)==1);
    nn=length(temp);
    for k=1:nn;
        i=temp(k);
        time_space = [time_space; [lanes,t,i,v(i,lanes)]];
        if (lanes == 2)
            time_space_1 = [time_space_1; [lanes,t,i,v(i,lanes)]];
        elseif (lanes == 3)
            time_space_2 = [time_space_2; [lanes,t,i,v(i,lanes)]];
        end

    end
end


lane_1 = fopen(['F:\DTA\CA\SDCA\output\lane1.txt'],'at');
lane_2 = fopen(['F:\DTA\CA\SDCA\output\lane2.txt'],'at');

[r,c]=size(time_space_1);            % 得到矩阵的行数和列数
for i=1:r
    for j=1:c
        fprintf(lane_1,'%d     ',time_space_1(i,j));
    end 
    fprintf(lane_1,'\n');
end
fclose(lane_1);

[r,c]=size(time_space_2);            % 得到矩阵的行数和列数
for i=1:r
    for j=1:c
        fprintf(lane_2,'%d     ',time_space_2(i,j));
    end 
    fprintf(lane_2,'\n');
end
fclose(lane_2);