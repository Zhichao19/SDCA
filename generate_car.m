function [L,W,num,num1,plaza,v,vmax]=generate_car(plaza,v,rho,probv,VTypes)

[L,W]=size(plaza);
num = floor(rho * L * 2 /1000);
num1 = floor(num * probv(1));
vmax=zeros(L,W); % vmax matrix
for lanes = 2:W-1;
    for i = 1:num
        plaza(ceil(i/2)*12,mod(i,2)+2) = 1;
        if (i<=num1)
            vmax(ceil(i/2)*12,mod(i,2)+2)=VTypes(1);
        else
            vmax(ceil(i/2)*12,mod(i,2)+2)=VTypes(2);
        end
        v(ceil(i/2)*12,mod(i,2)+2) = ceil(rand*vmax(ceil(i/2)*12,mod(i,2)+2));
    end
end



       
