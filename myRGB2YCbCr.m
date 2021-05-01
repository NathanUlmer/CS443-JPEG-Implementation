function [imOut] = MyRGB2YCbCr(imagePath)

% Read in image
im = imread(imagePath);

% Get Image Bitdepth PER CHANNEL. (grayscale -> R=G=B) 
% (Matlab does 8 bit, 16 bit, and floating point from 0 to 1 for other
% depths)
if(isa(im,'uint8'))
    n = 8;
elseif(isa(im,'uint16'))
    n = 16;
elseif(isa(im,'double'))
    n = 0; %Bitdepth is not actually 0, but range is between 0 and 1
else %Otherwise, we don't know what it is
    Output = -1;
    return;
end


%% Convert image values into range 0 ... 1 if not already

if(n ~= 0)
   
    img(:,:,:) = double(im(:,:,:))/double(2^n-1);
else
    img(:,:,:) = im;
end
%% Convert RGB image to YCbCr
%disp("         b. Convert to YCbCr...")
% Multiply the [R;G;B] vector by this for each triplet of colors
A_YCbCr = [ 0.299,      0.587,     0.114;
           -0.1618736, -0.331264,  0.5;
            0.5,       -0.418688, -0.081312];
% Add this vector to end
b_YCbCr = [ 0;
            0.5;
            0.5];

% Decompose channels so we can do matrix multiplication
Rs = img(:,:,1);
Gs = img(:,:,2);
Bs = img(:,:,3);

% Calculate the matrices for Y, Cb, and Cr
Y = A_YCbCr(1,1)*Rs + A_YCbCr(1,2)*Gs + A_YCbCr(1,3)*Bs + b_YCbCr(1);
Cb = A_YCbCr(2,1)*Rs + A_YCbCr(2,2)*Gs + A_YCbCr(2,3)*Bs + b_YCbCr(2);
Cr = A_YCbCr(3,1)*Rs + A_YCbCr(3,2)*Gs + A_YCbCr(3,3)*Bs + b_YCbCr(3);


%% Convert the image back to RGB
%disp("         d. Convert to RGB...")
% Assign the Y, Cb, and Cr matrices to an image
imYCbCr = zeros(size(img,1),size(img,2),size(img,3));
imYCbCr(:,:,1) = Y;
imYCbCr(:,:,2) = Cb;
imYCbCr(:,:,3) = Cr;

imOut = imYCbCr.*255;

