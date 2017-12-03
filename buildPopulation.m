function [population, populationSize] = buildPopulation(targetPhrase)
%This function is used to create the intial population
%of 200 phrases for the string evolution process and a variable that stores
%the number of organisms in the population.

%Store the size of the initial population. As instructed we set our 
%population total at 200, where each of the 200 organisms is a different string the
%same length as the target phrase. 
populationSize = 200; 

%find how many characters comprise targetPhrase: 
targetPhraseLength = length(targetPhrase);

%Create a vector with all possible characters, which include all lower
%case letters, capital letters, and a space. Call this vector 
%PossCharASCII: 
CapASCII = [65:90];
LowASCII = [97:122];
SpaceASCII = [32];
%Used in task 1.7 experimentation: add numbers to the mix: 
NumASCII = [48:57]; 

%Use with only the characters assigned: 
PossCharASCII = char([CapASCII, LowASCII, SpaceASCII]);  

%Use with more characters (numbers) for task 1.7: 
%PossCharASCII = char([CapASCII, LowASCII, SpaceASCII,NumASCII]);  

%1.7 General note: adding more characters increases the number of possible
%strings that are incorrect, thereby making the evolution process slower. 

%Population will be stored as a matrix that has as many rows as there are
%organisms and as many columns as there are characters in a given organism.

%Note: We made the decision for simplicity to not store our population in a
%cell. Our program is still quite fast and Professor Z did approve this
%decision. 

%Preallocate the population matrix with zeros: 
population = zeros(populationSize,targetPhraseLength); 

%Use the data sample function to create the entire starting population as a
%vector, then reshape this vector to have each row of the population matrix
%be an individual organism. 

population = reshape(datasample(PossCharASCII,populationSize * targetPhraseLength),...
    populationSize,targetPhraseLength);

end 
