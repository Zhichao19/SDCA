function [v_new,gap]=accleration(plaza,v,vmax,l,v_s,a,M,R_a,d_acc,d_keep,d_dec)
[L,W]=size(plaza);% The size of the lane, including the boundary
v_new =  -1 * ones(L,W);
gap = zeros(L,W);
R_s = 0.1 * ones(L,W);

temp_v0_1 = find(v(:,2)==0);
temp_v0_2 = find(v(:,3)==0);
   
for lanes=2:W-1   % lane by lane
    temp=find(plaza(:,lanes)==1); % index and position
    nn=length(temp);              % The number of cars in this lane
    for k = 1 : nn
        i=temp(k);
        if(k==nn)                 % for the first vehicle
            preceding = 1;
            gap(i,lanes)=L-(i-temp(preceding) + l(temp(preceding),lanes));% periodic boundary 
        else
            preceding = k + 1;
            gap(i,lanes)=temp(preceding)-i-l(temp(preceding),lanes);
        end
        %%%%%%%%%%%%%%%%%%%% S3a
        if (gap(i,lanes) >= d_acc(i,lanes))
            if (rand <= R_a(i,lanes))
                v_new(i,lanes) = min(v(i,lanes) + a(i,lanes), vmax(i,lanes));
            else
                v_new(i,lanes) = v(i,lanes);
            end
        end
        %%%%%%%%%%%%%%%%%%%% S3b
        if ((d_acc(i,lanes) > gap(i,lanes)) & (gap(i,lanes) >= d_keep(i,lanes))) | (v(i,lanes) == vmax(i,lanes))
            if (rand <= R_s(i,lanes))
                v_new(i,lanes) = max(v(i,lanes) - a(i,lanes), 0);
            else
                v_new(i,lanes) = v(i,lanes);
            end                
        end
        %%%%%%%%%%%%%%%%%%%% S3c
        if (d_keep(i,lanes) > gap(i,lanes)) & (gap(i,lanes) >= d_dec(i,lanes))
            v_new(i,lanes) = max(v(i,lanes) - a(i,lanes), 0);
        end
        %%%%%%%%%%%%%%%%%%%% S3d
        if (v(i,lanes) > 0) & (gap(i,lanes) < d_dec(i,lanes) )
            v_new(i,lanes) = max(v(i,lanes) - M(i,lanes),0);
        end
    end
end
temp_v0_1_new = find(v_new(:,2)==0);
temp_v0_2_new = find(v_new(:,3)==0);
v(1,1);