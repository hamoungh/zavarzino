zavarzino
=========
the original data set is composed of the following data in tabular format:
(day,hour,latitude, longitude, volume, occupancy, speed)
the data that we originally had was more granular (i.e. sampled every 10 minutes instead of one hour). 
Before doing any visualization , I first cleaned the data and then converted it to the multidimensional format. In multidimensional format, you deal with multidimensional arrays or cubes instead of tables. 
Each cube has a bunch of dimensions and each element of the cube is indexed by the dimensions. Each element can contain multiple values. Possible operations on the dimensions are projection, summarization, slice and dice, drill down, roll up, and pivot. For example moving from 10 minute sample granularity to one hour can be considered a rollup in the time dimension. This resulted into a smaller data set that can be explored using in-memory programs (here Matlab). We could have, of course, exported the whole data into a multidimensional database where all possible cubes are materialized and so the queries are very fast, but we kind of did this using in-house tools. 
## The ETL step:
I just use the following heuristic to clean the data. I removed every row with a null value. If a latitude or longitude is null the sensor number cannot be retrieved at all. So it’s logical to discard it. Note that the data did not contain a sensor number and I generated it based on identical geographical locations. The following is a Matlab code that does this (it’s actually interesting to see how hard it is to do this using a query language):
```matlab
M = csvread('temp1.csv'); 
M=M(~any(isnan(M),2),:);
changes=[0 ; M(2:end,3)~=M(1:end-1,3)];
sn=sum(changes)+1; 
sensor=cumsum(changes)+1;
```

now if the latitude and longitude are not missing in a row but instead one of the values of occupancy, volume or speed are missing, again I decided to get rid of the row. This is because I didn’t want to give one variable an advantage of having more values. 
Now the problem is if the data set is a multidimensional array, what happens to the elements that are empty. I initialized the whole array with nan.
```matlab
volume_=zeros([7 24 sn]);
volume_(i) = M(:,volume);
volume_=permute(volume_,[3 1 2]);
```

## Visualizations
I mainly performed four types of visualizations. I will describe each separately.
I first assumed that there may similarities between a transportation network and a queuing network. 

### The scatterplots
In a queuing network the main measures of interest are the utilization of each queuing center(U_k), the delay it center introduces for the customers (R_k), and the number of customers waiting or getting a service in each queue (N_k). 
Let’s assume the volume in our data set is a number of customers N, the occupancy is the utilization U, and the speed is a measure of how high th delay is i.e. R. 
as a result the relationship between the number of customers and the occupancy has to be proportional up to a point that the center is saturated and the occupancy cannot go higher than a threshold. In other words if the utilization of the queuing center does not proportionally increased with additional users than the center is a bottleneck. In the third graph below however the reverse happens. The volume stops increasing   while the occupancy increases. I do not know how to interpret that. Maybe should talk to a traffic engineer. But I guess it means that the center’s occupant because somewhere else is the bottleneck (i.e. the center itself does not have a lot of volume but maybe to one next to it has). 
Inline-style: 
![alt text](https://github.com/hamoungh/zavarzino/tree/master/diagram/scatter-volume-versus-occupancy-sensor401.png "Logo Title Text 1")


   
  
Maybe actually the occupancy is equivalent of number of users and the volume is the utilization. (then the graphs match  the queuing networks theory).

The fifth graph above is actually interesting because you see two different regression lines and correlation coefficient. I think that’s maybe because there is a change of condition in the road for example Lane has been blocked for the repair  or something like that (note that the data for this diagram has been grabbed from the whole seven day interval)   

Below graphs show the relationship between occupancy and speed. What I would expect from the queuing network model is that the utilization should increase while the center’s delay will remain the same. And the way utilization hits the max the delay starts to increase. It’s a little different here in the graphs. To speed drops as soon as the occupancy starts to increase.
   
In the third graph above,  however there’s no specific relationship between the occupancy and the  speed. I think that basically means that  the region associated with this sensor should not be modeled as a queuing center. Basically it just gets affected by the other regions.
 
### Comparing the speed of different days (same hour) using a histogram
the graph is self descriptive. It shows that on day five we have much less a speed overall. the distributions are over all the sensors. 

  
### Comparing different hours using cumulative distribution function
multiple cumulative distribution functions of different hours of the day can be shown in the same diagram. Below, in the first diagram we see that (sorry the x axis labels are wrong) at 6 o’clock half of sensors cdf= .5, experience an speed of under 80 km. Almost 70% of sensors at this hour experience speed of lower than hundred kilometers. In other hours, almost 90% of sensors experience an speed of more than 90 km. 
 
Below graph shows that the occupancy experienced by most of the sensors is increased by about 15 to 20 at 6 o’clock. 
 graph shows that the volume experienced by sensors at 6 o’clock is pretty much the same volume that is experienced at noon. This might be again because the network is saturated and cannot take more volume. This increase in the occupancy   while the volume hits a max again suggests that may be the volume represents some metric such as utilization and the occupancy represents the number of cars in the region. 


 
### Graphs of individual sensors over day/time
this graphs focus on individual sensors. Basically they show that there are two points during the day of the volume is increase and speed is dropped. 
 
 
### The animation
the animation is actually a scatterplot where each circle represents a sensor and the location of the circle is obtained from the location of the sensor. A nonlinear function is used to map the occupancy and speed tupple associated with each  sensor at each time to a triple that represents the RGB color. 
