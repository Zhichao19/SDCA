function [Density,Velocity,Flow,Change_F] = fundamental_diagram(Probv_set,M_truck_set)

B=2;              % The number of the lanes
plazalength=12000;  % The length of the simulation highways
h=NaN;            % The handle of the image

Density = 2:2:80;
Density = Density';
Velocity = [];
Flow = [];
Change_F = [];

for rho = 2:2:80

    l_car = 6; v_max_car = 30; v_s_car = 7; a_car = 2; M_car = 5;
    l_truck = 12; v_max_truck = 23; v_s_truck = 7; a_truck = 1; M_truck = M_truck_set;
    parameters = {l_car,v_max_car,v_s_car,a_car,M_car,l_truck,v_max_truck,v_s_truck,a_truck,M_truck};

    [plaza,v]=create_plaza(B,plazalength);
    % h=show_plaza(plaza,h,0.1);
    changing_N=0;

    iterations=5000;    % Number of iterations
    % rho = 10;            % density unit: veh/km
    % probc=0.1;          % Density of the cars
    probv=[Probv_set 1];      % Density of two kinds of vehicles: truck and car
    % probslow=0.3;       % The probability of random slow
    % Dsafe=1;            % The safe gap distance for the car to change the lane
    VTypes=[v_max_truck,v_max_car];       % Maximum speed of two different cars 

    num = floor(rho * plazalength * B /1000); % The number of all vehicles
    num1 = floor(num * probv(1));             % The number of all trucks

    [L,W,num,num1,plaza,v,vmax]=generate_car(plaza,v,rho,probv,VTypes);
    % temp_1 = find(plaza(:,2)==1);
    % headway_1 = zeros(size(temp_1));
    % temp_2 = find(plaza(:,3)==1);
    % [plaza,v,vmax]=new_cars(plaza,v,probc,probv,VTypes);% Generate two types of vehicles on the lane

    [l,v_s,a,M] = generate_properties(plaza,vmax,parameters);

    % time_space = get_time_space(0,plaza,v,vmax,l,v_s,a,M);

    % size(find(plaza==1)) % the total number of vehicles
    PLAZA=rot90(plaza,2); %transfer matrix
    % h=show_plaza(PLAZA,h,0.1); %show
    v_ave_t = []; 
    for t=1:iterations;
        t
        % size(find(plaza==1));
        PLAZA=rot90(plaza,2); % transfer???
        % h=show_plaza(PLAZA,h,0.1);
        [d_acc,d_keep,d_dec]=safety_distance(plaza,v,l,v_s,a,M);
        [changing_N,plaza,v,vmax,l,v_s,a,M]=lane_changing(changing_N,t,iterations,plaza,v,vmax,l,v_s,a,M,d_acc,d_keep,d_dec);
        [d_acc,d_keep,d_dec]=safety_distance(plaza,v,l,v_s,a,M);
        [R_a]=slow_to_accleration(plaza,v,l,v_s,a,M);
        [v,gap]=accleration(plaza,v,vmax,l,v_s,a,M,R_a,d_acc,d_keep,d_dec);
        % temp_v0_1 = find(v(:,2)==0);
        % temp_v0_2 = find(v(:,3)==0);
        [plaza,v,vmax,l,v_s,a,M]=move_forward(plaza,v,vmax,l,v_s,a,M);
        % temp_v0_1 = find(v(:,2)==0);
        % temp_v0_2 = find(v(:,3)==0);

        % pos_1 = find(plaza(:,2)==1);
        % pos_2 = find(plaza(:,3)==1);
        % velo_1 = find(v(:,2)~=-1);
        % velo_2 = find(v(:,3)~=-1);
        % t
        if (t >= iterations - 1000)
            time_space = get_time_space_nowrite(t,plaza,v,vmax,l,v_s,a,M);
            v_ave_t = [v_ave_t; 3.6 * mean(time_space(:,4))];
        end
        % [v,gap,LUP,LDOWN]=para_count(plaza,v,vmax);
        % [plaza,v,vmax]=switch_lane(plaza,v,vmax,gap,LUP,LDOWN);
        % [plaza,v,vmax]=random_slow(plaza,v,vmax,probslow);
        
    end
    changing_f=changing_N/(num*1000);
    Change_F = [Change_F ; changing_f];
    Velocity = [Velocity ; mean(v_ave_t)];
    
end

Flow = Velocity.*Density;