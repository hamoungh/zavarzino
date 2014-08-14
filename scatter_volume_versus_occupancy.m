function [  ] = scatter_volume_versus_occupancy(  )
[ volume_,occupancy_,speed_ ] = get_multidimensional_data( );

for i= 1:80:457 
h=figure;
scatter(reshape(permute(volume_(i,1:7,:),[3 2 1]),[],1),...
    reshape(permute(occupancy_(i,1:7,:),[3 2 1]),[],1))
xlabel('volume'); ylabel('occupancy');
text=strcat('sensor',num2str(i));
title(text);
UtilityLib.print_figure(h,9,7,strcat('scatter-volume-versus-occupancy-',text)); 
end 
end

