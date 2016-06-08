function A = createA(dim , data)  
    A = zeros(dim, 6*3+1);
    A(:,1) = ones(dim, 1);
    v = data(1,:);
    w = data(2,:);
    for p = 0 : 5
        A(:, 3 * p + 1) = v.^(p+1);
        A(:, 3 * p + 2) = w.^(p+1);
        A(:, 3 * p + 3) = (v.*w).^(p+1);
    end
end