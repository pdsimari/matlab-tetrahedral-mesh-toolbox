function vol = tetraVolumeSingle(A,B,C,D)

% Patricio Simari
% July 2013
%
% vol = tetraVolumeSingle(A,B,C,D)
% 
% Compute the volume of a tetrahedron determined by the four points A, B,
% C, and D represented as column vectors.
%
% See also tetraVolumes, tetraBarycentricVolumes, tetraVoronoiVolumes.

M = zeros(5,5);
M(2:end,1) = 1;
M(1,2:end) = 1;

M(2,3) = sum((A - B).^2);
M(2,4) = sum((A - C).^2);
M(2,5) = sum((A - D).^2);
M(3,4) = sum((B - C).^2);
M(3,5) = sum((B - D).^2);
M(4,5) = sum((C - D).^2);

M(3,2) = M(2,3);
M(4,2) = M(2,4);
M(5,2) = M(2,5);
M(4,3) = M(3,4);
M(5,3) = M(3,5);
M(5,4) = M(4,5);

vol = sqrt(det(M)/288);
