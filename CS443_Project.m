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
ALU = input("Enter first Image Path: ",'s')

% Tulips Image path
TULIPS = input("Enter Second Image Path: ",'s')

disp("Processing Images, this may take a while.")


%% Project Description
% The goal of this project is to imlement the lossy compression part of the
% JPEG algorithm. It implements and applies the specified JPEG algorithm
% for the two included images in Project_Code_Images. 

%% Step 1: Compression

disp("1. Reading in Images")
aluOriginal = double(imread(ALU));
tulipOriginal = double(imread(TULIPS));

disp("2. Converting Images to YCbCr Color Space")
% 1. Convert RGB components to YCbCr (using HW 2)
aluYCbCr = myRGB2YCbCr(ALU);
tulipYCbCr = myRGB2YCbCr(TULIPS);

disp("3. Subsampling images at 4:2:0 pattern")
% 2. Perform chroma subsampling 4:2:0 (use HW2)
aluSS = chromaSubsample(aluYCbCr,[4,2,0]);
tulipSS = chromaSubsample(tulipYCbCr,[4,2,0]);




% 3. Apply 2D DCT transform (N=M=8) on Y, Cb, and Cr components (see
% dctbasis.m)
N = 8;
disp("4. Processing DCT2D algorithm, you may want to go make some coffee")
aluDCT = DCT2D(aluSS, N);
tulipDCT = DCT2D(tulipSS, N);




disp("5. Quantizing images")
% 4. Apply quantization using quantization table (Tables 9.1, 9.2) for
% luminance and chrominance (remove AC components)
quality = 50;
aluQuant = Quantization(aluDCT,quality,N);
tulipQuant = Quantization(tulipDCT,quality,N);



%% Step 2: Decompression

disp("6. Dequantizing Images")
% Dequantize the DCT coefficients
aluDequant = DeQuantization(aluQuant,quality,N);
tulipDequant = DeQuantization(tulipQuant,quality,N);

disp("7. Inverting DCT")
% Implement and apply the 2D IDCT to the dequantized DCT coefficients
aluIDCT = IDCT2D(aluDequant,aluSS,N);
tulipIDCT = IDCT2D(tulipDequant,tulipSS,N);

%%

disp("8. Converting YCbCr to RGB")
%3. Convert YCbCr to RGB (use HW2)
aluRGB = myYCbCr2RGB(aluIDCT);
tulipRGB = myYCbCr2RGB(tulipIDCT);

disp("9. Final Outputs")

%% Step 3: Outputs
% Save outputs in .png format
imshow(uint8(aluRGB))
imwrite(uint8(aluYCbCr),"output/aluYCbCrJPEG.png",'PNG');
imwrite(uint8(aluSS),"output/aluSSJPEG.png",'PNG');
imwrite(uint8(aluDCT),"output/aluDCTJPEG.png",'PNG');
imwrite(uint8(aluQuant),"output/aluQuantJPEG.png",'PNG');
imwrite(uint8(aluDequant),"output/aluDequantJPEG.png",'PNG');
imwrite(uint8(aluIDCT),"output/aluIDCTJPEG.png",'PNG');
imwrite(uint8(aluRGB),"output/aluRGBJPEG.png",'PNG');

figure
imshow(uint8(tulipRGB))
imwrite(uint8(tulipYCbCr),"output/tulipYCbCrJPEG.png",'PNG');
imwrite(uint8(tulipSS),"output/tulipSSJPEG.png",'PNG');
imwrite(uint8(tulipDCT),"output/tulipDCTJPEG.png",'PNG');
imwrite(uint8(tulipQuant),"output/tulipQuantJPEG.png",'PNG');
imwrite(uint8(tulipDequant),"output/tulipDequantJPEG.png",'PNG');
imwrite(uint8(tulipIDCT),"output/tulipIDCTJPEG.png",'PNG');
imwrite(uint8(tulipRGB),"output/tulipRGBJPEG.png",'PNG');

%% Step 4: Error Computation

% 1. Compute the pixel-wise error(difference) between the original frame
% and output frame and display error using imagesc()

aluError = aluOriginal - double(aluRGB);
figure
imagesc(aluError)

tulipError = tulipOriginal - double(tulipRGB);
figure
imagesc(tulipError)



% 2. Compute Peak SNR (I is original frame and I' is output frame)
% MSE = 1/(M*N)*sumM(sumN((I[x,y]-I'[x,y])^2))
aluMSE = 1/(size(aluRGB,1)*size(aluRGB,2))*sum(sum((aluOriginal - double(aluRGB)).^2));

tulipMSE = 1/(size(aluRGB,1)*size(aluRGB,2))*sum(sum((tulipOriginal - double(tulipRGB)).^2));

% PSNR = 20*log10(255/sqrt(MSE))
aluPSNR = 20.*log10(255./sqrt(aluMSE));
tulipPSNR = 20.*log10(255./sqrt(tulipMSE));

%% Step 5: Group Report Output

% MaluIDCT = zeros(size(aluIDCT));
% for x = 8:8:size(aluDequant,1)
%     for y = 8:8:size(aluDequant,2)
%         MaluIDCT(x-7:x,y-7:y,1) = dct2(aluSS(x-7:x,y-7:y,1));
%         MaluIDCT(x-7:x,y-7:y,2) = dct2(aluSS(x-7:x,y-7:y,2));
%         MaluIDCT(x-7:x,y-7:y,3) = dct2(aluSS(x-7:x,y-7:y,3));
%         
%     end
%     
% end
% 
% max(max(aluDCT(1:100,1:100,:) - MaluIDCT(1:100,1:100,:)))

