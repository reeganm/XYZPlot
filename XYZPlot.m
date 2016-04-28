classdef XYZPlot<handle
    %XYZPlot Creates an plot of XYZ coordinates wrt time
    %   Detailed explanation goes here
    
    properties
        plotsize; %number of data points displayed on plot
        datasize; %max data stored in data array
        %arrays for holding data
        x = [];
        y = [];
        z = [];
        t = [];
        
        %keeping track of amount of data points
        index;
        %plot handles
        xplot;
        yplot;
        zplot;
    end
    
    methods
        function obj=XYZPlot(plotdisplaysize,datastoragesize)
            %class constructor
            if nargin == 0
                obj.datasize = 1000;
                obj.plotsize = 100;
            end
            if nargin == 1
                obj.datasize = 1000;
                obj.plotsize = plotdisplaysize;
            end
            if nargin == 2
                obj.plotsize = plotdisplaysize;
                obj.datasize = datastoragesize;
            end
            
            
            obj.index = 0;
            
            %%preallocated ram for preformance
            %data
            obj.x = zeros(1,obj.datasize);
            obj.y = zeros(1,obj.datasize);
            obj.z = zeros(1,obj.datasize);
            obj.t = zeros(1,obj.datasize);
            
            %%create subplots
            %x
            subplot(3,1,1);
            obj.xplot = plot(obj.t,obj.x);
            ylabel('X');
            %y
            subplot(3,1,2);
            obj.yplot = plot(obj.t,obj.y);
            ylabel('Y');
            %z
            subplot(3,1,3);
            obj.zplot = plot(obj.t,obj.z);
            xlabel('TIME');
            ylabel('Z');
        end
        
        function obj=addpoint(obj,array)
            %adds data to plot
            obj.index = obj.index + 1;
            if(nargin > 0)
                %update data
                obj.x(obj.index) = array(1);
                obj.y(obj.index) = array(2);
                obj.z(obj.index) = array(3);
                obj.t(obj.index) = array(4);
                
                %update plots
                if obj.index <= obj.plotsize
                    set(obj.xplot,'XData',obj.t,'YData',obj.x);
                    set(obj.yplot,'XData',obj.t,'YData',obj.y);
                    set(obj.zplot,'XData',obj.t,'YData',obj.z);
                else
                    set(obj.xplot,'XData',obj.t((obj.index-obj.plotsize):obj.index),'YData',obj.x((obj.index-obj.plotsize):obj.index));
                    set(obj.yplot,'XData',obj.t((obj.index-obj.plotsize):obj.index),'YData',obj.y((obj.index-obj.plotsize):obj.index));
                    set(obj.zplot,'XData',obj.t((obj.index-obj.plotsize):obj.index),'YData',obj.z((obj.index-obj.plotsize):obj.index));
                end
                %give it time to redraw
                pause(0.0001);
                
                %limit ram usage
                if obj.index  == obj.datasize
                    %reset data
                    obj.index  = 0;
                    obj.x = zeros(1,obj.datasize);
                    obj.y = zeros(1,obj.datasize);
                    obj.z = zeros(1,obj.datasize);
                    obj.t = zeros(1,obj.datasize);
                end
            end
        end
        
    end
end

