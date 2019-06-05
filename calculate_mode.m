function [modeValue binCentres] = calculate_mode(X,binEdges);
%USE: [modeValue binCentres] = calculate_mode(X,binEdges);
%
%Discretize data in the one-D vector X into bins and return the most common
%value, i.e. the mode.
%

%B. Scheifele 2018/05

if ~isvector(X)
    error('input must be one dimensional vector');
end

binCentres = midpoints(binEdges);
ibin = discretize(X,binEdges);
modeValue = binCentres(mode(ibin));










end