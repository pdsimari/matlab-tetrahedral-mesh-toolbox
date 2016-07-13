function tetra = tetraExample()

% Patricio Simari
% July 2013
%
% tetra = tetraExample()
%
% Returns the tetrahedral complex and scalar values of the small example
% presented in Section 5 of "Discrete Distortion in Triangulated 
% 3-Manifolds," Mostefa et al, SGP 2008. It differs in that the coordinates
% of vertices g and h are swapped, as this is a probable typo. It is
% intended for debugging purposes. The distortion at the first vertex
% should be -10.1633

tetra.V = [ ...
    [ 0;  0;  0;  0    ], ... % O 1
    [ 1; -1; -1;  0.01 ], ... % a 2
    [ 1;  1; -1;  10000], ... % b 3
    [ 1;  1;  1;  0.01 ], ... % c 4
    [ 1; -1;  1;  10000], ... % d 5
    [-1; -1;  1;  0.01 ], ... % e 6
    [-1;  1;  1;  10000], ... % f 7
    [-1;  1; -1;  0.01 ], ... % g 8
    [-1; -1; -1;  10000]  ... % h 9
];

tetra.T = [ ...
    [1;2;3;8], ... % oabg
    [1;2;8;9], ... % oagh
    [1;3;4;8], ... % obcg
    [1;4;7;8], ... % ocfg
    [1;8;7;6], ... % ogfe
    [1;8;6;9], ... % ogeh
    [1;2;9;6], ... % oahe
    [1;2;5;6], ... % oade
    [1;2;4;5], ... % oacd
    [1;2;4;3], ... % oacb
    [1;4;7;6], ... % ocfe
    [1;4;5;6]  ... % ocde
];
        