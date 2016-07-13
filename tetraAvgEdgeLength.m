function ael = tetraAvgEdgeLength(tetra)

% Patricio Simari
% July 2013
%
% ael = tetraAvgEdgeLength(tetra)
%
% ael is the average edge length of the tetrahedral mesh tetra.

ael = 0;
n = 0;
for v1 = 1:3
    for v2 = (v1+1):4
        ael = ael + mean(sqrt(sum((tetra.V(:,tetra.T(v1,:)) - tetra.V(:,tetra.T(v2,:))).^2)));
        n = n + 1;
    end
end

ael = ael/n;