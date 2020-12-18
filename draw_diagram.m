clc;
clear all;
close all;

[Density_3,Velocity_3,Flow_3] = fundamental_diagram(0.3,3);
[Density_4,Velocity_4,Flow_4] = fundamental_diagram(0.4,3);
[Density_5,Velocity_5,Flow_5] = fundamental_diagram(0.5,3);

[Density_11,Velocity_11,Flow_11] = fundamental_diagram(0.1,1);
[Density_12,Velocity_12,Flow_12] = fundamental_diagram(0.1,2);
[Density_14,Velocity_14,Flow_14] = fundamental_diagram(0.1,4);
[Density_15,Velocity_15,Flow_15] = fundamental_diagram(0.1,5);