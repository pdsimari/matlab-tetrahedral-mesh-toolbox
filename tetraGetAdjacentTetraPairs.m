function tetra = tetraGetAdjacentTetraPairs(tetra)

% Patricio Simari
% February 21, 2016
%
% tetra = tetraGetAdjacentTetraPairs(tetra)
%
% Add field 'F' to the tetra structure containing triangular faces in the
% mesh and pairs of indices referencing the tetra incident on them. More
% formally, F(1:3, i) contains the i-th such face's vertex indices
% (referencing tetra.V), and s = F(4, i) and t = F(5, i) are indices to the
% incident tetrahedra (referencing tetra.T).

% Create list of faces (column indices) with a 4th coordinate referencing
% the tetra they came from. 

% generate tetra indices
ind = 1:size(tetra.T, 2);

% Create list of faces (column indices) with a 4th coordinate referencing
% the tetra they came from. Note: the vertex indices need to be in sorted 
% order for the face key to be unique.

T = sort(tetra.T);
Ft = [[T([1, 2, 3], :); ind], ...
      [T([1, 2, 4], :); ind], ...
      [T([1, 3, 4], :); ind], ...
      [T([2, 3, 4], :); ind]];

% get set of unique faces, keeping track of their original indices in Ft
[F, ~, ind] = unique(Ft(1:3, :)', 'rows');
F = F';

% expand F with 4th and 5th coord to hold indices of incident tetras
F([4; 5], :) = 0;

% populate 4th and 5th coordinates with ind results from "unique" ...
for i = 1:numel(ind)
    
    % get index f to unique face
    f = ind(i);
    
    % get index t to incident tetrahedron
    t = Ft(4, i);
    
    % register to pair in first available slot
    if F(4, f) == 0
        F(4, f) = t;
    elseif F(5, f) == 0
        F(5, f) = t;
    else
        warning(['A third tetrahedron attempted to register ', ... 
                 'to same face.\n Tetra indices: %i, %i, %i'], ...
                 F(4, f), F(5, f), t);
    end
    
end

% add F as a new field
tetra.F = F;