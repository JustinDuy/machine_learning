function [p, alpha]=forward_hmm(o,a,b,pi)
%O=Given observation sequence 
%A(N,N)=transition probability matrix
%B(N,M)= observation probability distribution
%pi= initial state distribution
%---------------------------------------------------------
%Output: P=likelihood of the given observation sequence 
% with the model
N=length(a(1,:));
T=length(o);
alpha = zeros(T,N);
%it uses forward algorith to compute the probability
for i=1:N        %it is initilization
    alpha(1,i)=b(o(1),i)*pi(i);
end
for t=1:(T-1)      %recurssion
    for j=1:N
        z=0;
        for i=1:N
            z=z+a(i,j)*alpha(t,i);
        end
        alpha(t+1,j)=z*b(o(t+1),j);
    end
end
p=0;
for i=1:N         %termination
    p=p+alpha(T,i);        
end
