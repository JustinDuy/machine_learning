function d = dist(v1, v2)
    %v1 1x3
    %v2 1x3
    v = v1-v2;
    v = v.*v;
    v = sqrt(sum(v,2));
    d = sum(v);
end