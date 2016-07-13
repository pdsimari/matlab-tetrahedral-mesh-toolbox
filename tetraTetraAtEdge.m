function T = tetraTetraAtEdge(tetra, v1, v2)

% Patricio Simari
% July 2013
%
% T = tetraTetraAtEdge(tetra, v1, v2)
%
% Return the list of tetrahedra incident at edge (v1,v2). Assumes that
% tetra has the attribute 't_at_v' which is initialized by calling tetra =
% getOneRingTetra(tetra).
%
% See also tetraGetVertexStar, tetraGetOneRingTetra,
% tetraCountTetraAtVerts, tetraGetTetraAdjacencyList.


T = intersect(tetra.t_at_v{v1}, tetra.t_at_v{v2});