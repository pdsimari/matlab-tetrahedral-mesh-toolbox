function tetra = tetraLoad(filestr)

% Patricio Simari
% July 2013
%
% tetra = tetraLoad(filestr)
%
% Load a tetra mesh from a file in .ts format.
%
% See also tetraExport.

file = fopen(filestr);

sz = fscanf(file, '%u %u\n', [1 2]);

tetra.V = fscanf(file, '%f %f %f %f\n', [4 sz(1)]);
tetra.T = fscanf(file, '%u %u %u %u\n', [4 sz(2)]);
tetra.T = tetra.T + 1;

fclose(file);
