function tetra = tetraGetOneRingTetra(tetra)

% Patricio Simari
% July 2013
%
% tetra = tetraGetOneRingTetra(tetra)
%
% Add a cell array field 't_at_v' to tetra; t_at_v{v} contains a list of
% indices of all tetrahedra incident on v.
%
% See also tetraGetVertexStar, tetraCountTetraAtVerts, tetraTetraAtEdge,
% tetraGetTetraAdjacencyList.

% initialize all incident lists to null
tetra.t_at_v = cell(size(tetra.V,2),1);

% for each tetrahedron t
for t = 1:size(tetra.T,2)
    % for each vertex v of t
    for v = tetra.T(:,t)' 
        % at t as being incident on v
        tetra.t_at_v{v} = [tetra.t_at_v{v},t];
    end
end
