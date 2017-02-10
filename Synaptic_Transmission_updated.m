clc;
clear all;

spike_input = 0;

dt = 10^-5;

N = (20 * 10^-3)/dt;      % 2000 time steps

tau = 2 * 10^-3;
g_l = 15 * 10^-9;
g_s = 15 * 10^-12;
E_s = 0;


P(1) = 0;
U(1) = -65 * 10^-3;
I(1) = 0;
g(1) = 0;
w = 1; 
C = 12.4*10^-12;

for i = 1:N
    
    if (rem(i,500) == 0)                % input spike is given every 5 milliseconds
        spike_input = 1;
    end
    
    dP(i) = dt*((-P(i)/tau)+ spike_input);
    P(i+1) = P(i) + dP(i);
    g(i+1) = g_s * w * P(i+1);
    I(i+1) = g(i+1)* (E_s - U(i));
    
    dU(i) = ( -g_l*(U(i) - U(1)) + I(i+1))*(dt/C)  ;
    
    U(i+1) = U(i) + dU(i);
    
    
    spike_input = 0;
    
end

t = 1: N+1;

figure
plot(t,g);

figure
plot(t,I);


figure
plot(t,U);
    
    
    
    
