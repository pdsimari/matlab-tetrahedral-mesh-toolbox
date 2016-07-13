function [tetra, in] = tetraJitteredGridComplexExplicitFunction(fstring, xvals, yvals, zvals, jitter_fraction)

% Patricio Simari
% February 2013
% Updated Feb 23, 2016
%
% [tetra, in] = tetraJitteredGridComplexExplicitFunction(fstring, xvals, yvals, zvals, jitter_fraction)

f = inline(fstring, 'x', 'y', 'z');
tetra.V = zeros(4, numel(xvals)*numel(yvals)*numel(zvals));

jitter_delta_x = jitter_fraction*.5*(xvals(2) - xvals(1));
jitter_delta_y = jitter_fraction*.5*(yvals(2) - yvals(1));
jitter_delta_z = jitter_fraction*.5*(zvals(2) - zvals(1));

in = false(1, size(tetra.V, 2));

k = 1;
for x = xvals
    for y = yvals
        for z = zvals
            
            % if it's a boundary point, don't jitter it
            if (x == xvals(1)) || (x == xvals(end)) || (y == yvals(1)) || (y == yvals(end)) || (z == zvals(1)) || (z == zvals(end))
                tetra.V(1, k) = x;
                tetra.V(2, k) = y;
                tetra.V(3, k) = z;
            else
                % otherwise, add jitter
                tetra.V(1, k) = x + (2*rand - 1)*jitter_delta_x;
                tetra.V(2, k) = y + (2*rand - 1)*jitter_delta_y;
                tetra.V(3, k) = z + (2*rand - 1)*jitter_delta_z;
                
                % mark as interior
                in(k) = true;
            end
            
            tetra.V(4, k) = f(tetra.V(1, k), tetra.V(2, k), tetra.V(3, k));
            k = k + 1;
            
        end
    end
end

tetra.T = delaunayn(tetra.V(1:3, :)')';
