function fitness = colorImageDiffFitnessUD(population,targetImage,maxFitness);
%This function compares the rate of change between pixels in the target
%image's RGB layers and the population members' RGB layers in order to
%produce a fitness value for each member of the population: 

%Take the sizes of the images that we are calculating the fitnesses of: 
[row,col,page] = size(targetImage);

%Take the color layers of the target image: 
targetImageR = targetImage(:,:,1);
targetImageG = targetImage(:,:,2);
targetImageB = targetImage(:,:,3);

%Use the Diff function to record the up to down differences in the
%target image's values for each of its color layers: 
TargetUDR = diff(targetImageR,1,1);  
TargetUDG = diff(targetImageG,1,1); 
TargetUDB = diff(targetImageB,1,1); 

%pre-allocate the size of the fitness vector that will be returned. One
%element per organism: 
fitness = zeros(row*col,1);

%Set the tolerance for fitness using the maxFitness dependent tolerance 
%equation we developed. Tolerance decreases as the maxFitness of the population
%decreases, but if tolerance drops below .05 it becomes set at .05  
tolerance = (1-(.5*maxFitness)) * .3;
if (tolerance < .05)
   tolerance = .05; 
end

%Run the following loop for every pixel of the population: 
for i = 1:row*col
    
    %store the image matrix of a single organism in variable 'currentOrganism'
    currentOrganism = population{i,1};
    
    %Take the RGB layers of the current organism: 
    currentOrganismR = currentOrganism(:,:,1);
    currentOrganismG = currentOrganism(:,:,2);
    currentOrganismB = currentOrganism(:,:,3);
    
    %Use the Diff function to record the up to down differences in the
    %current organism's values for each of its color layers: 
    CurrentUDR = diff(currentOrganismR,1,1);  
    CurrentUDG = diff(currentOrganismG,1,1); 
    CurrentUDB = diff(currentOrganismB,1,1); 
    
    %Record the differences between the color layers of the current organism
    %and the target organism. 
    Rdiff = abs(CurrentUDR - TargetUDR); 
    Gdiff = abs(CurrentUDG - TargetUDG);
    Bdiff = abs(CurrentUDB - TargetUDB); 
      
    %Create a matrix of the same size as the target image with each element
    %containing the number of its index: 
    pixels = [1:(row*col)];
    pixels = reshape(pixels,row,col);
   
    %Preallocate matrices of zeros for each RGB layer in the image. 
    matR = zeros(1,(row*col));
    matG = zeros(1,(row*col));
    matB = zeros(1,(row*col));
   
    %Create a logical vector marking the locations of elements the organism's 
    %red layer that fall within the diff tolerance level: 
    rWithin = Rdiff <= tolerance;
    
    %Assign these "locations" to actual indexes: take the indices of the 
    %pixels that fall within the RED tolerance
    %level: 
    rIndicesWithin = pixels(rWithin);
    
    %Set the elements of the matR matrix representing elements of the
    %organism's red layer within tolerance equal to one:  
    matR(rIndicesWithin) = 1;
   
    %Create a logical vector of the indices of the organism's green layer 
    %that fall within the tolerance level: 
    gWithin = Gdiff <= tolerance;
    %Take the indices of the pixels that fall within the GREEN tolerance
    %level: 
    gIndicesWithin = pixels(gWithin);
    %Set the elements of the matG matrix representing elements of the
    %organism's green layer within tolerance equal to one: 
    matG(gIndicesWithin) = 1;
   
    %Create a logical vector of the indices of the organism's blue layer 
    %that fall within the tolerance level: 
    bWithin = Bdiff <= tolerance;
    %Take the indices of the pixels that fall within the BLUE tolerance
    %level: 
    bIndicesWithin = pixels(bWithin);
    %Set the elements of the matB matrix representing elements of the
    %organism's blue layer within tolerance equal to one:
    matB(gIndicesWithin) = 1;
   
    %Combine matR,G,and B into one matrix. Each element in the matrix
    %ranges from one to three, with each element representing how many RGB
    %layers a given pixel in the population member has within diff tolerance: 
    matTotal = matR + matG + matB;
   
    %Find the total number of pixels the organism has that are within diff
    %tolerance for all three color layers: 
    withinTolerance = find(matTotal == 3);
   
    %calculate the difference for each of the pixels between the current
    %organism and the target image
    diffR = abs(CurrentUDR(withinTolerance) - TargetUDR(withinTolerance));
    diffG = abs(CurrentUDG(withinTolerance) - TargetUDG(withinTolerance));
    diffB = abs(CurrentUDB(withinTolerance) - TargetUDB(withinTolerance));
   
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
   
    %Assign the final fitness of the organism to be the value 
    fitness(i,1) = totalDiff / ((row-1) * col);

end 