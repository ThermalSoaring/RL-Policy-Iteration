function PrintPolicy(policyActions, sideLength)
% Displays policy choices in a more intuitive way
% 0 == go right -> R
% 1 == go up -> U
% 2 == go left -> L
% 3 == go down -> D

toDisp = char(zeros(sideLength, sideLength));
for i = 1: sideLength
   for j = 1: sideLength
       if (policyActions(i,j) == 0)
            toDisp(i,j) = 'R';
       elseif(policyActions(i,j) == 1)
            toDisp(i,j) = 'U';
       elseif(policyActions(i,j) == 2)
            toDisp(i,j) = 'L';
       elseif(policyActions(i,j) == 3)
            toDisp(i,j) = 'D';
       end
   end
end
disp(toDisp)