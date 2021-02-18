function a = wavesquare(f,t)
%WAVESQUARE Summary of this function goes here
%   Detailed explanation goes here
    p = 1./f;
    a = 2*round(mod(t,p)./p) - 1;
end

