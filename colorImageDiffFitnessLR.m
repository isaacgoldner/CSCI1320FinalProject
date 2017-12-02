function fitness = colorImageDiffFitnessLR(population,targetImage,maxFitness);
%Using the target image: 
%For each direction of comparison (up/down and left/right)
%a matrix that captures the rate of change beween pixels. Turn these
%matrices into vectors for ease of comparison later in the function:

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

%Set the tolerance for fitness. Don't let fitness go below .05
tolerance = (1-(maxFitness)) * .3;
if tolerance < .05
   tolerance = .05; 
end  

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

    %Record the differences between the color layers of the current organism
    %and the target organism. 
    Rdiff = abs(CurrentLRR - TargetLRR); 
    Gdiff = abs(CurrentLRG - TargetLRG);
    Bdiff = abs(CurrentLRB - TargetLRB); 

    %create matrix of the same size as the target image with each element
    %containing the number of its index
    pixels = [1:(row*col)];
    pixels = reshape(pixels,row,col);

    %pre-allocate the size of the matrices for each of the red, green, and
    %blue layer comparisons
    matR = zeros(1,(row*col));
    matG = zeros(1,(row*col));
    matB = zeros(1,(row*col));

    %logical vector of the indices of red layer that fall
    %within the tolerance level
    rWithin = Rdiff <= tolerance;
    %indices of the pixels that fall within the tolerance level
    rIndicesWithin = pixels(rWithin);
    %set the indices of the red layer comparison matrix that fall within
    %the tolerance to 1, with the pixels that do not fall within the range
    %set to 0
    matR(rIndicesWithin) = 1;

    %logical vector of the indices of green layer that fall
    %within the tolerance level
    gWithin = Gdiff <= tolerance;
    %indices of the pixels that fall within the tolerance level
    gIndicesWithin = pixels(gWithin);
    %set the indices of the green layer comparison matrix that fall within
    %the tolerance to 1, with the pixels that do not fall within the range
    %set to 0
    matG(gIndicesWithin) = 1;

    %logical vector of the indices of blue layer that fall
    %within the tolerance level
    bWithin = Bdiff <= tolerance;
    %indices of the pixels that fall within the tolerance level
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
    diffR = abs(CurrentLRR(withinTolerance) - TargetLRR(withinTolerance));
    diffG = abs(CurrentLRG(withinTolerance) - TargetLRG(withinTolerance));
    diffB = abs(CurrentLRB(withinTolerance) - TargetLRB(withinTolerance));

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
    fitness(i,1) = totalDiff / (row * (col-1));
       
end 