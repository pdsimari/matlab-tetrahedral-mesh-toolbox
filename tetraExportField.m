function tetraExportField(field, file)

% Patricio Simari
% July 2013
%
% tetraExportField(field, file)
%
% Export the one dimensional array field to the file. The first entry in
% the file corresponds to the total number of elements. Subsequently, the
% field is exported in plain text, one entry per line.

fid = fopen(file, 'w');
fprintf(fid, '%d\n', numel(field));
fprintf(fid, '%f\n', field);
fclose(fid);
