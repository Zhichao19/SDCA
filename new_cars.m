function [plaza,v,vmax]=new_cars(plaza,v,probc,probv,VTypes);
    [L,W]=size(plaza);
    vmax=zeros(L,W); % vmax matrix
    for lanes=2:W-1; % lane columns
        for i=1:L;   % all rows
            if(rand<=probc) % Generate a car randomly on this pisition 
                tmp=rand;
                plaza(i,lanes)=1;     % generate a vehicle
                for k=1:length(probv) % two types of vehicles
                    if(tmp<=probv(k)) % which type of vehicles
                        vmax(i,lanes)=VTypes(k); 
                        v(i,lanes)=ceil(rand*vmax(i,lanes));% Initial speed for current position
                        break;
                    end
                end
            end
        end
    end
    % Cars do not meet density requirement
    needn=ceil((W-2)*L*probc);
    number=size(find(vmax~=0),1); %find() return the linear index
    if(number<needn) % if density is smaller than expected
        while(number~=needn)
            i=ceil(rand*L);
            lanes=floor(rand*(W-2))+2;
            if(plaza(i,lanes)==0)
                plaza(i,lanes)=1;
                for k=1:length(probv)
                   if(tmp<=probv(k))
                       vmax(i,lanes)=VTypes(k);
                       v(i,lanes)=ceil(rand*vmax(i,lanes));
                       break;
                   end
                end
                number=number+1;
            end
        end
    end
    if(number>needn)% if density is bigger than expected
        temp=find(plaza==1);
        for k=1:number-needn;
            i=temp(k);
            plaza(i)=0;
            vmax(i)=0;
            v(i)=0;
        end
    end
end