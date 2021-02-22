function [Y,f] = fft2NdB(y,fs)
%FFT2NDB transforms the signal to the frequency-domain, normalised 
    N = length(y); % number of points
    Fy = fft(y,N)/N; % F{y}
    P2 = abs(Fy);   % symmetric
    Y = 20*log10(2*P2(1:N/2));
    f = linspace(0,fs/2,N/2);
end

