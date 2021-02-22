function y = FSsquarewave(f,t,N)
%FSSQUAREWAVE Summary of this function goes here
%   Detailed explanation goes here
    y = zeros(length(t),N);
    for n=1:N
        y(:,n) = sin(2.*pi.*f.*(2.*n-1).*t')./(2*n-1);
    end
    y = 4./pi.*sum(y,2)';
end

