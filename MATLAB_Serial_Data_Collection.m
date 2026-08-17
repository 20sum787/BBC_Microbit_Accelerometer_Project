% Self-erasing terminal print
clear; clc;

% Setup
port = "COM3"; 
baud = 115200;
device = serialport(port, baud);
configureTerminator(device, "LF");
flush(device);

disp('Recording... Press Stop to stop.');
% Initialising
totalTime = 0;
recorded_data = [];

while true
    
    try
        
        tic
        % Reads the CSV line from the microbit
        line = readline(device);

        splitline = strsplit(line,',');

        accel_data = [0,0,0];

        for i = 1:3
            accel_data(i) = str2double(splitline(i));
        end
        % the serial data has now been converted into numerical values

        recorded_data = [recorded_data; totalTime, accel_data];
      
        elapsedTime = toc;
        totalTime = totalTime + elapsedTime;

    catch
        break;
    end
end
