%compute classification error and optimize d
load('likelihood');
labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
[imgcount, MAX_d, classcount] = size(likelihood);
predicted = (-1)* ones(imgcount, MAX_d);
for d = 1 : MAX_d
    for i = 1 : imgcount
       max_likelihood = 0;
       for j = 1 : classcount
           if likelihood(i,d,j) > max_likelihood
               max_likelihood = likelihood(i,d,j) ;
               predicted(i , d) = j - 1;
           end   
       end
    end
end
close all;
for d = 1 : MAX_d
    figure(d)
    mat = confusionmat(labels , predicted(:,d));
    helperDisplayConfusionMatrix(mat);
end
