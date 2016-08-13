function WalkQLearning(state)
Q=zeros(16,4);
done = 0;
t = 1;
T = 16;
seq = [];
epsilon = 0.5;
alpha = 0.9;
gamma = 0.5;
for t = 1: T 
    seq = [seq state];
    for a = 1:4
        %epsilon-greedy
        q_epsilon(a) = (1 - epsilon)* Q(state,a) + epsilon / 3 * sum(Q(state,:)) - epsilon / 3 * Q(state,a); %other than a
    end
    [r, a_max] = max(q_epsilon);
    %Q(s,a) <- Q(s,a)+ alpha[r+ maxa0 Q(s0,a0) Q(s,a)]
    [nxt_state r] = SimulateRobot(state, a_max);
    tmp = Q(state, a_max) + alpha*(r + gamma* max(Q(nxt_state,:)) - Q(state,a_max))
    Q(state, a_max) = tmp;
    %s <- nxt_s
    state = nxt_state;
end
%Q
walkshow(seq);