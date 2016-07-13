function tetra = tetraLoadRaw(filename, rows, cols)

% Patricio Simari
% November 2015
% 
% tetra = loadRaw(filename, rows, cols)
% 
% Loads a 3D raw image file with the given number of rows, columns into I. 
% The number of slices is automatically inferred.
%
% Example: 
% 
% I = loadRaw('Frog.raw', 256, 256); 
% imagesc(I(:,:,20));

I = imageLoadRaw(filename, rows, cols);
tetra = tetraFromImage(I);