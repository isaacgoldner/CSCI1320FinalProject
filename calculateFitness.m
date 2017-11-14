function fitness = calculateFitness(population,populationSize,targetPhrase)
%This function takes in the current population and returns the "fitness" of
%each organism in it by comparing the target phrase with each organism. The
%function returns a column vector where each element is an individual
%population organism's fitness expressed as a percent. 

%take the current population and revert it back from a single cell to an
%array. 
%pop = cell2mat(population); 

%Temporarily reshape the population to be a row vector for easy comparison: 
pop4Compare = reshape(population,1,populationSize * length(targetPhrase)); 

%Replicate the target phrase to create a "target row vector" that can be
%compared with pop4Compare: 
target4Compare = repmat(targetPhrase,1,populationSize); 

%MatchCheck creates a 200 by 18 logical array where each row represents an
%organism in the population and each column of an individual row stores 
%either a one or a zero
%for whether or not the particular character from
%the organism represented by the column matched with the target phrase's 
%character:
rightOrWrong = pop4Compare == target4Compare;
matchCheck = reshape(rightOrWrong,length(targetPhrase),populationSize);

%MatchCheck = reshape((pop4Compare == target4Compare),200,18); 

%Fitness, a 200x1 column vector, is created to store the fitness of each
%of the members of the population expressed as a percent. Each element of
%the fitness vector corrisponds to an individual organism. 
fitness = (sum(matchCheck))./length(targetPhrase); 
fitness = fitness';

end