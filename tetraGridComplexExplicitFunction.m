function tetra = tetraGridComplexExplicitFunction(fstring, xvals, yvals, zvals)

% Patricio Simari
% March 2015
%
% tetra = tetraGridComplexExplicitFunction(fstring, xvals, yvals, zvals)
%
% Generates a tetrahedralized sampling of the function represented in
% fstring evaluated using the symbolic toolbox. The domain is sampled on a
% 3D grid of points along the x, y, and z values specified in xvals, yvals,
% and zvals respectively. The tetrahedra are the result of a grid 
% tessellation of the sample points orthographically projected to the first
% 3 dimensions. 
%
% See also tetraGridComplexHemisphere, tetraRandomComplexExplicitFunction.

f = inline(fstring,'x','y','z');
tetra.V = zeros(4,numel(xvals)*numel(yvals)*numel(zvals));

k = 1;
for x = xvals
    for y = yvals
        for z = zvals
            tetra.V(1,k) = x;
            tetra.V(2,k) = y;
            tetra.V(3,k) = z;
            tetra.V(4,k) = f(x,y,z);
            k = k + 1;
        end
    end
end

tetra.T = tetraGridTessellation(numel(xvals), numel(yvals), numel(zvals));