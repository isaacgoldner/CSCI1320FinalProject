function child = breed(parent1,parent2,targetPhrase)
%Takes in the matingPool population one pair of parents at a time and
%creates a new population of children (one child at a time) based on their 
%parent's DNA; Note that there are 2 methods in this function for how to 
%breed this new child specified on the assignment sheet.


%DO METHOD ONE: 

% % Method 1:
% % The first method creates the child's combination of DNA by randomly
% % picking a midpoint to divide the parents' DNA and then giving one half
% % from each parent to the child:
% 
% %Take the length of the target string: 
%  targetStringLength = length(targetPhrase);
% 
% %choose a random index in the length of the target string to split the
% %parent's DNA to breed the child: 
%  num = randi([1,targetStringLength-1]);
% 
% 
% %choose the part of parent 1's DNA sequence to be given to the child that was chosen by the
% %random number 'num'. Note that the first "section" of the child's DNA will
% %come from parent 1: 
%  parent1DNA = parent1(1:num);
%  
% 
% %Use parent 2's DNA after the selected midpoint to serve as the second
% %"section" of the child's DNA. 
% 
% parent2DNA = parent2(num+1:end);
% % 
% %For the child by combining the two "sections" of parent DNA. 
%  child =[parent1DNA,parent2DNA];

%% Method 2:
%The second breeding method creats the child's DNA by taking a completely 
%random selection of one parent’s DNA, followed by taking the remaining DNA 
%from the other.

%Take the length of the target string: 
targetStringLength = length(targetPhrase);

%randomly select how many characters from the first parent will be used in
%the breeding process: 
numChars = randi([1,targetStringLength - 1]);

%randomly select the indices of the chars that will be taken from parent1
%based on the randomly-selected 'numChars' value: 
 
%Decide which characters from the first parent will be given to the child: 
parent1Indices = sort(datasample([1:targetStringLength],numChars));

%Pre-allocate the size of the child character vector that will be returned: 
child = blanks(targetStringLength);

%Set the specific indices of the child to parent 1's DNA, whose values were
%chosen in the variable 'parent1Indices':
child(parent1Indices) = parent1(parent1Indices);

%Find the indices out of the entire length of the target phrase that were
%not used in 'parent1Indices':
x = ~ismember([1:targetStringLength],parent1Indices);

%Set the indices of the child's DNA that were not taken out of parent 1's 
%DNA to the corrisponding indicies in parent 2's DNA to finalize the
%breeding of the new child: 
child(x) = parent2(x);

end