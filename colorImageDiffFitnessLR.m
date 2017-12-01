function fitness = colorImageDiffFitnessLR(population,targetImage,maxFitness);


%function fitness = colorImageDiffFitness2(population,targetImage,generation,maxFitness);

%Using the target image: 
%For each direction of comparison (up/down and left/right)
%a matrix that captures the rate of change beween pixels. Turn these
%matrices into vectors for ease of comparison later in the function:

%Divide the target image into layerss:

%get the sizes of the images that we are calculating the fitnesses of: 
[row,col,page] = size(targetImage);

%Take the layers of the target image: 
targetImageR = targetImage(:,:,1);
targetImageG = targetImage(:,:,2);
targetImageB = targetImage(:,:,3);

%Use the Diff function to record the left to right differences in the
%target image's values for each of its color layers: 

TargetLRR = diff(targetImageR,1,2);   
TargetLRG = diff(targetImageG,1,2); 
TargetLRB = diff(targetImageB,1,2); 

%pre-allocate the size of the fitness vector that will be returned. One
%element per organism: 
fitness = zeros(row*col,1);

%Set the tolerance for fitness: 
tolerance = (1-(maxFitness)) * .3;

if tolerance < .02
   tolerance = .02; 
end  

%tolerance =(  (1- maxFitness(generation)) * .05); 


%Run the following loop for every pixel of the population: 
for i = 1:row*col
    
    %store the value of a single organism in variable 'currentOrganism'
    currentOrganism = population{i,1};
    
    %Take the RGB layers of the current organism: 
    currentOrganismR = currentOrganism(:,:,1);
    currentOrganismG = currentOrganism(:,:,2);
    currentOrganismB = currentOrganism(:,:,3);
    
    %Use the Diff function to record the left to right differences in the
    %target image's values for each of its color layers: 

    CurrentLRR = diff(currentOrganismR,1,2);   
    CurrentLRG = diff(currentOrganismG,1,2); 
    CurrentLRB = diff(currentOrganismB,1,2); 
    
    %Record the differences between the diff function values for the target
    %image and the current organism: 
    
    %Left to right diff values: 
    RLRCompare = abs(TargetLRR - CurrentLRR); 
    GLRCompare = abs(TargetLRG - CurrentLRG); 
    BLRCompare = abs(TargetLRB - CurrentLRB); 

%LRAccept records the number of diff values in each layer of the current
%organism that are within the tolerance value of the diff values for each
%layer of the target organism (For left to right difference): 
      
    LRAccept = (RLRCompare <= tolerance) + (GLRCompare <= tolerance) + ...
        (BLRCompare <= tolerance);

   %Record the total number of pixels in the current organism have diff
   %values, left to right, that are within the set
   %tolerance of the diff values from the target image for
   %TWO OR MORE COLOR LAYERS: 
   
   %THE ABOVE LINE CHANGES. 
   
   numPixelsWithinLRRange = sum(sum(LRAccept >= 2));
    
  %Save the fitness of the current organism as the total number of pixels
  %within the LR diff tolerance range and the UD diff tolerance range
  %divided by the total number of diff values possible for LR and UD to
  %express the fitness values as a percent. 
   
   fitness(i,1) = (numPixelsWithinLRRange) /((row-1)*(col)); 
    



end 