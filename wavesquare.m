function a = wavesquare(f,t)
%WAVESQUARE Summary of this function goes here
%   Detailed explanation goes here
    p = 1./f;
    a = round(mod(t,p)./p);
end

