function tetraPlotAABB(tetra)

% Patricio Simari
% July 2013
% Modified Feb 23, 2016
%
% tetraPlotAABB(tetra)
%
% Plot the axis aligned-bounding of the 3D volume covered by the vertex
% values held in tetra.V(1:3, :).
%
% See also tetraPlotMesh, tetraPlotField.

% get lower and upper corners of box
lower = min(tetra.V(1:3, :), [], 2); 
upper = max(tetra.V(1:3, :), [], 2); 

% get all eight corner coordinates
P1 = lower; 
P2 = [lower(1); lower(2); upper(3)]; 
P3 = [lower(1); upper(2); upper(3)]; 
P4 = [lower(1); upper(2); lower(3)]; 
P5 = [upper(1); lower(2); lower(3)]; 
P6 = [upper(1); lower(2); upper(3)]; 
P7 = upper; 
P8 = [upper(1); upper(2); lower(3)]; 

% plot all twelve edges

hold on; 

plot3([P1(1); P2(1)], [P1(2); P2(2)], [P1(3); P2(3)], 'k-'); 
plot3([P2(1); P3(1)], [P2(2); P3(2)], [P2(3); P3(3)], 'k-'); 
plot3([P3(1); P4(1)], [P3(2); P4(2)], [P3(3); P4(3)], 'k-'); 
plot3([P4(1); P1(1)], [P4(2); P1(2)], [P4(3); P1(3)], 'k-'); 

plot3([P5(1); P6(1)], [P5(2); P6(2)], [P5(3); P6(3)], 'k-'); 
plot3([P6(1); P7(1)], [P6(2); P7(2)], [P6(3); P7(3)], 'k-'); 
plot3([P7(1); P8(1)], [P7(2); P8(2)], [P7(3); P8(3)], 'k-'); 
plot3([P8(1); P5(1)], [P8(2); P5(2)], [P8(3); P5(3)], 'k-'); 

plot3([P1(1); P5(1)], [P1(2); P5(2)], [P1(3); P5(3)], 'k-'); 
plot3([P2(1); P6(1)], [P2(2); P6(2)], [P2(3); P6(3)], 'k-'); 
plot3([P3(1); P7(1)], [P3(2); P7(2)], [P3(3); P7(3)], 'k-'); 
plot3([P4(1); P8(1)], [P4(2); P8(2)], [P4(3); P8(3)], 'k-'); 

hold off; 