function [ volume_,occupancy_,speed_,latitude_,longitude_ ] = get_multidimensional_data(  )
global day time latitude longitude volume...
    speed occupancy
day=1;
 time=2;
 latitude=3;
 longitude=4;;
 volume=5;
 speed=6;
 occupancy=7 ;

 M = csvread('temp1.csv'); 
M=M(~any(isnan(M),2),:);
changes=[0 ; M(2:end,3)~=M(1:end-1,3)];
sn=sum(changes)+1; 
sensor=cumsum(changes)+1; 

volume_=nan([7 24 sn]);
occupancy_=nan([7 24 sn]);
speed_=nan([7 24 sn]); 
% zeros([7 24 sn]);
latitude_=nan([7 24 sn]);
longitude_=nan([7 24 sn]);

time_=zeros([7 24 sn]);
i = sub2ind([7 24 sn],M(:,day), M(:,time)+1,sensor); 

volume_(i) = M(:,volume);
volume_=permute(volume_,[3 1 2]);

occupancy_(i) = M(:,occupancy);
occupancy_=permute(occupancy_,[3 1 2]);

speed_(i) = M(:,speed); 
speed_=permute(speed_,[3 1 2]);

latitude_(i) = M(:,latitude); 
latitude_=permute(latitude_,[3 1 2]);

longitude_(i) = M(:,longitude); 
longitude_=permute(longitude_,[3 1 2]);
end

