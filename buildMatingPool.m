function matingPool = buildMatingPool(fitness)
%This function takes in a vector containing the fitness of each of the
%current population's members and builds a "mating pool" for creating the 
%next generation that prefers organisms with heigher fitness. The mating
%pool produced by this function is a vector that only consists of indexes
%referring to the organisms in the population that the next generation will
%be bred from. 

%First, the fitness values for the generation must be normalized, with 1 as
%the heighest possible fitness and 0 as the lowest. This allows for easy
%creation of a "lottery" style mating pool later in the function: 

%The process for normalizing the fitness values for the generation is as
%follows: 
%1) subtract the minimum
%2) divide by the new maximum
normalizedFitness = (fitness - min(fitness))./(max(fitness) - min(fitness)); 

%Now it must be decided how many times a particular organism will appear in
%the mating pool based on its fitness; how many 'tickets' it will have in 
%the 'lottery'. This is accomplished using a mating
%factor that is saved as a variable so that it can be altered later. 
mateFactor = 10; 

%TicketsPerOrg is a vector that simply saves the number of times a
%particular organism will appear in the mating pool. Each element in the
%vector corrisponds to an organism that appears in the generation being
%used to create the mating pool. The number of tickets an organism has is
%rounded to the nearest interger. 
TicketsPerOrg = round(normalizedFitness .* (mateFactor)); 

%The repelem function is then used to have the index for each organism in
%the population (the population of 200) being used to create the mating 
%pool appear in the pool a number of times equal to the number of "tickets"
%the organism has. 
matingPool = repelem([1:200]',TicketsPerOrg); 

end 