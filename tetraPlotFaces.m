function tetraPlotFaces(tetra, ind_f, color_f)

% Patricio Simari
% Feb 23, 2016
%
% tetraPlotFaces(tetra, ind_f, color_f)
%
% Plot a subset of the triangular faces. Assumes tetraGetAdjecantTetraPairs
% has been invoked on the tetraStructure and field 'F' is available. Plots
% the faces tetra.F(1:3, ind_f) with color indices color_f.

patch( ...
    'faces',                tetra.F(1:3, ind_f)', ...
    'vertices',             tetra.V(1:3,:)',      ...
    'EdgeColor',            'k',                  ...
    'FaceColor',            'flat',               ...
    'FaceVertexCData',      color_f',             ...
    'AmbientStrength',      0.7,                  ...
    'FaceLighting',         'phong',              ...
    'EdgeLighting',         'none'                ...
);