function children = colorImageBreed(matingPool,targetImage,population)
%breed randomly selected "parent" organism pairs from the mating pool
%population with a specific method of taking random DNA 
%(which are represented with individual pixels) from each of the 
%individual parents.  

%assign the first column of the matingPool vector to the "first parents"
%and the second column of the matingPool vector to the "second parents"
firstParents = population(matingPool(:,1)); 
secParents = population(matingPool(:,2)); 

%get the size of the target image
[row,col,page] = size(targetImage);

%Start by having the children match the first parent population exactly.
%They will be altered from here: 
children = firstParents; 

%create a vector of the same length as the population size with random
%values to represent how many pixels will be taken from each of the parents
Par2PixelsPer = randi([1,(row*col)-1],1,row*col); 

%create a cell in which each cell will contain what pixels will be used
%from which parent
Par2PixelsCell = cell((row*col),1);

%loop through each of the elements of the 'Par2PixelsCell' assigning what
%pixels will be taken from parent 2
for i = 1:(row*col) 
    Par2PixelsCell{i,1} = datasample([1:(row*col)],Par2PixelsPer(i)); 
end

%loop through each of the children assigning certain pixels from parent 2
%to the child
for i = 1:(row*col)
    children{i,1}(Par2PixelsCell{i,1}) = secParents{i,1}(Par2PixelsCell{i,1});

end

end 
