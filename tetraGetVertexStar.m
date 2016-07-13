function tetra = tetraGetVertexStar(tetra)

% Patricio Simari
% July 2013
%
% tetra = tetraGetVertexStar(tetra)
%
% Add a cell array field 'star' to tetra; star{v} contains a list of
% indices of all vertices adjacent to v.
%
% See also tetraGetOneRingTetra, tetraCountTetraAtVerts, tetraTetraAtEdge,
% tetraGetTetraAdjacencyList.

% initialize all adjacency lists to null
tetra.star = cell(size(tetra.V,2),1);

% for each tetrahedron t
for t = 1:size(tetra.T,2)
    % for each vertex v of t
    for v = tetra.T(:,t)' 
        % list it as being adjacent to all others in t
        tetra.star{v} = [tetra.star{v},tetra.T(:,t)'];
    end
end

% remove self and repeated elements from each list
for v = 1:size(tetra.V,2)
    tetra.star{v} = setdiff(tetra.star{v},v);
end