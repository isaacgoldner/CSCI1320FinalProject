%%Example of how we could take all of our necessary information and save it
%%to a text file. Formatting is rough, but in practice this should work.


%Note that titles are created independently of the rest of the information
%as all of the titles are strings. 
Titles = {'Generation' 'TargetString' 'MaxFitness'}; 

%These vectors and the cell array for the string output of each generation
%would already be created. 
Generation = num2cell(1:5); 
TargetString = {'To be or not to be' 'To be or not to be' 'To be or not to be' 'To be or not to be' 'To be or not to be'}; 
MaxFit = num2cell(10:10:50); 

%Table Creator is the cell array actually iterated though to make the
%table.
%Note that one column of TableCreator stores all of the necessary data from
%a single generation. 
TableCreator = [Generation; TargetString; MaxFit]; 

%Spaces added to make the table clear before the addition of proper
%formatting. 
fprintf('%s     ',Titles{:}); 
fprintf('\n');
fprintf('%d          %s     %d\n',TableCreator{:}); 


% Format used from the Mathworks website: 
% x = 0:.1:1;
% A = [x; exp(x)];
% 
% fileID = fopen('exp.txt','w');
% fprintf(fileID,'%6s %12s\n','x','exp(x)');
% fprintf(fileID,'%6.2f %12.8f\n',A);
% fclose(fileID);