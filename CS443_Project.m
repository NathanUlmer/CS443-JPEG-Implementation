% CS443 Project
% Group Members:
%   Nathan Ulmer
%   Dian Hernandez
%   Juley Yeager
%   Jared Nicoll
%   Dalton Johnson
%
% Spring 2021
clear all; close all; clc;

% Path to the images and provided files for the project
addpath("Project_Code_Images");

% ALU Image path
ALU = "alu.tif"

% Tulips Image path
TULIPS = "tulips.png"



%% Project Description
% The goal of this project is to imlement the lossy compression part of the
% JPEG algorithm. It implements and applies the specified JPEG algorithm
% for the two included images in Project_Code_Images. 

%% Step 1: Compression

% 1. Convert RGB components to YCbCr (using HW 2)
aluYCbCr = myRGB2YCbCr(TULIPS);



% 2. Perform chroma subsampling 4:2:0 (use HW2)
aluSS = chromaSubsample(aluYCbCr,[4,2,0]);




% 3. Apply 2D DCT transform (N=M=8) on Y, Cb, and Cr components (see
% dctbasis.m)
N = 8;
aluDCT = DCT2D(aluSS, N);





% 4. Apply quantization using quantization table (Tables 9.1, 9.2) for
% luminance and chrominance (remove AC components)
aluQuant = Quantization(aluDCT,50,N);



%% Step 2: Decompression


% Dequantize the DCT coefficients
aluDequant = DeQuantization(aluQuant,50,N);

% Implement and apply the 2D IDCT to the dequantized DCT coefficients
aluIDCT = IDCT2D(aluDequant,N);



%3. Convert YCbCr to RGB (use HW2)
aluRGB = myYCbCr2RGB(aluIDCT);


%% Step 3: Outputs
% Save outputs in .png format
imshow(aluRGB)
imwrite(aluRGB,"output/aluJPEG.png",'PNG');

%% Step 4: Error Computation

% 1. Compute the pixel-wise error(difference) between the original frame
% and output frame and display error using imagesc()
aluOriginal = double(imread(TULIPS));
aluError = aluOriginal - aluRGB;
figure
imagesc(aluError)


% 2. Compute Peak SNR (I is original frame and I' is output frame)
% MSE = 1/(M*N)*sumM(sumN((I[x,y]-I'[x,y])^2))
MSE = 1/(N*N)*sum(sum((aluOriginal - aluRGB).^2));

% PSNR = 20*log10(255/sqrt(MSE))
PSNR = 20.*log10(255./sqrt(MSE));

%% Step 5: Group Report Output

