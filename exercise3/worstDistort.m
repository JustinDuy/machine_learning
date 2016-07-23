function [center, ind] = worstDistort(data, classes)
    [pts_no, dim_no] = size(data);
    k = max(max(classes));
    %compute centers for each cluster
    clusters = zeros(k,dim_no);
    count_clusters = zeros(k,1);
    for pts = 1:pts_no
        clusters(classes(pts), :) =  clusters(classes(pts) , :) + data(pts,:);
        count_clusters(classes(pts)) = count_clusters(classes(pts)) + 1;
    end
    for c = 1:k
        clusters(c, :) = clusters(c , :) / count_clusters(c);
    end
    %compute total distortion for each cluster
    clusters_dist = zeros(k,1);
    for pts = 1:pts_no
        clusters_dist(classes(pts)) = clusters_dist(classes(pts)) + dist(data(pts,:), clusters(classes(pts,:)));
    end
    clusters_dist = clusters_dist ./ count_clusters; 
    %find worst clusters
    [dump, ind] = max(clusters_dist);
    center = clusters(ind,:);
end