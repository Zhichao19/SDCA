function [plaza,v]=create_plaza(B,plazalength);

plaza=zeros(plazalength,B+2);
v=-1*ones(plazalength,B+2); 

plaza(1:plazalength,[1,2+B])=-1;% all rows, 1 and 2+B columns

