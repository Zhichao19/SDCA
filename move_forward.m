function [plaza,v,vmax,l,v_s,a,M]=move_forward(plaza,v,vmax,l,v_s,a,M);
[L,W]=size(plaza);% The size of the lane
gap=zeros(L,W);
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

for lanes=2:W-1;
    temp=find(plaza(:,lanes)==1);
    nn=length(temp);
    for k=1:nn;
        i=temp(k);
        if(v(i,lanes)<=gap(i,lanes))
        pos=mod(i+v(i,lanes)-1,L)+1;
        end
        if(v(i,lanes)>gap(i,lanes))
        pos=mod(i+gap(i,lanes)-1,L)+1;
        end
        if(pos~=i)
            % i
            % k
            % lanes
            % pos
            % v(i,lanes)
            % gap(i,lanes)
        plaza(pos,lanes)=1;
        v(pos,lanes)=v(i,lanes);
        vmax(pos,lanes)=vmax(i,lanes);
        l(pos,lanes) = l(i,lanes);
        v_s(pos,lanes) = v_s(i,lanes);
        a(pos,lanes) = a(i,lanes);
        M(pos,lanes) = M(i,lanes);  

        plaza(i,lanes)=0;
        v(i,lanes)=-1;
        vmax(i,lanes)=0;
        l(i,lanes) = 0;
        v_s(i,lanes) = 0;
        a(i,lanes) = 0;
        M(i,lanes) = 0;  
        end
    end
end
