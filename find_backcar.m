function [backcar]=find_backcar(i,aim,vmax,L,kind)
if kind == 1
    temp_aim = find(vmax(:,aim)==23);
elseif kind == 2
    temp_aim = find(vmax(:,aim)==30);
elseif kind ==3
    temp_aim = find(vmax(:,aim)>=23);
end
n=length(temp_aim);
if i < min(temp_aim)  % Ŀ�공��ǰ��û��truck
    backcar = temp_aim(n);
else %Ŀ�공��ǰ����truck
    backcar = max(temp_aim(find(temp_aim <= i)));
end

end