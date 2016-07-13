function d = tetraDistortionInstrinsic(tetra)

% Patricio Simari
% May, 2012
%
% d = tetraDistortionInstrinsic(tetra)
%
% Compute the (intrinsic) distortion values at the vertices of tetra; 
% d(i) is the distortion at tetra.V(:,i). For details, see "Discrete 
% Distortion in Triangulated 3-Manifolds," Mostefa et al, SGP 2008

% If not yet available, compute per vertex set of incident tetrahedra.
if ~isfield(tetra,'t_at_v')
    tetra = tetraGetOneRingTetra(tetra);
end

d = zeros(1,size(tetra.V,2));

% for each vertex
for v = 1:size(tetra.V,2)
    % for each incident tetrahedra
    for t = tetra.t_at_v{v}
        
        rest = setdiff(tetra.T(:,t),v);
        
        O = tetra.V(:,v);
        A = tetra.V(:,rest(1));
        B = tetra.V(:,rest(2));
        C = tetra.V(:,rest(3));
        
        s = tetraDihedralAngle(O(1:(end-1)),A(1:(end-1)),B(1:(end-1)),C(1:(end-1))) + ...
            tetraDihedralAngle(O(1:(end-1)),B(1:(end-1)),A(1:(end-1)),C(1:(end-1))) + ...
            tetraDihedralAngle(O(1:(end-1)),C(1:(end-1)),A(1:(end-1)),B(1:(end-1)));
        
        s_raised = tetraDihedralAngle(O,A,B,C) + ...
                   tetraDihedralAngle(O,B,A,C) + ...
                   tetraDihedralAngle(O,C,A,B);
        
        d(v) = d(v) + (s - s_raised);
        
    end     
end