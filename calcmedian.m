function outvec=calcmedian(invec, winlen)
%CALCMEDIAN calculate the running median using windowlength winlen
%
%z=calcmedian(x, winlen) implements a running median of windowlength winlen
%on the input data x which must be a one-dimensional vector. The "smoothed"
%output data is returned in z. 
%
%End effects: data points within (winlen-1)/2 on either side are left
%unmodified.

checkinputs(invec,winlen);

x=invec;

N=length(invec);

W=(winlen-1)/2; % Half window size
zm=x;                   % By setting z=x, we get automatically the data for the edges
for i=1+W:N-W
    zm(i)=median(x(i-W:i+W));	% Computing median for the corresponding window
end
outvec=zm;

end

function checkinputs(invec, winlen)
%sanity check to make sure the input arguments are okay

dims = size(invec);
if dims(1)~=1 & dims(2)~=1
    error('Input data must be 1D vector')
end
if length(invec)<winlen+1
    error('Input data must be greater than winlen+1')
end
if rem(winlen, 2)==0 | round(winlen)~=winlen
    error('winlen must be an odd integer')
end
if winlen<3
    error('winlen must be greater than or equal to 3')
end

end