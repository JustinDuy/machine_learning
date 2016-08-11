function WalkPolicyIteration(s1)
state = [1:16];% set of states
action = [1:4];% set of actions
delta = [2 4 5 13;
         1 3 6 14;
         4 2 7 15;
         3 1 8 16;
         6 8 1 9;
         5 7 2 10;
         8 6 3 11;
         7 5 4 12;
         10 12 13 5;
         9 11 14 6;
         12 10 15 7;
         11 9 16 8;
         14 16 9 1;
         13 15 10 2;
         16 14 11 3;
         15 13 12 4];
 reward = [0 5 0 5;
           0 5 -5 5;
           0 -5 -5 5;
           0 -5 0 5;
           -5 5 0 5;
           -10 -10 -10 -10;
           -10 -10 -10 -10;
           -5 -5 0 5;
           -5 -5 0 -5;
           -10 -10 -10 -10;
           -10 -10 -10 -10;
           -5 -5 0 5;
           0 5 0 -5;
           0 5 -5 -5;
           0 -5 -5 -5;
           0 -5 0 -5]; 
 policy=ceil(rand(16,1)*4);
 value = zeros(16);
 gamma = 0.1;
 T = 100;
 t=1;
 A = zeros(16,16);
 done = 0;
while (~done)
    % Increment counter.
    t = t+1
    % Store previous policy (for display purposes only).
    policy_prev = policy;
    % Solve eq. sys for cur value
    M = eye(16,16);
    b = [];
    for s=1:16
        M(s,delta(s,policy(s))) = M(s, delta(s,policy(s)))  - gamma;
        b = [b ; reward(s,policy(s))];
    end
    V = linsolve(M,b);
    % find best action to update policy
    for s=1:16
        %possible next states s'
        s_next = delta(s,:);
        v_next = reward(s,:)' + gamma * V(s_next);
        [v_max, policy(s)] = max(v_next);
    end

    uchange(t) = length(find(abs(policy - policy_prev)));
    
    % If the policy did not change, then it's optimal.
    if (uchange(t)==0 || t > T)
        done=1;
    end
 end

states = [s1];
finished = 0;
count = 1;
while(~finished && count < 16)
    nxtState = policy(states(count));
    states = [states nxtState];
    count = count + 1;
    if(nxtState == s1)
        finished = 1;
    end
end

walkshow(states);