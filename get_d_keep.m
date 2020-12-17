function [d_keep] = get_d_keep(k,preceding,temp,lanes,v,a,M)
    delta_v_keep = v(temp(preceding),lanes) - M(temp(preceding),lanes) - ( v(temp(k),lanes) );
    delta_M = M(temp(preceding),lanes) - M(temp(k),lanes);
    if (delta_M~=0)
        tau_1_keep = floor(delta_v_keep/delta_M);
        tau_2_keep = floor((v(temp(k),lanes))/M(temp(k),lanes));
        d_keep_1 = zeros(tau_1_keep + 1,1);
        d_keep_2 = zeros(tau_2_keep + 1,1);
        for i = 0 : tau_1_keep
            d_keep_1(i+1) = v(temp(k),lanes) - i * M(temp(k),lanes) - (v(temp(preceding),lanes) - M(temp(preceding),lanes) - i * M(temp(preceding),lanes));
        end
        for i = 0 : tau_2_keep
            d_keep_2(i+1) = v(temp(k),lanes) - i * M(temp(k),lanes) - (v(temp(preceding),lanes) - M(temp(preceding),lanes) - i * M(temp(preceding),lanes));
        end
        d_keep = min(sum(d_keep_1),sum(d_keep_2));
        
    else
        ubound_1 = floor((v(temp(k),lanes)) / M(temp(k),lanes));
        ubound_2 = floor((v(temp(preceding),lanes) - M(temp(k),lanes)) / M(temp(k),lanes));
        sum_1 = zeros(ubound_1 + 1,1);
        sum_2 = zeros(ubound_2 + 1,1);
        for i = 0 : ubound_1
            sum_1(i + 1) = v(temp(k),lanes) - i * M(temp(k),lanes);
        end
        for i = 0 : ubound_2
            sum_2(i + 1) = v(temp(preceding),lanes) - M(temp(preceding),lanes) - i * M(temp(preceding),lanes);   
        end
        d_keep = max(0,sum(sum_1)-sum(sum_2));
    end