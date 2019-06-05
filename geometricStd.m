function Y = geometricStd(X,varargin)
%Simple wrapper for std() function to calculate the geometric standard
%deviation factor. For details see Kirkwood 1979.
%
%USE: Y = geometricStd(X,dim,nanflag)
%   X: is an array
%   dim: the dimension along which to do the calculation (default: 1)
%   nanflag: 'omitnan' (default) or 'includenan'. Note this is the opposite
%            default behaviour as the builtin function. See help std.
%   
%Calculation of the geometric standard deviation factor is according to 
%   Y = exp(std(log(X)))
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
Y = exp(std(log(X),dim,nanflag));

end