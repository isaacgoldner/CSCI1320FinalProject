function population = buildPopulation(targetString)
%creates a random population of 200 strings that are the same length as the
%target phrase. 

populationSize = 200;

asciiChars = [32,65:90,97:122];

lengthChars = length(asciiChars);

lengthOfTarget = length(targetString);

randVec = rand(populationSize,lengthOfTarget);

end 


