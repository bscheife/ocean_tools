function aNorm = normPos(a)
%USE: aNorm = normPos(a)
%
%This function normalizes a vector or matrix to values linearly scaled
%between 0 and 1. It calculates
%
% aNorm = a - min(a(:))
% aNorm = aNorm ./ max(aNorm(:))

aNorm = a - min(a(:));
aNorm = aNorm ./ max(aNorm(:));


end
