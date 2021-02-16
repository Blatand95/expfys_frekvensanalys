fs = 50e3; % 50kS/s
T_s = 1/fs; % sample period
n_rl = 2^12; % record-length or number of samples
t_T = n_rl*T_s; % allocation time
t = 0:T_s:t_T-T_s; % sample time
f_max = fs/2;
f = 0:(fs/n_rl):fs/2;

S = wavetriangle(100,t); % time-domain signal
%S = S + 10*randn(size(S));
F = fft(S,n_rl);
P2 = abs(F/n_rl);
P1 = 10*log10((2*P2(1:n_rl/2+1)));
subplot(2,1,1)
plot(t,S)
subplot(2,1,2)
plot(f,P1)