function tetra = tetraVertexNormals(tetra)

% Patricio Simari
% July 2013
%
% tetra = tetraVertexNormals(tetra)
% 
% Adds the field tetra.Nv such that tetra.Nv(:,i) contains the unit normal 
% vector of vertex tetra.V(:,i) computed as the volume-weighted average of
% all normals associated with tetrahedra incident on vertex i.
%
% See also tetraNormals.

% compute tetra normals if necessary
if ~isfield(tetra,'Nt')
    tetra = tetraNormals(tetra);
end

% for each vertex, compute vertex normal as volume-weighted average of
% all incident tetradra's normals

tetra.Nv = zeros(size(tetra.V));

vol = zeros(1,size(tetra.V,2));

M = zeros(5,5);
M(2:end,1) = 1;
M(1,2:end) = 1;

for t = 1:size(tetra.T,2)
    
    % compute volume of tetrahedron t
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

    for d = 1:size(tetra.V,1)
        tetra.Nv(d,tetra.T(:,t)) = tetra.Nv(d,tetra.T(:,t)) + t_vol*tetra.Nt(d,t);
    end
    vol(tetra.T(:,t)) = vol(tetra.T(:,t)) + t_vol;
    
end

% normalize weighted contribution over total volume;
for d = 1:size(tetra.Nv,1)
    tetra.Nv(d,:) = tetra.Nv(d,:)./vol;
end

% normalize normalize to unit lenght
n = sqrt(sum(tetra.Nv.^2,1));
for d = 1:size(tetra.Nv,1)
    tetra.Nv(d,:) = tetra.Nv(d,:)./n;
end
