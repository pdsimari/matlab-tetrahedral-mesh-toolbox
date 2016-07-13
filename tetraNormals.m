function tetra = tetraNormals(tetra)

% Patricio Simari
% July 2013
%
% tetra = tetraNormals(tetra)
% 
% Adds the field tetra.Nt such that tetra.Nt(:,i) contains the unit normal 
% vector of tetrahedron tetra.T(:,i) computed using PCA over the four
% points that define it. Outward direction is determined by choosing a
% positive last coordinate, assuming a heightfield.
%
% See also tetraVertexNormals.

tetra.Nt = zeros(size(tetra.V));

for t = 1:size(tetra.T,2)
    tetra.Nt(:,t) = pcaNormal(tetra.V(:,tetra.T(:,t)));
end

flip = tetra.Nt(end,:) < 0;
tetra.Nt(:,flip) = -tetra.Nt(:,flip);

% -------------------------------------------------------------------------
function N = pcaNormal(Ps)

% Computes a normal to the set of points by fitting a plane using PCA.

% Find and subtract centroid
C = mean(Ps,2);
Ps = Ps - C(:,ones(1,size(Ps,2)));

% Fit plane passing through origin
[~, ~, V] = svd(Ps','econ');
N = V(:,end);
