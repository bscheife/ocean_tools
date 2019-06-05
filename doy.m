
function DayOfYear = doy(X);
% USE: DayOfYear = doy(X);
%   Calculate Day of Year for datetime array X. This is a wrapper for
%       day(X,'dayofyear');


% B.Scheifele 2018

DayOfYear = day(X,'dayofyear');

end