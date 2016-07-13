function tetra = tetraDeleteVertices(tetra, deleteList)

% Patricio Simari
% August 2012
%
% tetra = tetraDeleteVertices(tetra, deleteList)
%
% Delete the vertices specified by deleteList from the tetrahedralization
% tetra. deleteList is an array of indices. Tetrahedra who referenced any
% of the deleted vertices will also be removed.

keepList = setdiff(1:size(tetra.V,2),deleteList);

% remove unwanted vertices
tetra.V(:,deleteList) = [];

% remove any tetrahedra referencing the removed vertices
tetra.T(:,any(ismember(tetra.T,deleteList),1)) = [];

% fix references in remaining tetrahedra
[~, tetra.T] = ismember(tetra.T,keepList);