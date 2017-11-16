function [outImg] = luminance(inImg)
%takes in an image and returns the image in grayscale using no loops
%Isaac Goldner
%CSCI 1320
%Assignment #7
%Instructor: Zagrodzki

%get size of inImg
[row,col,page] = size(inImg);

%if image is not grayscale, calculate intensity of each pixel, otherwise,
%outImg = inImg
if page == 1
    outImg = inImg;
else
    %calculates intensity of each pixel
    red = double(inImg(:,:,1)) * .299;
    green = double(inImg(:,:,2)) * .587;
    blue = double(inImg(:,:,3)) * .114;

    outImg = (red + green + blue)/255;
end

end