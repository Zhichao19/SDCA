%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A Two-Lane Cellular Automaton Traffic Flow Model with the Keep-Right Rule
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;

B=2;              % The number of the lanes
plazalength=120;  % The length of the simulation highways
h=NaN;            % The handle of the image

l_car = 6; v_max_car = 30; v_s_car = 7; a_car = 2; M_car = 5;
l_truck = 12; v_max_truck = 23; v_s_truck = 7; a_truck = 1; M_truck = 5;
parameters = {l_car,v_max_car,v_s_car,a_car,M_car,l_truck,v_max_truck,v_s_truck,a_truck,M_truck};

[plaza,v]=create_plaza(B,plazalength);
% h=show_plaza(plaza,h,0.1);

iterations=1000;    % Number of iterations
rho = 30;            % density unit: veh/km
probc=0.1;          % Density of the cars
probv=[0.5 1];      % Density of two kinds of cars
probslow=0.3;       % The probability of random slow
Dsafe=1;            % The safe gap distance for the car to change the lane
VTypes=[v_max_truck,v_max_car];       % Maximum speed of two different cars 

[L,W,num,num1,plaza,v,vmax]=generate_car(plaza,v,rho,probv,VTypes);
% [plaza,v,vmax]=new_cars(plaza,v,probc,probv,VTypes);% Generate two types of vehicles on the lane

[l,v_s,a,M] = generate_properties(plaza,vmax,parameters);



% size(find(plaza==1)) % the total number of vehicles
PLAZA=rot90(plaza,2); %transfer matrix
% h=show_plaza(PLAZA,h,0.1); %show
for t=1:iterations;
    % size(find(plaza==1));
    PLAZA=rot90(plaza,2); % transfer???
    % h=show_plaza(PLAZA,h,0.1);
    [d_acc,d_keep,d_dec]=safety_distance(plaza,v,l,v_s,a,M);
    [R_a]=slow_to_accleration(plaza,v,l,v_s,a,M);
    [v_new,gap]=accleration(plaza,v,vmax,l,v_s,a,M,R_a,d_acc,d_keep,d_dec);
    [plaza,v,vmax,l,v_s,a,M]=move_forward(plaza,v_new,vmax,l,v_s,a,M);
    % [v,gap,LUP,LDOWN]=para_count(plaza,v,vmax);
    % [plaza,v,vmax]=switch_lane(plaza,v,vmax,gap,LUP,LDOWN);
    % [plaza,v,vmax]=random_slow(plaza,v,vmax,probslow);
    
end




