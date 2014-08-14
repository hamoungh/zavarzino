
%lat = [48.8708 51.5188 41.9260 40.4312 52.523 37.982];
%lon = [2.4131 -0.1300 12.4951 -3.6788 13.415 23.715];

%lat = [43.6   43.6 43.85 43.85];
%lon = [-79.7 -78.9 -79.7 -78.9];

 axis([-79.7 -78.9 43.6 43.85]);
 [lonVec latVec imag] = plot_google_map...
      ('MapType','roadmap');
   % ('MapType','roadmap','AutoAxis',0,'Refresh',0);
 axis([43.6 43.85 -79.7 -78.9]); 
imagesc([43.6 43.85], [-78.9 -79.7], imag);

%figure
%image(imag) 
  
  

