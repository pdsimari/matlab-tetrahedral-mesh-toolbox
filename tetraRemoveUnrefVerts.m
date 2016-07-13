function tetra = tetraRemoveUnrefVerts(tetra)

% Patricio Simari
% February 23, 2016
%
% tetra = tetraRemoveUnrefVerts(tetra)
%
% Delete any vertices from tetra.V that are not referenced in tetra.T.

verts = unique(tetra.T(:));
remcount = size(tetra.V, 2) - numel(verts);

if remcount > 0    
    tetra.V = tetra.V(:, verts);
    [~, tetra.T] = ismember(tetra.T, verts);
end

fprintf('Removed %d vertices.\n', remcount);