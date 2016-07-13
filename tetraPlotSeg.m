function tetraPlotSeg(tetra, seg, fstring)

% Patricio Simari
% Created: February 2016
% Last updated: May 4, 2016
%
% tetraPlotSeg(tetra, seg, fstring)
%
% Plot the tetrahedral segmentation given by seg, where seg(i) contains
% the label of the i-th tetra. Plot only the volume that is inside as 
% determined by the fstring function given when f(x, y, z) evaluates to 
% true.

if ~isfield(tetra, 'F')
    warning(['Computing ''F'' field for tetra structure. ', ...
             'Consider pre-invoking tetraGetAdjacentTetraPairs ', ...
             'to avoid redundant computation.']);
    tetra = tetraGetAdjacentTetraPairs(tetra);
end
if ~isfield(tetra, 'C')
    warning(['Computing ''C'' field for tetra structure. ', ...
             'Consider pre-invoking tetraGetCentroids ', ...
             'to avoid redundant computation.']);
    tetra = tetraGetCentroids(tetra);
end
    
f = inline(fstring, 'x', 'y', 'z');

% evaluate fstring: inside is negative, outside is positive
inside = false(1, size(tetra.T, 2));
for t = 1:size(tetra.T, 2)
    inside(t) = f(tetra.C(1, t), tetra.C(2, t), tetra.C(3, t));
end

% face indices and corresponding face colors
ind_f = [];
seg_f = [];

% for every triplet (f, t1, t2) ...
for f = 1:size(tetra.F, 2)
    
    t1 = tetra.F(4, f);
    t2 = tetra.F(5, f);
    
    % f is a boundary face --> t1 color
    if (t1 ~= 0) && (t2 == 0)
        
        if inside(t1)
            ind_f = [ind_f, f];
            seg_f = [seg_f, seg(t1)];
        end
        
    % t1 is inside and t2 is outside --> t1 color
    elseif inside(t1) && ~inside(t2)
        
        ind_f = [ind_f, f];
        seg_f = [seg_f, seg(t1)];
        
    % t1 is outside and t2 is inside --> t2 color
    elseif ~inside(t1) && inside(t2)
        
        ind_f = [ind_f, f];
        seg_f = [seg_f, seg(t2)];
        
    end
end

tetraPlotFaces(tetra, ind_f, seg_f);
tetraPlotAABB(tetra);

set(gcf, 'Color', 'w');
set(gcf, 'Renderer', 'OpenGL');
set(gca, 'Projection', 'perspective');

axis equal;
axis tight;
axis off;

view(3);
camlight;

end