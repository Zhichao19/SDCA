function [frontcar]=find_frontcar(i,aim,vmax,L,kind)
if kind == 1
    temp_aim = find(vmax(:,aim)==23);
elseif kind == 2
    temp_aim = find(vmax(:,aim)==30);
elseif kind ==3
    temp_aim = find(vmax(:,aim)>=23);
end

if i > max(temp_aim)  % Ŀ�공��ǰ��û��truck
    frontcar = temp_aim(1);
else %Ŀ�공��ǰ����truck
    frontcar = min(temp_aim(find(temp_aim >= i)));
end

end
