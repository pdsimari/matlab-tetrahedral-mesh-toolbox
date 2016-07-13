function vol = tetraBarycentricVolumes(tetra)

% Patricio Simari
% July 2013
%
% vol = tetraBarycentricVolumes(tetra)
%
% vol(i) is the barycentric volume associated with vertex i. This is
% computed as the sum 1/4 volume of all tetrahedra incident on i.
%
% See also tetraVolumeSingle, tetraVolumes, tetraVoronoiVolumes.

vol = zeros(1,size(tetra.V,2));

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
    
    t_vol = sqrt(det(M)/288);
    
    vol(tetra.T(:,t)) = vol(tetra.T(:,t)) + t_vol;
end

vol = vol./4;