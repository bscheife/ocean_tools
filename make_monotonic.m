function [depthMono temperatureMono]=make_monotonic(depth, temperature)
%
% USE: [depth temperature]=make_monotonic(depth_in, temperature_in)
%
% This simple function sorts a depth-temperature profile so that it
% increases monotonically in depth. Repeated depths are excluded. The
% function's primary purpose is to clean up a profile where the instrument
% wobbled up and down while profiling, making the depth record
% non-monotonic. Monotonic records are needed for e.g. 1D interpolation.
%
% depth_in and temperature_in can really be any set of independent and
% dependent variables with the independent variable non-monotonic.
%
% The calculation is:
%
%   [depthMono isort]=unique(depth);
%   temperatureMono=temperature(isort);

% B. Scheifele 2016


[depthMono isort]=unique(depth);
temperatureMono=temperature(isort);


end