A = dlmread('A.txt');
B = dlmread('B.txt');
Pi = dlmread('pi.txt');
A_test = dlmread('A_Test_Binned.txt');
[seq_len, seq_num] = size(A_test);
P = zeros(1,seq_num);
for i = 1:seq_num
    [P(i), alpha] = forward_hmm(A_test(:,i), A, B, Pi)
end
P = log(P) > -120
