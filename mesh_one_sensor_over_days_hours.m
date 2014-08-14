function [  ] = mesh_one_sensor_over_days_hours(  )

 M = csvread('temp1.csv'); 
M=M(1:end-1,:);
% this is like a select statement on the latitude 
temp=num2cell(M(find(M(:,latitude)==M(1,latitude)),...
    [day time volume speed occupancy]),1)
[x y volume_ speed_ occupancy_]=temp{:}
 [qx qy]=meshgrid(1:7,0:23);
 
 h=figure;
 F = TriScatteredInterp(x,y,volume_); 
% qvolume_ = F(qx,qy);
 mesh(qx,qy,F(qx,qy));
 title('volume for sensor 1');
 xlabel('day'); ylabel('hour');
 UtilityLib.print_figure(h,9,7,'volume'); 
 
 h=figure;
 F = TriScatteredInterp(x,y,speed_); 
 mesh(qx,qy, F(qx,qy));
 title('speed for sensor 1');
 xlabel('day'); ylabel('hour');
 UtilityLib.print_figure(h,9,7,'speed'); 

 h=figure;
 F = TriScatteredInterp(x,y,occupancy_); 
% qvolume_ = F(qx,qy);
 mesh(qx,qy,F(qx,qy));
 title('occupancy for sensor 1');
 xlabel('day'); ylabel('hour');
 UtilityLib.print_figure(h,9,7,'occupancy'); 
end

