function mutatedNewPopulationMember = colorImageImprovedCauseMutation(newPopulationMember,maxFitness)
%First, decide if a pixel is to be mutated at all. 'mutationRate' is a
%number from 1 to 100, representing a percentage
mutationRate = 1;

%Store the size of the child to be mutated: 
[row,col,page] = size(newPopulationMember);

%Generate random integer(s) from a range that depends on the desired
%mutation rate: 
luckyNumber = randi([1,100],1,mutationRate);

%Create a vector of random integers drawn from the same range as
%LuckyNumber. This vector's length matches the number of elements in the 
%child that is to be mutated; each element corrisponds to one of the
%child's pixels. 
chanceVec = randi([1,100],1,(row*col));

%Create a logical vector that marks the instances where an element of
%ChanceVec matches the LuckyNumber's value:
mutMeRandomLogical = ismember(chanceVec,luckyNumber);

%create a vector with the indices of all of the elements of the population
%member
pixels = [1:(row*col)];

%Find the indexes of the elements in the child that should be mutated by
%finding where the element's of ChanceVec matched LuckyNumber: 
mutMeRandomIndices = pixels(mutMeRandomLogical);

%mutation rate for entirely random mutation
randomMutationRate = 0.2;

%Decide which of the pixels are to be randomly mutated:  

NumPro1Pixels = round(randomMutationRate * length(mutMeRandomIndices));
Process1ers = datasample(mutMeRandomIndices, NumPro1Pixels,'Replace',false);

%Have the remaining pixels undergo a more specific mutation process:
Process2ers = mutMeRandomIndices(~ismember(mutMeRandomIndices,Process1ers));

    %% Entirely random mutation: 
    %Pixels assigned to process 1 will be randomly mutated: 

    %assign random values to the first page
    randNewVals1 = rand(1,length(Process1ers));
    newPopulationMember(Process1ers) = randNewVals1; 

    %assign random values to the second page
    randNewVals2 = rand(1,length(Process1ers));
    newPopulationMember(Process1ers + (row*col)) = randNewVals2;

    %assign random values to the third page
    randNewVals3 = rand(1,length(Process1ers));
    newPopulationMember(Process1ers + (2*row*col)) = randNewVals3;
    
    %% Within range mutation: 
    %Pixels assigned to process 2 will either be lightened or darkened within
    %a specific mutatation range. 
    mutationRange = (1-(0.5 * maxFitness)) * .3; 

    %Create a vector of values within the range that will either be added or
    %subtracted: 
    ligDar = rand(1,length(Process2ers))*(mutationRange - (-mutationRange))+(-mutationRange); 
    newPopulationMember(Process2ers) = newPopulationMember(Process2ers) + ligDar; 
    newPopulationMember(Process2ers + (row*col)) = newPopulationMember(Process2ers) + ligDar; 
    newPopulationMember(Process2ers + (2*row*col)) = newPopulationMember(Process2ers) + ligDar; 

    %set values that are greater than 1 to 1
    greaterThan1Indices = find(newPopulationMember > 1);
    newPopulationMember(greaterThan1Indices) = 1;

    %set values that are less than 0 to 0
    lessThan0Indices = find(newPopulationMember < 0);
    newPopulationMember(lessThan0Indices) = 0;
    
    %Finish with setting the function's output equal to the altered child. 
    mutatedNewPopulationMember = newPopulationMember;
    
%% Flipping pixels up/down
%set the mutation rate for the flipping of pixels
flipPixelsMutationRateUD = round((1 - (maxFitness)) * 50);

%Generate random integer(s) from a range that depends on the desired
%mutation rate: 
luckyNumber = randi([1,100],1,flipPixelsMutationRateUD);

%Create a vector of random integers drawn from the same range as
%LuckyNumber. This vector's length matches the number of elements in the 
%child that is to be mutated; each element corrisponds to one of the
%child's pixels. 
chanceVec = randi([1,100],1,(row*col));

