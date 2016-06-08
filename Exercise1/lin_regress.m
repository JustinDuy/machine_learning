load('Data.mat');
n = size(Input,2);
K = 5;
min_th_err = flintmax;
min_pos_err = flintmax;
par = cell(1,3);
for k = 1:5
%k-th subsample is the test set
    %read in data
    out_test = Output(:, (k-1)*(n/K) + 1 : k*n/K ); 
    in_test = Input(:, (k-1)*(n/K) + 1 : k*n/K ); 
    
    out_train = zeros(3, (K-1) *n/K);
    in_train = zeros(2, (K-1) *n/K);
    out_train(:, 1: (k-1)*(n/K)) = Output(:, 1: (k-1)*(n/K));
    out_train(:, (k-1)*(n/K)+1 : end) = Output(:,  k*n/K + 1 : end);
    
    in_train(:, 1: (k-1)*(n/K)) = Input(:, 1: (k-1)*(n/K));
    in_train(:, (k-1)*(n/K)+1 : end) = Input(:,  k*n/K + 1 : end);

    %creat A matrix for training set
    A = createA((K-1)*n/K, in_train);
    %create A matrix for testing set
    A_test = createA(n/K, in_test);
    %creat A matrix for whole input set
    A_whole = createA(n, Input);
    
    min_ori_e = flintmax;
    min_pos_e = flintmax;
    min_p1 = -1;
    min_p2 = -1;
    min_ax = [];
    min_ay = [];
    min_atheta = [];
    for p = 1 : 6
        %use training set to compute model parameter
        A_p = A(:, 1:3*p+1);
        pseudo_invert = (A_p'*A_p)^-1*A_p';
        a_x = pseudo_invert * out_train(1,:)';
        a_y = pseudo_invert * out_train(2,:)';
        a_theta = pseudo_invert * out_train(3,:)';
        %estimate error on testing set
        [pos_err, the_err] = computeError(A_test, p, p, a_x, a_y, a_theta, out_test);
        if(pos_err < min_pos_e) 
            min_pos_e = pos_err;
            min_p1 = p;
            min_ax = a_x;
            min_ay = a_y;
        end
        if(the_err < min_ori_e) 
            min_ori_e = the_err;
            min_p2 = p;
            min_atheta = a_theta;
        end
    end
    %min_p1
    %min_p2
    %re-evaluate over whole set
    [pos_err, the_err] = computeError(A_whole,min_p1,min_p2, min_ax, min_ay, min_atheta, Output);
    if(pos_err  < min_pos_err )
        min_pos_err = pos_err ;
        par(1,1) = {min_ax};
        par(1,2) = {min_ay};   
    end
    if(the_err < min_th_err)
        min_th_err = the_err ;
        par(1,3) = {min_atheta};
    end
end
save('params','par');