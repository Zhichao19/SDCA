function [plaza_new,v_new,vmax_new,l_new,v_s_new,a_new,M_new]=move_forward(plaza,v,vmax,l,v_s,a,M);
[L,W]=size(plaza);% The size of the lane
gap=zeros(L,W);
plaza_new = zeros(L,W);
v_new = -1*ones(L,W);
vmax_new = zeros(L,W);
l_new = zeros(L,W);
v_s_new = zeros(L,W);
a_new = zeros(L,W);
M_new = zeros(L,W);

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
        plaza_new(pos,lanes)=1;
        v_new(pos,lanes) = v(i,lanes);
        vmax_new(pos,lanes) = vmax(i,lanes);
        l_new(pos,lanes) = l(i,lanes);
        v_s_new(pos,lanes) = v_s(i,lanes);
        a_new(pos,lanes) = a(i,lanes);
        M_new(pos,lanes) = M(i,lanes);
        
        
    end
end
end


