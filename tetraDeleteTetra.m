function tetra = tetraDeleteTetra(tetra, ind)

% Patricio Simari
% February 21, 2016
%
% tetra = tetraDeleteTetra(tetra, ind)
%
% Delete the tetrahedra referenced by the indices in ind.

keep = true(1, size(tetra.T, 2));
keep(ind) = false;

tetra.T = tetra.T(:, keep);

% map old vertex id to new; deleted verts map to zero.
map = zeros(1, size(tetra.V, 2));
map(keep) = 1:sum(keep);

if isfield(tetra, 'C')
    tetra.C = tetra.C(:, keep);
end
    
if isfield(tetra, 'F')
    
    % map tetra references to their new values
    tetra.F(4, :) = map(tetra.F(4, :));
    tetra.F(5, :) = map(tetra.F(5, :));
       
    % clean-up and marking for deletion 
    del = false(1, size(tetra.F, 2));
    for f = 1:size(tetra.F, 2)
        if tetra.F(4, f) == 0
            if tetra.F(5, f) == 0
                del(f) = true;
            else
                tetra.F(4, f) = tetra.F(5, f);
                tetra.F(5, f) = 0;
            end
        end
    end
    tetra.F(:, del) = [];
    
end