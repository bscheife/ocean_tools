function [binCentres binEdges data nBin] = binData(X,Y,bin)
% USE: [binCentres binEdges data nBin] = binData(X,Y,bin)
%
% Take (X,Y) data pairs and segregate them into bins spaced along the X
% axis. X and Y must have the same size and be real. BIN may be a
% scalar or a 1D vector. If BIN is a scalar, it is the number of bins;
% these will be equally spaced between MIN(X(:)) and MAX(X(:)). If BIN is a
% vector, it will be taken as the vector of bin edges and will be the same
% as the output BINEDGES. The calculation is performed using the histcounts
% function. Data pairs with NAN in either X or Y are excluded.
%
% Output: DATA is a cell array containing the original Y data separated
% into bins. The length of DATA equals the number of bins. BINCENTRES
% contains the midpoints of the bins and has the same length as DATA.
% BINEDGES contains the edges of the bins and is one element longer than
% DATA. NBIN is a 1D vector with the number of data points in each bin.
%
% Note: use CELLFUN as a convenient means to manipulate data in each bin:
% e.g.  averages = cellfun(@mean, data);
% e.g.  averages = cellfun(@(x) trimmean(x,95), data);

% B. Scheifele 2018/05

%bin input acceptable?
if all(size(bin)>1) | ndims(bin)>2
    error('BIN must be a scalar or one-D vector')
end
if any(diff(bin)<0)
    error('Bin edges must be monotonically increasing')
end

%use histogram to flag each datum with its appropriate bin
[nBin, binEdges, indBin] = histcounts(X, bin);

%midpoints of bins
binCentres = midpoints(binEdges);

%loop through each bin and get data
data = cell(size(nBin));
for jj=1:length(nBin)
    %logical array, find data that belong to bin and are finite
    iBin = indBin==jj & isfinite(Y);
    data{jj} = Y(iBin);
end

%nBin is incorrect because it counted the NaN values, so recount
nBin = cellfun(@length,data);

end



