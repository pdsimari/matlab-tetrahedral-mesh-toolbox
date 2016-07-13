function [lb, vor] = tetraLaplaceBeltrami(tetra)

% Patricio Simari
% July 2013
%
% lb = tetraLaplaceBeltrami(tetra)
%
% Compute the Laplace-Beltrami operator over all vertices such that lb(i)
% containst the signed norm of the Laplace-Beltrami vector at the i-th
% vertex. Sign is determined assuming tetra represents a heightfield. In
% order to obtain a mean curvature estimate, devide by vertex volume
% estimateion.
%
% [lb, vor] = tetraLaplaceBeltrami(tetra)
%
% Return in vor(i) the Voronoi volume value at vertex i. Note: for
% curvature estimates, the barycentric volume seems to work better.
%
% See also tetraBarycentricVolumes.

% Pre-tabulate all 6 tetra edges (v1(k),v2(k)) and their opposing edge 
% (w1(k),w2(k)), k in [1,6].
v1 = [ 1, 1, 1, 2, 2, 3 ];
v2 = [ 2, 3, 4, 3, 4, 4 ];
w1 = [ 3, 2, 2, 1, 1, 1 ];
w2 = [ 4, 4, 3, 4, 3, 2 ];

% preallocate K and vor (volume) array
K = zeros(size(tetra.V));

if nargout > 1
    vor = zeros(1,size(tetra.V,2));
end

% for each tetrahedron
for t = 1:size(tetra.T,2)
        
    % for each edge in the tetrahedron
    for k = 1:6
        
        % edge indices
        i1 = tetra.T(v1(k),t);
        i2 = tetra.T(v2(k),t);
        
        % opposite edge indices
        j1 = tetra.T(w1(k),t);
        j2 = tetra.T(w2(k),t);
        
        % get the four vertex coords
        I1 = tetra.V(:,i1);
        I2 = tetra.V(:,i2);
        J1 = tetra.V(:,j1);
        J2 = tetra.V(:,j2);
        
        % get dihedral angle at opposite edge
        ang = tetraDihedralAngle(J1,J2,I1,I2);
        
        % get cotangent weight
        w = (1/6)*cot(ang)*sqrt(sum((J2-J1).^2));
        
        % get edge vector
        E = I1 - I2;
        
        % update K value at vertices i1 and i2
        K(:,i1) = K(:,i1) + w*E;
        K(:,i2) = K(:,i2) + w*(-E);
        
        if nargout > 1
            v = (1/6)*w*sum(E.^2,1);
            vor(i1) = vor(i1) + v;
            vor(i2) = vor(i2) + v;
        end
        
    end
        
end

lb = (1/3)*sqrt(sum(K.^2,1));

% since it's a graph function, we can compute the sign of the LB by looking
% at the sign of the last component of the K vector.
lb = lb.*sign(K(end,:));