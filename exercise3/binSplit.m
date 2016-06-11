function classes = binSplit(gesture, K)
%constant
v = [0.08, 0.05, 0.02];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[pts_no, dim_no] = size(gesture);
classes = ones(pts_no,1);
k = 1;
while k < K
    %find worst clusters
    [worstCtr,worstId] = worstDistort(gesture, classes);
    %split the worst cluster
    classes = splitCluster(gesture, classes, worstCtr, worstId, v);
    k = max(max(classes));
end
end