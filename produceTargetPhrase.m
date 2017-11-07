%script to define the target, generate initial population, calculate
%fitnesses, build mating pools, and breed new populations. 

%Specifying the target phrase string:
targetPhrase = 'To be or not to be';

%create the initial population
population = buildPopulation();

%Store the size of the initial population as PopSiz. 200 is used as for the
%text situation the population will consist of 200 different strings the
%same length as the target phrase. 

PopSiz = 200; 

%begin timer to detemine how long evolving to meet the target phrase will
%take: 
tic

%The process below will continue until the target phrase is found in the
%evolved population: 

i = 1;

while newPopulation{i-1} ~= targetPhrase

%calculate the fitnesses of each of the organisms
fitness = calculateFitness(population)

%creating the mating pool that is based off of the fitness of each of the
%organisms
matingPool = buildMatingPool(population,fitness);

%breeding a new population one child at a time based on the mating pool 
%that was created with the bulidMatingPool function: 
children = breed(matingPool{1},matingPool{2});


%Reassign population to the 200 new children created in each iteration: 
newPopulation{i} = children; 

i = i + 1;

%End of while loop will occur one the target phrase is met:
end 

%End timer: 
toc

%print the number of generations
generationNumbers = 1;
fprintf('%d',generationNumbers);

%plot the maximum fitness over generations:
figure
x1 = 2;
y1 = 2;
plot(x,y);

%plot the average fitness over generations on the same plot as the maximum
%fitness over generations:
hold on
x2 = 1;
y2 = 1;
plot(x,y);

figure
%plot genetic diversity over generations on a seperate figure:
x3 = x1 - x2;
y3 = y1 - y2;
plot(x3,y3);

%save best phrase, maximum fitness, average fitness, and genetic diversity
%for each generation to a txt file currently named saver.txt: 

%We anticpated each of the generation qualities mentioned to be stored in
%vectors with one element per generation. 

%General idea... 
fid = fopen('saver.txt','w'); 
fprintf(fid,'Generation 1''s maximum fitness is %f'); 
%Process continues for each characteristic and each generation. We will
%investigate a method to accomplish this without loops. 

%Once all of the needed information is inputted, the txt file is closed. 
fclose(fid); 




