function matingPool = buildMatingPool(fitness,populationSize)
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
%factor that is saved as a variable so that it can be altered for task 1.7 
%work. 
mateFactor = 1000; 

%Task 1.7 Note: anything between 10 and 15 works quite well using our 
%"standard settings" and not 
%applying and exponent to the fitness values.
%With an exponential factor of 100 on the fitness values a mating factor of
%1000 produces the target phrase in significantly fewer generations.
%Increasing the mating factor over this value generally lead to a slower
%evolution process. 

%TicketsPerOrg is a vector that simply saves the number of times a
%particular organism will appear in the mating pool. Each element in the
%vector corrisponds to an organism that appears in the generation being
%used to create the mating pool. The number of tickets an organism has is
%rounded to the nearest interger. If the calculation returns 0 tickets for
%an organism, this zero is replaced with a 1 so that every organism is
%included in the mating pool at least once to help maintain genetic
%diversity. 
TicketsPerOrg = round(normalizedFitness .* (mateFactor)); 
TicketsPerOrg(find(TicketsPerOrg == 0)) = 1;

%The repelem function is then used to have the index for each organism in
%the population (the population of 200) being used to create the mating 
%pool appear in the pool a number of times equal to the number of "tickets"
%the organism has. 
matingPoolTickets = repelem([1:populationSize]',TicketsPerOrg);

%Store the number of "tickets" entering the mating pool. 
totalTickets = length(matingPoolTickets);

%initialize the matingPool matrix, which will create the 200 pairs of
%parents that will be used to breed the members of the next generation. 
matingPool = zeros(populationSize,2);

%Go through each index of the matingPool matrix, picking a random number for
%the index of an element in the matingPoolTickets vector and assign the
%specific index of matingPool to the organism number that was chosen. This
%will create random pairs of parents to breed.
%If the same parent is randomly selected to breed with itself, choose a
%different organism to breed with until this is not the case. The process
%will end when all parent pairs are created. 
for p1 = 1:populationSize
    for p2 = 1:2
        num = randi([1,totalTickets]);
        matingPool(p1,p2) = matingPoolTickets(num);
        while matingPool(p1,1) == matingPool(p1,2)
           num = randi([1,totalTickets]);
           matingPool(p1,2) = matingPoolTickets(num);
        end
    end

end

end 