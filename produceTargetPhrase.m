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
c = 1;
while (bestPhrase ~= targetPhrase)
    i = 1;
    
    %creating a new generation
    while (newPopulation{i-1} ~= targetPhrase) && (i < 202)

    %calculate the fitnesses of each of the organisms
    fitness = calculateFitness(population);

    %creating the mating pool that is based off of the fitness of each of the
    %organisms
    matingPool = buildMatingPool(population,fitness);

    %breeding a new population one child at a time based on the mating pool 
    %that was created with the bulidMatingPool function: 
    children = breed(matingPool{1,1},matingPool{1,2});


    %Reassign population to the 200 new children created in each iteration: 
    newPopulation{i} = children; 

    i = i + 1;
    
    %store the best fitness, average fitness, and best phrase for each
    %generation
    bestFitness = 2;
    averageFitness = 1;
    bestPhrase = 'x';
    
    %End of while loop will occur once the target phrase is met:
    end 
    
    bestFitnessVec[1,c] = bestFitness;
    averageFitnessVec[1,c] = averageFitness;
    bestPhraseVec{c,1} = bestPhrase;
    
    c = c + 1;

end

%End timer: 
toc

%print the number of generations
generationNumbers = c - 1;
fprintf('%d',generationNumbers);

%plot the maximum fitness over generations:
figure
plot(generationNumbers,bestFitnessVec);

%plot the average fitness over generations on the same plot as the maximum
%fitness over generations:
hold on
plot(generationNumbers,averageFitnessVec);

figure
%plot genetic diversity over generations on a seperate figure:
geneticDiversity = bestFitnessVec - averageFitnessVec;
plot(generationNumbers,geneticDiversity);

%save best phrase, maximum fitness, average fitness, and genetic diversity
%for each generation to a txt file currently named saver.txt: 
%We anticpated each of the generation qualities mentioned to be stored in
%vectors with one element per generation. 
%General idea... 
fid = fopen('saver.txt','w'); 
fprintf(fid,'%s %s %s %s','Best Phrase','Maximum Fitness','Average Fitness','Genetic Diversity'); 
fprintf(fid,'%s %f %f %f\n',bestPhraseVec,bestFitnessVec,averageFitnessVec,geneticDiversity);
%Process continues for each characteristic and each generation. We will
%investigate a method to accomplish this without loops. 

%Once all of the needed information is inputted, the txt file is closed. 
fclose(fid); 


