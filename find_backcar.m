function [backcar]=find_backcar(i,aim,vmax,L,kind)
if kind == 1
    temp_aim = find(vmax(:,aim)==23);
elseif kind == 2
    temp_aim = find(vmax(:,aim)==30);
elseif kind ==3
    temp_aim = find(vmax(:,aim)>=23);
end
n=length(temp_aim);
if i < min(temp_aim)  % 目标车道前方没有truck
    backcar = temp_aim(n);
else %目标车道前方有truck
    backcar = max(temp_aim(find(temp_aim <= i)));
end

end