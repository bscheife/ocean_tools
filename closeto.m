function [ind]=closeto(x,number)
%[ind]=closeto(x,number)
%Find the index of the 1D vector x whose value is nearest the search value
%'number'. If x is a matrix, it is treated as x(:). If there are
%multiple matches, closeto() returns the first match. If 'number' is
%non-finite or imaginary, closeto() returns NaN. Also works for 'datetime'
%variables as long as both x and number are datetimes.
%
%Also works if 'number' is a 1D vector. In this case, 'ind' is a 1D vector
%the same length as 'number', with each element indicating the index of the
%nearest search value corresponding to that element in 'number'.

%check for 1D
if ~isvector(number)
    error('number must be a scalar or 1D vector')
end

%convert datetimes to serial times if required
if isdatetime(x) & isdatetime(number)
    x = datenum(x);
    number = datenum(number);
end

%check finite and real
if ~isfinite(number) | ~isreal(number)
    ind = nan;
    return
end

%Do the calculation. Vectorize for efficiency if length(number)>1
try
    [~, ind] = min(abs(x(:)-number(:)'));
    %This doesn't work if the matrices are too big. If they're too big
    %you're just gonna have to wait for the loop (catch below)
catch
        ind = nan(size(number));
        for ii=1:length(number)
            [val ind(ii)] = min(abs(x-number(ii)));
        end
end


end

%above requires 2016b or later. If using earlier, I think this will work:
% [~, ind] = min(abs(bsxfun(@minus,x(:),number(:)')));






% %previous code uses a loop. Too slow.
% %if we're looking for just a single value
% if length(number)==1
%     %do the calculation
%     [val ind]=min(abs(x-number));
%     
% %if we're looking for multiple values, use a loop
% elseif length(number)>1
%     ind = nan(size(number));
%     for ii=1:length(number)
%         [val ind(ii)] = min(abs(x-number(ii)));
%     end
% else
%     error('something is wrong');
% end






%alternative calculation, probably slower
%ind=find(abs(x-number)==min(abs(x-number)),1,'first');






