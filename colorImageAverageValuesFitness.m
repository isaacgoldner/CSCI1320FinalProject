function fitness = imageAverageValuesFitness(population,targetImage)

%use the mean filter function to generate a "smoothed" version of the
%original and target image, then with a similar tolerance value as before, 
%compare each pixel to generate the fitness value for each "organism"

%get the sizes of the images that we are calculating the fitnesses of
[row,col,page] = size(targetImage);

%Take the layers of the target image: 
targetImageR = targetImage(:,:,1)  ;
targetImageG = targetImage(:,:,2)  ;
targetImageB = targetImage(:,:,3)  ;

%indices of pixels to take the average of
%at this stage the vector includes the indices of the top row and bottom
%row of the image, which will be deleted in the next step as we do not want
%those outside pixels in the mean filter calculation
x = [row+2:(row * col) - row - 1];

%bottom row and top row of the image not indluded in the indices vector;
%gets rid of edge cases
discludeFromXIndices = find(mod(x,row) == 0);
x(discludeFromXIndices) = [];
discludeFromXIndices = find(mod(x,row) == 1);
x(discludeFromXIndices) = [];

%indices of surrounding pixels for the average calculation
topLeft = x - row - 1;
middleLeft = x - row;
bottomLeft = x - row + 1;
topCenter = x - 1;
center = x;
bottomCenter = x + 1;
topRight = x + row - 1;
middleRight = x + row;
bottomRight = x + row + 1;

%smooth the target image, one color layer at a time, by taking the average of all of the surrounding
%pixels
%Red
smoothedTargetOrganismR = (targetImageR(topLeft) + targetImageR(middleLeft) + ...
        targetImageR(bottomLeft) + targetImageR(topCenter) + targetImageR(center) + ...
        targetImageR(bottomCenter) + targetImageR(topRight) + targetImageR(middleRight) + ...
        targetImageR(bottomRight)) / 9;
 %Green
 smoothedTargetOrganismG = (targetImageG(topLeft) + targetImageG(middleLeft) + ...
        targetImageG(bottomLeft) + targetImageG(topCenter) + targetImageG(center) + ...
        targetImageG(bottomCenter) + targetImageG(topRight) + targetImageG(middleRight) + ...
        targetImageG(bottomRight)) / 9;
 %Blue
 smoothedTargetOrganismB = (targetImageB(topLeft) + targetImageB(middleLeft) + ...
        targetImageB(bottomLeft) + targetImageB(topCenter) + targetImageB(center) + ...
        targetImageB(bottomCenter) + targetImageB(topRight) + targetImageB(middleRight) + ...
        targetImageB(bottomRight)) / 9;
    
    
%reshape the 'smoothedTargetOrganism' color layers back into the dimensions of the
%target image's color layers; the previous step converts the matrices into row vectors, so
%this step reverses that process
%Red
smoothedTargetOrganismR = reshape(smoothedTargetOrganismR,row-2,col-2);
%Green
smoothedTargetOrganismG = reshape(smoothedTargetOrganismG,row-2,col-2);
%Blue
smoothedTargetOrganismB = reshape(smoothedTargetOrganismB,row-2,col-2);

%Combine the smoothed target organism's layers back together. 

smoothedTargetOrganism(:,:,1) = smoothedTargetOrganismR; 
smoothedTargetOrganism(:,:,2) = smoothedTargetOrganismG; 
smoothedTargetOrganism(:,:,3) = smoothedTargetOrganismB; 

%pre-allocate the size of the fitness vector that will be returned. One
%element per organism: 
fitness = zeros(row*col,1);
tolerance = .05;

%this loop is not used in the mean value calculation, it is only used to
%cover each of the organisms in the population;
%the values of the iterator variable are not used at all in the actual mean
%value calculation
for i = 1:row*col
    
    %store the value of a single organism in variable 'currentOrganism'
    currentOrganism = population{i,1};
    
    %Take the layers of the current organism: 
    currentOrganismR = currentOrganism(:,:,1)  ;
    currentOrganismG = currentOrganism(:,:,2)  ;
    currentOrganismB = currentOrganism(:,:,3)  ;
    
    %Apply the same smoothing process with the current organism used with
    %the target image: 
    
    %smooth the current organism, one color layer at a time, by taking the average of all of the surrounding
%pixels
%Red
smoothedcurrentOrganismR = (currentOrganismR(topLeft) + currentOrganismR(middleLeft) + ...
        currentOrganismR(bottomLeft) + currentOrganismR(topCenter) + currentOrganismR(center) + ...
        currentOrganismR(bottomCenter) + currentOrganismR(topRight) + currentOrganismR(middleRight) + ...
        currentOrganismR(bottomRight)) / 9;
 %Green
 smoothedcurrentOrganismG = (currentOrganismG(topLeft) + currentOrganismG(middleLeft) + ...
        currentOrganismG(bottomLeft) + currentOrganismG(topCenter) + currentOrganismG(center) + ...
        currentOrganismG(bottomCenter) + currentOrganismG(topRight) + currentOrganismG(middleRight) + ...
        currentOrganismG(bottomRight)) / 9;
 %Blue
 smoothedcurrentOrganismB = (currentOrganismB(topLeft) + currentOrganismB(middleLeft) + ...
        currentOrganismB(bottomLeft) + currentOrganismB(topCenter) +currentOrganismB(center) + ...
        currentOrganismB(bottomCenter) + currentOrganismB(topRight) + currentOrganismB(middleRight) + ...
        currentOrganismB(bottomRight)) / 9;
       
%reshape the 'smoothedcurrentOrganism' color layers back into the dimensions of the
%organism's color layers; the previous step converts the matrices into row vectors, so
%this step reverses that process
%Red
smoothedcurrentOrganismR = reshape(smoothedcurrentOrganismR,row-2,col-2);
%Green
smoothedcurrentOrganismG = reshape(smoothedcurrentOrganismG,row-2,col-2);
%Blue
smoothedcurrentOrganismB = reshape(smoothedcurrentOrganismB,row-2,col-2);

%Combine the smoothed target organism's layers back together. 

smoothedcurrentOrganism(:,:,1) = smoothedcurrentOrganismR; 
smoothedcurrentOrganism(:,:,2) = smoothedcurrentOrganismG; 
smoothedcurrentOrganism(:,:,3) = smoothedcurrentOrganismB; 
    
  
    
    %find the indices of the 'smoothedCurrentOrganism' that are within the
    %specified range of the target image; these indices are used in the
    %final fitness calculation
    indicesWithinRange = find(abs(smoothedcurrentOrganism - smoothedTargetOrganism) <= tolerance);
    
    %find the number of pixels in 'smoothedCurrentImage' that are within
    %the specified range to be used in the final fitness calculation
    numIndicesWithinRange = length(indicesWithinRange);
    
    %divide the calculated fitness value by the total number of pixels in
    %the target image to express the fitness as a percentage
    fitness(i,1) = numIndicesWithinRange / (3*(((row * col) - (2*row) - (2*row - 4))));
    
end


end 
