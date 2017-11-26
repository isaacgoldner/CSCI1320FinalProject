function child = breed(parent1,parent2,targetPhrase)
%Takes in the matingPool population and, using pairs of randomly selected 
%"parent organisms", creates a new population of children based on their 
%parent's DNA; Note that there are 2 methods in this function for how to 
%breed this new child specified on the assignment sheet.

% %% Method 1:
% 
% %get length of target string
% targetStringLength = length(targetPhrase);
% % z = blanks(targetStringLength);
% % children = repmat(z,populationSize,1);
% 
% %choose a random index in the length of the target string to split the
% %DNA to breed the child
% num = randi([1,targetStringLength-1]);
% 
% %choose the part of parent 1's DNA sequence that was chosen by the
% %random number 'num'
% parent1DNA = parent1(1:num);
% 
% %choose the part of parent 2's DNA sequence that was chosen by the
% %random number 'num'
% parent2DNA = parent2(num+1:end);
% 
% %form the child based on p1DNA and p2DNA
% child = strcat(parent1DNA,parent2DNA);

%% Method 2:

%get length of target string
targetStringLength = length(targetPhrase);

%randomly select how many characters from the first parent will be used in
%the breeding process
numChars = randi([1,targetStringLength - 1]);

%randomly select the indices of the chars that will be taken from parent1
%based on the randomly-selected 'numChars' value

%TROUBLE SHOOTING NOTE HERE: THIS WORKS, BUT WE ARE CURRENTLY SAMPLING WITH
%REPLACEMENT. WE MOST LIKELY DO NOT WANT THIS. 

parent1Indices = sort(datasample([1:targetStringLength],numChars));

%pre-allocate the size of the child vector that will be returned
child = blanks(targetStringLength);

%set the specific indices of the child to parent 1's DNA, whose values were
%chosen in the variable 'parent1Indices'
child(parent1Indices) = parent1(parent1Indices);

%find the indices out of the entire length of the target phrase that were
%not used in 'parent1Indices'
x = ~ismember([1:targetStringLength],parent1Indices);

%set the indices that were not taken out of parent 1's DNA to parent 2's
%DNA to finalize the breeding of the new child
child(x) = parent2(x);

end