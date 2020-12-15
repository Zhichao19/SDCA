function [l,v_s,a,M] = generate_properties(plaza,vmax,parameters)
[L,W]=size(plaza);% The size of the lane, including the boundary
[l_car,v_max_car,v_s_car,a_car,M_car,l_truck,v_max_truck,v_s_truck,a_truck,M_truck]= deal(parameters{:});
l=zeros(L,W);
v_s=zeros(L,W);
a=zeros(L,W);
M=zeros(L,W);

for lanes=2:W-1;
    temp=find(plaza(:,lanes)==1); % find vehicles indces
    for k=1:length(temp)          % for each vehicle
        i=temp(k);      
        if vmax(i,lanes) == v_max_truck
            l(i,lanes) = l_truck;
            v_s(i,lanes) = v_s_truck;
            a(i,lanes) = a_truck;
            M(i,lanes) = rand * (M_truck - 1) + 1;
        end
        if vmax(i,lanes) == v_max_car
            l(i,lanes) = l_car;
            v_s(i,lanes) = v_s_car;
            a(i,lanes) = a_car;
            M(i,lanes) = M_car;    
        end
    end
end


