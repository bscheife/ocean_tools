

function [trackDist, lon_interp, lat_interp]=glider_track_distance(lon, lat)
% Usage: [trackDist, lon_interp, lat_interp]=glider_track_distance(lon, lat)
%
%lon and lat are 1D vectors with gps coordinates for all casts. 
%Since the glider only surfaces every few casts, seperate casts from the
%same sequence have the same gps tag. This is, of course, incorrect. So we
%create linearly-spaced gps coordinates for consecutive casts between
%surfacings.
%
%Output: trackDist is the along-track distance for each cast. lon_interp 
%   and lat_interp are coordinate vectors, with linearly interpolated 
%   coordinates when the glider didn't surface. These are needed to
%   calculate the along-track distance for each cast.
%
%Requires m_lldist() which is part of m_map, available from Rich Pawlowicz
%
%B. Scheifele 2016-11

%Note, an alternative would be to use the glider's dead-reckoned position
%coordinates, but this will have discontinuities at each surfacing

%Setup cell array so we can use a loop, rather than copy-paste
coords{1}=lat;
coords{2}=lon;

for ii=1:2
    
    gps=coords{ii};
    
    %check to make sure input is a 1D vector
    if size(gps,1)>1 & size(gps,2)>1
        error('input must be a 1D vector');
    end
    
    %Replace nans (if any) with previous known location
    inan=find(isnan(gps));
    for jj=inan
        gps(jj)=gps(jj-1);
    end
    
    %Indeces of new gps fixes
    inew = find(abs(diff(gps))>0) + 1; %first index of each sequence
    inew = [1 inew];
    
    %And linearly interpolate to get new gps coordinates
    gps_interp = gps;
    for jj=1:(length(inew)-1)
        gps1 = gps(inew(jj));
        gps2 = gps(inew(jj+1));
        num = inew(jj+1)-inew(jj)+1;
        newVals=linspace(gps1, gps2, num);
        gps_interp(inew(jj):inew(jj+1))=newVals;
        %disp(gps_interp)
    end
   
    coords_interp{ii}=gps_interp;
end

%The new lats and lons
lat_interp=coords_interp{1};
lon_interp=coords_interp{2};

%m_map provides convenient way to calculate distance between points (kms)
distPts = m_lldist(lon_interp, lat_interp);
trackDist = cumsum(distPts');
%Along track distance (km)
trackDist = [0 trackDist];

end %end of function








