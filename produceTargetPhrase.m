%This script runs the text evolution process. Specifically it
%defines the target phrase, generates an initial population of phrases, 
%calculates organisms' fitnesses, builds mating pools, and then uses the 
%mating pools to breed new populations. 

%Set the target phrase that the process should evolve. 
targetPhrase = 'To be or not to be';

%1.7 Notes: Shorter phrases have less possible wrong strings and therefore
%generate faster. 

%Use the buildPopulation function to create the initial population of 
%strings and set the size of the population: 
[population,populationSize] = buildPopulation(targetPhrase);

%Specify the maximum number of generations that will be run through if the
%target phrase has still not been produced: 
maxGenerations = 250;

%Preallocate vectors that will be used to store required information about
%every generation: 
maxFitness = zeros(1,maxGenerations);
avgFitness = zeros(1,maxGenerations);
geneticDiversity = zeros(1,maxGenerations);

%Importantly, the bestPharse vector stores the most fit organism from every
%generation of the evolution process: 
bestPhrase = char(maxGenerations,length(targetPhrase));

%declare and initialize the 'generation' variable that will be used to
%check if 'maxGenerations' has been reached as the evolution process runs; 
%the variable 'generation' is also used as a counter variable throughout 
%the while-loop below: 
generation = 1;

%Start timer for recording the evolution process' run time: 
tic; 

%This while loop allows the evolution process to run one generation at a
%time until either the max allowed generation number is reached or the
%target phrase is reached: 

while (generation ~= maxGenerations+1) && (~ismember(1,maxFitness))
     

    %calculate the fitness of the population
    fitness = calculateFitness(population,populationSize,targetPhrase);
    
    %find the indices of the maximum fitness in the current population: 
    maxFitnessVec = find(max(fitness) == fitness);
    
    %store the max fitness for the generation; 'maxFitnessVec(1,1) is used
    %because there may be multiple organisms with the same best fitness, so
    %it doesn not matter which of these best organisms is selected to use
    %for bestFitness: 
    maxFitness(1,generation) = fitness(maxFitnessVec(1,1));
    
    %store the average fitness for the generation: 
    avgFitness(1,generation) = sum(fitness) / populationSize;
    
    %store the genetic diversity (max fitness - avg fitness) for the
    %generation: 
    geneticDiversity(1,generation) = maxFitness(1,generation) - ...
        avgFitness(1,generation);
    
    %store the best phrase out of the generation to bestPhrase: 
    bestPhrase(generation,1:length(targetPhrase)) = population(maxFitnessVec(1,1),1:length(targetPhrase));

    %For each generation as the process runs, print the current generation
    %adn the best phrase within side by side: 
    fprintf('Best Phrase: %s  |  Generation: %d\n',(population(maxFitnessVec(1,1),1:length(targetPhrase))),generation); 
    
    %Use the buildMatingPool function to create the mating pool that will
    %be used to breed the next generation: 
    matingPool = buildMatingPool(fitness,populationSize);

    %pre-allocate the char matrix for the new population that will be created
    newPopulation = char(populationSize,length(targetPhrase));

    %create a new population by breeding the parents based on the calculated
    %mating pool, causing random mutations in the newly-bred children, and
    %replacing the members of the old population with the new population:
    for i = 1:populationSize
        %Breed: 
        newPopulation(i,1:length(targetPhrase)) = breed(population(matingPool(i,1),:),...
            population(matingPool(i,2),:),targetPhrase);

        %Cause mutation:
        newPopulation(i,1:end) = causeMutation(newPopulation(i,1:end),targetPhrase);

        %Replace the old population with the new population of bred and
        %mutated children: 
        population(i,1:end) = newPopulation(i,1:end);
        
    end
  
    %increment the generation number when the new population has been
    %formed
    generation = generation + 1;
    

end

%Print the amount of time elapsed and the number of generations
%the evolution process required. 

%End timer for evolution process occurs inside the fprintf. 
%Conditionals are used to express the end of process information. 
if ismember(targetPhrase,bestPhrase,'rows')
fprintf('\nThe evolution process succeeded in %f seconds and %d generations.\n'...
    ,toc, generation-1);  
else
fprintf('\nThe evolution process terminated in %f seconds after the maximum possible generation (generation %d) was reached.\n'...
    ,toc,maxGenerations);         
end

%Plot max. fitness, avg. fitness, and genetic diversity over the
%generations. Use the subplot function to show all the plots at once.
figure

%Plot avg. fitness over the generations: 
subplot(1,3,1); 
plot([1:generation-1],avgFitness(1:generation-1),'r');
title('Generation vs. Avg. Fitness'); 
xticks(0:20:200); 
yticks(0:.05:1); 
xlabel('Generation'); 
ylabel('Avg. Fit.'); 

%Plot max. fitness over the generations: 
subplot(1,3,2); 
plot([1:generation-1],maxFitness(1:generation-1),'b');
title('Generation vs. Max. Fitness'); 
xticks(0:20:200); 
yticks(0:.05:1);
xlabel('Generation'); 
ylabel('Max. Fit.'); 

%Plot. gen. div. over the generations: 
subplot(1,3,3); 
plot([1:generation-1],geneticDiversity(1:generation-1),'m');
title('Generation vs. Genetic Diversity'); 
xticks(0:20:200); 
%yticks(0:.01:.4);
xlabel('Generation'); 
ylabel('Gen. Div.'); 
 
%Save best phrase, maximum fitness, average fitness, and genetic diversity 
%for each generation to a text file: 

%The text file is called PhraseEvolutionResults.txt and is overwritten each
%time the evolution process is run. 

%Establish the vectors needed for the printing process: 
GenerationsForTxt = num2cell(1:generation-1); 
BestPhrases = cellstr(bestPhrase)';  
MaxFit = num2cell(maxFitness(1:generation-1));
AvgFit = num2cell(avgFitness(1:generation-1));
GenDiv = num2cell(geneticDiversity(1:generation-1));

%Table Creator is the cell array actually iterated though to make the
%"table" that will appear in the text file.

%Note that one column of TableCreator stores all of the necessary data from
%a single generation. 
TableCreator = [GenerationsForTxt; BestPhrases; MaxFit; AvgFit; GenDiv]; 

%The following commands save the data to the text file in a clear format: 
 fileID = fopen('PhraseEvolutionResults.txt','w');
 fprintf(fileID,'Generation         Best Phrase          Max. Fitness    Avg. Fitness   Gen. Diversity\r\n');
 fprintf(fileID,'%5d          %18s          %.4f          %.4f          %.4f\r\n',TableCreator{:});
 fclose(fileID);

