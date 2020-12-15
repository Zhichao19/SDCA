function [d_dec] = get_d_dec(k,preceding,temp,lanes,v,a,M)
    delta_v_dec = v(temp(preceding),lanes) - M(temp(preceding),lanes) - (v(temp(k),lanes) - a(temp(k),lanes));
    delta_M = M(temp(preceding),lanes) - M(temp(k),lanes);
    if (delta_M~=0)
        tau_1_dec = floor(delta_v_dec/delta_M);
        tau_2_dec = floor((v(temp(k),lanes)-a(temp(k),lanes))/M(temp(k),lanes));
        d_dec_1 = zeros(tau_1_dec + 1,1);
        d_dec_2 = zeros(tau_2_dec + 1,1);
        for i = 0 : tau_1_dec
            d_dec_1(i+1) = v(temp(k),lanes) - a(temp(k),lanes) - i * M(temp(k),lanes) - (v(temp(preceding),lanes) - M(temp(preceding),lanes) - i * M(temp(preceding),lanes));
        end
        for i = 0 : tau_2_dec
            d_dec_2(i+1) = v(temp(k),lanes) - a(temp(k),lanes) - i * M(temp(k),lanes) - (v(temp(preceding),lanes) - M(temp(preceding),lanes) - i * M(temp(preceding),lanes));
        end
        d_dec = min(sum(d_dec_1),sum(d_dec_2));
        
    else
        ubound_1 = floor((v(temp(k),lanes) - a(temp(k),lanes)) / M(temp(k),lanes));
        ubound_2 = floor((v(temp(preceding),lanes) - M(temp(k),lanes)) / M(temp(k),lanes));
        sum_1 = zeros(ubound_1,1);
        sum_2 = zeros(ubound_2,1);
        for i = 0 : sum_1
            sum_1(i + 1) = v(temp(k),lanes) - a(temp(k),lanes) - i * M(temp(k),lanes);
        end
        for i = 0 : sum_2
            sum_2(i + 1) = v(temp(preceding),lanes) - M(temp(preceding),lanes) - i * M(temp(preceding),lanes);   
        end
        d_dec = max(0,sum(sum_1)-sum(sum_2));
    end