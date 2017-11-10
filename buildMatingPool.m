function matingPool = buildMatingPool(population, fitness)
%takes in a population and a vector containing the fitness of its members
%and builds a mating pool for creating the next generation that prefers
%organisms with heigher fitness. 


%We plan on using a "lottery" based system to decide an individual population member's
%chance of entering the mating pool: 

%Mating factor will be decided later. 

%The code below represents a possible initial mating pool where one organism
%appears more often due to its higher fitness. 
initialMatingPool = cell(1,3);
initialMatingPool{1,1} = 'string1';
initialMatingPool{1,2} = 'string1';
initialMatingPool{1,3} = 'string2';

%Parent pairs are then selected randomly from the initial mating pool. 
matingPool = cell(1,2);

%form the mating pool based on random selection but with a higher frequency
%of the higher fitness organisms
for i = 1:2
   indexInt = randi([1,3]);
   matingPool{1,i} = initialMatingPool{1,indexInt};
end


end