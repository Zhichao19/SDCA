function [v_new,gap]=accleration(plaza,v,vmax,l,v_s,a,M,R_a,d_acc,d_keep,d_dec)
[L,W]=size(plaza);% The size of the lane, including the boundary
v_new =  -1 * ones(L,W);
gap = zeros(L,W);
R_s = 0.1 * ones(L,W);
lambda=3;
R_h=1;

temp_v0_1 = find(v(:,2)==0);
temp_v0_2 = find(v(:,3)==0);
temp1=find(plaza(:,2)==1);
temp2=find(plaza(:,3)==1);
for lanes=2:W-1;
    temp=find(plaza(:,lanes)==1); 
    nn=length(temp);% The number of the cars in the lane
    for k=1:nn;
        i=temp(k);
        if(k==nn)
            gap(i,lanes)=L-(i-temp(1)+l(temp(1),lanes));% periodic boundary 
            continue;
        end
        gap(i,lanes)=temp(k+1)-i-l(temp(k+1),lanes);
    end
end
for lanes=2:W-1   % lane by lane
    temp = find(plaza(:,lanes)==1); % index and position
    temp_truck_other = find(l(:,5-lanes)==12);
    nn=length(temp);              % The number of cars in this lane
    for k = 1 : nn
        i=temp(k);
        %%%%%%%%%%%%%%%%%%%% S3a*
        if (l(i,lanes)==12) && (lanes==2) && (length(temp_truck_other)>0)
            aim=3;
            n=length(temp2);
            f_car=find_frontcar(i,aim,vmax,L,1);%%find front truck
            f=find(temp2==f_car);
            if (f==1)
                b = n;
            else
                b = f-1;
            end
            b_car=temp2(b);
            if  (f_car-i-l(f_car,aim)<=lambda*v(i,lanes)) && (b_car>=i-l(i,lanes)-10) && (l(b_car,aim)==6) && (v(b_car,aim)>=23) && (rand<=R_h)
                v_new(i,lanes)=max(v(i,lanes)-a(i,lanes),0);
                break
            end
        end
        if (l(i,lanes)==12) && (lanes==3) && (length(temp_truck_other)>0)
            aim=2;
            n=length(temp1);
            f_car=find_frontcar(i,aim,vmax,L,1);%%find front truck
            f=find(temp1==f_car);
            if (f==1)
                b = n;
            else
                b = f-1;
            end
            b_car=temp1(b);
            if (f_car-i-l(f_car,aim)<=lambda*v(i,lanes)) && (b_car>=i-l(i,lanes)-10) && (l(b_car,aim)==6) && (v(b_car,aim)>=23) && (rand<=R_h)
                v_new(i,lanes)=max(v(i,lanes)-a(i,lanes),0);
                break
            end
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