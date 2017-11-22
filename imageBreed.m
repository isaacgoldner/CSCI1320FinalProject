function child = imageBreed(parent1,parent2,targetImage)

%breed randomly selected "parent" organism pairs from the mating pool
%population with a specific method of taking random DNA 
%(which are represented with individual pixels) from each of the 
%individual parents.  

[row,col] = size(targetImage);

numPixels = randi([1,(row*col)-1]);

parent1Pixels = sort(datasample([1:(row*col)],numPixels));

child = zeros(row,col);

child(parent1Pixels) = parent1(parent1Pixels);

x = ~ismember([1:(row*col)],parent1Pixels);

child(x) = parent2(x);

end