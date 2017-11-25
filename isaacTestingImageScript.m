%NOT the main script
%script to test progress of image functions
%can delete for final

tic

%read in the mona lisa image
image = imread('36x36monalisa.jpg');

%build a random population and also return 'targetImage' which is the black
%and white version of the 'image'
[population,targetImage] = imageBuildPopulation(image);

%calculate the fitness of the random population
fitness = imageAverageValuesFitness(population,targetImage);

%build a mating pool with the indices of which parents are to be bred
matingPool = imageBuildMatingPool(population,fitness,targetImage);

%get the size of the black and white target image
[row,col] = size(targetImage);

%pre-allocate the size of the 'newPopulation' variable which is a cell
%vector
newPopulation = cell((row*col),1);

%loop through the mating pool in order to breed the entire new population
for i = 1:(row*col)
   
    %New children are bred one at a time. Start by storing the organisms in
    %the mating pool that will serve as the child's parents: 
    parent1 = population{matingPool(i,1)};
    parent2 = population{matingPool(i,2)};
    
    %Breed the child: 
    newPopulation{i,1} = imageBreed(parent1,parent2,targetImage);
    
    %Cause mutation (Currently this works with the improved mutation function:)
    newPopulation{i,1} = imageImprovedCauseMutation(newPopulation{i,1}); 
    
    
end



toc