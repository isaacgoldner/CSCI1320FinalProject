%NOT the main script
%script to test progress of image functions
%can delete for final

tic

image = imread('36x36monalisa.jpg');

[population,targetImage] = imageBuildPopulation(image);

fitness = imageAverageValuesFitness(population,targetImage);

toc