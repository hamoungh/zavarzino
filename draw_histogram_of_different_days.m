
 function []=draw_histogram_of_different_days()
 [ volume_,occupancy_,speed_ ] = get_multidimensional_data( )

% sn=round(size(M,1)/(7*24));
% mdN_long=permute(reshape(M(:,[1 2 3 4 5 6 7]),[24 7 sn 7])...
%     ,[3 2 1 4]); 

nbins = 50;
colormap(hot)
day_=[1,2,5];
hour_=[12 18]; 
hou=18;
h=figure
for d=1:2
 subplot(2,1,d)
hist(speed_(:,2,hour_(d)),nbins)
hf = findobj(gca,'Type','Patch');
set(hf,'FaceColor',[1 1 1], 'EdgeColor','black');
title(['distribution of speed for day:',num2str(day_(d)),...
    ',hour:',num2str(hou)])
end
UtilityLib.print_figure(h,9,7,'speed-histogram-different-days');
 end
