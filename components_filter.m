function components = components_filter(varargin)
% COMPONENTS_FILTER will supply the settings for a filter
% # Syntax
% components_filter(f,R)
% components_filter(Name,Value,...)

tmp_struct = struct;
acceptableArgumentNames = {'frequency','type','resistance','capacitance'};
valid_types = {'lowpass','highpass'};

if nargin == 2 && all(cellfun(@(x)isnumeric(x) && x > 0,varargin))
    tmp_struct.Frequency = varargin{1};
    tmp_struct.Resistance = varargin{2};
elseif nargin == 6
    n = varargin(1:2:nargin-1);
    
    if all(cellfun(@(x) isstring(x) || ischar(x),n))
        n = lower(n);
    else
        fprintf("Invalid arguments\n");
        return
    end
        
    v = varargin(2:2:nargin);
    n_valid = cellfun(@(x) any(strcmp(acceptableArgumentNames,x)),n);
    if ~all(n_valid)
        fprintf("%s is invalid.\n",convertCharsToStrings(n(~n_valid)));
        return
    end
    
    type_given = false;
    for i = 1:nargin/2
        vi = v{i};
        switch n{i}
            case 'frequency'
                if isnumeric(vi) && vi > 0
                    tmp_struct.Frequency = vi;
                else
                    return
                end
            case 'type'
                if isstring(vi)
                    vi = convertStringsToChars(vi);
                end
                if ischar(vi) && any(strcmp(vi,valid_types))
                    tmp_struct.Type = vi;
                    type_given = true;
                else
                    return
                end
            case 'resistance'
                if isnumeric(vi) && vi > 0
                    tmp_struct.Resistance = vi;
                else
                    return
                end
            case 'capacitance'
                if isnumeric(vi) && vi > 0
                    tmp_struct.Capacitance = vi;
                else
                    return
                end
            otherwise
                return
        end
    end
    
    % Find missing fields
    missing_i = cellfun(@(x) ~any(strcmp(n,x)),acceptableArgumentNames);
    fields_missing = acceptableArgumentNames(missing_i);
    
    ismissing = @(n_) any(strcmp(fields_missing,n_));
    
    % 
    if ismissing('frequency')
        tmp_struct.Frequency = 100;
    end
else
    return
end
    components = tmp_struct;
end

