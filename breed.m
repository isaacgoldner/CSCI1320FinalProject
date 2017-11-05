function child = breed(parent1,parent2)
%takes in two parents and returns the child that is bred from these two
%parents; there are 2 methods in this function for how to breed this new 
%child, the first one is pseudocoded here: 

child = blanks(length(parent1));
child(1,1:3) = parent1(1,1:3);
child(1,4:end) = parent2(1,4:end);

end