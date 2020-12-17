function [d_acc] = get_d_acc(k,preceding,temp,lanes,v,a,M)
delta_v_acc = v(temp(preceding),lanes) - M(temp(preceding),lanes) - (v(temp(k),lanes) + a(temp(k),lanes));
delta_M = M(temp(preceding),lanes) - M(temp(k),lanes);
if (delta_M~=0)
    tau_1_acc = floor(delta_v_acc/delta_M);
    tau_2_acc = floor((v(temp(k),lanes)+a(temp(k),lanes))/M(temp(k),lanes));
    d_acc_1 = zeros(tau_1_acc + 1,1);
    d_acc_2 = zeros(tau_2_acc + 1,1);
    for i = 0 : tau_1_acc
        d_acc_1(i+1) = v(temp(k),lanes) + a(temp(k),lanes) - i * M(temp(k),lanes) - (v(temp(preceding),lanes) - M(temp(preceding),lanes) - i * M(temp(preceding),lanes));
    end
    for i = 0 : tau_2_acc
        d_acc_2(i+1) = v(temp(k),lanes) + a(temp(k),lanes) - i * M(temp(k),lanes) - (v(temp(preceding),lanes) - M(temp(preceding),lanes) - i * M(temp(preceding),lanes));
    end
    d_acc = min(sum(d_acc_1),sum(d_acc_2));
    
else
    ubound_1 = floor((v(temp(k),lanes) + a(temp(k),lanes)) / M(temp(k),lanes));
    ubound_2 = floor((v(temp(preceding),lanes) - M(temp(k),lanes)) / M(temp(k),lanes));
    sum_1 = zeros(ubound_1 + 1,1);
    sum_2 = zeros(ubound_2 + 1,1);
    for i = 0 : ubound_1
        sum_1(i + 1) = v(temp(k),lanes) + a(temp(k),lanes) - i * M(temp(k),lanes);
    end
    for i = 0 : ubound_2
        sum_2(i + 1) = v(temp(preceding),lanes) - M(temp(preceding),lanes) - i * M(temp(preceding),lanes);   
    end
    d_acc = max(0,sum(sum_1)-sum(sum_2));
end