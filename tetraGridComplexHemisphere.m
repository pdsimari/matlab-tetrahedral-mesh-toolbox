function tetra = tetraGridComplexHemisphere(n, r)

% Patricio Simari
% July 2013
%
% tetra = tetraGridComplexHemisphere(n)
%
% Generates a tetrahedralized sampling  of a 3-hemisphere of radius 1
% embedded in R^4 sampled on an n^3 grid of points sampled along the first
% three coordinates from -1 to 1. Sample points that lie outside the 
% spherical domain in R^3 are not used. The tetrahedra are the result of a 
% grid tessellation of the sample points orthographically projected to
% the first 3 dimensions. 
%
% tetra = tetraGridComplexHemisphere(n, r)
%
% Generate the sphere with radius r (default 1). 
%
% See also tetraGridComplexExplicitFunction, tetraRandomComplexExplicitFunction.

% default value for r
if nargin < 2
    r = 1;
end

% store r^2
r2 = r*r;

tetra.V = zeros(4,n*n*n);

k = 1;
for x = linspace(-r,r,n)
    for y = linspace(-r,r,n)
        for z = linspace(-r,r,n)

            tetra.V(1,k) = x;
            tetra.V(2,k) = y;
            tetra.V(3,k) = z;
            k = k + 1;
            
        end
    end    
end

% tessellate
tetra.T = tetraGridTessellation(n);

% remove vertices not conforming to spherical domain
tetra = tetraDeleteVertices(tetra,find(sum(tetra.V(1:3,:).^2) > r2));

% compute field value as upper hemisphere
tetra.V(4,:) = sqrt(r2 - sum(tetra.V(1:3,:).^2));
