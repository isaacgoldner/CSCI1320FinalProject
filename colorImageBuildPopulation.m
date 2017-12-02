function [imagePopulation] = colorImageBuildPopulation(targetImage)

%generate random images of same size as targetImage, the image that
%is to be generated,to build the initial population to begin the 
%evolution process. 

[row,col,page] = size(targetImage);

imagePopulation = cell(row * col,1);

randomImages = rand; 

for i = 1:(row * col)
    imagePopulation{i,1} = rand(row,col,3); 
end

end