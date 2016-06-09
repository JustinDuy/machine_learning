%%%%constant
MAX_d = 60;
classcount = 10;

%%%%%%%%%%%%%%%%%load training data %%%%%%%%%%%%%%%%%%%%%%
images = loadMNISTImages('train-images.idx3-ubyte');
%load training ground truth
train_labels = loadMNISTLabels('train-labels.idx1-ubyte');

m = mean(images,2); % Computing the average image
imgcount = size(images,2);

%%%%%%%%  calculating A matrix, i.e. after subtraction of all image vectors from the mean image vector %%%%%%
demean = double(images) - repmat(m, 1, imgcount);

C = cov(demean');%(demean * demean') / (imgcount-1);%cov(demean') ; 
[V,D]=eig(C);  %% V : eigenvector matrix  D : eigenvalue matrix
%sort eigen vector based on eigen value descending:
D2=diag(sort(diag(D),'descend')); % make diagonal matrix out of sorted diagonal values of input D
[c, ind]=sort(diag(D),'descend'); % store the indices of which columns the sorted eigenvalues come from
V2=V(:,ind); % arrange the columns in this order


%get the principal components
eigenfaces = [];
for i = 1 : MAX_d 
    eigenfaces = [eigenfaces V2(:,i)];
end

%%%%%%% finding the projection of each image vector on the facespace (where the eigenfaces are the co-ordinates or dimensions) %%%%%
projtrainimg = eigenfaces' * demean;

%%%%%%%learn the distribution of facespace for each class%%%%%%%%
mu = cell(MAX_d, classcount);
sigma = cell(MAX_d, classcount);
train_img_no = size(projtrainimg,2);
classes = cell(classcount,1);
for i= 1: train_img_no
    label = train_labels(i) + 1; %matlab index from 1->10
    classes(label) = {[cell2mat(classes(label)) projtrainimg(:,i)]};
end
for d = 1: MAX_d
    %%%calculate mean and covariance of gaussian dist for each class (0->9)
    %%%using training data
    for j = 1: classcount
        classj = cell2mat(classes(j));
        mu(d,j) = {mean(classj(1:d,:), 2)}; %classes(j): d x m
        sigma(d,j) = {cov(classj(1:d,:)')};
    end    
end

save('mean','m');
save('eigenfaces', 'eigenfaces');
save('mu','mu');
save('sigma','sigma');