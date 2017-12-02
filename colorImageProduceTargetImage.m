%Script used to run the image evolution process in color: 

%Read in the desired target image, save it as targetImage: 
targetImage = imread('25x25angry.png');

%Convert the image to type double and have intensity values range from 0 to 1. 
targetImage = double(targetImage); 
targetImage = targetImage ./ 255; 

%Build the randomly generated starting population
population = colorImageBuildPopulation(targetImage);

%specify the maximum number of generations that will be run through
maxGenerations = 500;

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

%'c' is used as a counter variable throughout the loop in order to pass
%certain values of each of the data vectors to the fitness functions
c = 2;

%Start timer to determine how long the evolution process will take: 
tic; 

%continue this main loop until the maximum generations has been reached or
%the target image has been produced
while (generation ~= maxGenerations+1) && (~ismember(1,maxFitness))

    %Calculate the fitness of each organism with the calculate fitness function
    fitnessBasic = colorImageBasicFitness(population,targetImage,maxFitness(1,c-1));
    fitnessAvgValues = colorImageAverageValuesFitness(population,targetImage,maxFitness(1,c-1));
    fitnessDiffUD = colorImageDiffFitnessUD(population,targetImage,maxFitness(1,c-1));
    fitnessDiffLR = colorImageDiffFitnessLR(population,targetImage,maxFitness(1,c-1));
    
    %add the fitness values in quadrature and divide by two so that a
    %fitness of 1 is considered perfectly "fit"
    fitness = sqrt((fitnessBasic.^2) + (fitnessAvgValues.^2) + (fitnessDiffUD.^2) + ...
    (fitnessDiffLR.^2)) / 2;
    %fitness = fitnessBasic;
    
    %find the indices of the maximum fitness 
    maxFitnessVec = find(max(fitness) == fitness);

    %store the max fitness for the generation; 'maxFitnessVec(1,1)' is used
    %because there may be multiple organisms with the same best fitness, so
    %it doesn not matter which of these best organisms is selected to use
    %for bestFitness
    maxFitness(1,generation) = fitness(maxFitnessVec(1,1)) / 2;

    %store the average fitness for the generation
    avgFitness(1,generation) = (sum(fitness) / length(fitness)) / 2;

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
    
    %build the new population from the mating pool with the breed function
    newPopulation = colorImageBreed(matingPool,targetImage,population);
    
    %loop is used to cause mutation in each of the organisms of the new
    %populatiomn
    for i = 1:(row*col)
    
        %Cause mutation for the specific organism of the new population
        newPopulation{i,1} = colorImageImprovedCauseMutation(newPopulation{i,1},maxFitness(c-1)); 

        %Replace the old population with the new population one child at a
        %time
        population{i,1} = newPopulation{i,1}; 
        
    end 

%print out the current generation number, max fitness, and average fitness
fprintf('Generation number: %d; Current max fitness: %f; Current avg fitness: %f\n',...
generation,maxFitness(1,generation),avgFitness(1,generation));

%increment the generation number when the new population has been formed
generation = generation + 1;

%increment the c iterator variable
c = c + 1;

end
%Cut timer for determining how long the image evolution process took in total 
toc; 

%create a new figure and using the subplot function plot 9 evenly spaced
%best images out of the total number of generations:
figure
subplot(3,3,1);
imshow(bestImage{1,1});
title('1');

subplot(3,3,2);
imshow(bestImage{round(generation / 9),1});
title(round((generation / 9)));

subplot(3,3,3);
imshow(bestImage{round((generation / 9) * 2),1});
title(round((generation / 9) * 2));

subplot(3,3,4);
imshow(bestImage{round((generation / 9) * 3),1});
title(round((generation / 9) * 3));

subplot(3,3,5);
imshow(bestImage{round((generation / 9) * 4),1});
title(round((generation / 9) * 4));

subplot(3,3,6);
imshow(bestImage{round((generation / 9) * 5),1});
title(round((generation / 9) * 5));

subplot(3,3,7);
imshow(bestImage{round((generation / 9) * 6),1});
title(round((generation / 9) * 6));

subplot(3,3,8);
imshow(bestImage{round((generation / 9) * 7),1});
title(round((generation / 9) * 7));

subplot(3,3,9);
imshow(bestImage{generation - 1,1});
title(generation - 1);

%Save the image with the heighest fitness created in the entire evolution
%process to an image file. 

%Determine which one of the images in bestImage has the best fitness
%reached in the entire process: 
bestImageIndex = find(maxFitness == max(maxFitness)); 

%Save the best overall image to bestOverallImage:
bestOverallImage = bestImage{bestImageIndex(1,1)}; 

%Save the best overall image to jpeg file: 
imwrite(bestOverallImage,'bestOverallImage.jpg');
 

% %Save the average fitness, max. fitness, and genetic diversity of each
% %generation to a text file. 
% fileID = fopen('ImageEvolutionResults.txt','w');
% fprintf(fileID,'Generation                   Max. Fitness    Avg. Fitness   Gen. Diversity\r\n');
% fprintf(fileID,'%5d                %.5f          %.5f          %.4f\r\n',TableCreator{:});
% fclose(fileID);



%Establish the vectors needed for the printing process: 
GenerationsForTxt = num2cell(1:generation-1);  
MaxFit = num2cell(maxFitness(1:generation-1));
AvgFit = num2cell(avgFitness(1:generation-1));
GenDiv = num2cell(geneticDiversity(1:generation-1));
%Table Creator is the cell array actually iterated though to make the
%"table" that will appear in the text file.

%Note that one column of TableCreator stores all of the necessary data from
%a single generation. 
TableCreator = [GenerationsForTxt; MaxFit; AvgFit; GenDiv]; 

%The following commands save the data to the text file in a clear format: 
fileID = fopen('ImageEvolutionResults.txt','w');
fprintf(fileID,'Generation   Max. Fitness   Avg. Fitness   Gen. Diversity\r\n');
fprintf(fileID,'%5d           %.5f        %.5f       %.5f\r\n',TableCreator{:});
%fclose(fileID);
