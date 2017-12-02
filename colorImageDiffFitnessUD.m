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
%decreases, but if tolerance drops below .02 it becomes set at .02.  
tolerance = (1-(.5*maxFitness)) * .3;
if (tolerance < .02)
   tolerance = .02; 
end
% tolerance = .3;
% tolerance = tolerance * .99;

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
   
    %1: Process using  NO loops: 
   
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
   
    %Create vectors for each color layer of the organism's diff matrix that
    %record the difference between the current organism's color layer's 
    %diff value and the target image's color layer's corrisponding diff
    %value for every pixel where the diff value is within tolerance for all
    %three color layers: 
    diffR = abs(CurrentUDR(withinTolerance) - TargetUDR(withinTolerance));
    diffG = abs(CurrentUDG(withinTolerance) - TargetUDG(withinTolerance));
    diffB = abs(CurrentUDB(withinTolerance) - TargetUDB(withinTolerance));
   
    %Record totalDiff as the sum of the three vectors created above: 
    totalDiff = diffR + diffG + diffB;
   
    %Divide totalDiff by
    totalDiff = totalDiff ./ (tolerance * row * col * 3);
   
    
    totalDiff = 1 - totalDiff;
   
    
    totalDiff = sum(sum(totalDiff));
   
    %Assign the final fitness of the organism to be the value 
    fitness(i,1) = totalDiff / ((row-1) * col);
    
   
   
   %SAVED: Original version of the function prior to the addition of the 
   %tolerance algorithm and other minor edits. 
% %     %Record the differences between the diff function values for the target
%     %image and the current organism: 
% 
%     %Up to down diff values: 
%     RUDCompare = abs(TargetUDR - CurrentUDR); 
%     GUDCompare = abs(TargetUDG - CurrentUDG);
%     BUDCompare = abs(TargetUDB - CurrentUDB);
% 
%  %UDAccept records the number of diff values in each layer of the current
% %organism that are within the tolerance value of the diff values for each
% %layer of the target organism (For lup to down difference)
% 
%     UDAccept = (RUDCompare <= tolerance) + ...
%         (GUDCompare <= tolerance) + (BUDCompare <= tolerance); 
%     
%    %Record the total number of pixels in the current organism have diff
%    %values, left to right and up to down, that are within the set
%    %tolerance of the diff values from the target image for
%    %TWO OR MORE COLOR LAYERS: 
%    
%    %THE ABOVE LINE CHANGES. 
%    
%    
%    numPixelsWithinUDRange = sum(sum(UDAccept >= 2));
%     
%    
%   %Save the fitness of the current organism as the total number of pixels
%   %within the LR diff tolerance range and the UD diff tolerance range
%   %divided by the total number of diff values possible for LR and UD to
%   %express the fitness values as a percent. 
%    
%    fitness(i,1) = (numPixelsWithinUDRange) /((row-1)*(col)); 
%     



end 







