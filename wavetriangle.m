function ampl = wavetriangle(f, t)
%WAVETRIANGLE Summary of this function goes here
%   Detailed explanation goes here
    ampl = 4.*abs(mod(t,1./f).*f-0.5) - 1;
end

