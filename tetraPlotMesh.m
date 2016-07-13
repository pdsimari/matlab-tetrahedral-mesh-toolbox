function tetraPlotMesh(tetra)

% Patricio Simari
% July 2013
%
% tetraPlotMesh(tetra)
%
% Plot the wireframe mesh of the tetrahedral complex in 3D. The fourth
% dimension (scalar field over 3D points) is not plotted. This is intended
% for inspecting the tessellation. 
%
% See also tetraPlotField, tetraPlotAABB.

    function plotTetra_helper(T)
        patch( ...
            'faces',T', ...
            'vertices', tetra.V(1:3,:)',...
            'LineWidth', .01, ...
            'FaceColor', 'none' ...
        );
    end

plotTetra_helper(tetra.T([2,3,4],:));
plotTetra_helper(tetra.T([1,4,3],:));
plotTetra_helper(tetra.T([1,2,4],:));
plotTetra_helper(tetra.T([1,3,2],:));


set(gcf, 'Color', 'w');

axis equal,
axis tight;
axis off;
set(gcf, 'Renderer', 'OpenGL');
view(3);

end