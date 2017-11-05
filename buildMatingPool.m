function matingPool = buildMatingPool(population)
%takes in a population and builds a mating pool based on the fitness of
%each member of the population


%Using a "lottery" based system to decide an individual population member's
%chance of entering the mating pool: 

%Mating factor will be decided later. 

 ticketVector = (fitness).*(mating factor)

 %ticketVector is a numerical vector indicating the number of "tickets"
 %each population memeber will have in the "lottery" system. 
 
 

matingPool = cell(1,2);
matingPool{1,1} = 'string1';
matingPool{1,2} = 'string2';


end