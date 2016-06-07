images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');
m = mean(images,2); % Computing the average image
imgcount = size(images,2);
%%%%%%%%  calculating A matrix, i.e. after subtraction of all image vectors from the mean image vector %%%%%%
demean = images - repmat(m, 1, imgcount);

C = cov(demean') ; 
[V,D]=eig(C);  %% V : eigenvector matrix  D : eigenvalue matrix

%get the principal components
eigenfaces = [];
for i = 1 : size(V,2) 
    if( D(i,i) > 1 )
        eigenfaces = [eigenfaces V(:,i)];
    end
end

%%%%%%% finding the projection of each image vector on the facespace (where the eigenfaces are the co-ordinates or dimensions) %%%%%
projectimg = [ ];  % projected image vector matrix
for i = 1 : size(eigenfaces,1)
    temp = eigenfaces' * demean(:,i);
    projectimg = [projectimg temp];
end


%%%calculate mean and covariance of gaussian dist for each class (0->9) 
classcount = 10;
classes = cell(classcount,1);
for i= 1: imgcount
    label = labels(i) + 1 %matlab index from 1->10
    classes(label,1) = [{classes(label,1)} projectimg(:,i)];
end
%muj = zeros(classcount,1);
%sigmaj = cell(1, classcount);
%for j= 1 : classcount
 %   muj(j) = mean(classes(1,j));
 %   sigmaj(1,j) = {cov(classes(1,j))};
%end

