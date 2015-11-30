function greedyPolicy = MakeGreedy(policyActions, V, outV, sideLength)
% Inputs:
% -Current policy and state values estimates under tha tpolciy
% Outputs:
% -Greedy policy under state value estimates

greedyPolicy = zeros(sideLength, sideLength);
for i = 1:sideLength % x coord
    for j = 1:sideLength % y coord
        % Try all the actions and see which has the best value
        % Tell the algorithm it's a BAD idea to go outside the grid (via outV)
        VRight = rewardIfAction(0,i,j,V,outV,sideLength);
        VUp = rewardIfAction(1,i,j,V,outV,sideLength);
        VLeft = rewardIfAction(2,i,j,V,outV,sideLength);
        VDown= rewardIfAction(3,i,j,V,outV,sideLength);   
        [maxVal, whichAction] = max([VRight, VUp, VLeft, VDown]); 
         greedyPolicy(i,j) = whichAction-1; % If 1st action is good, choose 0 as action
    end
 end