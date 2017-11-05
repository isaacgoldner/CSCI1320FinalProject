%script to define the target, generate initial population, calculate
%fitnesses, build mating pools, and breed new populations

%specifying the target phrase
targetPhrase = 'To be or not to be';

%create the initial population
population = buildPopulation();

%calculate the fitnesses of each of the organisms
fitness = calculateFitness(population)



