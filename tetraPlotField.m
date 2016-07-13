function tetraPlotField(tetra, field, alpha)

% Patricio Simari
% July 2013
%
% tetraPlotField(tetra)
%
% Plot in 3D the field contained in the 4th component vertex elements of
% tetra.
%
% tetraPlotField(tetra, field)
%
% Plot in 3D the specified field using the first three dimensions of the
% vertices provided in tetra for spatial location.
%
% tetraPlotField(tetra, field, alpha)
%
% Use the alpha values provided. When not specified, alpha values are
% determined by field values linearly, normalized to range.
%
% See also tetraPlotMesh, tetraPlotAABB.

% ---------------------------------------------------------------------
    function plotTetra_helper(T)
        if numel(field) == size(tetra.V,2)
            patch( ...
                'faces',T',...
                'vertices', tetra.V(1:3,:)',...
                'EdgeColor', 'none', ...
                'FaceVertexCData', field, ...
                'FaceColor', 'interp', ...
                'FaceAlpha', 'interp', ...
                'FaceVertexAlphaData',alpha, ...
                'AlphaDataMapping', 'scaled', ...
                'AmbientStrength', 0.7, ...
                'FaceLighting', 'phong', ...
                'EdgeLighting', 'none' ...
                );
        elseif numel(field) == size(tetra.T,2)
            patch( ...
                'faces',T',...
                'vertices', tetra.V(1:3,:)',...
                'EdgeColor', 'none', ...
                'FaceVertexCData', field, ...
                'FaceColor', 'flat', ...
                'FaceAlpha', 'flat', ...
                'FaceVertexAlphaData',alpha, ...
                'AlphaDataMapping', 'scaled', ...
                'AmbientStrength', 0.7, ...
                'FaceLighting', 'phong', ...
                'EdgeLighting', 'none' ...
                );
        end
    end
    % ---------------------------------------------------------------------

% if no field is provided, default to height field on tetra
if nargin < 2
    field = tetra.V(4,:)';
end

if size(field,1) == 1
   field = field';
end

% field = field - median(field);
% field = field./(1.4826*median(abs(field)));
% field = normcdf(field);

field = field - min(field(:));
field = field./max(field(:));

if nargin < 3
    if size(field,2) == 1
        alpha = field;
    else
        alpha = mean(field,2);
    end
else
    alpha = alpha - min(alpha(:));
    alpha = alpha./max(alpha(:));
end

if size(alpha,1) == 1
   alpha = alpha';
end
    
hold on;
plotTetra_helper(tetra.T([2,3,4],:));
plotTetra_helper(tetra.T([1,4,3],:));
plotTetra_helper(tetra.T([1,2,4],:));
plotTetra_helper(tetra.T([1,3,2],:));
hold off;

set(gcf, 'Color', 'w');

%alphamap(linspace(0,.025,256));
alphamap(linspace(0,.01,1));

set(gcf, 'Color', 'w');
set(gcf, 'Renderer', 'OpenGL');
set(gca, 'Projection', 'perspective');

axis equal;
axis tight;
axis off;

view(3);

tetraPlotAABB(tetra);

end