function children = imageBreed(matingPool,targetImage,population)

%breed randomly selected "parent" organism pairs from the mating pool
%population with a specific method of taking random DNA 
%(which are represented with individual pixels) from each of the 
%individual parents.  

firstParents = population(matingPool(:,1)); 
secParents = population(matingPool(:,2)); 

[row,col] = size(targetImage);

%Start by having the children match the first parent population exactly.
%They will be altered from here: 
children = (firstParents); 

Par2PixelsPer = randi([1,(row*col)-1],1,row*col); 
Par2PixelsCell = cell((row*col),1);

for i = 1:(row*col) 
    Par2PixelsCell{i,1} = datasample( [1:(row*col)],Par2PixelsPer(i)); 
end

for i = 1:(row*col)
    children{i,1}(Par2PixelsCell{i,1}) = secParents{i,1}(Par2PixelsCell{i,1});
    
end






end 






%Original vectorized version
%function child = imageBreed(parent1,parent2,targetImage)
% [row,col] = size(targetImage);
% 
% numPixels = randi([1,(row*col)-1]);
% 
% parent1Pixels = sort(  datasample([1:(row*col)],numPixels)   );
% 
% child = zeros(row,col);
% 
% child(parent1Pixels) = parent1(parent1Pixels);
% 
% x = ~ismember([1:(row*col)],parent1Pixels);
% 
% child(x) = parent2(x);

%end