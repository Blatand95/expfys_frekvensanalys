function y_filtered = o1filter(y, fs,w0,t_type)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    N = length(y);
    Y = fft(y,N);
    T = o1transfer(N/2,fs/2,w0,t_type);
    Y_filtered = Y.*[T,T(end:-1:1)];
    y_filtered = ifft(Y_filtered,N,'symmetric');
end

