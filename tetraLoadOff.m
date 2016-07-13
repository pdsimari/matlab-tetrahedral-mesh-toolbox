function tetra = tetraLoadOff(filestr)

% Patricio Simari
% July 2013
%
% tetra = tetraLoadOff(filestr)
%
% Load a tetra mesh from a file in .off format.

file = fopen(filestr);

sz = textscan(file, '%d %d\n',1,'CommentStyle','#');
V = textscan(file, '%f %f %f %f\n',sz{1},'CommentStyle','#');
T = textscan(file, '%d %d %d %d\n',sz{2},'CommentStyle','#');

tetra.V = zeros(4,sz{1});
for d = 1:4
    tetra.V(d,:) = V{d};
end

tetra.T = zeros(4,sz{2});
for d = 1:4
    tetra.T(d,:) = T{d} + 1;
end

fclose(file);
