function ZZ=runmeanmean(Y, WinLen, EndPts)
%
% USE: [ZZ]=runmeanmean(Y, WinLen, EndPt)
% 
% Calculate running mean in both directions (zero phase shift). After
% performing one running mean, runmean flips the vector, performs another
% running mean, and then flips the vector again. NaNs are ignored when
% averaging. Requires R2015a or newer. Could modify this for older versions
% of matlab by implementing nanmean. See the code for runmean.m as an
% example.
%
% Inputs
%    Y: input vector (1D) 
%    WinLen: window length for running mean (must be odd integer)
%    EndPt: (optional) specify endpoint handling. Options are
%               - 'Orig' to copy original values from x to z (default)
%               - 'ShrinkWin' to shrink window as you approach the edge
%
% Note that using 'Orig' does NOT account for padding by NaNs at the
% endpoints of your vectors. I.E. if your vectors are padded with NaNs at
% the endpoints, runmeanmean in effect just ends up using a shrinking
% window

% B. Scheifele 2016



%Input checks

%Window length
if length(Y)/WinLen<3
    error('Window length must be at least 3x larger than the vector')
end
if mod(WinLen,2)~=1 | WinLen<0
    error('Window length must be positive, odd integer')
end
%End point argument
if nargin<3
    EndPts='Orig';
elseif ~strcmpi(EndPts,'Orig') & ~strcmpi(EndPts,'ShrinkWin')
    error('Endpoint argument is invalid')
end
%Which dimension?
[~, dim] = max(size(Y));

%Setup variables
N=length(Y);
%By setting Z=Y initially, we automatically get the original data at edges
Z=Y;  
%number of pts on either side to avg
W=(WinLen-1)/2;

%loop through each point (but not the endpoints)
for i=1+W:N-W
    Z(i)=mean(Y(i-W:i+W), 'omitnan');	% Compute mean in window
end

%shrink window at end-points if requested
if strcmpi(EndPts, 'ShrinkWin')
    for i=1:W
        Z(i)=mean(Y(1:2*i-1), 'omitnan'); %shrink left endpoint
    end
    for i=N-W+1:N
        Z(i)=mean(Y(2*i-N:N), 'omitnan'); %shrink right window
    end
end

%Flip filtered vector
if dim==2 %if row vector
    Z=fliplr(Z);
elseif dim==1 %if column vector
    Z=flipud(Z);
else
    error('cant get dimension of vector')
end

%Repeat filtering
ZZ = Z;
for i=1+W:N-W
    ZZ(i)=mean(Z(i-W:i+W), 'omitnan');	% Compute mean in window
end
if strcmpi(EndPts, 'ShrinkWin')
    for i=1:W
        ZZ(i)=mean(Z(1:2*i-1), 'omitnan'); %shrink left endpoint
    end
    for i=N-W+1:N
        ZZ(i)=mean(Z(2*i-N:N), 'omitnan'); %shrink right window
    end
end

%And flip back!
if dim==2 %if row vector
    ZZ=fliplr(ZZ);
else %if column vector
    ZZ=flipud(ZZ);
end

%Lastly, make sure any NaNs in the original vector are NaNs in the new one,
%because the window-averaging could potentially introduce artificial data

ZZ(isnan(Y))=nan;

end








