%this script creates a running x y z plot

clear all

plotsize = 360;

%define refresh delay rate
speed = 0.01;

%make plot
myplot = XYZPlot(plotsize);

for i = [1:1000]
    myplot.addpoint([sind(i) cosd(i) tand(i) i*speed ]);
    pause(speed); %find a better method of timing than this
end