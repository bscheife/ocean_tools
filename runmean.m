function Z=runmean(Y, WinLen, EndPts)
%
% USE: [Z]=runmean(Y, WinLen, EndPt)
% 
% Calculate running mean. NaNs are ignored. Requires R2015a or 
% newer, or the function nanmean() for older Matlab releases.
%
% Inputs
%    Y: input vector (1D) 
%    WinLen: window length for running mean (must be odd integer)
%    EndPt: (optional) specify endpoint handling. Options are
%               - 'Orig' to copy original values from x to z (default)
%               - 'ShrinkWin' to shrink window as you approach the edge
%               - 'NaN' to fill endpoints with NaNs
%
% Outputs
%    Z: smoothed series, same size as x
%

% B. Scheifele 2016



%Input checks below

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
elseif ~strcmpi(EndPts,'Orig') & ~strcmpi(EndPts,'ShrinkWin') & ...
        ~strcmpi(EndPts,'NaN')
    error('Endpoint argument is invalid')
end

%Setup variables
N=length(Y);
%By setting Z=Y initially, we automatically get the original data at edges
Z=Y;  
%number of pts on either side to avg
W=(WinLen-1)/2;

%For Matlab 2015a and newer use regular mean() function. This is almost an 
%order of magnitude faster than using nanmean in older versions of matlab.

if ~verLessThan('matlab', '8.5')
    
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
    %use NaNs at endpoints if requested
    if strcmpi(EndPts, 'nan');
        Z(1:W)=nan;
        Z(N-W+1:N)=nan;
    end
    
%For older versions of Matlab use nanmean() instead, but this is slow
else
    %loop through each point (but not the endpoints)
    for i=1+W:N-W
        Z(i)=nanmean(Y(i-W:i+W));	% Compute mean in window
    end
    %shrink window at end-points if requested
    if strcmpi(EndPts, 'ShrinkWin')
        for i=1:W
            Z(i)=nanmean(Y(1:2*i-1)); %shrink left endpoint
        end
        for i=N-W+1:N
            Z(i)=nanmean(Y(2*i-N:N)); %shrink right window
        end
    end
    %use NaNs at endpoints if requested
    if strcmpi(EndPts, 'nan');
        Z(1:W)=nan;
        Z(N-W+1:N)=nan;
    end
    
end

%Lastly, make sure any NaNs in the original vector are NaNs in the new one,
%because the window-averaging could potentially introduce artificial data

Z(isnan(Y))=nan;
            
end








