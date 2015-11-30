function [VCons] = EvaluatePolicy(policyActions, V, R, sideLength, discRate)
% Input is:
% -current policy 
% -estimates of states, currently
% -rewards given
% -sidelength of square grid world
% Returns:
% -consistent estimates of state values according to the policy

%% Policy Evaluation
% Calculate V(current) from probability of transitions, reward on
% transition, and future (estimated) reward from next state
% (Bellman equation)
% V(s) <- sum_s' P_{ss'}^{policy(s)}[R_{ss'}^{policy(s)}+disc*V(s')]
% Note that we re-write our estimates as we go (not all at once)

% We'll assume we can always walk to a state if we so desire:
% V(s) <- [R_{ss'}^{policy(s)}+disc*V(s')] % (s'= policy(s)) 

% Keeps track of the maximum change in our estimates of the values of the states
% We loop until this vDiff becomes small enough
vDiff = 100; 

% Max change in V allowed for us to stop iterating
vMaxAll = 0.005;

while vDiff > vMaxAll
    % Go through all the states (squares)
    for i = 1:sideLength % x coord
        for j = 1:sideLength % y coord

            % Create a copy of V to see how much V is changing
            vCopy = V;

            % Stores next state according to the current policy
            nextState = zeros(1,2);

            % Determines if we went out of bounds
            wentOut = 0;
            
            % Check if we tried to go out of bounds
            % Give a large negative reward and stay in the same state
            outR = -100;
            % (row, column)
            if (policyActions(i,j) == 0 & j == sideLength) % Tried to go right
                wentOut = 1;
                nextState = [i, j]; % Stay in the same state as before
            elseif  (policyActions(i,j) == 2 & j == 1) % Tried to go left
                wentOut = 1;
                nextState = [i, j]; 
            elseif  (policyActions(i,j) == 1 & i == 1) % Tried to go up
                wentOut = 1;
                nextState = [i, j]; 
            elseif  (policyActions(i,j) == 3 & i == sideLength) % Tried to go down
                wentOut = 1;
                nextState = [i, j];
            end

            % Calculate what the next state would be if we didn't go out of
            % bounds
            if (wentOut ~= 1)
                if (policyActions(i,j) == 0) % Tried to go right        
                    nextState = [i, j+1]; 
                elseif  (policyActions(i,j) == 2) % Tried to go left        
                    nextState = [i, j-1]; 
                elseif  (policyActions(i,j) == 1) % Tried to go up            
                    nextState = [i-1, j]; 
                elseif  (policyActions(i,j) == 3) % Tried to go down           
                    nextState = [i+1, j];
                end      
            end

            % Discount rate is how farsighted we are
            % The reward given is different if we tried to go out of bounds  
            % This calculates new value of states based on reward given
            % from that state under the current policy
            if (wentOut == 1)
                % Any policy that has us go out of bounds will result in very
                % negative state value evaluations at those points
                V(i,j) = 1*(outR+discRate*V(i,j));
            else
                V(i,j) = 1*(R(i,j)+discRate*V(nextState(1), nextState(2)));            
            end
        end
    end

    % Determine the maximum change in V
    vDiff = max(max(abs(V - vCopy)));
    str = sprintf('Difference in V is %f', vDiff);
    disp(str)
end

% Print state estimates once our estimate of the state values under
% this policy is consistent
str = sprintf('Resulting estimate of state values:');
disp(str)
disp(V)

% Print the policy used to generate these state values
str = sprintf('Current Policy (before greedy):');
disp(str)
PrintPolicy(policyActions, sideLength);

% Returns consistent state values under the current policy
VCons = V;