function d = tetraBoundingBoxDiagonal(tetra)

% Patricio Simari
% July 2013
%
% d = tetraBoundingBoxDiagonal(tetra)
%
% d is the diagonal length of the axis-aligned bounding box of the vertices
% of tetra. This can be used as an estimate of the scale of the tetrahedral
% mesh.

d = sqrt(sum((max(tetra.V,[],2) - min(tetra.V,[],2)).^2));