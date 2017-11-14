function mutatedChild = causeMutation(child,targetPhrase)
%Using the newly created population of children, this function
%takes in a "child" string and mutates it with a certain mutation rate

%initialize the mutated child as the same as the regular child
mutatedChild = child;

%initialize the mutation rate as a number between 0 and 100, which
%represents a percentage, of how often a mutation of a piece of DNA (a char)
%will occur
mutationRate = 3;

%generate random number(s) based on the mutation rate
numVec = randi([1,100],mutationRate);

%generate a vector of random numbers on the same interval as the previously
%initialized random number, which is the same length as the target phrase
randNumVecStringLength = randi([1,100],1,length(targetPhrase));

%find the instances of 'randNumVecStringLength' that match the value(s) of
%numVec
x = ismember(randNumVecStringLength,numVec);

%set the value of the vector to 1 if the random number vector 'numVec' is the
%same as the specific index of 'randNumVecStringLength'
randNumVecStringLength(x) = 1;

%set the value of the vector to 0 if the random number vector 'numVec' is 
%different than the specific index of 'randNumVecStringLength'
randNumVecStringLength(~x) = 0;

%generate a char vector of the possible chars that can be replaced for in
%the mutation process
CapASCII = [65:90];
LowASCII = [97:122];
SpaceASCII = [32];
PossCharASCII = char([CapASCII, LowASCII, SpaceASCII]);  

%find how many chars will be mutated in the child
numMutationChars = sum(randNumVecStringLength);

%generate random chars to replace the chars that were selected to be
%mutated
randChars = datasample(PossCharASCII,numMutationChars);

%find the indexes of the child that will be mutated
mutateIndices = find(randNumVecStringLength == 1);

%replace the old chars with the new, random chars for the mutation
mutatedChild(mutateIndices) = randChars;

end