function T = o1transfer(N,fs,w0,t_type)
%O1TRANSFER Summary of this function goes here
%   Detailed explanation goes here
    s = 1j*linspace(0,fs,N);
    if t_type == "low-pass"
        T = w0./(s + w0);
    elseif t_type == "high-pass"
        T = s./(s+w0);
    else
        error("Type is either low-pass och high-pass {%s}",t_type);
    end
end

