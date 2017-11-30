function fitness = colorImageBasicFitness(population,targetImage)
    
[row,col,page] = size(targetImage);
   for i = 1:row*col
    
    %store the value of a single organism in variable 'currentOrganism'
    currentOrganism = population{i,1};
    
    %Take each of the target organism's layers: 
    targetOrganismR = targetImage(:,:,1);
    targetOrganismG = targetImage(:,:,2);
    targetOrganismB = targetImage(:,:,3);
    
    
   %Take each of the current organism's layers: 
   currentOrganismR = currentOrganism(:,:,1); 
   currentOrganismG = currentOrganism(:,:,2);
   currentOrganismB = currentOrganism(:,:,3);
    
   Rdiff = abs(currentOrganismR - targetOrganismR); 
   Gdiff = abs(currentOrganismG - targetOrganismG);
   Bdiff = abs(currentOrganismB - targetOrganismB); 
    
   indicesWithinRange = 0; 
   tolerance = 0.05;  
   for i = 1:row*col
       if (Rdiff(i) <= tolerance) && (Bdiff(i) <= tolerance) && (Gdiff(i) <= tolerance); 
           indicesWithinRange =  indicesWithinRange + 1; 
       end 
       
   end 
   
    numIndicesWithinRange = length(indicesWithinRange);
    
    %divide the calculated fitness value by the total number of pixels in
    %the target image to express the fitness as a percentage
    fitness(i,1) = numIndicesWithinRange / (row * col);
    
end
