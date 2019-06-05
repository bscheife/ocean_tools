
function XM = midpoints(X);
% USE: XM = midpoints(X);
%   X is a one-dimensional N-element vector without NaNs. XM is an N-1
%   element one-dimensional vector, containing values at the midpoints
%   between consecutive values in X. It is calculated using:
%       XM = diff(X)/2 + X(1:end-1)
%   Note there are no input checks. Works with datetimes.
%

% B.Scheifele 2016

XM = diff(X)/2 + X(1:end-1);


end