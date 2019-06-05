


function rmsErr=rmsError(y1, y2);
% 
%USE: rmsErr=rmsError(y1, y2);
%
%Returns the root-mean-square deviations between two vectors y2 and y1:
%
%   errNorm = sqrt(mean((y2-y1).^2)));
%
%This is a normalized, but scale-dependent, measure of how well two series
%agree. Ignores pairs where either value is non-finite. y2 and y1 are 
%one-dimensional vectors of equal length. rmsErr is a scalar.

%B. Scheifele 2016-01





%check input
if (isrow(y1)==0 & iscolumn(y1)==0) | (isrow(y2)==0 & iscolumn(y2)==0)
    error('Inputs must be 1D vectors')
elseif size(y1)~=size(y2)
    error('y1 and y2 must be same size')
end

%Use only finite values
cc = isfinite(y1) & isfinite(y2);

%Calculation
meanSqErr=mean((y2(cc)-y1(cc)).^2);
rmsErr=sqrt(meanSqErr);

end

