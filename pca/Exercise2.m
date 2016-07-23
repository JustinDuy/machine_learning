function Exercise2(d_max)
%training phase
[mean, eigenfaces, mu, sigma] = train(d_max);
%testing phase
likelihood = test(mean, eigenfaces, mu, sigma);    

%compute classification error and optimize d
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load('likelihood');%run train.m and then test.m to compute likelihood first

test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');

[test_img_no, d_max, classcount] = size(likelihood);
predicted = (-1)* ones(test_img_no, d_max);
error = [];
for d = 1 : d_max
    error_d = zeros(test_img_no,1);
    for i = 1 : test_img_no
       max_likelihood = 0;
       for j = 1 : classcount
           if likelihood(i,d,j) > max_likelihood
               max_likelihood = likelihood(i,d,j) ;
               predicted(i,d) = j - 1;
               error_d(i) = (j - 1) ~= test_labels(i);
           end   
       end
    end
    error = [error sum(error_d)];
end
error = error ./ test_img_no*100;

[opt_err opt_d] = min(error);
%error_15 = error(15)

mat = confusionmat(test_labels , predicted(:,opt_d));
helperDisplayConfusionMatrix(mat);

figure(1);
plotconfusion(test_labels, predicted(:,opt_d));

figure(2);
d = [1:d_max];
plot(d, error, 'b-');
title('Classification error according to # of eigen vectors');
xlabel('d') % x-axis label
ylabel('error') % y-axis label

end
