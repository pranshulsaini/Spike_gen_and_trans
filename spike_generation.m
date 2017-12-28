% just some comments for github

clc;
clear all;

dt = 1 * 10^-3;
r = 100 ; %spikes per second
time = 0.1;   %second
N = time/dt;
t = 1:N;

% So we expect to have spikes in 100 dt intervals out of 1000 dt intervals
% corresponding to time = 1 second

delta_input = unifrnd(0,1,1,N);

for i = 1:N
    if delta_input(i) <= (r*dt)
        spike(i) = 1;
    else
        spike(i) =0;
    end
end



% rectangular frame for convolution
kernel = 11;
rect = ones(1,kernel);   % for 10 ms
scaling_factor = 1/(kernel*dt);     %  1 s in the denominator we want frequency in concolution plot
%convolution with rectangular frame
spikes_rect_conv = conv(spike, rect,'same') * scaling_factor;


%guassin frame for convolution
kernel = 1:15;
std = 2;
mean = 8;
gauss = normpdf(kernel,mean,std);      % 6 is the mean, 2 is the standard deviation
sum_gauss = sum(gauss);
gauss = gauss*(1/sum_gauss)*10;       % when guass is one, in means that the spikes are 10
scaling_factor = 1/(size(kernel,2)*dt);
%convolution with gauss frame
spikes_gauss_conv = conv(spike, gauss,'same') * scaling_factor;   % multiplied with scaling factor bcz the output is number of spikes in 10 ms




%poisson frame for convolution
kernel = 1:11;
mean= 3;
poiss = poisspdf(kernel,mean);      % 6 is the mean, 2 is the standard deviation
sum_poiss = sum(poiss);
poiss = poiss*(1/sum_poiss)*10 ;
scaling_factor = 1/(size(kernel,2)*dt);
%convolution with gauss frame
spikes_poiss_conv = conv(spike, poiss) * scaling_factor;   % multiplied with 1000 bcz the output is always between 0 and 1
spikes_poiss_conv = spikes_poiss_conv(3: N -(size(kernel)- mean));



subplot(2,1,1)
plot(1:N, spike);
ylabel('Spikes');

subplot(2,1,2), hold on
plot(t, spikes_rect_conv);
plot(t, spikes_gauss_conv,'r')
plot(t, spikes_poiss_conv,'g')
ylabel('firing rate')



fprintf('The average firing rate for rectangular convolution is %f\n', mean(spikes_rect_conv));
fprintf('The average firing rate for gaussian convolution is %f\n', mean(spikes_gauss_conv));
fprintf('The average firing rate for gaussian convolution is %f\n', mean(spikes_poiss_conv));










        
        
