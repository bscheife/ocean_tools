function Y = geometricMean(X,varargin)
%Simple wrapper for mean() function to calculate the geometric mean. Use
%this in place of Matlab's built-in geomean() function because that
%function doesn't support handling of NaN values. This one does.
%
%USE: Y = geometricMean(X,dim,nanflag)
%   X: is an array
%   dim: the dimension along which to take the mean (default: 1)
%   nanflag: 'omitnan' (default) or 'includenan'. Note this is the opposite
%            default behaviour as the builtin function. See help mean.
%   
%Calculation of the geometric mean is according to Y = exp(mean(log(X))).
%Note that if you want to include a nanflag, you also have to include the
%dimension.
%
%
%B. Scheifele 2018

%check for zeroes
if ~all(X(:))
    warning('Input can''t have zeroes. Exiting function')
    Y = nan;
    return
end

%Check for optional input arguments dim and nanflag
nArgs = length(varargin);
if nArgs>2
    error('at most 2 optional arguments');
end
%set default values for optional arguments: dim=1; nanflag='omitnan'
optArgs = {1, 'omitnan'};
%parse optional input arguments
optArgs(1:nArgs) = varargin;
dim = optArgs{1};
nanflag = optArgs{2};

%Do the calculation
Y = exp(mean(log(X),dim,nanflag));

end