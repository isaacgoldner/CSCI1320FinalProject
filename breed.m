function children = breed(parent1,parent2)
%Takes in the matingPool population and, using pairs of randomly selected 
%"parent organisms", creates a new population of children based on their 
%parent's DNA; Note that there are 2 methods in this function for how to 
%breed this new child specified on the assignment sheet.

% %% Method 1:
% 
% %get length of target string and create the char matrix for children that
% %will be returned by the function
% targetStringLength = length('To be or not to be');
% z = blanks(targetStringLength);
% children = repmat(z,200,1);
% 
% %loop through 200 times in order to create the new population
% for i = 1:200
%     
%     %choose a random index in the length of the target string to split the
%     %DNA to breed the child
%     num = randi([1,targetStringLength-1]);
%     
%     %get parent 1's entire DNA sequence
%     p1 = population(matingPool(i,1),1:end);
%     
%     %choose the part of parent 1's DNA sequence that was chosen by the
%     %random number 'num'
%     p1DNA = p1(1:num);
%     
%     %get parent 2's entire DNA sequence
%     p2 = population(matingPool(i,2),1:end);
%     
%     %choose the part of parent 2's DNA sequence that was chosen by the
%     %random number 'num'
%     p2DNA = p2(num+1:end);
%     
%     %for the child based on p1DNA and p2DNA
%     child = strcat(p1DNA,p2DNA);
%     
%     %input this new child's DNA into the 'children' char matrix that will
%     %be returned
%     children(i,1:length(child)) = child;
% end

%% Method 2:

targetStringLength = length('To be or not to be');

%randomly select how many characters from the first parent will be used in
%the breeding process
numChars = randi([1,targetStringLength - 1]);

indices = zeros(1,numChars);

%loop through however many numbers of characters will be used in breeding from
%parent 1
for i = 1:numChars
    %pick the indices that will be used from parent 1
    indices(1,i) = randi([1,targetStringLength]);
end

children = blanks(targetStringLength);

children(indices) = parent1(indices);

indices2 = targetStringLength - length(indices);


counter = 1;
for i = 1:targetStringLength
   if (find(indices == i) == []) 
      indices2(counter) = i;
      counter = counter + 1;
   end
end

children(indices2) = parent2(indices2);