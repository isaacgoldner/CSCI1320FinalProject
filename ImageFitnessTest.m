function fitness = ImageFitnessTest(population,targetImage)
    
[row,col] = size(targetImage);
   for i = 1:row*col
    
    %store the value of a single organism in variable 'currentOrganism'
    currentOrganism = population{i,1};
    
   
    indicesWithinRange = find(abs(currentOrganism - targetImage) <= 0.3);
    
    %find the number of pixels in 'smoothedCurrentImage' that are within
    %the specified range to be used in the final fitness calculation
    numIndicesWithinRange = length(indicesWithinRange);
    
    %divide the calculated fitness value by the total number of pixels in
    %the target image to express the fitness as a percentage
    fitness(i,1) = numIndicesWithinRange / (row * col);
    
end


