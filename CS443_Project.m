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


% aluDCT = zeros(size(aluSS));
% for i = 1:8:size(aluDCT,1)
%     for j = 1:8:size(aluDCT,2)
%         if(i+7<=size(aluDCT,1) && j+7<=size(aluDCT,2))
%             aluDCT([i:i+8-1],[j:j+8-1],1) = dct2(aluSS([i:i+8-1],[j:j+8-1],1));
%             aluDCT([i:i+8-1],[j:j+8-1],2) = dct2(aluSS([i:i+8-1],[j:j+8-1],2));
%             aluDCT([i:i+8-1],[j:j+8-1],3) = dct2(aluSS([i:i+8-1],[j:j+8-1],3));
%         elseif(i+7<=size(aluDCT,1))
%             aluDCT([i:i+8-1],[j:end],1) = dct2(aluSS([i:i+8-1],[j:end],1));
%             aluDCT([i:i+8-1],[j:end],2) = dct2(aluSS([i:i+8-1],[j:end],2));
%             aluDCT([i:i+8-1],[j:end],3) = dct2(aluSS([i:i+8-1],[j:end],3));
%         elseif(j+7<=size(aluDCT,2))
%             aluDCT([i:end],[j:j+8-1],1) = dct2(aluSS([i:end],[j:j+8-1],1));
%             aluDCT([i:end],[j:j+8-1],2) = dct2(aluSS([i:end],[j:j+8-1],2));
%             aluDCT([i:end],[j:j+8-1],3) = dct2(aluSS([i:end],[j:j+8-1],3));
%         else
%             aluDCT([i:end],[j:end],1) = dct2(aluSS([i:end],[j:end],1));
%             aluDCT([i:end],[j:end],2) = dct2(aluSS([i:end],[j:end],2));
%             aluDCT([i:end],[j:end],3) = dct2(aluSS([i:end],[j:end],3));
%         end
%     end
% end
% imshow(log(abs(aluDCT(:,:,1))))
% 
% figure
% imshow(log(abs(aluDCTme(:,:,1))))


% 4. Apply quantization using quantization table (Tables 9.1, 9.2) for
% luminance and chrominance (remove AC components)
aluQuant = Quantization(aluDCT,50,N);



%% Step 2: Decompression


% Dequantize the DCT coefficients
aluDequant = DeQuantization(aluQuant,50,N);

% Implement and apply the 2D IDCT to the dequantized DCT coefficients
aluIDCT = IDCT2D(aluDCT,N);


%3. Convert YCbCr to RGB (use HW2)
aluRGB = myYCbCr2RGB(aluIDCT);


%% Step 3: Outputs
% Save outputs in .png format
imshow(aluDCT)

%% Step 4: Error Computation

% 1. Compute the pixel-wise error(difference) between the original frame
% and output frame and display error using imagesc()

% 2. Compute Peak SNR (I is original frame and I' is output frame)
% MSE = 1/(M*N)*sumM(sumN((I[x,y]-I'[x,y])^2))

% PSNR = 20*log10(255/sqrt(MSE))

%% Step 5: Group Report Output

