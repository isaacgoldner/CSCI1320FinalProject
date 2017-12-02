function fitness = colorImageBasicFitness(population,targetImage,maxFitness)
%Basic fitness calculation function. Calculates fitness through a direct 
%comparison of pixels of organism to target image.

%Take the size of the target image 
[row,col,page] = size(targetImage);

%Set the fitness tolerance. Tolerance lowers as max fitness increases. Max
%possible tolerance being 0.3. Don't let the tolerance go below 0.1
tolerance = (1-(maxFitness)) * .3;
if tolerance < .1
   tolerance = .1; 
end

%Preallocate the size of the fitness vector
fitness = zeros(row*col,1);

%Separate each of the target organism's layers 
targetOrganismR = targetImage(:,:,1);
targetOrganismG = targetImage(:,:,2);
targetOrganismB = targetImage(:,:,3);

%Run this loop for every member of the population: 
for i = 1:row*col

    %store the value of a single organism in variable 'currentOrganism'
    currentOrganism = population{i,1};

    %Separate each of the current organism's layers 
    currentOrganismR = currentOrganism(:,:,1); 
    currentOrganismG = currentOrganism(:,:,2);
    currentOrganismB = currentOrganism(:,:,3);

    %Record the differences between the color layers of the current organism
    %and the target organism and take the absolute value of this calculation 
    Rdiff = abs(currentOrganismR - targetOrganismR); 
    Gdiff = abs(currentOrganismG - targetOrganismG);
    Bdiff = abs(currentOrganismB - targetOrganismB);

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
    diffR = abs(currentOrganismR(withinTolerance) - targetOrganismR(withinTolerance));
    diffG = abs(currentOrganismG(withinTolerance) - targetOrganismG(withinTolerance));
    diffB = abs(currentOrganismB(withinTolerance) - targetOrganismB(withinTolerance));

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
    fitness(i,1) = totalDiff / (row * col);
    
    end 

end 