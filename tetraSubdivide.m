function [tetra, lengths] = tetraSubdivide(tetra, n)

% Patricio Simari
% July 16, 2016
%
% tetra = tetraSubdivide(tetra)
%
% Applies n iterations of longest-edge subdivision. Each iteration adds a
% new vertex at the midpoint of the longest edge and splits all incident
% tetrahedra accordinly.

if n <= 0
    return;
end

% precompute edges, lengths, and tetra at vertices
E = tetraGetEdges(tetra);
lengths = sqrt(sum((tetra.V(:, E(1, :)) - tetra.V(:,E(2, :))).^2, 1));
tetra = tetraGetOneRingTetra(tetra);

% while there are edge splits to be done ... 
while n > 0
    
    % find longest edge e1 = (v1, v2)
    [~, e1] = max(lengths);
    v1 = E(1, e1);
    v2 = E(2, e1);
    
    % create new vertex m at mid point
    m = size(tetra.V, 2) + 1;
    tetra.V(:, m) = 0.5*(tetra.V(:, v1) + tetra.V(:, v2));
    tetra.t_at_v{m} = [];
    
    % split all tetra t1 incident on e1 ...
    t_at_e1 = tetraTetraAtEdge(tetra, v1, v2);
    for t1 = t_at_e1
        
        % get two copies of tetra t1
        T1 = tetra.T(:, t1);
        T2 = T1;
        
        % replace v1 and v2 in each by m
        T1(T1 == v2) = m;
        T2(T2 == v1) = m;
        
        % update old tetra t1 and add new tetra t2 to the mesh
        t2 = size(tetra.T, 2) + 1;
        tetra.T(:, t1) = T1;
        tetra.T(:, t2) = T2;
        
        % update t_at_v...
        
        % * v1 keeps t1 (nothing to do)
        
        % * v2 loses t1 and gets t2
        tetra.t_at_v{v2} = setdiff(tetra.t_at_v{v2}, t1);
        tetra.t_at_v{v2} = union(tetra.t_at_v{v2}, t2);
        
        % * m gets t1 and t2
        tetra.t_at_v{m} = union(tetra.t_at_v{m}, [t1, t2]);
        
    end
    
    % update edges and lengths
    E1 = E(:, e1);
    E2 = E1;
        
    E1(E1 == v2) = m;
    E2(E2 == v1) = m;
    
    e2 = size(E, 2) + 1;
    E(:, e1) = E1;
    E(:, e2) = E2;
    
    lengths(e1) = 0.5*lengths(e1);
    lengths(e2) = lengths(e1);
    
    % update count remaining
    n = n - 1;
    
end