%Script to define the target phrase, generate initial population of phrases, 
%calculate fitnesses, build mating pools, and breed new populations. 

%Specifying the target phrase string:
targetPhrase = 'To be or not to be';

%Store the size of the initial population as PopSiz. 200 is used as for the
%text situation the population will consist of 200 different strings the
%same length as the target phrase. 
populationSize = 200; 

%create the initial population
population = buildPopulation(targetPhrase,populationSize);

%specify the maximum number of generations that will be run through if the
%target phrase has still not been produced yet
maxGenerations = 200;

maxFitness = zeros(1,maxGenerations);
avgFitness = zeros(1,maxGenerations);
geneticDiversity = zeros(1,maxGenerations);
bestPhrase = char(maxGenerations,length(targetPhrase));

%declare and initialize the 'generation' variable that will be used to
%check if 'maxGenerations' has been reached; the variable 'generation' is
%also used as a counter variable throughout the while-loop
generation = 1;

while (generation ~= maxGenerations) && (strcmp(bestPhrase(generation-1,1:end),...
        targetPhrase))

    %calculate the fitness of the population
    fitness = calculateFitness(population,populationSize,targetPhrase);

    %find the indices of the maximum fitness 
    maxFitnessVec = find(max(fitness) == fitness);

    %store the max fitness for the generation; 'maxFitnessVec(1,1) is used
    %because there may be multiple organisms with the same best fitness, so
    %it doesn not matter which of these best organisms is selected to use
    %for bestFitness
    maxFitness(1,generation) = fitness(maxFitnessVec(1,1));
    
    %store the average fitness for the generation
    avgFitness(1,generation) = sum(fitness) / populationSize;
    
    %store the genetic diversity (max fitness - avg fitness) for the
    %generation
    geneticDiversity(1,generation) = maxFitness(1,generation) - ...
        avgFitness(1,generation);
    
    %store the bestPhrase out of the generation
    bestPhrase(generation,1:end) = population(maxFitnessVec(1,1));

    %build the mating pool from the population
    matingPool = buildMatingPool(fitness,populationSize);

    %pre-allocate the char matrix for the new population that will be created
    newPopulation = char(populationSize,length(targetPhrase));

    %create a new population by breeding the parents based on the calculated
    %mating pool, cause random mutations in the newly-bred children, and
    %replace the members of the old population with the new population
    for i = 1:populationSize
        %breed
        newPopulation(i,1:end) = breed(population(matingPool(i,1),1:end),...
            population(matingPool(i,2),1:end));

        %cause mutation
        newPopulation(i,1:end) = causeMutation(newPopulation(i,1:end),targetPhrase);

        %replace old population with new population
        population(i,1:end) = newPopulation(i,1:end);
    end
  
    %increment the generation number when the new population has been
    %formed
    generation = generation + 1;
    
end
%% Skeleton
% %begin timer to detemine how long evolving to meet the target phrase will
% %take: 
% tic
% 
% %The process below will continue until the target phrase is found in the
% %evolved population: 
% 
% %c shows an example of how a generation iterator might be used to store the
% %required information for each generation: 
% c = 1;
% while (bestPhrase ~= targetPhrase)
%     
%     %creating a new generation
%     while %The new population members of the generation currently being 
%           %created do not include the target phrase (increases efficiency
%           %as code will terminate if target phrase is found): 
% 
%     %calculate the fitnesses of each of the organisms
%     fitness = calculateFitness(population);
% 
%     %creating the mating pool that is based off of the fitness of each of the
%     %organisms
%     matingPool = buildMatingPool(population,fitness);
% 
%     %breed a new population consting of children of parent pairs found in
%     %the mating pool that was created with the bulidMatingPool function: 
%     children = breed(matingPool);
% 
%     %Mutate the children with the cause mutation function
%     population = causeMutation(children); 
% 
%     %This will also reassign population to the 200 new children, included those mutated 
%     %with the cause mutation function. 
%     
%     
%     %store the best fitness, average fitness, and best phrase for each
%     %generation
%     bestFitness = 2;
%     averageFitness = 1;
%     bestPhrase = 'x';
%     
%     %End of inner while loop will occur once the target phrase is found 
%     %within the newly created population:
%     end 
%     
%     %Record required information for each generation created:
%     bestFitnessVec[1,c] = bestFitness;
%     averageFitnessVec[1,c] = averageFitness;
%     bestPhraseVec{c,1} = bestPhrase;
%     
%     %increase generation iterator: 
%     c = c + 1;
% 
% end
% 
% %End timer: 
% toc
% 
% %print the number of generations
% generationNumbers = c - 1;
% fprintf('%d',generationNumbers);
% 
% %plot the maximum fitness over generations:
% figure
% plot(generationNumbers,bestFitnessVec);
% 
% %plot the average fitness over generations on the same plot as the maximum
% %fitness over generations:
% hold on
% plot(generationNumbers,averageFitnessVec);
% 
% figure
% %Plot genetic diversity over generations on a seperate figure:
% geneticDiversity = bestFitnessVec - averageFitnessVec;
% plot(generationNumbers,geneticDiversity);
% 
% %Save best phrase, maximum fitness, average fitness, and genetic diversity
% %for each generation to a txt file currently named saver.txt: 
% 
% %We anticpate each of the generation qualities mentioned to be stored in
% %vectors with one element per generation. 
% %General idea... (Will be modified as needed to fit required
% %functionality.)
% fid = fopen('saver.txt','w'); 
% fprintf(fid,'%s %s %s %s','Best Phrase','Maximum Fitness','Average Fitness','Genetic Diversity'); 
% fprintf(fid,'%s %f %f %f\n',bestPhraseVec,bestFitnessVec,averageFitnessVec,geneticDiversity);
% %Process continues for each characteristic and each generation. We will
% %investigate a method to accomplish this without loops. 
% 
% %Once all of the needed information is inputted, the txt file is closed. 
% fclose(fid); 


