function matingPool = buildMatingPool(population)
%takes in a population and builds a mating pool based on the fitness of
%each member of the population


%Using a "lottery" based system to decide an individual population member's
%chance of entering the mating pool: 

%Mating factor will be decided later. 

initialMatingPool = cell(1,3);
initialMatingPool{1,1} = 'string1';
initialMatingPool{1,2} = 'string1';
initialMatingPool{1,3} = 'string2';

matingPool = cell(1,2);

for i = 1:2
   indexInt = randi([1,3]);
   matingPool{1,i} = initialMatingPool{1,indexInt};
end


end