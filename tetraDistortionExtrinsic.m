function d = tetraDistortionExtrinsic(tetra)

% Patricio Simari
% July 2013
%
% d = tetraDistortionExtrinsic(tetra)
%
% For estimating mean curvature, divide weighed d by vertex volume.

if ~isfield(tetra,'Nt')
    tetra = tetraNormals(tetra);
end

% Hash table to find adjacent tetrahedra
% Index range is too large for a sparse matrix map 

n_buckets = size(tetra.T,2);
hash_map = cell(1, n_buckets);
n = size(tetra.V,2);

disp('Registering tetrahedra to hash map...');

% Register each tetrahedron to the buckets corresponding to each of its
% faces
for t = 1:size(tetra.T,2)
    
    keys_used = [];
    
    ind = sort(tetra.T(:,t)) - 1;
    
    key = mod((ind(2)*n + ind(3))*n + ind(4), n_buckets) + 1;
    if ~ismember(key, keys_used)
        hash_map{key} = [hash_map{key}, t];
        keys_used = [keys_used,key];
    end
    
    key = mod((ind(1)*n + ind(3))*n + ind(4), n_buckets) + 1;
    if ~ismember(key, keys_used)
        hash_map{key} = [hash_map{key}, t];
        keys_used = [keys_used,key];
    end
    
    key = mod((ind(1)*n + ind(2))*n + ind(4), n_buckets) + 1;
    if ~ismember(key, keys_used)
        hash_map{key} = [hash_map{key}, t];
        keys_used = [keys_used,key];
    end
    
    key = mod((ind(1)*n + ind(2))*n + ind(3), n_buckets) + 1;
    if ~ismember(key, keys_used)
        hash_map{key} = [hash_map{key}, t];
        keys_used = [keys_used,key];
    end
    
end

disp('Computing vertex distortion...');
d = zeros(1,n);
tic;

% for each bucket
for b = 1:n_buckets
    
    % for all pairs of tetrahedra in that bucket
    for i1 = 1:(numel(hash_map{b})-1)
        for i2 = (i1+1):(numel(hash_map{b}))
        
            % get the stored tetrahedra indices
            t1 = hash_map{b}(i1);
            t2 = hash_map{b}(i2);
            
            f = intersect(tetra.T(:,t1)',tetra.T(:,t2)');
            
            % if t1 and t2 meet at a face
            if (numel(f) == 3)
                
                % get face's hash key
                ind = f - 1;
                key = mod((ind(1)*n + ind(2))*n + ind(3), n_buckets) + 1;
                
                % if the key for the face they meet on pertains to the bin
                if (key == b)
                    
                    % x1 and x2 are the verts of t1 and t2 not on face f
                    x1 = setdiff(tetra.T(:,t1)',f);
                    x2 = setdiff(tetra.T(:,t2)',f);
                    
                    % determine sign of angle
                    if dot(tetra.V(:,x2)-tetra.V(:,x1),tetra.Nt(:,t1)) > 0
                        s = -1;
                    else
                        s = +1;
                    end
                    
                    tetra_ang = s*real(acos(dot(tetra.Nt(:,t1),tetra.Nt(:,t2))));
                    face_area = triangleArea(tetra.V(:,f(1)),tetra.V(:,f(2)),tetra.V(:,f(3)));
                    
                    local_distortion = (1/9)*face_area*tetra_ang;
                    
                    d(f) = d(f) + local_distortion;
                    
                end
            end
        end
    end
    
    if toc > 10
        dispPercent(b/n_buckets);
        tic;
    end
    
end

% -------------------------------------------------------------------------
function a = triangleArea(X,Y,Z)

% base
b = sqrt(sum((X - Y).^2));

% height
cos_y = dot(vectorUnit(X-Y),vectorUnit(Z-Y));
sin_y = sqrt(1 - cos_y*cos_y);
h = sin_y*sqrt(sum((Z - Y).^2));

a = .5*b*h;
