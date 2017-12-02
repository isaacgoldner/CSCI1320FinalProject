function fitness = colorImageAverageValuesFitness(population,targetImage,maxFitness)
%Mean filter fitness calculation function. Calculates the fitness by
%"smoothing" both the current organism and the target image and then
%comparing whether the difference of each pixel from current organism to
%target image falls within the specified tolerance value.

%store size of the target image
[row,col,page] = size(targetImage);

%Separate the layers of the target image
targetImageR = targetImage(:,:,1);
targetImageG = targetImage(:,:,2);
targetImageB = targetImage(:,:,3);

%indices of pixels to take the average of;
%at this stage the vector includes the indices of the top row and bottom
%row of the image, which will be deleted in the next step as we do not want
%those outside pixels in the mean filter calculation
x = [row+2:(row * col) - row - 1];

%bottom row and top row of the image not included in the indices vector;
%gets rid of edge cases:
%find the indices of the bottom row
discludeFromXIndices = find(mod(x,row) == 0);
%disclude the indices of the bottom row from the vector
x(discludeFromXIndices) = [];
%find the indices of the top row
discludeFromXIndices = find(mod(x,row) == 1);
%disclude the indices of the top row from the vector
x(discludeFromXIndices) = [];

%indices of surrounding pixels for the average calculation; each of the
%vectors stores the indices of the surrounding pixels of the "inner"
%pixels, of which we take the average of
topLeft = x - row - 1;
middleLeft = x - row;
bottomLeft = x - row + 1;
topCenter = x - 1;
center = x;
bottomCenter = x + 1;
topRight = x + row - 1;
middleRight = x + row;
bottomRight = x + row + 1;

%smooth the target image one color layer at a time by taking the 
%average of all of the surrounding pixels
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
%element per organism
fitness = zeros(row*col,1);

%Set the fitness tolerance. Tolerance lowers as max fitness increases. Max
%possible tolerance being 0.3. Don't let the tolerance go below 0.02.
tolerance = (1 - (maxFitness)) * .2;
if tolerance < .05
   tolerance = .05; 
end
% tolerance = .3;
% tolerance = tolerance * .99;

