function fitness = colorImageBasicFitness(population,targetImage,maxFitness)
   

%Take the size of the target image: 
[row,col,page] = size(targetImage);

%Set the fitness tolerance: 
tolerance = (1-(.5*maxFitness)) * .3;

if tolerance < .02
   tolerance = .02; 
end

%Preallocate the fitness vector: 
fitness = zeros(row*col,1);

 %Take each of the target organism's layers: 
    targetOrganismR = targetImage(:,:,1);
    targetOrganismG = targetImage(:,:,2);
    targetOrganismB = targetImage(:,:,3);

%Run this loop for every member of the population: 
   for i = 1:row*col
    
    %store the value of a single organism in variable 'currentOrganism'
    currentOrganism = population{i,1};
    
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
   
   %create matrix of the same size as the target image with each element
   %containing the number of its index
   pixels = [1:(row*col)];
   pixels = reshape(pixels,row,col);
   
   matR = zeros(1,(row*col));
   matG = zeros(1,(row*col));
   matB = zeros(1,(row*col));
   
   %logical vector of the indices of red layer that fall
   %within the tolerance level
   rWithin = Rdiff <= tolerance;
   %indices of the pixels that fall within the tolerance level
   rIndicesWithin = pixels(rWithin);
   matR(rIndicesWithin) = 1;
   
   %logical vector of the indices of green layer that fall
   %within the tolerance level
   gWithin = Gdiff <= tolerance;
   %indices of the pixels that fall within the tolerance level
   gIndicesWithin = pixels(gWithin);
   matG(gIndicesWithin) = 1;
   
   %logical vector of the indices of blue layer that fall
   %within the tolerance level
   bWithin = Bdiff <= tolerance;
   %indices of the pixels that fall within the tolerance level
   bIndicesWithin = pixels(bWithin);
   matB(gIndicesWithin) = 1;
   
   matTotal = matR + matG + matB;
   
   withinTolerance = find(matTotal == 3);
   
   diffR = abs(currentOrganismR(withinTolerance) - targetOrganismR(withinTolerance));
   diffG = abs(currentOrganismG(withinTolerance) - targetOrganismG(withinTolerance));
   diffB = abs(currentOrganismB(withinTolerance) - targetOrganismB(withinTolerance));
   
   totalDiff = diffR + diffG + diffB;
   
   totalDiff = totalDiff ./ (tolerance * row * col * 3);
   
   totalDiff = 1 - totalDiff;
   
   totalDiff = sum(sum(totalDiff));
   
   fitness(i,1) = totalDiff / (row * col);
   
   %Create a row*col matrix called ColorFit, where each element represents
   %a pixel in the image. If the element is 3, the RGB layers are all
   %within the set tolerance value. 
   
   %ColorFit = (Rdiff <= tolerance) + (Bdiff <= tolerance) + (Gdiff <= tolerance); 
   
   
   %Record the number of pixels that are within the tolerance range for all
   %three of their color layers: 
    
   %numPixelsWithinRange = sum(sum(ColorFit >= 2)); 

    %divide the number of fit pixels by the total number of pixels in
    %the target image to express the image's fitness as a percentage: 
    
    %fitness(i,1) = numPixelsWithinRange / (row * col);
   
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