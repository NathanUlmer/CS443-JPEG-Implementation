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




%% Project Description
% The goal of this project is to imlement the lossy compression part of the
% JPEG algorithm. It implements and applies the specified JPEG algorithm
% for the two included images in Project_Code_Images. 

%% Step 1: Compression

% 1. Convert RGB components to YCbCr (using HW 2)

% 2. Perform chroma subsampling 4:3:0 (use HW2)

% 3. Apply 2D DCT transform (N=M=8) on Y, Cb, and Cr components (see
% dctbasis.m)

% 4. Apply quantization using quantization table (Tables 9.1, 9.2) for
% luminance and chrominance (remove AC components)




%% Step 2: Decompression


% Dequantize the DCT coefficients

% Implement and apply the 2D IDCT to the dequantized DCT coefficients

%3. Convert YCbCr to RGB (use HW2)

%% Step 3: Outputs
% Save outputs in .png format

%% Step 4: Error Computation

% 1. Compute the pixel-wise error(difference) between the original frame
% and output frame and display error using imagesc()

% 2. Compute Peak SNR (I is original frame and I' is output frame)
% MSE = 1/(M*N)*sumM(sumN((I[x,y]-I'[x,y])^2))

% PSNR = 20*log10(255/sqrt(MSE))

%% Step 5: Group Report Output

