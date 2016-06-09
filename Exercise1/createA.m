function A = createA(dim , data, max_p)  
    A = zeros(dim, max_p*3+1);
    A(:,1) = ones(dim, 1);
    v = data(1,:);
    w = data(2,:);
    for p = 1 : max_p
        A(:, 3 * (p-1) + 2) = v.^p;
        A(:, 3 * (p-1) + 3) = w.^p;
        A(:, 3 * (p-1) + 4) = (v.*w).^p;
    end
end