function fitness = colorImageAverageValuesFitness(population,targetImage,maxFitness)

%use the mean filter process to generate a "smoothed" version of the
%original and target image, then with a similar tolerance value as before, 
%compare each pixel to generate the fitness value for each "organism"

%get the sizes of the images that we are calculating the fitnesses of
[row,col,page] = size(targetImage);

%Take the layers of the target image: 
targetImageR = targetImage(:,:,1);
targetImageG = targetImage(:,:,2);
targetImageB = targetImage(:,:,3);

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
smoothedTargetOrganismR = double(reshape(smoothedTargetOrganismR,row-2,col-2));
%Green
smoothedTargetOrganismG = double(reshape(smoothedTargetOrganismG,row-2,col-2));
%Blue
smoothedTargetOrganismB = double(reshape(smoothedTargetOrganismB,row-2,col-2));

%pre-allocate the size of the fitness vector that will be returned. One
%element per organism: 
fitness = zeros(row*col,1);

%Set the tolerance for fitness: 
tolerance = (1 - (.5*maxFitness)) * .3;

if tolerance < .02
   tolerance = .02; 
end

%Run the following loop for every member of the population: 
for i = 1:row*col
    
    %store the value of a single organism in variable 'currentOrganism'
    currentOrganism = population{i,1};
    
    %Take the RGB layers of the current organism: 
    currentOrganismR = currentOrganism(:,:,1);
    currentOrganismG = currentOrganism(:,:,2);
    currentOrganismB = currentOrganism(:,:,3);
    
    %Apply the same smoothing process with the current organism used with
    %the target image: 
    
    %smooth the current organism, one color layer at a time, by taking the 
    %average of all of the surrounding pixels:
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
    
  
    %Record the differences between the color layers of the smoothed
    %current organism and the smoothed target organism: 
   Rdiff = abs(smoothedcurrentOrganismR - smoothedTargetOrganismR); 
   Gdiff = abs(smoothedcurrentOrganismG - smoothedTargetOrganismG);
   Bdiff = abs(smoothedcurrentOrganismB - smoothedTargetOrganismB); 
   
  %Process using  NO loops: 
   
   %Create a matrix called ColorFit, where each element represents
   %a pixel in the smoothed image (the edges are cut off). If the element 
   %is 3, the RGB layers are all within the set tolerance value. 
   ColorFit = (Rdiff <= tolerance) + (Bdiff <= tolerance) + (Gdiff <= tolerance); 
   
   %Record the number of pixels that are within the tolerance range for all
   %three of their color layers: 
   numPixelsWithinRange = sum(sum(ColorFit >= 2)); 

%     %divide the number of fit pixels by the total number of pixels in
%     %the target image to express the image's fitness as a percentage: 
%     fitness(i,1) = numPixelsWithinRange / (row * col);

    %divide the number of fit pixels in the smoothed image by the total 
    %number of pixels in the smoothed target image to express the fitness 
    %as a percentage
    fitness(i,1) = numPixelsWithinRange / ((row * col) - (2*row) - (2*row - 4));
    
end


end 
