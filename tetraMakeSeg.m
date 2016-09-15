function [tetra, seg_tetra, seg_verts] = tetraMakeSeg(fstring, res, r, jitter)

% Patricio Simari
% Created: February 22, 2016
% Last Edited: Sep 15, 2016
%
% [tetra, seg_gt] = tetraMakeSeg(fstring, res, r, jitter)
%
% Generate a tetrahedral complex labeled with a ground truth segmentation
% usable for validating a segmentation function.
%
% Arguments:
% 
% * fstring: a function of x, y, z in string form (see example below).
%
% * res: the resolution of the initial (unjittered) grid. Number of 
% vertices will be res^3.
%
% * r: the radius of the bounding cube of the complex; each dimension will
% range from -r to r.
%
% * jitter: the magnitude of uniform noise added to internal vertex 
% positions expressed as a fraction of side edge length prior to jitter.
%
% Example:
% 
% [tetra, seg_gt] = tetraMakeSeg('x^2 + y^2 + z^2 <= 1', 10, 1.5, 0.1);

xvals = linspace(-r, r, res);
tetra = tetraJitteredGridComplexExplicitFunction(fstring, xvals, xvals, xvals, jitter);
tetra.V(4, :) = tetra.V(4, :) + 1;

% ground truth segmentation
tetra = tetraGetCentroids(tetra);
seg_tetra = round(tetra.C(4, :));
seg_verts = tetra.V(4, :);

tetra = tetraGetAdjacentTetraPairs(tetra);

