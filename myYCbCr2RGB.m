function [imgRGB] = myYCbCr2RGB(imYCbCr)
%MYYCBCR2RGB Summary of this function goes here
%   Detailed explanation goes here

imYCbCr = imYCbCr./255;

%% Convert the image back to RGB
%disp("         d. Convert to RGB...")
% Assign the Y, Cb, and Cr matrices to an image
% imYCbCr = zeros(size(img,1),size(img,2),size(img,3));
% imYCbCr(:,:,1) = Y;
% imYCbCr(:,:,2) = Cb;
% imYCbCr(:,:,3) = Cr;

A_YCbCr = [ 0.299,      0.587,     0.114;
           -0.1618736, -0.331264,  0.5;
            0.5,       -0.418688, -0.081312];

b_YCbCr = [ 0;
            0.5;
            0.5];



invA_YCbCr = inv(A_YCbCr);

% Retrieve the new Y, Cb, Cr (and subtract the b that was added to them)
Y = imYCbCr(:,:,1)-b_YCbCr(1);
Cb = imYCbCr(:,:,2)-b_YCbCr(2);
Cr = imYCbCr(:,:,3)-b_YCbCr(3);

% Calculate the matrices for R,G,B
R = invA_YCbCr(1,1)*Y  + invA_YCbCr(1,2)*Cb + invA_YCbCr(1,3)*Cr;
G = invA_YCbCr(2,1)*Y + invA_YCbCr(2,2)*Cb + invA_YCbCr(2,3)*Cr;
B = invA_YCbCr(3,1)*Y + invA_YCbCr(3,2)*Cb + invA_YCbCr(3,3)*Cr;

% Assign the new R, G, B values back to the original image
img(:,:,1) = R;
img(:,:,2) = G;
img(:,:,3) = B;

imgRGB = (img*255);
end

