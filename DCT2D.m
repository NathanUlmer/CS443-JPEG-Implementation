function [imDCT] = DCT2D(imYCbCr,N)
%DCT2D Summary of this function goes here
%   Detailed explanation goes here

im = imYCbCr;

C = @(x) (x>0)*1 + (x==0)*sqrt(2)/2;

Basis = @(u,v,i,j) cos(2*i+1).*u.*pi./(2.*N)  .* cos(2.*j+1).*v.*pi./(2.*N);

Fuv = zeros(size(im));

% Group Image into DCT Blocks
for x = 1:N:size(im,1)
    for y = 1:N:size(im,2)
        
        % Loop through each DCT block and apply DCT
        for u = 0:1:N-1
            for v = 0:1:N-1
                F(x+u,y+v,1) = 2*C(i)*C(j)/sqrt(M*N) * Basis(u,v,[0:7],[0:7]) *
            end
        end
        
        %2*C(i)*C(j)/sqrt(M*N)
    end
end



% Generate Basis Functions
C = zeros(N,N);
for m = 0:1:N-1
	for n = 0:1:N-1
		if n == 0
		k = sqrt(1/N);
		else
		k = sqrt(2/N);
		end
	C(m+1,n+1) = k*cos( ((2*m+1)*n*pi) / (2*N));
	end
end   

imDCT = im;
end

