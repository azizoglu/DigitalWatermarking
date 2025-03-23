function decimalValues = Binary2Decimal(binaryMatrix, varargin)
%BINARY2DECIMAL Convert binary or base-P vectors to decimal values.
%
%   This function is a custom implementation equivalent to MATLAB's BI2DE
%   (Communication Toolbox). Supports arbitrary base conversion and MSB orientation.
%
%   decimalValues = Binary2Decimal(B) converts a binary matrix B to a column vector.
%   Each row of B is treated as a separate number (default: right-MSB orientation).
%
%   decimalValues = Binary2Decimal(B, P) sets the base of the number system.
%   decimalValues = Binary2Decimal(B, MSBFLAG) sets bit orientation.
%   decimalValues = Binary2Decimal(B, P, MSBFLAG) or Binary2Decimal(B, MSBFLAG, P) both work.
%
%   Example:
%       B = [0 0 1 1; 1 0 1 0];
%       T = [0 1 1; 2 1 0];
%
%       d1 = Binary2Decimal(B);
%       d2 = Binary2Decimal(B, 'left-msb');
%       d3 = Binary2Decimal(T, 3);
%   Note: This implementation is toolbox-independent and can be used as a
%   replacement when Communication Toolbox is not available.

narginchk(1, 3);

% Validate input type
if ~(isnumeric(binaryMatrix) || islogical(binaryMatrix))
    error('Input must be numeric or logical.');
end

% Store original type and convert to double for computation
inputType = class(binaryMatrix);
binaryMatrix = double(binaryMatrix);

% --- Default parameters ---
base = 2;
orientation = 'right-msb';

% --- Parse optional inputs ---
for i = 1:numel(varargin)
    arg = varargin{i};
    if isnumeric(arg)
        base = arg;
    elseif ischar(arg) || isstring(arg)
        orientation = lower(char(arg));
    else
        error('Optional inputs must be numeric (base) or string (orientation).');
    end
end

% --- Validate binaryMatrix values ---
if isempty(binaryMatrix)
    error('Input matrix is empty.');
end

if any(binaryMatrix(:) < 0) || any(~isfinite(binaryMatrix(:))) || any(floor(binaryMatrix(:)) ~= binaryMatrix(:))
    error('Matrix must contain only finite non-negative integers.');
end

% --- Validate base ---
if ~isscalar(base) || ~isreal(base) || base < 2 || floor(base) ~= base
    error('Base must be a real scalar integer ≥ 2.');
end

% --- Validate values within base range ---
if any(binaryMatrix(:) > (base - 1))
    error('Matrix contains digits that exceed the maximum allowed for base %d.', base);
end

% --- Validate orientation ---
if ~ismember(orientation, {'left-msb', 'right-msb'})
    error('Orientation must be ''left-msb'' or ''right-msb''.');
end

% --- Flip if MSB is on the left ---
[~, numCols] = size(binaryMatrix);
if strcmp(orientation, 'left-msb')
    binaryMatrix = binaryMatrix(:, end:-1:1);
end

% --- Compute powers and perform base conversion ---
powersOfBase = base.^(0:numCols-1);
decimalValues = binaryMatrix * powersOfBase.';

% --- Handle overflow protection (optional safeguard) ---
maxColumnsAllowed = 1024;
if numCols > maxColumnsAllowed
    overflowRows = any(binaryMatrix(:, maxColumnsAllowed+1:end), 2);
    decimalValues(overflowRows) = Inf;
end

% --- Restore original data type if needed ---
if ~islogical(inputType)
    decimalValues = feval(inputType, decimalValues);
end

end
