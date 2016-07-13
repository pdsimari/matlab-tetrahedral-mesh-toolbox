function tetra = tetraRandomComplex(n)

% Patricio Simari
% July 2013
%
% tetra = randomComplex(n)
%
% Generate a random complex. The points are randomly sampled from [0,1]^3
% using a uniform distribution and then Delaunay tessellated. Fourth 
% dimension is not included.
%
% See also tetraGridTessellation.

tetra.V = rand(3,n);
tetra.T = delaunayn(tetra.V')';