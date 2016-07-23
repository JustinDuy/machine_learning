function classes = splitCluster(data, classes, worst_center, worst_id, v)
    k = max(max(classes));
    [pts_no, dim_no] = size(data);
    for pts = 1: pts_no
        if classes(pts) > worst_id
            %shift this pts's class by one to the left
            %i.e: shift worst class to the end
            classes(pts) = classes(pts) - 1;
        else if classes(pts) == worst_id %only split the worst cluster
            dst_plus = dist(data(pts,:),worst_center + v);
            dst_minus = dist(data(pts,:), worst_center - v);
            if dst_minus > dst_plus %closer to center + v --> k
                classes(pts) = k;
            else                    %closer to center -v --> k + 1
                classes(pts) = k + 1;
            end 
        end
    end
end