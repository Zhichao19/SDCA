function [R_a]=slow_to_accleration(plaza,v,l,v_s,a,M)
[L,W]=size(plaza);% The size of the lane, including the boundary
R_a =  -1 * ones(L,W);
R_d = ones(L,W);
R_0 = 0.8 * ones(L,W);

for lanes=2:W-1   % lane by lane
    temp=find(plaza(:,lanes)==1); % index and position
    nn=length(temp);              % The number of cars in this lane
    for k = 1 : nn
        i=temp(k);
        R_a(i,lanes) = min(R_d(i,lanes), R_0(i,lanes) + (v(i,lanes) * (R_d(i,lanes) - R_0(i,lanes)))/v_s(i,lanes));
    end
end
