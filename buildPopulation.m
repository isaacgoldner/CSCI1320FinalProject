function [population, populationSize,targetPhrase] = buildPopulation()
%This function is used to create a cell that contains the intial population
%of 200 phrases for the string evolution process and a variable that stores
%the number of organisms in the population.

%Store populationSize as 200 as there are 200 organisms in the population. 
populationSize = 200; 

%establish the target phrase
targetPhrase = 'To be or not to be';

%find how many characters comprise targetPhrase
targetPhraseLength = length(targetPhrase);

%Create a vector with all possible characters, which include all lower
%case letters, capital letters, and a space. Call this vector 
%PossCharASCII: 
CapASCII = [65:90];
LowASCII = [97:122];
SpaceASCII = [32];

PossCharASCII = char([CapASCII, LowASCII, SpaceASCII]);  

%Create the output cell that contains the population. 
% population = cell(1,1); 
% population{1,1} = reshape(datasample(PossCharASCII,populationSize * targetPhraseLength),...
%     populationSize,targetPhraseLength); 

population = zeros(populationSize,targetPhraseLength); 
population = reshape(datasample(PossCharASCII,populationSize * targetPhraseLength),...
    populationSize,targetPhraseLength);

end 
