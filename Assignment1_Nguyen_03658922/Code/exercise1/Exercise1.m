function par = Exercise1(k)
    %constant
    MAX_p = 6;
    %k = 5;
    load('Data.mat');
    n = size(Input,2);
    par = cell(1,3);
    pos_err = zeros(k,MAX_p);
    ori_err = zeros(k,MAX_p);
    for K = 1:k
        %k-th subsample is the test set ??? assumption
        %read in data
        out_test = Output(:, (K-1)*(n/k) + 1 : K*n/k ); 
        in_test = Input(:, (K-1)*(n/k) + 1 : K*n/k ); 

        out_train = zeros(3, (k-1) *n/k);
        in_train = zeros(2, (k-1) *n/k);

        out_train(:, 1: (K-1)*(n/k)) = Output(:, 1: (K-1)*(n/k));
        out_train(:, (K-1)*(n/k)+1 : end) = Output(:,  K* (n/k) + 1 : end);

        in_train(:, 1: (K-1)*(n/k)) = Input(:, 1: (K-1)*(n/k));
        in_train(:, (K-1)*(n/k)+1 : end) = Input(:,  K*n/k + 1 : end);

        %creat A matrix for training set
        A_train = createA((k-1)*n/k, in_train, MAX_p);
        %create A matrix for testing set
        A_test = createA(n/k, in_test, MAX_p);
        %creat A matrix for whole input set
        A_whole = createA(n, Input, MAX_p);
        %compute position error and orientation error for each k-fold 
        %with p varies from 1 to 6
        for p = 1 : MAX_p
            %use training set to compute model parameters
            A_p = A_train(:, 1:3*p+1);
            pseudo_invert = (A_p'*A_p)^-1*A_p';
            a_x = pseudo_invert * out_train(1,:)';
            a_y = pseudo_invert * out_train(2,:)';
            a_theta = pseudo_invert * out_train(3,:)';
            %estimate error on testing set/ whole set
            [pos_err(K,p), ori_err(K,p)] = computeError(A_test, p, p, a_x, a_y, a_theta, out_test);
        end
    end
    %average position error and orientation error over k folds:
    pos_err = mean(pos_err,1); 
    ori_err = mean(ori_err,1);
    %find optimal p1 and p2:
    [min_pos_err p1_min] = min(pos_err);
    [min_ori_err p2_min] = min(ori_err);

    %re-estimate the model parameters on the whole data-set
    A_p1 = A_whole(:, 1:3*p1_min+1);
    A_p2 = A_whole(:, 1:3*p2_min+1);
    pseudo_invert_p1 = (A_p1'*A_p1)^-1*A_p1';
    pseudo_invert_p2 = (A_p2'*A_p2)^-1*A_p2';
    a_x = pseudo_invert_p1 * Output(1,:)';
    a_y = pseudo_invert_p1 * Output(2,:)';
    a_theta = pseudo_invert_p2 * Output(3,:)';
    %estimate error on testing set/ whole set
    [pos_err, ori_err] = computeError(A_whole, p1_min, p2_min, a_x, a_y, a_theta, Output);
    par(1,1) = {a_x};
    par(1,2) = {a_y};
    par(1,3) = {a_theta};
    save('params','par');
end