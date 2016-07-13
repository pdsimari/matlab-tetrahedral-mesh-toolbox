function vol = tetraVoronoiVolumes(tetra, n)

% Patricio Simari
% July 2013
%
% vol = tetraVoronoiVolumes(tetra)
%
% vol(i) is the Voronoi volume associated with vertex i.
%
% vol = tetraVoronoiVolumes(tetra, n)
%
% Computes the volume using the first n dimensions. Default value is n = 
% size(tetra.V,2).
%
% See also tetraVolumeSingle, tetraVolumes, tetraBarycentricVolumes.

if nargin < 2
    n = size(tetra.V,1);
end

% pretabulate tetrahedral incidence at vertices
if ~isfield(tetra,'t_at_v')
    tetra = tetraGetOneRingTetra(tetra);
end

vol = zeros(1,size(tetra.V,2));

% for each vertex
for p = 1:size(tetra.V,2)
    
    % get the set T_p of tetrahedra incident on p
    T_p = tetra.t_at_v{p};
    
    % get the set of vertices adjacent to p (i.e., the star of p)
    N1 = setdiff(unique(tetra.T(:,T_p)),p)';
    
    % reset volume accumulator;
    volume = 0;
    
    % for each vertex x adjacent to p
    for x = N1
        
        % get the set T_px of tetrahedra incident on edge (p,x)
        T_px = tetraTetraAtEdge(tetra, p, x);
        
        % sum of cotangents accumulator;
        weight = 0;
        
        % for each tetrahedra incident on edge (p,x)
        for t = T_px
            
            % determine indices of vertices other than p and x
            other = setdiff(tetra.T(:,t),[p,x]);
            
            % compute dihedral angle of tetrahedron t at edge opposite (p,x)
            ang = tetraDihedralAngle(tetra.V(1:n,other(1)), tetra.V(1:n,other(2)), tetra.V(1:n,p), tetra.V(1:n,x));
            
            % accumulate cotangent weight
            weight = weight + cot(ang);
        
        end
        %weight = weight/numel(T_px);
        
        % edge vector
        E = tetra.V(1:n,p) - tetra.V(1:n,x);
        
        volume = volume + weight*(sum(E.^2));
        
    end
    
        
    volume = volume/8; %/(2^(n-1));
    
    
    vol(p) = volume;
    
end