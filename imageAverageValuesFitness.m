function fitness = imageAverageValuesFitness(population)

%use the mean filter function to generate a "smoothed" version of the
%original and target image, then with a similar tolerance value as before, 
%compare each pixel to generate the fitness value for each "organism"

%get the size of the images that we are calculating the fitnesses of
[row,col] = size(population{1,1});

%indices of pixels to take the average of
%at this stage the vector includes the indices of the top row and bottom
%row of the image, which will be discluded in the next step
x = [row+2:(row * col) - row - 1];

%bottom row and top row of the image discluded from the indices vector
%discluding edge cases
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

%this loop is not used in the mean value calculation, it is only used to
%cover each of the organisms in the population
%the values of the iterator variable are not used at all in the actual mean
%value calculation
for i = 1:row*col

    currentOrganism = population{i,1};
    
    smoothedCurrentOrganism = (currentOrganism(topLeft) + currentOrganism(middleLeft) + ...
        currentOrganism(bottomLeft) + currentOrganism(topCenter) + ...
        currentOrganism(center) + currentOrganism(bottomCenter) + ...
        currentOrganism(topRight) + currentOrganism(middleRight) + ...
        currentOrganism(bottomRight)) / 9;
    
    smoothedCurrentOrganism = reshape(smoothedCurrentOrganism,row-2,col-2);
    
    
    
end

