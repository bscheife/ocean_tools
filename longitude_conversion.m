function lonOut = longitude_conversion(lonIn,spec)
% lonOut = longitude_conversion(lonIn,spec)
%
% represent longitude (degrees) in the range from [0 360] or in the range
% [-180 180], whichever is requested
%
% 'spec' must be the string '180' to convert to the 180 representation, or
% '360' to convert to the '360' representation


if strcmp(spec,'360')
    lonOut = wrap360(lonIn);
elseif strcmp(spec,'180')
    lonOut = lonIn;
    iconv = lonIn < -180 | lonIn > 180;
    lonOut(iconv) = wrap360(lonOut(iconv)+180) - 180;
else 
    error('spec must be ''180'' or ''360'' ');
end



end

function lon360 = wrap360(lon)
%wrap to 360 coordinates
lon360 = mod(lon, 360);
end
