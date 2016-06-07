images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');
m = mean(images,2); % Computing the average image
imgcount = size(images,2);
%%%%%%%%  calculating A matrix, i.e. after subtraction of all image vectors from the mean image vector %%%%%%
demean = images - repmat(m, 1, imgcount);

C = cov(demean') ; 
[V,D]=eig(C);  %% V : eigenvector matrix  D : eigenvalue matrix
%sort eigen vector based on eigen value descending:
D2=diag(sort(diag(D),'descend')); % make diagonal matrix out of sorted diagonal values of input D
[c, ind]=sort(diag(D),'descend'); % store the indices of which columns the sorted eigenvalues come from
V2=V(:,ind); % arrange the columns in this order

MAX_d = 60;
%get the principal components
eigenfaces = [];
for i = 1 : MAX_d 
    eigenfaces = [eigenfaces V2(:,i)];
end

%%%%%%% finding the projection of each image vector on the facespace (where the eigenfaces are the co-ordinates or dimensions) %%%%%
projtrainimg = [ ];  % projected image vector matrix
for i = 1 : imgcount
    temp = eigenfaces' * demean(:,i);
    projtrainimg = [projtrainimg temp];
end

save('mean','m');
save('eigenfaces', 'eigenfaces');
save('projtrainimg', 'projtrainimg');