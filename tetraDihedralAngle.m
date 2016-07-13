function ang_A = tetraDihedralAngle(O,A,B,C)

% Patricio Simari
% July 2013
%
% ang_A = tetraDihedralAngle(O,A,B,C)
%
% Compute the dihedral angle at edge OA, i.e. between the triangles OAB and
% OAC. O, A, B, and C are n x 1 points. The implementation is independent
% of n.

O = double(O);
A = double(A);
B = double(B);
C = double(C);

% form the three unit vectors of interest
OA = vectorUnit(A-O);
OB = vectorUnit(B-O);
OC = vectorUnit(C-O);

% compute cosine of angles using dot product
cos_a = dot(OB,OC); 
cos_b = dot(OA,OC);
cos_c = dot(OA,OB);

% compute sine values using trigonometric identity; assume positive sign
% since angles should be smaller than 180 deg 
sin_b = sqrt(1-cos_b*cos_b);
sin_c = sqrt(1-cos_c*cos_c);

% compute cos(A) using Expression (1) from "Discrete Distortion in
% Triangulated 3-Manifolds," Mostefa et al, SGP 2008
cos_A = (cos_a - cos_b*cos_c)/(sin_b*sin_c);

% return angle value in radians
ang_A = real(acos(cos_A));
