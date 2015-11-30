function Vact = rewardIfAction(action, i, j, V, outV, sideLength)
% Returns values of state transitioned to from (i,j) under currently policy
% (Function has a bad title! Sorry.)
% i - location in x
% j - location in y
% V - estimated value of squares
% outR - reward to give if landing outside of grid
% sideLength - the number of squares to a side in the grid world

% 0 == go right
% 1 == go up
% 2 == go left
% 3 == go down

% Determine if we tried to leave the grid
wentOut = 0; 
if (action == 0 && j == sideLength) % Tried to go right
    wentOut = 1;
elseif  (action == 2 && j== 1) % Tried to go left
    wentOut = 1;
elseif  (action == 1 && i == 1) % Tried to go up
    wentOut = 1;
elseif  (action== 3 && i == sideLength) % Tried to go down
    wentOut = 1;
end

% Calculate what the next state would be if we didn't go out of
% bounds
nextState = zeros(1,2);
if (wentOut ~= 1)
    if (action == 0) % Tried to go right        
        nextState = [i, j+1]; 
    elseif  (action == 2) % Tried to go left        
        nextState = [i, j-1]; 
    elseif  (action == 1) % Tried to go up (up is lower indices)         
        nextState = [i-1, j]; 
    elseif  (action == 3) % Tried to go down           
        nextState = [i+1, j];
    end      
end

% Calculate the value of the next state under this action
% This helps us choose which state we should choose to go to
% (the one with the best value)
if (wentOut == 1)
    Vact = outV; % If went out
else  
    Vact = V(nextState(1), nextState(2)); % Otherwise   
end

