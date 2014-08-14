function [color]=color_mapping_function2(speed,utilization)
%red=zeros(size(speed));
red=ones(size(speed));
%red(speed< 0.7)=1;
green=zeros(size(speed)); 
%green(speed> 0.7)=1;
blue=zeros(size(speed));

color=[red green blue];
 % color=[speed utilization]*x;
end


