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
In a queuing network the main measures of interest are the utilization of each queuing center(Uk), the delay it center introduces for the customers (Rk), and the number of customers waiting or getting a service in each queue (Nk). 

Let’s assume the volume in our data set is throughput, the occupancy is the utilization U, and the speed is a measure of how high th delay is i.e. R. 
As a result the relationship between the volume and the occupancy has to be proportional:
Inline-style: 
![alt text](https://raw.githubusercontent.com/hamoungh/zavarzino/master/diagram/volume-versus-occupancy-sensor1.png "Logo Title Text 1")


Below graphs shows the speed drops as soon as the occupancy starts to increase: 
![alt text](https://raw.githubusercontent.com/hamoungh/zavarzino/master/diagram/scatter-occupancy-versus-speed-sensor321.png "Logo Title Text 1")
   
 
### Comparing the speed of different days (same hour) using a histogram
the graph is self descriptive. It shows that on day five we have much less a speed overall. the distributions are over all the sensors. 
![alt text](https://raw.githubusercontent.com/hamoungh/zavarzino/master/diagram/speed-histogram-different-days.png "Logo Title Text 1")
  
### Comparing different hours using cumulative distribution function
multiple cumulative distribution functions of different hours of the day can be shown in the same diagram. Below, in the first diagram we see that (sorry the x axis labels are wrong) at 6 o’clock half of sensors cdf= .5, experience an speed of under 80 km. Almost 70% of sensors at this hour experience speed of lower than hundred kilometers. In other hours, almost 90% of sensors experience an speed of more than 90 km. 
 ![alt text](https://raw.githubusercontent.com/hamoungh/zavarzino/master/diagram/cdf-speed-hour-1-17.png "Logo Title Text 1")
 
Below graph shows that the occupancy experienced by most of the sensors is increased by about 15 to 20 at 6 o’clock. 
  ![alt text](https://raw.githubusercontent.com/hamoungh/zavarzino/master/diagram/cdf-occupancy-hour-1-17.png "Logo Title Text 1")
 
 graph shows that the volume experienced by sensors at 6 o’clock is pretty much the same volume that is experienced at noon. This might be again because the network is saturated and cannot take more volume. This increase in the occupancy   while the volume hits a max again suggests that may be the volume represents some metric such as utilization and the occupancy represents the number of cars in the region. 
 ![alt text](https://raw.githubusercontent.com/hamoungh/zavarzino/master/diagram/cdf-volume-hour-1-17.png "Logo Title Text 1")
 
 
### Graphs of individual sensors over day/time
this graphs focus on individual sensors. Basically they show that there are two points during the day of the volume is increase and speed is dropped. 
  ![alt text](https://raw.githubusercontent.com/hamoungh/zavarzino/master/diagram/occupancy.png "Logo Title Text 1")
  ![alt text](https://raw.githubusercontent.com/hamoungh/zavarzino/master/diagram/speed.png "Logo Title Text 1")
 
### The animation
the animation is actually a scatterplot where each circle represents a sensor and the location of the circle is obtained from the location of the sensor. A nonlinear function is used to map the occupancy and speed tupple associated with each  sensor at each time to a triple that represents the RGB color. 
[Animation link]([I'm a relative reference to a repository file](../blob/master/LICENSE))
[Animation link](./animation)

  ![alt text](https://raw.githubusercontent.com/hamoungh/zavarzino/master/animation/Tuesday-6%20PM.png "Logo Title Text 1")

 
