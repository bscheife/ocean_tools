

function mtime = unixtime2mtime(utime)
%USE: mtime = unixtime2mtime(unix_time)
%Convert unix time to matlab's datenumber format

    mtime=utime./86400 + 719529;         % 719529 == datenum(1970,1,1)

end