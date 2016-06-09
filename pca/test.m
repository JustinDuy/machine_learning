%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('projtrainimg');%projtrainimg
load('mean');%m
load('eigenfaces');%eigenfaces
load('mu');
load('sigma');

[MAX_d, classcount] = size(mu);
%load test data
images = loadMNISTImages('t10k-images.idx3-ubyte');
test_img_no = size(images,2);
%demean and project test images
demean = double(images) - repmat(m, 1, test_img_no);
projtestimg = eigenfaces'*demean; % projection of test image onto the facespace

%compute likelihood
likelihood = zeros(test_img_no,  MAX_d, classcount);
for d = 1 : MAX_d
    for j = 1 : classcount
        %compute likelihood for each class j of input i
        muj = cell2mat(mu(d,j)); %dx1
        sigmaj = cell2mat(sigma(d,j)); %dxd
        for i = 1 : test_img_no
            likelihood(i,d,j) = mvnpdf(projtestimg(1:d, i), muj, sigmaj);
        end
    end    
end

save('likelihood','likelihood');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%compute classification error and optimize d
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('likelihood');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');

[test_img_no, MAX_d, classcount] = size(likelihood);
predicted = (-1)* ones(test_img_no, MAX_d);
error = [];
for d = 1 : MAX_d
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
[opt_err opt_d] = min(error);

error_15 = error(15)/test_img_no*100

mat = confusionmat(test_labels , predicted(:,opt_d));
helperDisplayConfusionMatrix(mat);


