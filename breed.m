function children = breed(matingPool)
%Takes in the matingPool population and, using pairs of randomly selected 
%"parent organisms", creates a new population of children based on their 
%parent's DNA; Note that there are 2 methods in this function for how to 
%breed this new child specified on the assignment sheet.


%Sample code of how the first method of completing this task might be done 
%(parent1 and parent2 would be
%members selected from the matingPool population): 
child = blanks(length(parent1));
child(1,1:3) = parent1(1,1:3);
child(1,4:end) = parent2(1,4:end);

end