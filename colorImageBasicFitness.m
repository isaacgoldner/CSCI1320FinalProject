function fitness = colorImageBasicFitness(population,targetImage)
   

%Take the size of the target image: 
[row,col,page] = size(targetImage);

%Set the fitness tolerance: 
tolerance = 0.05;  

%Preallocate the fitness vector: 
fitness = zeros(row*col,1);

%Run this loop for every member of the population: 
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
    
   %Record the differences between the color layers of the current organism
   %and the target organism. 
   Rdiff = abs(currentOrganismR - targetOrganismR); 
   Gdiff = abs(currentOrganismG - targetOrganismG);
   Bdiff = abs(currentOrganismB - targetOrganismB); 
   
   %1: Process using  NO loops: 
   
   %Create a row*col matrix called ColorFit, where each element represents
   %a pixel in the image. If the element is 3, the RGB layers are all
   %within the set tolerance value. 
   ColorFit = (Rdiff <= tolerance) + (Bdiff <= tolerance) + (Gdiff <= tolerance); 
   
   %Record the number of pixels that are within the tolerance range for all
   %three of their color layers: 
   numPixelsWithinRange = length(ColorFit == 3); 
   
    %divide the number of fit pixels by the total number of pixels in
    %the target image to express the image's fitness as a percentage: 
    fitness(i,1) = numPixelsWithinRange / (row * col);
   
   end 
   
end 

%    %2: Backup Process using loops: 
%    
%    %Initialize the number of pixels that are considered "fit" to be 0.  
%    PixelsWithinTol = 0; 
%    %Set the fitness tolerance: 
%    tolerance = 0.05;  
%    
%    %Run this loop to find out how many pixels in the image are fit. 
%    for i = 1:row*col
%        if (Rdiff(i) <= tolerance) && (Bdiff(i) <= tolerance) && (Gdiff(i) <= tolerance); 
%            PixelsWithinTol =  PixelsWithinTol + 1; 
%        end 
%        
%    end 
%    
%    %Save the number of pixels that are considered fit in the organism. 
%     numPixelsWithinRange = length(PixelsWithinTol);
%     
%     %divide the calculated fitness value by the total number of pixels in
%     %the target image to express the image's fitness as a percentage: 
%     fitness(i,1) = numPixelsWithinRange / (row * col);