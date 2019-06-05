
function [z zm]=runmeanmed(x, winlen, winlen_med)
%
% USE: [z zm]=runmeanmed(x, winlen, winlen_med)
% 
% Calculate running mean and running median. NaNs are ignored.
%
% Inputs
%    x: input vector (1D) 
%    winlen: window length for running mean (must be odd integer)
%    winlen_med: window length for running median (must be odd integer)
%
% Outputs: z (running mean), zm (running median)
%
% Edges:  the original values from x are copied into the outputs z and zm

if mod(winlen,2)~=1 | mod(winlen_med,2)~=1 | winlen<0 | winlen_med<0
    error('Window lengths must be positive, odd integers')
end

N=length(x);

W_mean=(winlen-1)/2;    % Half window size
z=x;                    % By setting z=x, we automatically get the data for the edges
try
    for i=1+W_mean:N-W_mean
        z(i)=mean(x(i-W_mean:i+W_mean), 'omitnan');	% Compute mean in window
    end
catch %in case older version of matlab
    for i=1+W_mean:N-W_mean
        z(i)=nanmean(x(i-W_mean:i+W_mean));	% Compute mean in window
    end
end

W_med=(winlen_med-1)/2; % Half window size
zm=x;                   % By setting z=x, we get automatically the data for the edges
try
    for i=1+W_med:N-W_med
        zm(i)=median(x(i-W_med:i+W_med), 'omitnan');	% Compute median in window
    end
catch %in case older version of matlab
    for i=1+W_med:N-W_med
        zm(i)=nanmedian(x(i-W_med:i+W_med));	% Compute median in window
    end
end


end