%script to define the target, generate initial population, calculate
%fitnesses, build mating pools, and breed new populations

%specifying the target phrase
targetPhrase = 'To be or not to be';

%create the initial population
population = buildPopulation();

tic

%calculate the fitnesses of each of the organisms
fitness = calculateFitness(population)

%creating the mating pool that is based off of the fitness of each of the
%organisms
matingPool = buildMatingPool(population);

%breeding a new population based off of the mating pool that was created
child = breed(matingPool{1},buildMatingPool{2});

toc

%print the number of generations
generationNumbers = 1;
fprintf('%d',generationNumbers);

%plotting the maximum fitness over generations
x1 = 2;
y1 = 2;
plot(x,y);

%plotting the average fitness over generations
hold on
x2 = 1;
y2 = 1;
plot(x,y);

%plotting genetic diversity over generations
x3 = x1 - x2;
y3 = y1 - y2;
plot(x3,y3);

%save best phrase, maximum fitness, average fitness, and genetic diversity
%for each generation to a txt file





