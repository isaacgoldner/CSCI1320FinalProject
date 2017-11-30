%Script used to run the image evolution process in color: 

%Read in the desired target image, save it as targetImage: 
targetImage = imread('25x25angry.png');

%Convert the image to type double and have intensity values range from 0 to 1. 
targetImage = double(targetImage); 
targetImage = targetImage ./255; 

%Build the randomly generated starting population and return 
%'targetImage', which is the black and white version of 'image'. 

[population,targetImage] = colorImageBuildPopulation(targetImage);

%specify the maximum number of generations that will be run through if the
%target phrase has still not been produced yet

maxGenerations = 10000;

%Initialize the vectors that will be used to store data from each
%generation, along with the cell array that will store the best image from
%each generation: 
maxFitness = zeros(1,maxGenerations);
avgFitness = zeros(1,maxGenerations);
geneticDiversity = zeros(1,maxGenerations);
bestImage = cell(maxGenerations,1); 
%declare and initialize the 'generation' variable that will be used to
%check if 'maxGenerations' has been reached; the variable 'generation' is
%also used as a counter variable throughout the while-loop
generation = 1;

%Start timer to determine how long the evolution process will take: 
tic; 

while (generation ~= maxGenerations+1) && (~ismember(1,maxFitness))
%Calculate the fitness of each organism with the calculate fitness
%function (there are to be multiple versions for this function):


    %RUN ON AVG VALUE:
 
    fitness = colorImageAverageValuesFitness(population,targetImage);

    %RUN ON DIFF
    %fitness = imageDiffFitness(population,targetImage);
    
    %RUN ON BASIC: 
    %fitness = colorImageBasicFitness(population,targetImage);
    
    %find the indices of the maximum fitness 
    maxFitnessVec = find(max(fitness) == fitness);

    %store the max fitness for the generation; 'maxFitnessVec(1,1) is used
    %because there may be multiple organisms with the same best fitness, so
    %it doesn not matter which of these best organisms is selected to use
    %for bestFitness
    maxFitness(1,generation) = fitness(maxFitnessVec(1,1));
    
    %store the average fitness for the generation
    avgFitness(1,generation) = sum(fitness) / length(fitness);
    
    %store the genetic diversity (max fitness - avg fitness) for the
    %generation
    geneticDiversity(1,generation) = maxFitness(1,generation) - ...
        avgFitness(1,generation);
    
    %store the best image out of the generation: 
    bestImage{generation,1} = population{maxFitnessVec(1,1),1};  
 
    %Build the mating pool needed to create the next generation with the 
    %indices of which parents are to be bred: 

    matingPool = colorImageBuildMatingPool(population,fitness,targetImage);
    
    %Store the dimensions of the target image with the variables row, col,
    %and pg: 
    [row,col,pg] = size(targetImage);
    
    %pre-allocate the cell vector that will be used to store the "new
    %population" that will be bred from the previous generation: 
   % newPopulation = cell((row*col),1);
    
    
    %FIRST VERSION OF THE BREEDING PROCESS: 
                        %This loop is used to create the new population:  
                        % for i = 1:(row*col)
                        %    
                        %     %New children are bred one at a time. Start by storing the organisms in
                        %     %the mating pool that will serve as the child's parents: 
                        %     parent1 = population{matingPool(i,1)};
                        %     parent2 = population{matingPool(i,2)};
                        %     
                        %     %Breed the child: 
                        %     newPopulation{i,1} = imageBreed(parent1,parent2,targetImage);
    
                        
     %UPDATED, MIGHT BE FASTER
  newPopulation = colorImageBreed(matingPool,targetImage,population); 
    %A Loop is then used to cause mutation
    for i = 1:(row*col)
    %Cause mutation (Currently this works with the improved mutation function:)
   
    newPopulation{i,1} = colorImageImprovedCauseMutation(newPopulation{i,1}); 
  
    %Replace the old population with the new population one child at a
    %time: 
       population{i,1} = newPopulation{i,1}; 
    end 
    
    %increment the generation number when the new population has been
    %formed
    generation = generation + 1;
    generation-1
   

end
%while loop will finally terminate when the target image is produced. 

toc; 
%(Cut timer for determining how long the image evolution process took in total). 

figure
%Plot avg. fitness over the generations: 
subplot(1,3,1); 
plot([1:generation-1],avgFitness(1:generation-1),'r');
title('Generation vs. Avg. Fitness'); 
xticks(0:300:maxGenerations); 
yticks(0:.1:1); 
xlabel('Generation'); 
ylabel('Avg. Fit.'); 

%Plot max. fitness over the generations: 
subplot(1,3,2); 
plot([1:generation-1],maxFitness(1:generation-1),'b');
title('Generation vs. Max. Fitness'); 
xticks(0:300:maxGenerations); 
yticks(0:.1:1);
xlabel('Generation'); 
ylabel('Max. Fit.'); 

%Display the last image that was produced. 
subplot(1,3,3);
imshow(bestImage{generation-1,1}); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PSUDO LEFTOVERS: 

%Using the command window, once the target image has been reached print the
%generation number, the current maximum fitness, and the current 
%average fitness of the population to the screen. .

% fprintf('Current generation number: %d',c); 
% fprintf('Current maximum fitness: %f',bestFitnessVec(c));
% fprintf('Average current population fitness: %f',averageFitnessVec(c)); 

%Final tasks to be completed once the target organism is found:

%plot a sample of the the 9 maximum fitness members from evenly spaced
%generations. This will be accompished using subplot. 

%Save the maximum fitness organism to an image file.

%save the max fitness, avg fitness, and genetic diversity vectors to a txt
%file. This will incorperate the same process we use in the string example
%at a larger scale.