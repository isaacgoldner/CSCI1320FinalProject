function fitness = imageAverageValuesFitness(population,targetImage)

%use the mean filter function to generate a "smoothed" version of the
%original and target image, then with a similar tolerance value as before, 
%compare each pixel to generate the fitness value for each "organism"

%get the size of the images that we are calculating the fitnesses of
[row,col] = size(targetImage);

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

%type-cast the target image to type double in order to have the ability to
%calculate the averages (not possible while in type uint8)
smoothedTargetOrganism = double(targetImage);

%smooth the target image by taking the average of all of the surrounding
%pixels
smoothedTargetOrganism = (targetImage(topLeft) + targetImage(middleLeft) + ...
        targetImage(bottomLeft) + targetImage(topCenter) + targetImage(center) + ...
        targetImage(bottomCenter) + targetImage(topRight) + targetImage(middleRight) + ...
        targetImage(bottomRight)) / 9;

%reshape the 'smoothedTargetOrganism' back into the dimensions of the
%target image; the previous step converts the matrix into a row vector, so
%this step reverses that process
smoothedTargetOrganism = reshape(smoothedTargetOrganism,row-2,col-2);

%pre-allocate the size of the fitness vector that will be returned
fitness = zeros(row*col,1);

%this loop is not used in the mean value calculation, it is only used to
%cover each of the organisms in the population;
%the values of the iterator variable are not used at all in the actual mean
%value calculation
for i = 1:row*col
    
    %store the value of a single organism in variable 'currentOrganism'
    currentOrganism = population{i,1};
    
    %smooth the 'currentOrganism' with the mean filter algorithm; this step
    %converts the matrix into a row vector in the process
    smoothedCurrentOrganism = (currentOrganism(topLeft) + currentOrganism(middleLeft) + ...
        currentOrganism(bottomLeft) + currentOrganism(topCenter) + ...
        currentOrganism(center) + currentOrganism(bottomCenter) + ...
        currentOrganism(topRight) + currentOrganism(middleRight) + ...
        currentOrganism(bottomRight)) / 9;
    
    %reshape the 'smoothedCurrentOrganism' back into the dimensions of the
    %target image
    smoothedCurrentOrganism = reshape(smoothedCurrentOrganism,row-2,col-2);
    
    %find the indices of the 'smoothedCurrentOrganism' that are within the
    %specified range of the target image; these indices are used in the
    %final fitness calculation
    indicesWithinRange = find(abs(smoothedCurrentOrganism - smoothedTargetOrganism) <= 0.1);
    
    %find the number of pixels in 'smoothedCurrentImage' that are within
    %the specified range to be used in the final fitness calculation
    numIndicesWithinRange = length(indicesWithinRange);
    
    %divide the calculated fitness value by the total number of pixels in
    %the target image to express the fitness as a percentage
    fitness(i,1) = numIndicesWithinRange / (row * col);
    
end

