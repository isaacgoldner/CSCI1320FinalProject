%script to generate the target image

%define the target image

%call the function to generate the initial random population

%tic

%while the target image has not been produced in the generations continue
%doing these steps:

    %calculate the fitness of each organism with the calculate fitness
    %function (there are multiple versions for this function)
    
    %create the mating pool by calling the build mating pool function
    
    %breed a new population from the mating pool by calling the build
    %mating pool function
    
    %create a new population with the new children
    
    %randomly mutate members of the new population 
    
    %save the max fitness, avg fitness, and genetic diversity for each generation 
    %to separate vector
    
    %print the generation number, current max fitness, and current avg
    %fitness
    
%while loop ends when the target image is produced

%plot a sample of the the 9 maximum fitness members from evenly spaced
%generations. 

%save the max fitness organism to an image file

%save the max fitness, avg fitness, and genetic diversity vectors to a txt
%file.
    
%toc