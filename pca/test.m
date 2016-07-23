function likelihood = test(m, eigenfaces, mu, sigma)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load('mean');%m
%load('eigenfaces');%eigenfaces
%load('projtrainimg');%projtrainimg
%load('mu');
%load('sigma');

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

%save('likelihood','likelihood');
end

