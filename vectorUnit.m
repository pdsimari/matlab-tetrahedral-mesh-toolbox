function v = vectorUnit(v)

% Patricio Simari
% July 2013
% 
% v = vectorUnit(v) 
%
% Normalizes v to a unit vector.

v = v./sqrt(sum(v.^2));
