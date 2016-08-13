% FUNCTION Y = MVNPDF(X, [MU], [SIGMA])
%   X & MU: vectors of same size
%   sigma: square matrix
function p = mypdf(data,mu,sigma)
[n,dim] = size(data);
if size(mu,1) ~= dim | size(mu,2) ~= 1 | size(sigma,1) ~= dim | size(sigma,2) ~= dim
  error('Parameter dimensions must agree');
end
p = [];
for i = 1 : n
    x = data(i,:)';
    a = (2*pi)^-(dim/2) * det(sigma)^-.5;
    b = exp(-.5 * (x-mu).' * inv(sigma) * (x-mu));
    y = a * b;
    p = [p ; y];
end