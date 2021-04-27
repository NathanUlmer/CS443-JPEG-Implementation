function [imOut] = chromaSubsample(imYCbCr,subSampleType)
%CHROMASUBSAMPLE Summary of this function goes here
%   Detailed explanation goes here

%disp("       Subsampling: " + imagePath)
%disp("         a. Read in image and generate 3D matrix...")



img = imYCbCr;
Y = img(:,:,1);
Cb = img(:,:,2);
Cr = img(:,:,3);



%% Subsample the image and fill in the empty pixels
%disp("         c. Subsample...")
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


imYCbCr(:,:,1) = Y;
imYCbCr(:,:,2) = Cb;
imYCbCr(:,:,3) = Cr;




imOut = imYCbCr;
end

