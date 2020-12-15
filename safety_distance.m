function [d_acc,d_keep,d_dec]=safety_distance(plaza,v,l,v_s,a,M)
[L,W]=size(plaza);% The size of the lane, including the boundary
d_acc = -1 * ones(L,W);
d_keep = -1 * ones(L,W);
d_dec = -1 * ones(L,W);

for lanes=2:W-1   % lane by lane
    temp=find(plaza(:,lanes)==1); % index and position
    nn=length(temp);              % The number of cars in this lane
    for k = 1 : nn
        i=temp(k);
        if(k==nn)                 % for the first vehicle
            preceding = 1;
            d_acc(temp(k),lanes) = get_d_acc(k,preceding,temp,lanes,v,a,M);
            d_keep(temp(k),lanes) = get_d_keep(k,preceding,temp,lanes,v,a,M);
            d_dec(temp(k),lanes) = get_d_dec(k,preceding,temp,lanes,v,a,M);
            continue;
        else
            preceding = k + 1;
            d_acc(temp(k),lanes) =  get_d_acc(k,preceding,temp,lanes,v,a,M);
            d_keep(temp(k),lanes) = get_d_keep(k,preceding,temp,lanes,v,a,M);
            d_dec(temp(k),lanes) = get_d_dec(k,preceding,temp,lanes,v,a,M);
        end
    end
end
