%script to generate the target image

%define the target image

%call the function to generate the initial random population
imagePopulation = imageBuildPopulation(targetImage); 

%Start timer to determine how long the evolution process will take: 
tic;

%C is used to indicate how a generator counter might be implemented: 
c = 1; 
while %the target image has yet to occur as an organism in the generated 
    %populations:

    %Calculate the fitness of each organism with the calculate fitness
    %function (there are to be multiple versions for this function):
    fitness = imageBasicCalculateFitness(ImagePopulation);
    %SECOND VERSION:
    fitness = imageDiffFitness(ImgePopulation); 


    %create the mating pool by calling the build mating pool function: 
    matingPool = imageBuildMatingPool(imagePopulation,fitness); 

    
    %breed a new population of children from the mating pool by calling the
    %imageBreed function: 
    children = imageBreed(matingPool); 
    
    %randomly mutate members of the new population of the children by
    %calling the ImageBasicCauseMutation function. Note that this mutation
    %process is also performed using the imageImprovedCauseMutation
    %function: 
    mutatedChildren = imageBasicCauseMutation(children); 
   %SECOND OPTION: 
    mutatedChildren = imageImprovedCauseMutation(children); 
    
    
    %Set the next generation to be the population of children including
    %those now mutated: 
    ImagePopulation = mutatedChildren;
    
    %Save the max fitness, avg fitness, and genetic diversity for the
    %current generation: 
    maxFitness = 2;
    averageFitness = 1;
    GeneticDiversity = bestFitness - averageFitness;
    
    %Record required information for each generation created using vectors:
    maxFitnessVec[1,c] = maxFitness;
    averageFitnessVec[1,c] = averageFitness;
    GeneticDiversityVec[1,c] = GeneticDiversity;
    
    %increase generation iterator: 
    c = c + 1; 
end
%while loop will finally terminate when the target image is produced. 

toc
%(Cut timer for determining how long the image process took in total). 


%Using the command window, once the target image has been reached print the
%generation number, the current maximum fitness, and the current 
%average fitness of the population to the screen. .

fprintf('Current generation number: %d',c); 
fprintf('Current maximum fitness: %f',bestFitnessVec(c));
fprintf('Average current population fitness: %f',averageFitnessVec(c)); 

%Final tasks to be completed once the target organism is found:

%plot a sample of the the 9 maximum fitness members from evenly spaced
%generations. This will be accompished using subplot. 

%Save the maximum fitness organism to an image file.

%save the max fitness, avg fitness, and genetic diversity vectors to a txt
%file. This will incorperate the same process we use in the string example
%at a larger scale.