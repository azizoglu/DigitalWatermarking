function binaryMatrix = Decimal2Binary(varargin)
%Decimal2Binary Convert decimal numbers to binary (or base-p) representation.
%
%   This function is a custom implementation equivalent to MATLAB's DE2BI
%   (Communication Toolbox). Supports base-p conversion and MSB orientation.
%
%   binaryMatrix = Decimal2Binary(decimalValues) converts non-negative integers in 
%   decimalValues to a binary matrix. Each row corresponds to one number. Default is right-MSB.
%
%   binaryMatrix = Decimal2Binary(decimalValues, numDigits) specifies output digit count.
%   binaryMatrix = Decimal2Binary(decimalValues, numDigits, base) sets the number system base.
%   binaryMatrix = Decimal2Binary(decimalValues, numDigits, base, msbFlag) sets bit order:
%       'right-msb' (default) or 'left-msb'.
%
%   Example:
%       D = [12; 5];
%       Decimal2Binary(D)
%       Decimal2Binary(D, 5)
%       Decimal2Binary(D, [], 3)
%       Decimal2Binary(D, 5, 2, 'left-msb')
%   Note: This implementation is toolbox-independent and can be used as a
%   replacement when Communication Toolbox is not available.

narginchk(1, 4);

% --- Default values ---
decimalValues = [];
numDigits = [];
base = 2;
msbFlag = 'right-msb';

% --- Parse inputs ---
for i = 1:nargin
    arg = varargin{i};
    if isnumeric(arg)
        if isempty(decimalValues)
            decimalValues = arg;
        elseif isempty(numDigits)
            numDigits = arg;
        elseif isempty(base)
            base = arg;
        else
            error('Too many numeric inputs.');
        end
    elseif ischar(arg) || isstring(arg)
        msbFlag = lower(char(arg));
    else
        error('Invalid input type. Inputs must be numeric or string.');
    end
end

% --- Input validation ---
if isempty(decimalValues)
    error('Input decimalValues is required.');
end

originalInput = decimalValues;  % Keep for type restoration
decimalValues = double(decimalValues(:));  % Flatten and convert to double

if any(decimalValues < 0) || any(~isfinite(decimalValues)) || any(~isreal(decimalValues)) || any(floor(decimalValues) ~= decimalValues)
    error('Input must be non-negative real integers.');
end

if ~isscalar(base) || ~isreal(base) || base < 2 || floor(base) ~= base
    error('Base must be a real scalar integer ≥ 2.');
end

% --- Determine minimum required digits ---
maxValue = max(decimalValues);
if maxValue == 0
    requiredDigits = 1;
else
    requiredDigits = floor(log(maxValue) / log(base)) + 1;
    if base^(requiredDigits - 1) > maxValue
        requiredDigits = requiredDigits - 1;
    end
end

% --- Validate or assign number of digits ---
if isempty(numDigits)
    numDigits = requiredDigits;
elseif ~isscalar(numDigits) || ~isreal(numDigits) || floor(numDigits) ~= numDigits || numDigits < requiredDigits
    error('Invalid number of digits.');
end

% --- Validate MSB flag ---
if ~ismember(msbFlag, {'left-msb', 'right-msb'})
    error('MSB flag must be ''left-msb'' or ''right-msb''.');
end

% --- Initialize binary output ---
numValues = length(decimalValues);
binaryMatrix = zeros(numValues, numDigits);

% --- Conversion process ---
if base == 2
    % Vectorized binary conversion
    [~, requiredBits] = log2(max(decimalValues));
    binaryMatrix = rem(floor(decimalValues * pow2(1 - max(numDigits, requiredBits):0)), 2);
    
    if strcmp(msbFlag, 'right-msb')
        binaryMatrix = fliplr(binaryMatrix);
    end
else
    % General base conversion
    for i = 1:numValues
        current = decimalValues(i);
        for j = 1:numDigits
            if current == 0
                break;
            end
            binaryMatrix(i, j) = mod(current, base);
            current = floor(current / base);
        end
    end

    if strcmp(msbFlag, 'left-msb')
        binaryMatrix = fliplr(binaryMatrix);
    end
end

% --- Restore original data type (except logical) ---
if ~islogical(originalInput)
    binaryMatrix = feval(class(originalInput), binaryMatrix);
end

end
