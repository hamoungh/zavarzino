function [color]=color_mapping_function(speed,utilization)
A=[];
% High speed and high utilization [1 1] Will give green [0 1 0] 
% Low speed and high utilization [0 1] or [.5 1] will give red [1 0 0] 
% Low speed and low utilization [0 0] will give red [1 0 0]
% High speed and low utilization [1 0] will give white [1 1 1]
A=...
[1  1
0.7 1
0   1
0   0
1   0];
yy=...
[0      1       0
 1      0       0
 1      0       0
 1      0       0
 0.8    0.8     0.8]; 
A=[A; [ linspace(0.7,0,6)' ones(6,1)]];
yy=[yy; [ones(6,1) zeros(6,1) zeros(6,1)]];
 
p = polyfitn(A,yy(:,1),1)
red = polyvaln(p,[speed utilization]); 
p = polyfitn(A,yy(:,2),1)
green = polyvaln(p,[speed utilization]);
%p = polyfitn(A,yy(:,3),1);
%blue = polyvaln(p,[speed utilization]);
blue=zeros(size(speed));
color=[red green blue];
 % color=[speed utilization]*x;
end





