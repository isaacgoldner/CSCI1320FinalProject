function mutatedNewPopulationMember = imageImprovedCauseMutation(newPopulationMember)

%First, decide if a pixel is to be mutated at all. 'mutationRate' is a
%number from 1 to 100, representing a percentage
mutationRate = 1;

%Store the size of the child to be mutated: 
[row,col,page] = size(newPopulationMember); 

%Generate random integer(s) from a range that depends on the desired
%mutation rate: 
LuckyNumber = randi([1,100],1,mutationRate); 

%Create a vector of random integers drawn from the same range as
%LuckyNumber. This vector's length matches the number of elements in the 
%child that is to be mutated; each element corrisponds to one of the
%child's pixels. 
ChanceVec = randi([1,100],1,(row*col)); 

%Create a logical vector that marks the instances where an element of
%ChanceVec matches the LuckyNumber's value: 
mutMe = ismember(ChanceVec,LuckyNumber);

pixels = [1:row*col];

%Find the indexes of the elements in the child that should be mutated by
%finding where the element's of ChanceVec matched LuckyNumber: 

mutateWho = pixels(mutMe);

%For the pixels to be mutated, determine what type of mutation they will
%undergo (PROCESS 1 or 2)
%whatMut = randi([1,4],1,length(mutateWho)); 
whatMut = randi([1,4],1,sum(mutMe));

%randomMutationChance = 1;

%Assign which pixels from mutateWho will undergo which mutation process: 
%Process1ers = mutateWho(find(whatMut == 4)); 
%Process2ers = mutateWho(find(whatMut ~= 4)); 
Process1ers = mutateWho(find(whatMut == 1 )); 
Process2ers = mutateWho(find(whatMut ~= 1)); 

%PROCESS 1: 
%If a pixel is to be mutated, there is a 1/4 chance that it will simply be
%randomly mutated.

randNewVals = rand(1,length(Process1ers));
newPopulationMember(Process1ers) = randNewVals; 

%Process 2: 
%If a pixel is to be mutated, there is a 3/4 chance that it will be mutated
%more specifically by being lightened or darkened by a random value in a
%specific range. 
mutationRange = 0.05; 

%Create a vector of values within the range that will either be added or
%subtracted: 
ligDar = rand(1,length(Process2ers))*(mutationRange - (-mutationRange))+(-mutationRange); 

newPopulationMember(Process2ers) = newPopulationMember(Process2ers) + ligDar; 

greaterThan1Indices = find(newPopulationMember > 1);
newPopulationMember(greaterThan1Indices) = 1;

lessThan0Indices = find(newPopulationMember < 0);
newPopulationMember(lessThan0Indices) = 0;

%Finish with setting the function's output equal to the altered child. 
mutatedNewPopulationMember = newPopulationMember;


end