function matingPool = imageBuildMatingPool(imagePopulation,fitness,targetImage)

%Using the input population and the fitnesses of each member of this
%population, create a "mating pool" of organisms where a given organism has
%a larger presence in the pool if it has a heigher fitness value. 

%members of the mating pool population created will eventually be "bred" to
%create a new population of children.


fitness = fitness.^6;

%Before breeding the new population, the fitness values of the input
%population should be normalized. 

%The process for normalizing the fitness values for the generation is as
%follows: 
%1) subtract the minimum
%2) divide by the new maximum
maxFitnessVec = max(fitness);
maxFitness = maxFitnessVec(1,1);
minFitnessVec = min(fitness);
minFitness = minFitnessVec(1,1);
if minFitness ~= maxFitness
    normalizedFitness = (fitness - min(fitness))./(max(fitness) - min(fitness)); 
else
    normalizedFitness = fitness;
end

%Now it must be decided how many times a particular organism will appear in
%the mating pool based on its fitness; how many 'tickets' it will have in 
%the 'lottery'. This is accomplished using a mating
%factor that is saved as a variable so that it can be altered later. 
mateFactor = 20; 

%TicketsPerOrg is a vector that simply saves the number of times a
%particular organism will appear in the mating pool. Each element in the
%vector corrisponds to an organism that appears in the generation being
%used to create the mating pool. The number of tickets an organism has is
%rounded to the nearest interger. If the calculation returns 0 tickets for
%an organism, this zero is replaced with a 1 so that every organism is
%included at least once. 
TicketsPerOrg = round(normalizedFitness .* (mateFactor)); 
TicketsPerOrg(find(TicketsPerOrg == 0)) = 1;

%get the size of the target image
[row,col] = size(targetImage);

%The repelem function is then used to have the index for each organism in
%the population (the population of 200) being used to create the mating 
%pool appear in the pool a number of times equal to the number of "tickets"
%the organism has. 
matingPoolTickets = repelem([1:row*col]',TicketsPerOrg);

%store how many total tickets there are
totalTickets = length(matingPoolTickets);

%initialize the matingPool matrix
matingPool = zeros(row*col,2);

%go through each index of the matingPool matrix picking a random number for
%the index of an element in the matingPoolTickets vector and assign the
%specific index of matingPool to the organism number that was chosen.
%if the same parent is randomly selected to breed with itself, choose a
%different organism to breed with until this is not the case. 
for p1 = 1:row*col
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