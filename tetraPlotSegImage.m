function tetraPlotSegImage(I, seg)

% Patricio Simari
% Created June 8, 2016
% Updated July 13, 2016
% 
% tetraPlotSegImage(I, seg)
%
% Plot the segmentation seg of image I.

% copy seg indices into image with same size as I. Note: has to be done in
% row major order to preserve correspondence.
S_index = zeros(size(I));
s = 1;
for i = 1:size(I, 1)
    for j = 1:size(I, 2)
        for k = 1:size(I, 3)
            S_index(i, j, k) = seg(s);
            s = s + 1;
        end
    end
end

% find the color of each segment as the mean color of all pixels in it
s_max = s - 1;
color = zeros(1, s_max);
count = zeros(1, s_max);
for i = 1:size(I, 1)
    for j = 1:size(I, 2)
        for k = 1:size(I, 3)
            s = S_index(i, j, k);
            color(s) = color(s) + I(i, j, k);
            count(s) = count(s) + 1;
        end
    end
end
color = color./count;
S_color = color(S_index);

subplot(3, 3, 1);
imagesc(squeeze(I(:, :, round(size(I, 3)/2))));
axis equal; axis tight; axis off;

subplot(3, 3, 2);
imagesc(squeeze(I(:, round(size(I, 2)/2), :)));
axis equal; axis tight; axis off;

subplot(3, 3, 3);
imagesc(squeeze(I(round(size(I, 1)/2), :, :)));
axis equal; axis tight; axis off;

subplot(3, 3, 4);
imagesc(squeeze(S_index(:, :, round(size(S_index, 3)/2))));
axis equal; axis tight; axis off;

subplot(3, 3, 5);
imagesc(squeeze(S_index(:, round(size(S_index, 2)/2), :)));
axis equal; axis tight; axis off;

subplot(3, 3, 6);
imagesc(squeeze(S_index(round(size(S_index, 1)/2), :, :)));
axis equal; axis tight; axis off;

subplot(3, 3, 7);
imagesc(squeeze(S_color(:, :, round(size(S_color, 3)/2))));
axis equal; axis tight; axis off;

subplot(3, 3, 8);
imagesc(squeeze(S_color(:, round(size(S_color, 2)/2), :)));
axis equal; axis tight; axis off;

subplot(3, 3, 9);
imagesc(squeeze(S_color(round(size(S_color, 1)/2), :, :)));
axis equal; axis tight; axis off;