% function fitness = colorImageDiffFitnessUD(population,targetImage,maxFitness);
% 
% %function fitness = colorImageDiffFitness2(population,targetImage,generation,maxFitness);
% 
% %Using the target image: 
% %For each direction of comparison (up/down and left/right)
% %a matrix that captures the rate of change beween pixels. Turn these
% %matrices into vectors for ease of comparison later in the function:
% 
% %Divide the target image into layerss:
% 
% %get the sizes of the images that we are calculating the fitnesses of: 
% [row,col,page] = size(targetImage);
% 
% %Take the layers of the target image: 
% targetImageR = targetImage(:,:,1);
% targetImageG = targetImage(:,:,2);
% targetImageB = targetImage(:,:,3);
% 
% 
% %Use the Diff function to record the up to down differences in the
% %target image's values for each of its color layers: 
% TargetUDR = diff(targetImageR,1,1);  
% TargetUDG = diff(targetImageG,1,1); 
% TargetUDB = diff(targetImageB,1,1); 
% 
% %pre-allocate the size of the fitness vector that will be returned. One
% %element per organism: 
% fitness = zeros(row*col,1);
% 
% % %Set the tolerance for fitness: 
% tolerance = (1-(maxFitness)) * .3;
% if tolerance < .01
%    tolerance = .01; 
% end
% % tolerance = .3;
% % tolerance = tolerance * .99;
% 
% %tolerance =(  (1- maxFitness(generation)) * .05); 
% 
% 
% %Run the following loop for every pixel of the population: 
% for i = 1:row*col
%     
%     %store the value of a single organism in variable 'currentOrganism'
%     currentOrganism = population{i,1};
%     
%     %Take the RGB layers of the current organism: 
%     currentOrganismR = currentOrganism(:,:,1);
%     currentOrganismG = currentOrganism(:,:,2);
%     currentOrganismB = currentOrganism(:,:,3);
%     
%     %Use the Diff function to record the up to down differences in the
%     %current organism's values for each of its color layers: 
%     CurrentUDR = diff(currentOrganismR,1,1);  
%     CurrentUDG = diff(currentOrganismG,1,1); 
%     CurrentUDB = diff(currentOrganismB,1,1); 
%     
%     %%
%     %Record the differences between the color layers of the current organism
%    %and the target organism. 
%    Rdiff = abs(CurrentUDR - TargetUDR); 
%    Gdiff = abs(CurrentUDG - TargetUDG);
%    Bdiff = abs(CurrentUDB - TargetUDB); 
%    
%    %1: Process using  NO loops: 
%    
%    %create matrix of the same size as the target image with each element
%    %containing the number of its index
%    pixels = [1:(row*col)];
%    pixels = reshape(pixels,row,col);
%    
%    matR = zeros(1,(row*col));
%    matG = zeros(1,(row*col));
%    matB = zeros(1,(row*col));
%    
%    %logical vector of the indices of red layer that fall
%    %within the tolerance level
%    rWithin = Rdiff <= tolerance;
%    %indices of the pixels that fall within the tolerance level
%    rIndicesWithin = pixels(rWithin);
%    matR(rIndicesWithin) = 1;
%    
%    %logical vector of the indices of green layer that fall
%    %within the tolerance level
%    gWithin = Gdiff <= tolerance;
%    %indices of the pixels that fall within the tolerance level
%    gIndicesWithin = pixels(gWithin);
%    matG(gIndicesWithin) = 1;
%    
%    %logical vector of the indices of blue layer that fall
%    %within the tolerance level
%    bWithin = Bdiff <= tolerance;
%    %indices of the pixels that fall within the tolerance level
%    bIndicesWithin = pixels(bWithin);
%    matB(gIndicesWithin) = 1;
%    
%    matTotal = matR + matG + matB;
%    
%    withinTolerance = find(matTotal == 3);
%    
%    diffR = abs(CurrentUDR(withinTolerance) - TargetUDR(withinTolerance));
%    diffG = abs(CurrentUDG(withinTolerance) - TargetUDG(withinTolerance));
%    diffB = abs(CurrentUDB(withinTolerance) - TargetUDB(withinTolerance));
%    
%    totalDiff = diffR + diffG + diffB;
%    
%    totalDiff = totalDiff ./ (tolerance * row * col * 3);
%    
%    totalDiff = 1 - totalDiff;
%    
%    totalDiff = sum(sum(totalDiff));
%    
%    fitness(i,1) = totalDiff / ((row-1) * col);
%     
% % %     %Record the differences between the diff function values for the target
% %     %image and the current organism: 
% % 
% %     %Up to down diff values: 
% %     RUDCompare = abs(TargetUDR - CurrentUDR); 
% %     GUDCompare = abs(TargetUDG - CurrentUDG);
% %     BUDCompare = abs(TargetUDB - CurrentUDB);
% % 
% %  %UDAccept records the number of diff values in each layer of the current
% % %organism that are within the tolerance value of the diff values for each
% % %layer of the target organism (For lup to down difference)
% % 
% %     UDAccept = (RUDCompare <= tolerance) + ...
% %         (GUDCompare <= tolerance) + (BUDCompare <= tolerance); 
% %     
% %    %Record the total number of pixels in the current organism have diff
% %    %values, left to right and up to down, that are within the set
% %    %tolerance of the diff values from the target image for
% %    %TWO OR MORE COLOR LAYERS: 
% %    
% %    %THE ABOVE LINE CHANGES. 
% %    
% %    
% %    numPixelsWithinUDRange = sum(sum(UDAccept >= 2));
% %     
% %    
% %   %Save the fitness of the current organism as the total number of pixels
% %   %within the LR diff tolerance range and the UD diff tolerance range
% %   %divided by the total number of diff values possible for LR and UD to
% %   %express the fitness values as a percent. 
% %    
% %    fitness(i,1) = (numPixelsWithinUDRange) /((row-1)*(col)); 
% %     
% 
% 
% 
% end 