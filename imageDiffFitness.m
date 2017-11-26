function diffFitness = imageDiffFitness(imagePopulation,targetImage)

%Using the target image: 
%For each of the four directions (L to R, R to L, U to D, and D to U), make
%a matrix that captures the rate of change beween pixels. Turn these
%matrices into vectors for ease of comparison later in the function:

%Left to right: 
TargetRocLtoR = diff(targetImage,1,2); 
TargetRocLtoR = reshape(TargetRocLtoR',1,numel(TargetRocLtoR)); 
%Right to left: 
TargetRocRtoL = diff(fliplr(targetImage),1,2); 
TargetRocRtoL = reshape(TargetRocRtoL',1,numel(TargetRocRtoL));
%Up to down: 
TargetRocUtoD = diff(targetImage,1,1); 
TargetRocUtoD = reshape(TargetRocUtoD',1,numel(TargetRocUtoD));
%Down to up: 
TargetRocDtoU = diff(flipud(targetImage),1,1); 
TargetRocDtoU = reshape(TargetRocDtoU',1,numel(TargetRocDtoU));


%Set tolerance value used to compare the population organism's rates of
%change with the target's rates of change.
%(THIS MOST LIKELY REQUIRES ADJUSTMENT)  
tol = 0.05; 

%The for loop process works though one member of the population at a time:
for i=1:length(imagePopulation)
%Take the left to right rate of change between pixel values for the
%population member:
%Create a row vector of the organism's left to right difference values: 
PopLRDiff{i,1} = reshape( ( diff(imagePopulation{i,1},1,2) )' ,1,numel(TargetRocLtoR) );

%Compare the target image's left to right diff values with the organism's.
%The vector LRMatchorNot stores a 1 if the difference value of the organism
%is within the tolerance value of the population's corrisponing diffrence value. 
LRMatchorNot = ((abs(TargetRocLtoR - PopLRDiff{i,1})) <= tol) ; 
%The LRFit vector is then used to store the "left to right" fitness value of each
%organism in the population.
LRFit(i,1) = sum(LRMatchorNot)/(numel(LRMatchorNot));  

%Repeat Process for right to left: 
PopRLDiff{i,1} = reshape((diff(fliplr(imagePopulation{i,1}),1,2))',1,numel(TargetRocRtoL));
RLMatchorNot = ((abs(TargetRocRtoL - PopRLDiff{i,1})) <= tol) ; 
RLFit(i,1) = sum(RLMatchorNot)/(numel(RLMatchorNot));  

%Repeat process for up to down: 
PopUDDiff{i,1} = reshape((diff(imagePopulation{i,1},1,1))',1,numel(TargetRocUtoD)); 
UDMatchorNot = ((abs(TargetRocUtoD - PopUDDiff{i,1})) <= tol) ;
UDFit(i,1) = sum(UDMatchorNot)/(numel(UDMatchorNot)); 

%Repeat process for down to up:  
PopDUDiff{i,1} = reshape((diff(flipud(imagePopulation{i,1}),1,1))',1,numel(TargetRocDtoU));
DUMatchorNot = ((abs(TargetRocDtoU - PopDUDiff{i,1})) <= tol) ;
DUFit(i,1) = sum(DUMatchorNot)/(numel(DUMatchorNot)); 

%Use the assignment's quadrature process to create the function's output,
%which is a vector of each organism in the population's fitness. 

diffFitness(i,1) = ( ((LRFit(i,1))^2) + ((RLFit(i,1))^2) + ((UDFit(i,1))^2) + ((DUFit(i,1))^2) )^0.5; 
end 

end