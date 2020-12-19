clc;
clear all;
close all;

[Density,Velocity_1,Flow_1,Change_F_1] = fundamental_diagram(0.1,3);
[Density,Velocity_2,Flow_2,Change_F_2] = fundamental_diagram(0.2,3);
[Density,Velocity_3,Flow_3,Change_F_3] = fundamental_diagram(0.3,3);
[Density,Velocity_4,Flow_4,Change_F_4] = fundamental_diagram(0.4,3);
[Density,Velocity_5,Flow_5,Change_F_5] = fundamental_diagram(0.5,3);

[Density,Velocity_11,Flow_11,Change_F_11] = fundamental_diagram(0.1,1);
[Density,Velocity_12,Flow_12,Change_F_12] = fundamental_diagram(0.1,2);
[Density,Velocity_13,Flow_13,Change_F_13] = fundamental_diagram(0.1,3);
[Density,Velocity_14,Flow_14,Change_F_14] = fundamental_diagram(0.1,4);
[Density,Velocity_15,Flow_15,Change_F_15] = fundamental_diagram(0.1,5);