function [imOut] = chromaSubsample(imagePath,subSampleType)
%CHROMASUBSAMPLE Summary of this function goes here
%   Detailed explanation goes here

disp("       Subsampling: " + imagePath)
disp("         a. Read in image and generate 3D matrix...")

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
disp("         b. Convert to YCbCr...")
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



%% Subsample the image and fill in the empty pixels
disp("         c. Subsample...")
%%% Y component subsample
% If 1 sample - take first column of each 4
if(subSampleType(1) == 1)
    Y(:,2:4:end) = Y(:,1:4:end); % Set column equal to previous
    Y(:,3:4:end) = Y(:,2:4:end);
    Y(:,4:4:end) = Y(:,3:4:end);
% If 2 samples - take every other column
elseif(subSampleType(1) == 2)
    Y(:,2:4:end) = Y(:,1:4:end); % Set column equal to previous
    Y(:,4:4:end) = Y(:,3:4:end);
% If 3 samples - take the first 3
elseif(subSampleType(1) == 3)
    Y(:,4:4:end) = Y(:,3:4:end); % Set column equal to previous
% If 0 samples - set to 0
elseif(subSampleType(1) == 0)
    Y(:,:) = 0.0; 
end


%%% Cr & Cb - First Row Subsample
% If 1 sample - take first column of each 4
if(subSampleType(2) == 1)
    % Cb Component
    Cb(1:2:end,2:4:end) = Cb(1:2:end,1:4:end); % Set column equal to previous
    Cb(1:2:end,3:4:end) = Cb(1:2:end,2:4:end);
    Cb(1:2:end,4:4:end) = Cb(1:2:end,3:4:end);
    
    % Cr Component
    Cr(1:2:end,2:4:end) = Cr(1:2:end,1:4:end); 
    Cr(1:2:end,3:4:end) = Cr(1:2:end,2:4:end);
    Cr(1:2:end,4:4:end) = Cr(1:2:end,3:4:end);   
% If 2 samples - take every other column
elseif(subSampleType(2) == 2)
    % Cb Component
    Cb(1:2:end,2:4:end) = Cb(1:2:end,1:4:end);
    Cb(1:2:end,4:4:end) = Cb(1:2:end,3:4:end);
    
    % Cr Component
    Cr(1:2:end,2:4:end) = Cr(1:2:end,1:4:end);
    Cr(1:2:end,4:4:end) = Cr(1:2:end,3:4:end);
% If 3 samples - take the first 3
elseif(subSampleType(2) == 3)
    % Cb Component
    Cb(1:2:end,4:4:end) = Cb(1:2:end,3:4:end);
    
    % Cr Component
    Cr(1:2:end,4:4:end) = Cr(1:2:end,3:4:end);
% If 0 samples - set to 0 for now
elseif(subSampleType(2) == 0)
    % Cb Component
    Cb(1:2:end,:) = 0.0;
    
    % Cr Component
    Cr(1:2:end,:) = 0.0;
end

%%% Cr & Cb - Second Row Subsample
% If 1 sample - take first column of each 4
if(subSampleType(3) == 1)
    % Cb Component
    Cb(2:2:end,2:4:end) = Cb(2:2:end,1:4:end); % Set column equal to previous
    Cb(2:2:end,3:4:end) = Cb(2:2:end,2:4:end);
    Cb(2:2:end,4:4:end) = Cb(2:2:end,3:4:end);
    
    % Cr Component
    Cr(2:2:end,2:4:end) = Cr(2:2:end,1:4:end);
    Cr(2:2:end,3:4:end) = Cr(2:2:end,2:4:end);
    Cr(2:2:end,4:4:end) = Cr(2:2:end,3:4:end);   
% If 2 samples - take every other column
elseif(subSampleType(3) == 2)
    % Cb Component
    Cb(2:2:end,2:4:end) = Cb(2:2:end,1:4:end);
    Cb(2:2:end,4:4:end) = Cb(2:2:end,3:4:end);
    
    % Cr Component
    Cr(2:2:end,2:4:end) = Cr(2:2:end,1:4:end);
    Cr(2:2:end,4:4:end) = Cr(2:2:end,3:4:end);
% If 3 samples - take the first 3
elseif(subSampleType(3) == 3)
    % Cb Component
    Cb(2:2:end,4:4:end) = Cb(2:2:end,3:4:end);
    
    % Cr Component
    Cr(2:2:end,4:4:end) = Cr(2:2:end,3:4:end);
% If 0 samples - set to first row
elseif(subSampleType(3) == 0)
    if(mod(size(Y,1),2) == 0) % Handle odd number of rows
        start = 1;
    else
        start = 3;    
    end
    % Cb Component
    Cb(2:2:end,:) = Cb(start:2:end,:); % Set row equal to previous
    
    % Cr Component
    Cr(2:2:end,:) = Cr(start:2:end,:);
end



% If the 1st row has no samples, now we fill it in with the 2nd row
if(subSampleType(2) == 0)
    if(mod(size(Y,1),2) == 0) % Handle odd number of rows
        start = 1;
    else
        start = 3;    
    end
    % Cb Component
    Cb(start:2:end,:) = Cb(2:2:end,:); % Set row equal to next
    
    % Cr Component
    Cr(start:2:end,:) = Cr(2:2:end,:); 
end

figure
nimg = zeros(size(img,1),size(img,2),size(img,3));
nimg(:,:,1) = Y;
nimg(:,:,2) = Cb;
nimg(:,:,3) = Cr;
imshow(nimg)



%% Convert the image back to RGB
disp("         d. Convert to RGB...")
% Assign the Y, Cb, and Cr matrices to an image
imYCbCr = zeros(size(img,1),size(img,2),size(img,3));
imYCbCr(:,:,1) = Y;
imYCbCr(:,:,2) = Cb;
imYCbCr(:,:,3) = Cr;




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

imOut = img;
end

