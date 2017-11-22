function diffFitness = imageDiffFitness(imagePopulation,targetImage)

%Create the rate of changes to compare with:
%These matrices should be stored as vectors for easy comparison. 

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


%Set tolerance value 
tol = 0.05; 

for i=1:length(imagePopulation)
%Take the left to right rate of change between pixel values for each member
%of the population: 

%Row vector of organism's left to right difference values: 
PopLRDiff{i,1} = reshape( ( diff(imagePopulation{i,1},1,2) )' ,1,numel(TargetRocLtoR) );

%Compare the target image's left to right diff with the organism's. Store a
%one if the value for the organism is within the tolerance: 
LRMatchorNot = ((abs(TargetRocLtoR - PopLRDiff{i,1})) <= tol) ; 
LRFit(i,1) = sum(LRMatchorNot)/(numel(LRMatchorNot));  

%Repeat Process for Left to right: 
PopRLDiff{i,1} = reshape((diff(fliplr(imagePopulation{i,1}),1,2))',1,numel(TargetRocRtoL));
RLMatchorNot = ((abs(TargetRocRtoL - PopRLDiff{i,1})) <= tol) ; 
RLFit(i,1) = sum(RLMatchorNot)/(numel(RLMatchorNot));  

%Repeat process for UD
PopUDDiff{i,1} = reshape((diff(imagePopulation{i,1},1,1))',1,numel(TargetRocUtoD)); 
UDMatchorNot = ((abs(TargetRocUtoD - PopUDDiff{i,1})) <= tol) ;
UDFit(i,1) = sum(UDMatchorNot)/(numel(UDMatchorNot)); 

%Repeat process for DU 
PopDUDiff{i,1} = reshape((diff(flipud(imagePopulation{i,1}),1,1))',1,numel(TargetRocDtoU));
DUMatchorNot = ((abs(TargetRocDtoU - PopDUDiff{i,1})) <= tol) ;
DUFit(i,1) = sum(DUMatchorNot)/(numel(DUMatchorNot)); 


diffFitness(i,1) = ( ((LRFit(i,1))^2) + ((RLFit(i,1))^2) + ((UDFit(i,1))^2) + ((DUFit(i,1))^2) )^0.5; 
end 


%HERE I AM ASSUMING THAT WE WILL NORMALIZE FITNESS LATER WHEN WE GO TO
%BUILD THE POPULATION. 

end