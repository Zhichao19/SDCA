function [plaza_new,v_new,vmax_new,l_new,v_s_new,a_new,M_new]=lane_changing(plaza,v,vmax,l,v_s,a,M,d_acc,d_keep,d_dec)
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
temp2=find(plaza(:,2)==1);
temp3=find(plaza(:,3)==1);

for lanes=2:W-1;
    if (lanes==2)
        aim=3;
        n=length(temp2);
        m=length(temp3);
        for k=1:n
            i=temp2(k);
            f_car=find_frontcar(i,aim,vmax,L,3);
            f=find(temp3==f_car);
            if (f==1)
                b = m;
            else
                b = f-1;
            end
            b_car=temp3(b);
            if (gap(i,lanes)<d_acc(i,lanes)) && (plaza(i,aim)~=1) && (i-b_car-l(i,lanes)>v(b_car,aim))
                cars_front = [i,f_car];
                v_other=v;
                v_other(i,aim)=v(i,lanes);
                a_other=a;
                a_other(i,aim)=a(i,lanes);
                M_other=M;
                M_other(i,aim)=M(i,lanes);
                d_acc_front=get_d_acc(1,2,cars_front,aim,v_other,a_other,M_other);
                cars_back = [b_car,i];
                d_acc_back=get_d_acc(1,2,cars_back,aim,v_other,a_other,M_other);
                if (f_car-i-l(f_car,aim)>=d_acc_front) && (gap(b_car,aim)>d_acc_back+l(i,lanes)) 
                    plaza_new(i,aim)=plaza(i,lanes);
                    v_new(i,aim)=v(i,lanes);
                    vmax_new(i,aim)=vmax(i,lanes);
                    l_new(i,aim)=l(i,lanes);
                    v_s_new(i,aim)=v_s(i,lanes);
                    a_new(i,aim)=a(i,lanes);
                    M_new(i,aim)=M(i,lanes);
                else
                    plaza_new(i,lanes)=plaza(i,lanes);
                    v_new(i,lanes)=v(i,lanes);
                    vmax_new(i,lanes)=vmax(i,lanes);
                    l_new(i,lanes)=l(i,lanes);
                    v_s_new(i,lanes)=v_s(i,lanes);
                    a_new(i,lanes)=a(i,lanes);
                    M_new(i,lanes)=M(i,lanes);
                end
            else
                plaza_new(i,lanes)=plaza(i,lanes);
                v_new(i,lanes)=v(i,lanes);
                vmax_new(i,lanes)=vmax(i,lanes);
                l_new(i,lanes)=l(i,lanes);
                v_s_new(i,lanes)=v_s(i,lanes);
                a_new(i,lanes)=a(i,lanes);
                M_new(i,lanes)=M(i,lanes);
            end
        end
    end
    if (lanes==3)
        aim=2;
        n=length(temp3);
        m=length(temp2);
        for k=1:n
            i=temp3(k);
            f_car=find_frontcar(i,aim,vmax,L,3);
            f=find(temp2==f_car);
            if (f==1)
                b = m;
            else
                b = f-1;
            end
            b_car=temp2(b);
            if (gap(i,lanes)<d_acc(i,lanes)) &&  (plaza(i,aim)~=1) && (i-b_car-l(i,lanes)>v(b_car,aim))
                cars_front = [i,f_car];
                v_other=v;
                v_other(i,aim)=v(i,lanes);
                a_other=a;
                a_other(i,aim)=a(i,lanes);
                M_other=M;
                M_other(i,aim)=M(i,lanes);
                d_acc_front=get_d_acc(1,2,cars_front,aim,v_other,a_other,M_other);
                cars_back = [b_car,i];
                d_acc_back=get_d_acc(1,2,cars_back,aim,v_other,a_other,M_other);
                if (f_car-i-l(f_car,aim)>=d_acc_front) && (gap(b_car,aim)>d_acc_back+l(i,lanes)) 
                    plaza_new(i,aim)=plaza(i,lanes);
                    v_new(i,aim)=v(i,lanes);
                    vmax_new(i,aim)=vmax(i,lanes);
                    l_new(i,aim)=l(i,lanes);
                    v_s_new(i,aim)=v_s(i,lanes);
                    a_new(i,aim)=a(i,lanes);
                    M_new(i,aim)=M(i,lanes);
                else
                    plaza_new(i,lanes)=plaza(i,lanes);
                    v_new(i,lanes)=v(i,lanes);
                    vmax_new(i,lanes)=vmax(i,lanes);
                    l_new(i,lanes)=l(i,lanes);
                    v_s_new(i,lanes)=v_s(i,lanes);
                    a_new(i,lanes)=a(i,lanes);
                    M_new(i,lanes)=M(i,lanes);
                end
            else
                plaza_new(i,lanes)=plaza(i,lanes);
                v_new(i,lanes)=v(i,lanes);
                vmax_new(i,lanes)=vmax(i,lanes);
                l_new(i,lanes)=l(i,lanes);
                v_s_new(i,lanes)=v_s(i,lanes);
                a_new(i,lanes)=a(i,lanes);
                M_new(i,lanes)=M(i,lanes);
            end
        end
    end
end
end