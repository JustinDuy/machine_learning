function d = dist(v1, v2)
    %v1 60 x 1 x 3
    %v2 1 x 60 x 3
    pts_no = size(v1,1);
    dim_no = size(v1,3);
    v1 = reshape(v1, [pts_no dim_no]);
    v2 = reshape(v2, [pts_no dim_no]);
    v = v1-v2;
    v = v.*v;
    v = sqrt(sum(v,2));
    d = sum(v);
end