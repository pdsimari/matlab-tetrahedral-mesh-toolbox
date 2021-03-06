function I = tetraToImage(tetra)

% Patricio Simari
% June 8, 2016
%
% I = tetraToImage(tetra)
%
% Converts the given tetrahedral mesh back to a 3D image. Note: this
% function assumes that the coordinate values of the mesh are positive
% integers that lie on a regular grid as generated by tetraFromImage.
%
% See also tetraFromImage.

sz = zeros(1, 3);

[~, ~, x] = unique(tetra.V(1, :));
[~, ~, y] = unique(tetra.V(2, :));
[~, ~, z] = unique(tetra.V(3, :));

sz(1) = max(x(:));
sz(2) = max(y(:));
sz(3) = max(z(:));

I = zeros(sz);
for v = 1:size(tetra.V, 2)        
    I(x(v), y(v), z(v)) = tetra.V(4, v);
end