%Run the following loop for every member of the population 
for i = 1:row*col
    
    %store the value of a single organism in variable 'currentOrganism'
    currentOrganism = population{i,1};

    %Separate the RGB layers of the current organism: 
    currentOrganismR = currentOrganism(:,:,1);
    currentOrganismG = currentOrganism(:,:,2);
    currentOrganismB = currentOrganism(:,:,3);

    %Apply the same smoothing process with the current organism used with
    %the target image: 
    %smooth the current organism, one color layer at a time, by taking the 
    %average of all of the surrounding pixels:
    %Red
    smoothedCurrentOrganismR = (currentOrganismR(topLeft) + currentOrganismR(middleLeft) + ...
        currentOrganismR(bottomLeft) + currentOrganismR(topCenter) + currentOrganismR(center) + ...
        currentOrganismR(bottomCenter) + currentOrganismR(topRight) + currentOrganismR(middleRight) + ...
        currentOrganismR(bottomRight)) / 9;
    %Green
    smoothedCurrentOrganismG = (currentOrganismG(topLeft) + currentOrganismG(middleLeft) + ...
        currentOrganismG(bottomLeft) + currentOrganismG(topCenter) + currentOrganismG(center) + ...
        currentOrganismG(bottomCenter) + currentOrganismG(topRight) + currentOrganismG(middleRight) + ...
        currentOrganismG(bottomRight)) / 9;
    %Blue
    smoothedCurrentOrganismB = (currentOrganismB(topLeft) + currentOrganismB(middleLeft) + ...
        currentOrganismB(bottomLeft) + currentOrganismB(topCenter) +currentOrganismB(center) + ...
        currentOrganismB(bottomCenter) + currentOrganismB(topRight) + currentOrganismB(middleRight) + ...
        currentOrganismB(bottomRight)) / 9;

    %reshape the 'smoothedcurrentOrganism' color layers back into the dimensions of the
    %organism's color layers; the previous step converts the matrices into row vectors, so
    %this step reverses that process
    %Red
    smoothedCurrentOrganismR = reshape(smoothedCurrentOrganismR,row-2,col-2);
    %Green
    smoothedCurrentOrganismG = reshape(smoothedCurrentOrganismG,row-2,col-2);
    %Blue
    smoothedCurrentOrganismB = reshape(smoothedCurrentOrganismB,row-2,col-2);

    %Record the differences between the color layers of the smoothed
    %current organism and the smoothed target organism: 
    Rdiff = abs(smoothedCurrentOrganismR - smoothedTargetOrganismR); 
    Gdiff = abs(smoothedCurrentOrganismG - smoothedTargetOrganismG);
    Bdiff = abs(smoothedCurrentOrganismB - smoothedTargetOrganismB); 

    %create matrix of the same size as the target image with each element
    %containing the number of its index
    pixels = [1:(row*col)];
    pixels = reshape(pixels,row,col);
    
    %pre-allocate the size of the matrices for each of the red, green, and
    %blue layer comparisons
    matR = zeros(1,(row*col));
    matG = zeros(1,(row*col));
    matB = zeros(1,(row*col));

    %create logical vector of the indices of red layer that fall
    %within the tolerance level
    rWithin = Rdiff <= tolerance;
    %store indices of the pixels that fall within the tolerance level
    rIndicesWithin = pixels(rWithin);
    %set the indices of the red layer comparison matrix that fall within
    %the tolerance to 1, with the pixels that do not fall within the range
    %set to 0
    matR(rIndicesWithin) = 1;

    %create logical vector of the indices of green layer that fall
    %within the tolerance level
    gWithin = Gdiff <= tolerance;
    %store indices of the pixels that fall within the tolerance level
    gIndicesWithin = pixels(gWithin);
    %set the indices of the green layer comparison matrix that fall within
    %the tolerance to 1, with the pixels that do not fall within the range
    %set to 0
    matG(gIndicesWithin) = 1;

    %create logical vector of the indices of blue layer that fall
    %within the tolerance level
    bWithin = Bdiff <= tolerance;
    %store indices of the pixels that fall within the tolerance level
    bIndicesWithin = pixels(bWithin);
    %set the indices of the blue layer comparison matrix that fall within
    %the tolerance to 1, with the pixels that do not fall within the range
    %set to 0
    matB(gIndicesWithin) = 1;
    
    %create a single matrix that stores with the sum of each of the indices of the
    %individual red, green, and blue layers
    matTotal = matR + matG + matB;
    
    %find the indices of 'matTotal' that equal 3, meaning that on the
    %current organism each of the individual red, green, and blue layers
    %fall within the tolerance range
    withinTolerance = find(matTotal == 3);
    
    %calculate the difference for each of the pixels between the current
    %organism and the target image
    diffR = abs(smoothedCurrentOrganismR(withinTolerance) - smoothedTargetOrganismR(withinTolerance));
    diffG = abs(smoothedCurrentOrganismG(withinTolerance) - smoothedTargetOrganismG(withinTolerance));
    diffB = abs(smoothedCurrentOrganismB(withinTolerance) - smoothedTargetOrganismB(withinTolerance));

    %store how "off" of the target image each of the pixels of the current
    %organism are by summing how "off" each of the individual red, green,
    %and blue layers are
    totalDiff = diffR + diffG + diffB;
    
    %convert all elements of this matrix to now range between 0 and 1, with
    %0 being the most fit and 1 being the least fit
    totalDiff = totalDiff ./ (tolerance * row * col * 3);

    %flip the values of 'totalDiff' so that 1 represents the maximum
    %possible fitness and 0 represents the minimum possible fitness
    totalDiff = 1 - totalDiff;

    %sum the total of 'totalDiff' so that a value of 255 represents a
    %"totally fit" organism
    totalDiff = sum(sum(totalDiff));

    %store the fitness of the current organism in the matrix 'fitness' with
    %a value of 1 being "totally fit" and a value of 0 being not fit at all
    fitness(i,1) = totalDiff / ((row-2) * (col-2));
    
end


end 
