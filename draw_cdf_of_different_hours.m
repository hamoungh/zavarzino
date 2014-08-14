function []=draw_cdf_of_different_hours()
[ volume_,occupancy_,speed_ ] = get_multidimensional_data( )

% time_(i) = M(:,time);


nbins = 150;
colormap(hot)
hour_=[1 6 12 18];
h=figure 

y=speed_(:,3,hour_(1)); 
[f,x] = ecdf(y);  plot(x,f,'r'); hold on;
y=speed_(:,3,hour_(2));
[f,x] = ecdf(y);  plot(x,f,'--b');
y=speed_(:,3,hour_(3)); 
[f,x] = ecdf(y);  plot(x,f,'m'); hold on;
y=speed_(:,3,hour_(4));
[f,x] = ecdf(y);  plot(x,f,'--g');

% axis([0 20 0 1]);
legend('hour=1','hour=6','hour=12','hour=18');
hXLabel=xlabel('Volume'); 
hYLabel=ylabel('Cumulative Probablity'); 
title('Cumulative distribution function of speed');
% axis([1 12*10^4 0 22]);
 
UtilityLib.print_figure(h,9,7,'speed-histogram-different-hours');
end