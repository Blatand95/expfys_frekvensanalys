function v = THD(peaks)
%THD Summary of this function goes here
%   Detailed explanation goes here
    v = sqrt(sum(peaks(:,2:end),2).^2)./peaks(:,1);
end

