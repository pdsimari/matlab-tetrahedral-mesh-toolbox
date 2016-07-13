function tetra = tetraGetCentroids(tetra)

% Patricio Simari
% Feb 2016
% 
% tetra = tetraGetCentroids(tetra)
%
% Adds a field 'C' to the tetra structure such that tetra.C(:,i) contains
% the coordinates of the i-th tetrahedron.

tetra.C = zeros(size(tetra.V, 1), size(tetra.T, 2));
for i = 1:4
    tetra.C = tetra.C + tetra.V(:, tetra.T(i, :));
end
tetra.C = tetra.C/4;