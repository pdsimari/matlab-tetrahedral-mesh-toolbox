function E = tetraGetEdges(tetra)

% Patricio Simari
% March 28, 2016
% 
% E = tetraGetEdges(tetra)
%
% Get the set of unique directed edges that appear in the mesh; E(:, i)
% contains the vertex ID references of the i-th edge.

T = sort(tetra.T);

E = [T([1, 2], :), T([1, 3], :), T([1, 4], :), ...
     T([2, 3], :), T([2, 4], :), T([3, 4], :)];
 
E = unique(E', 'rows')';