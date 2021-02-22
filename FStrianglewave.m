function y = FStrianglewave(f,t,N)
%FSSQUAREWAVE Summary of this function goes here
%   Detailed explanation goes here
    y = zeros(length(t),N);
    for n=1:N
        y(:,n) = (-1).^((2*n-2)./2).*sin(2.*pi.*f.*(2.*n-1).*t')./(2*n-1)^2;
    end
    y = 8./pi^2.*sum(y,2)';
end
