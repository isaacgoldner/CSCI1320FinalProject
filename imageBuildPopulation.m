function [imagePopulation,targetImage] = imageBuildPopulation(targetImage)

%generate random images of same size as targetImage, the image that
%is to be generated,to build the initial population to begin the 
%evolution process. 

newImage = luminance(targetImage);

targetImage = newImage;

[row,col] = size(newImage);

imagePopulation = cell(row * col,1);

randGen = rand(row * (row * col),col);

for i = 1:(row * col)
    imagePopulation{i,1} = randGen((((i-1) * row) + 1):i * row,1:col);
end

end