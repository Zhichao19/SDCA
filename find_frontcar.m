function [frontcar]=find_frontcar(i,aim,vmax,L,kind)
if kind == 1
    temp_aim = find(vmax(:,aim)==23);
elseif kind == 2
    temp_aim = find(vmax(:,aim)==30);
elseif kind ==3
    temp_aim = find(vmax(:,aim)>=23);
end

if i > max(temp_aim)  % 目标车道前方没有truck
    frontcar = temp_aim(1);
else %目标车道前方有truck
    frontcar = min(temp_aim(find(temp_aim >= i)));
end

end
