% Generating AR signal 
b = fir1(1024, .5);
[d,p0] = lpc(b,7);

rng(0,'twister'); % Allow reproduction of exact experiment
u = sqrt(p0)*randn(8192,1); % White gaussian noise to add on 
x = filter(1,d,u); % AR signal generation 

% Finding AR model from signal using Yule-Walker method 
[d1,p1] = aryule(x,7);

% Computing power spectral density 
[H1,w1] = freqz(sqrt(p1),d1);

% Periodogram generation 
periodogram(x)
hold on
hp = plot(w1/pi,20*log10(2*abs(H1)/(2*pi)),'r'); % Scale to make one-sided PSD
hp.LineWidth = 2;
xlabel('Normalized frequency (\times \pi rad/sample)')
ylabel('One-sided PSD (dB/rad/sample)')
legend('PSD estimate of x','PSD of model output')









