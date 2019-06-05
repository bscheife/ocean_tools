function [temprGrd pOut]=casts2matrix(TemprIn, Pressure, dP, winlen)
%USE: [temprGrd pOut]=CASTS2MATRIX(TemprIn, Pressure, dP, winlen)
%
%Takes a series of consecutive temperature (or salinity, or density, ...) casts,
%interpolates them onto a common depth grid, and returns a single 2D matrix
%that can be fed into contour(), pcolor(), etc... 
%Dependencies: requires runmean() in the matlab path.
%
% TemprIn: 1D cell array, where each cell contains a 1D column vector of
%          temperature (or salinity, density, ...) measurements. These
%          should be consecutive.
%
% Pressure: Corresponding cell array of 1D column vectors of measured 
%           pressure (or depth).
%
% dP: Spacing of the interpolated pressure (or depth) grid if dP is scalar.
%     If dP is a monotonically increasing vector, it is the pressure 
%     vector onto which the data wil be interpolated (i.e. pOut = dP).
%
% winlen: Window length for running-mean filter applied to each cast.
%
% temprGrd: Output matrix. Each column is one temperature cast. Casts are
%         in the same order as in the original cell array.
%
% pOut: Corresponding pressure. 1D column vector.
%
%
% B. Scheifele 2015-11


nCasts=length(TemprIn);
press=Pressure;
tempr=TemprIn;

%Find max and min pressure
pressAll=cat(1,press{:});  %each cell must be a column vector for this to work
maxP=max(pressAll);
minP=min(pressAll);

%check if dP is pressure increment, or the pressure vector. Make vector.
if length(dP)<2
linP=0:dP:maxP+dP; %interpolated pressure (ie. the z-axis)
else
    linP=dP;
end

temprGrd=nan(length(linP), nCasts);

%in order to interpolate, measured pressure has to be linearly increasing
%and unique. So sort and keep only unique values. Then apply running mean.
%Then interpolate in put into a new matrix
for jj=1:nCasts
    [press{jj} isort]=unique(press{jj});
    tempr{jj}=tempr{jj}(isort);
    tempr{jj}=runmean(tempr{jj}, winlen);
    temprGrd(:,jj)=interp1(press{jj}, tempr{jj}, linP);
end

pOut=linP;

end