function [time_space] = get_time_space_nowrite(t,plaza,v,vmax,l,v_s,a,M)
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
    
