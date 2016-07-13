function tetra = tetraRandomComplexExplicitFunction(fstring, n, xmin, xmax, ymin, ymax, zmin, zmax)

% Patricio Simari
% July 2013
%
% tetra = tetraRandomComplexExplicitFunction(fstring, n, xmin, xmax, ymin, ymax, zmin, zmax)
%
% Generates a tetrahedralized sampling of the function represented in
% fstring evaluated using the symbolic toolbox. Their are n samples chosen
% uniformly randomly in the intervals [xmin, xmax], [ymin, ymax], and 
% [zmin, zmax], of each dimension of the domain respectively. The samples
% are then Delaunay-tessellated in the domain to generate the tetrahedra.
%
% See also tetraGridComplexExplicitFunction, tetraGridComplexHemisphere.

f = inline(fstring,'x','y','z');

tetra.V(1,:) = rand(1,n)*(xmax-xmin) + xmin;
tetra.V(2,:) = rand(1,n)*(ymax-ymin) + ymin;
tetra.V(3,:) = rand(1,n)*(zmax-zmin) + zmin;

k = 1;
for k = 1:n
    tetra.V(4,k) = f(tetra.V(1,k),tetra.V(2,k),tetra.V(3,k));
end

tetra.T = delaunayn(tetra.V(1:3,:)')';