%compute classification error and optimize d
load('likelihood');
labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
[imgcount, MAX_d, classcount] = size(likelihood);
classification_error = -1 * ones(imgcount, MAX_d);
d = 15,
%for d = 1 : MAX_d
    for i = 1 : imgcount
       max_likelihood = 0;
       for j = 1 : classcount
           if likelihood(i,d,j) > max_likelihood
               max_likelihood = likelihood(i,d,j) ;
               classification_error(i,d) = labels(i) ~= j;
           end   
       end
    end
%end
classification_error = sum(classification_error(:,d),1);
%optimal_d = classification_error == max(classification_error); 