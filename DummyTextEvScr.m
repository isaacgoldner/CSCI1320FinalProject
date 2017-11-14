%DUMMY SCRIPT

%This script can act as the overview script for the text evolution process
%in the interest of testing to be sure that work completed can be
%integrated properly. 

targetPhrase = 'To be or not to be';

populationSize = 200;

population = buildPopulation(targetPhrase,populationSize); 

fitness = calculateFitness(population,populationSize,targetPhrase); 

matingPool = buildMatingPool(fitness,populationSize);

