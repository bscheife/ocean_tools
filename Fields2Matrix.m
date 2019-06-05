function [M1 M2]=Fields2Matrix(DataStruct,FieldName,pFieldName,pOut)
%USE: [M1 M2]=Fields2Matrix(DataStruct,FieldName,pFieldName,pOut)
%
%Interpolate data from one field of a 1xN data structure onto a 2D Matrix
%in order to make contouring easy. See example below
%
%DataStruct is a 1xN data structure. FieldName and pFieldName are strings.
%pOut is a one-dimensional pressure vector onto which to interpolate the
%vertical profiles.
%
%   DataStruct(ii).(FieldName) contains one or two profiles of temperature,
%       salinity, or similar. It must have one or two *columns* of data.
%
%   DataStruct(ii).(pFieldName) contains the corresponding pressure record.
%
%   M1 is a contourable matrix of the data in the first column of
%       {DataStruct.(FieldName)}'. It has size length(pOut)xN.
%   M2 is a contourable matrix of the data in the second column of 
%       {DataStruct.(FieldName)}' if this exists.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Example: There are 348 CTD casts, each stored in one element of a 1x348
%data structure. Each element contains three fields:
% 
% CTD = 
% 1x348 struct array with fields:
%     tempr
%     saln
%     press
% 
% and each field contains a vertical profile:
%
% CTD(10)
% ans = 
%     tempr: [87x2 double]
%      saln: [87x1 double]
%     press: [87x1 double]
%
% We want all temperature casts in an evenly spaced grid so we can easily
% contour the data. First set up the pressure grid we want to use. Then
% call Fields2Matrix.
%
% pmax = max(cell2mat({CTD.press}')); 
% p = [0:1:pmax]'; 
% [temprMat1 temprMat2] = Fields2Matrix(CTD,'tempr','press',p);
%
% Now we have two contourable matrices, one for each temperature channel.
% Each matrix has size length(p) x 348
%
%
% B.Scheifele 2017-01


%check if one or two channels
oneCast=[];
ii=1;
while isempty(oneCast)
    oneCast = DataStruct(ii).(FieldName);
    ii=ii+1;
end
nChan = min(size(oneCast));

%number of casts
nCasts = length(DataStruct);

%empty cell arrays
dat1_cell = cell(1,nCasts);
dat2_cell = cell(1,nCasts);

%make cell arrays. Use dynamic field names for the structure
for ii=1:nCasts
    p_cell{ii} = DataStruct(ii).(pFieldName);
    dat1_cell{ii} = DataStruct(ii).(FieldName)(:,1);
    if nChan==2
        dat2_cell{ii} = DataStruct(ii).(FieldName)(:,2);
    end
end

%make matrices from cell arrays
[M1 p] = casts2matrix(dat1_cell, p_cell, pOut, 1);
if nChan==2
    [M2 p] = casts2matrix(dat2_cell, p_cell, pOut, 1);
else
    M2 = [];
end


end