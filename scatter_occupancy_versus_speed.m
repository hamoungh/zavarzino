function [  ] = scatter_occupancy_versus_speed(  )
[ volume_,occupancy_,speed_ ] = get_multidimensional_data( );

for i= 1:80:457 
h=figure;
scatter(reshape(permute(occupancy_(i,1:7,:),[3 2 1]),[],1),...
    reshape(permute(speed_(i,1:7,:),[3 2 1]),[],1))
xlabel('occupancy'); ylabel('speed');
text=strcat('sensor',num2str(i));
title(text);
UtilityLib.print_figure(h,9,7,strcat('scatter-occupancy-versus-speed-',text)); 
end 
end

