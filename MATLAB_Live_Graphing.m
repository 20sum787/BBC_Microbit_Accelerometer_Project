% Self-erasing serial line
clear; clc;

%  Setup
port = "COM3"; 
baud = 115200;
device = serialport(port, baud);
configureTerminator(device, "LF");
flush(device);

disp('Recording... Press Stop to stop.');
totalTime = 0;
recorded_data = [];

x_accel_line = animatedline('Color', 'r', 'LineWidth', 1.5);
y_accel_line = animatedline('Color', 'g', 'LineWidth', 1.5);
z_accel_line = animatedline('Color', 'c', 'LineWidth', 1.5);
xlabel('Time/s'); ylabel(' Accels (x_red,y_green,z_blue)');

while true
    try
        tic
        % Reads the CSV line from microbit
        line = readline(device);
        splitline = strsplit(line,',');
        accel_data = [0,0,0];

        for i = 1:3
            accel_data(i) = str2double(splitline(i));
        end

        recorded_data = [recorded_data; totalTime, accel_data]; % Append new data to recorded_data

            xyz = accel_data;
            x_accel = xyz(:,1);
            y_accel = xyz(:,2);
            z_accel = xyz(:,3);
           
            
            addpoints(x_accel_line, totalTime, x_accel);
            
            addpoints(y_accel_line, totalTime, y_accel);
          
            addpoints(z_accel_line, totalTime, z_accel);
          
            drawnow;
       
            elapsedTime = toc;
            totalTime = totalTime + elapsedTime;
        
    catch
        break;
    end
end

clear device;
