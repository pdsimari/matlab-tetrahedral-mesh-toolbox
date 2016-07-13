function count = tetraCountTetraAtVerts(tetra)

% Patricio Simari
% July 2013
%
% count = tetraCountTetraAtVerts(tetra)
%
% count(v) is the number of tetrahedra incident on vertex with index v.
%
% See also tetraGetVertexStar, tetraGetOneRingTetra, tetraTetraAtEdge, 
% tetraGetTetraAdjacencyList.

count = zeros(1,size(tetra.V,2));

for t = 1:size(tetra.T,2)
    count(tetra.T(:,t)) = count(tetra.T(:,t)) + 1;
end