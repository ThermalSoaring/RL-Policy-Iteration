function Framework()
% The learning agent develops a policy for getting to the exit (or highest
% reward square) as quickly as possible when placed in any square in the
% grid world.

% Process overview: 
% Develop a randomized policy (go Up, Left, Right, or Down randomly)
% Calculate consistent state values for this policy.
% Develop a new policy that is greedy with respect to these state values.
% Loop.
% Each policy is guaranteed to be a strict improvement over the previous,
% except in the case in which the optimal policy has already been found.

% Simplifying assumptions:
% -Only one action allowed per state
% -Deterministic state transitions (if we try to go Right, we will)

% The algorithm is told that trying to leave the grid is bad.
% Some squares (ex. the exit) are assigned a large reward, and others (ex.
% walls are assigned a large penalty)

% This is a dynamic programming since the environment and the effect of
% actions is completely known (reward known, probability of transition
% known).

%% Initialization

% Set reward given for transitioning to a state (square)
% Currently set up to simulate a maze, but this is just one example of what
% can be done with this frameowork.
P = -1 ; % Represents a passage
W = -100000; % Represents a wall
E = 1000; % Represents exit
% R needs to be square for this code to work
R = [P P P W P P P P P E
     P W P P P W P W P P
     P W W W W W P W W P
     P P P P P W P W W W
     P P P P P W P W P P
     P P P P P W P P W P
     W W W P P W P P W P
     P P P P P W P P P P
     P P P W W W P P W P
     E P P P P P P P W P     
 ];

% The grid wowrld is a square with sideLength squares per side
sideLength = length(R);

% Set estimates of state values (V) randomly
scalFact = 1;
V = scalFact*rand(sideLength, sideLength);

% Set policy randomly
policyActions = randi(4,sideLength,sideLength) - 1;
% 0 == go right
% 1 == go up
% 2 == go left
% 3 == go down

%% Iterate, making the policy consistent and making it greedy again
numIter = 50;
discRate = 0.8; % The larger this value, the more far sighted we are
% Also, the higher the discount rate, the longer calculations take to
% converge

for i = 1:numIter    
% Makes the policy consistent.
% Retunrs consistent state values for current policy
V = EvaluatePolicy(policyActions, V, R, sideLength, discRate);

% Choose a new greedy policy based on the value calculated above
outV = -100; % Value of a state if you choose to leave the grid from that state
policyActions = MakeGreedy(policyActions, V, outV, sideLength);

% Print the new greedy policy
% str = sprintf('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nNew greedy policy:\n');
str = sprintf('\nNew greedy policy:\n');
disp(str)
%PrintPolicy(policyActions, sideLength);
PrintPolicyMaze(policyActions, sideLength, R, W); % Pretty printing for mazes
pause
end










