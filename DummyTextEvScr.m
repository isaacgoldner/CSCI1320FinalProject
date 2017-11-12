%DUMMY SCRIPT

%This script can act as the overview script for the text evolution process
%in the interest of testing to be sure that work completed can be
%integrated properly. 

[population,populationSize]= buildPopulation; 

fitness = calculateFitness(population); 

matingPool = buildMatingPool(fitness)