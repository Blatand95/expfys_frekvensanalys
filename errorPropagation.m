function [v,d] = errorPropagation(funct,fun_var,var_delta,diff_var)
    f_vals = num2cell(fun_var); % Convert fnc variables to cell array
    % Assert nr of supplied uncertainties equals num of differentiated 
    % dimensions
    n = cellfun(@numel,{var_delta,diff_var});
    assert(all(n == n(1)), "Mismatch: num differentiated variables and supplied uncertainties");
    
    % Evaluate center value
    f = matlabFunction(funct);
    v = f(f_vals{:});
    
    % Evaluate error propagation
    d = zeros(1,n(1));
    for i = 1:n(1)
        f = matlabFunction(diff(funct,diff_var(i)));
        d(i) = abs(f(f_vals{:}))*var_delta(i);
    end    
    d = sum(d);
end

