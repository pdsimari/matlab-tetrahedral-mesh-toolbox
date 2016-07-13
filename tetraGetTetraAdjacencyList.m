function tetra = tetraGetTetraAdjacencyList(tetra)

% Patricio Simari
% July 2013
%
% tetra = tetraGetTetraAdjacencyList(tetra)
%
% Add a cell array field 'tetraAdjList' to tetra; tetraAdjList{t} contains 
% a list of indices of all tetrahedra adjacent to t.
%
% See also tetraGetVertexStar, tetraGetOneRingTetra, 
% tetraCountTetraAtVerts, tetraTetraAtEdge.

disp('Creating face-to-tetra index...');

n = size(tetra.T,2);

% Create list of faces (column indices) with a 4th coordinate referencing
% the tetra they came from. Note: the vertex indices need to be in sorted 
% order for the face key to be unique.

T = sort(tetra.T);
F = [[T([1,2,3],:);1:n], ...
     [T([1,2,4],:);1:n], ...
     [T([1,3,4],:);1:n], ...
     [T([2,3,4],:);1:n]];

% sort the index to enable fast search
F = sortrows(F')';

disp('Building tetra adjacency lists...');
tetraAdjList = cell(size(tetra.T,2),1);

for f = 1:(size(F,2)-1)
    f2 = f + 1;
    while (f2 <= size(F,2)) && (F(1,f) == F(1,f2)) && (F(2,f) == F(2,f2)) && (F(3,f) == F(3,f2))
        t1 = F(4,f);
        t2 = F(4,f2);
        tetraAdjList{t1} = [tetraAdjList{t1}, t2];
        tetraAdjList{t2} = [tetraAdjList{t2}, t1];
        f2 = f2 + 1;
    end
end

tetra.tetraAdjList = tetraAdjList;