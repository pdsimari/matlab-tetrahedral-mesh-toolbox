function tetraExport(tetra, file)

% Patricio Simari
% July 2013
%
% tetraExport(tetra, file)
%
% Exports the data in tetra to a .ts formatted ascii file. The first line
% contains two entries, the number of vertices and tetrahedra. The
% following lines contain the vertex coordinates and tetrahedral indices
% (0-based) into the vertex array.
%
% See also tetraLoad.

if strcmpi(file(end-2:end),'.ts')
    
    fid = fopen(file, 'w');
    fprintf(fid, '%d %d\n', size(tetra.V,2), size(tetra.T,2));
    fprintf(fid, '%f %f %f %f\n', tetra.V);
    fprintf(fid, '%u %u %u %u\n', tetra.T - 1);
    fclose(fid);
    
else
    error('File name must end in ''.ts''. Currently only .ts format is supported.');
end