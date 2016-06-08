

load('projtrainimg');%projtrainimg
load('mean');%m
load('eigenfaces');%eigenfaces

%load test data
images = loadMNISTImages('t10k-images.idx3-ubyte');

imgcount = size(images,2);

projtestimg = [];
%demean and project test images
for i=1:imgcount
    img = images(:,i);
    img = double(img)-m; % mean subtracted vector
    temp = eigenfaces'*img; % projection of test image onto the facespace
    projtestimg = [projtestimg temp];
end

MAX_d = 60;
classcount = 10;

mu = cell(MAX_d, classcount);
sigma = cell(MAX_d, classcount);
for d = 1: MAX_d
    %%%calculate mean and covariance of gaussian dist for each class (0->9)
    %%%using training data
    classes = cell(classcount,1);
    for i= 1: imgcount
        label = labels(i) + 1; %matlab index from 1->10
        classes(label) = {[cell2mat(classes(label)) projtrainimg(1:d,i)]};
    end
    for j = 1: classcount
        classj = cell2mat(classes(j));
        mu(d,j) = {mean(classj, 2)}; %classes(j): d x m
        sigma(d,j) = {cov(classj')};
    end    
end

%classify test images
likelihood = zeros(imgcount,  MAX_d, classcount);
for d = 1 : MAX_d
    for j = 1 : classcount
        %compute likelihood for each class j of input i
        muj = cell2mat(mu(d,j));
        sigmaj = cell2mat(sigma(d,j));
        for i = 1 : imgcount
            likelihood(i,d,j) = mvnpdf(projtestimg(1:d, i), muj, sigmaj);
        end
    end    
end

save('likelihood',likelihood);
