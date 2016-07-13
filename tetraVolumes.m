function vol = tetraVolumes(tetra)

% Patricio Simari
% July 2013
%
% vol = tetraVolumes(tetra)
% 
% Compute the volumes of all tetrahedra so that vol(i) contains the volume
% of tetrahedron i.
%
% See also tetraVolumeSingle, tetraBarycentricVolumes, tetraVoronoiVolumes.

vol = zeros(1,size(tetra.T,2));

M = zeros(5,5);
M(2:end,1) = 1;
M(1,2:end) = 1;

for t = 1:size(tetra.T,2)
    
    M(2,3) = sum((tetra.V(:,tetra.T(1,t)) - tetra.V(:,tetra.T(2,t))).^2);
    M(2,4) = sum((tetra.V(:,tetra.T(1,t)) - tetra.V(:,tetra.T(3,t))).^2);
    M(2,5) = sum((tetra.V(:,tetra.T(1,t)) - tetra.V(:,tetra.T(4,t))).^2);
    M(3,4) = sum((tetra.V(:,tetra.T(2,t)) - tetra.V(:,tetra.T(3,t))).^2);
    M(3,5) = sum((tetra.V(:,tetra.T(2,t)) - tetra.V(:,tetra.T(4,t))).^2);
    M(4,5) = sum((tetra.V(:,tetra.T(3,t)) - tetra.V(:,tetra.T(4,t))).^2);
    
    M(3,2) = M(2,3);
    M(4,2) = M(2,4);
    M(5,2) = M(2,5);
    M(4,3) = M(3,4);
    M(5,3) = M(3,5);
    M(5,4) = M(4,5);
    
    vol(t) = sqrt(det(M)/288);
    
end
