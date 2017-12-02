function [imagePopulation] = colorImageBuildPopulation(targetImage)
%generate random images of same size as targetImage, the image that
%is to be generated, to build the initial population to begin the 
%evolution process. 

%find the size of the target image
[row,col,page] = size(targetImage);

%pre-allocate the size of the image population cell. A single cell
%representing a single organism
imagePopulation = cell(row * col,1);

%loop to go through each cell for the new population
for i = 1:(row * col)
    
    %assign the organism of the new population to be a random 3D matrix
    %with values ranging from 0 to 1
    imagePopulation{i,1} = rand(row,col,3); 
    
end

end