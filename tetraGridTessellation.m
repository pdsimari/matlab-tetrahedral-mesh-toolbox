function T = tetraGridTessellation(nx,ny,nz)

% Patricio Simari
% July 2013
%
% T = tetraGridTessellation(nx,ny,nz)
%
% Generate in T a tesselation for a set of points of size nx x ny x nz that
% are laid out uniformly on a grid of that size. Assumes points are listed
% in row major order.
%
% See also tetraRandomComplex.

if nargin < 2
    ny = nx;
end
if nargin < 3
    nz = ny;
end

T = zeros(4,6*(nx-1)*(ny-1)*(nz-1));

% stencil tetrahedron to be used for tiling
Stencil = [
        [2     4     4     4     4     4];
        [1     2     6     7     3     8];
        [3     3     2     6     7     6];
        [5     5     5     5     5     7];
    ];

t = 1;
indices = zeros(1,8);
for x = 1:(nx-1)
    for y = 1:(ny-1)
        for z = 1:(nz-1)
            
            k = 1;
            for a = 0:1;
                for b = 0:1;
                    for c = 0:1;
                        indices(k) = ((x+a-1)*ny + (y+b-1))*nz + z+c;
                        k = k + 1;
                    end;
                end;
            end;
           
            for k = 1:6
                T(:,t) = indices(Stencil(:,k));
                t = t + 1;
            end
            
        end
    end
end