%Create a logical vector that marks the instances where an element of
%ChanceVec matches the LuckyNumber's value:
mutMe= ismember(chanceVec,luckyNumber);

%create a vector with the indices of all of the elements of the population
%member
pixels = [1:(row*col)];

%Find the indexes of the elements in the child that should be mutated by
%finding where the element's of ChanceVec matched LuckyNumber: 
mutMeRandomIndices = pixels(mutMe);

%eliminate the indices of the top row edge cases
topRow = find(mod(mutMeRandomIndices,row) == 1);
mutMeRandomIndices(topRow) = [];

%eliminate the indices of the bottom row edge cases
bottomRow = find(mod(mutMeRandomIndices,row) == 0);
mutMeRandomIndices(bottomRow) = [];

%create a vector with two possible values: -1 or 1
upOrDown = [-1,1];

%randomly select values from 'upOrDown', the number of values depending on
%how many pixels are to be mutated
upOrDownVec = datasample(upOrDown,length(mutMeRandomIndices));

%store the values of the specific indices in a 'temp' variable
temp = newPopulationMember(mutMeRandomIndices);

%create a new matrix by adding the 'upOrDownVec' indices of the pixels to
%the indices of the pixels that are to be mutated
switchingIndices = upOrDownVec + mutMeRandomIndices;

%switch the pixels that are to be mutated with the pixels that are either
%one above or one below the specific pixel
newPopulationMember(mutMeRandomIndices) = newPopulationMember(switchingIndices);

%store the pixels that were either above or below the pixel in the previous
%mutated pixels location so that they are swapped
newPopulationMember(switchingIndices) = temp;

%% Flipping pixels left/right
%set the mutation rate for the flipping of pixels
flipPixelsMutationRateUD = round((1 - (maxFitness)) * 50);

%Generate random integer(s) from a range that depends on the desired
%mutation rate: 
luckyNumber = randi([1,100],1,flipPixelsMutationRateUD);

%Create a vector of random integers drawn from the same range as
%LuckyNumber. This vector's length matches the number of elements in the 
%child that is to be mutated; each element corrisponds to one of the
%child's pixels. 
chanceVec = randi([1,100],1,(row*col));

%Create a logical vector that marks the instances where an element of
%ChanceVec matches the LuckyNumber's value:
mutMe= ismember(chanceVec,luckyNumber);

%create a vector with the indices of all of the elements of the population
%member
pixels = [1:(row*col)];

%Find the indexes of the elements in the child that should be mutated by
%finding where the element's of ChanceVec matched LuckyNumber: 
mutMeRandomIndices = pixels(mutMe);

%find the indices of the left column to eliminate edge cases
leftColumn = find(mutMeRandomIndices <= row);
mutMeRandomIndices(leftColumn) = [];

%find the indices of the right column to eliminate edge cases
rightColumn = find(mutMeRandomIndices >= ((row * col) - row + 1));
mutMeRandomIndices(rightColumn) = [];

%create a vector with two possible options: -row or row, depending on
%whether the pixel should be shifted to the left or right
leftOrRight = [-row,row];

%randomly select values from 'leftOrRight', the number of values depending on
%how many pixels are to be mutated
leftOrRightVec = datasample(leftOrRight,length(mutMeRandomIndices));

%store the values of the specific indices in a 'temp' variable
temp = newPopulationMember(mutMeRandomIndices);

%create a new matrix by adding the 'leftOrRightVec' indices of the pixels to
%the indices of the pixels that are to be mutated
switchingIndices = leftOrRightVec + mutMeRandomIndices;

%switch the pixels that are to be mutated with the pixels that are either
%one to the left or one to the right of the specific pixel
newPopulationMember(mutMeRandomIndices) = newPopulationMember(switchingIndices);

%store the pixels that were either to the left or to the right of the pixel in the previous
%mutated pixels location so that they are swapped
newPopulationMember(switchingIndices) = temp;
end