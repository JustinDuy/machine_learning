function classes = kmeans(gesture, init, K)
%constant
thresh = 10e-6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[pts_no, rep_no, dim_no] = size(gesture);
%init gesture
centers = zeros(pts_no, K, dim_no); %7 x 60 x 3
for pt = 1:pts_no
    centers(pt,:,:) = init;
end

pre_dist = realmax;
cur_dist = realmax;
first_time = 1;
while first_time == 1 || (-cur_dist + pre_dist) > thresh
    classes = zeros(rep_no, 1);
    %assign each gesture with a cluster center
    for r = 1: rep_no
        dist2clusters = zeros(K,1);
        for k = 1:K
           dist2clusters(k) = dist(gesture(:,r,:), centers(:,k,:));
        end
        [min_dist classes(r)] = min(dist2clusters); 
    end
    %if first loop compute cur_dist
    pts_dist = zeros(K,1);
    if(first_time == 1) % first loop
        first_time = 0;
    end
    %update centers
    %[pts_no, rep_no, dim_no] = size(gesture);
    clusters = zeros(pts_no, K, dim_no);
    count_clusters = zeros(K,1);
    for r = 1:rep_no
        clusters(:, classes(r) , :) =  clusters(:, classes(r) , :) + gesture(:,r,:);
        count_clusters(classes(r)) = count_clusters(classes(r)) + 1;
    end
    for k = 1: K
        centers(:, k ,:) = clusters(:, k , :) / count_clusters(k);
    end

    %compute total distortion with new centers
    pts_dist = zeros(K,1);
    for r = 1:rep_no
        pts_dist(classes(r)) = pts_dist(classes(r)) + dist(gesture(:,r,:), centers(:,classes(r),:));
    end
    pre_dist = cur_dist
    cur_dist = sum(pts_dist)
    
end

end