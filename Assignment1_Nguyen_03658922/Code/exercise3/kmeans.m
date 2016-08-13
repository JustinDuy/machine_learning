function classes = kmeans(gesture, init, K)
%constant
thresh = 10e-6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[pts_no, dim_no] = size(gesture);
centers = init;
pre_dist = realmax;
cur_dist = realmax;
first_time = 1;
while first_time == 1 || (-cur_dist + pre_dist) > thresh
    classes = zeros(pts_no, 1);
    %assign each data point with a cluster center
    for pts = 1: pts_no
        dist2clusters = zeros(K,1);
        for k = 1:K
           dist2clusters(k) = dist(gesture(pts,:), centers(k,:));
        end
        [min_dist classes(pts)] = min(dist2clusters); 
    end

    if(first_time == 1) % first loop
        first_time = 0;
    end
    %update centers
    clusters = zeros(K,dim_no);
    count_clusters = zeros(K,1);
    for pts = 1:pts_no
        clusters(classes(pts), :) =  clusters(classes(pts) , :) + gesture(pts,:);
        count_clusters(classes(pts)) = count_clusters(classes(pts)) + 1;
    end
    for k = 1:K
        centers(k, :) = clusters(k , :) / count_clusters(k);
    end
    %compute total distortion with new centers
    pts_dist = zeros(K,1);
    for pts = 1:pts_no
        pts_dist(classes(pts)) = pts_dist(classes(pts)) + dist(gesture(pts,:), centers(classes(pts,:)));
    end
    pre_dist = cur_dist;
    cur_dist = sum(pts_dist);
    
end

end