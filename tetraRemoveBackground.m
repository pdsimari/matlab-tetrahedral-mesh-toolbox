function tetra = tetraRemoveBackground(tetra, threshold)

% Patricio Simari
% March 27, 2016
%
% tetra = tetraRemoveBackground(tetra, threshold)
%
% Remove the tetrahedra whose interpolated centroidal field value falls
% below the given threshold.

if ~isfield(tetra, 'C')
    tetra = tetraGetCentroids(tetra);
end

del = (tetra.C(4, :) < threshold);

tetra.T(:, del) = [];
tetra.C(:, del) = [];

tetra = tetraRemoveUnrefVerts(tetra);