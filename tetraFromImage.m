function tetra = tetraFromImage(I)

% Patricio Simari
% March 2013
%
% tetra = tetraFromImage(I)

tetra.V = zeros(4,numel(I));

k = 1;
for x = 1:size(I,1)
    for y = 1:size(I,2)
        for z = 1:size(I,3)
            tetra.V(1,k) = x;
            tetra.V(2,k) = y;
            tetra.V(3,k) = z;
            tetra.V(4,k) = I(x,y,z);
            k = k + 1;
        end
    end
end

tetra.T = tetraGridTessellation(size(I,1),size(I,2),size(I,3));