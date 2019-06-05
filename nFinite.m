function n = nFinite(x)
%USAGE: n = nFinite(x)
%Count the number of finite values in array x. Shorthand for
%n = sum(isfinite(x))

n = sum(isfinite(x));

end