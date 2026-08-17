disp(recorded_data);
Z_t = recorded_data(:,4);
t = recorded_data(:,1);

plot(t,Z_t)

title("Z-Acceleration")
xlabel("t(secs)")
ylabel("accel(mm s-2)")

%defining a function that carries out the DFT
%column_no is changed depending on whether X,Y or Z acceleration is to be used

function freq_domain = dft(X,column_no)
    try

    n_array = size(X(:,1));
    len = n_array(:,1);
    y = X(:,column_no);
    Y = [];

     % k and n are varied for each possible frequency, up to (but not including) the sampling rate
     % n represents the index of each datapoint i.e. y(n+1) (which can be between 0 or len - 1, when len is the number of points)
     % k represents the chosen factor of frequency (i.e. Fs/k ranges from the lowest frequency of Fs/len, to the 
     % highest possible frequency, which is the sampling rate.
     % n+1 and k+1 are used, as the DFT formula starts from 0, but MATLAB indexing starts from 1
    
    for k = 0:len-1
        Y_k = 0;

        for n = (0:len-1)
        % the mathematical formula used was sourced from wikipedia, with the MATLAB code written by myself
        
        summation_argument = y(n+1)*exp(-2*pi*1j*(k+1)*n/len);
        Y_k = Y_k + summation_argument;

        end

        Y = [Y,Y_k];

    freq_domain = Y;
    end

    catch
    %simple error catching
        disp("Error occurred - check inputs are valid")
    end

end

Z_freq = dft(recorded_data,4)

n_array = size(recorded_data(:,1));
n = n_array(:,1);
Fs = 50;

% the DFT results were plotted to verify that they were the same as the FFT ones

plot(Fs/n*(0:n-1),abs(Z_freq),"LineWidth",1.5)
title("Complex DFT Magnitudes")
xlabel("f(Hz)")
ylabel("Magnitude")


plot(Fs/n*(0:n-1),abs(Z_freq),"LineWidth",1.5)
xlim([1,10])
title("Complex DFT Magnitudes - Band Pass")
xlabel("f(Hz)")
ylabel("Magnitude")
