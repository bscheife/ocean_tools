function [rX, rY] = rotate_vectors(X,Y,theta)
%[rX, rY] = rotate_vectors(X,Y,theta)
%
% rotate around the origin the points given by the x and y coordinates
% defined by 1D vectors X and Y. Rotate by THETA degrees around the Z axis.
% Positive theta describes a counterclockwise rotation

% B.Scheifele 2017


%check inputs are oneD vectors
if ~isvector(X) | ~isvector(Y)
    error('X and Y must be 1D vectors');
end
%check X and Y are same size
if any(size(X)~=size(Y))
    error('X and Y must be same size')
end
%If column vectors, transpose
if iscolumn(X)
    X=X'; Y=Y';
    transposed=true;
else
    transposed=false;
end

%Rotation Matrix
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)]; %rotation matrix
%Do the rotation
V = [X; Y]; %[x1 x2 x3 ... ; y1 y2 y3 ...]
rV = R*V;
%rotated x and y
rX = rV(1,:); 
rY = rV(2,:); 

%transpose back if necessary
if transposed
    rX=rX'; rY=rY';
end

end