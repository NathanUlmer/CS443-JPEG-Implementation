function [imIDCT] = IDCT2D(imDequant,N)
%IDCT2D Summary of this function goes here
%   Detailed explanation goes here
im = imDequant;

C = @(x) (x>0)*sqrt(1/N) + (x==0)*sqrt(2/N);

Basis = @(u,v,i,j) C(i)*C(j)*cos(((2*i+1).*u.*pi)./(2.*N)).* cos(((2.*j+1).*v.*pi)./(2.*N));


Fij = zeros(size(im));



% Group Image into DCT Blocks
for x = 1:N:size(im,1)
    for y = 1:N:size(im,2)
        
        % Loop through each DCT block and apply DCT
        for u = 0:1:N-1
            for v = 0:1:N-1
                
                Ysum = 0;
                Cbsum = 0;
                Crsum = 0;
                for i = 0:1:N-1
                    for j = 0:1:N-1                        
                        if(x+i <=size(im,1) && y+j <= size(im,2))
                            Ysum = Ysum + Basis(u,v,i,j)*im(x+i,y+j,1);
                            Cbsum = Cbsum + Basis(u,v,i,j)*im(x+i,y+j,2);
                            Crsum = Crsum + Basis(u,v,i,j)*im(x+i,y+j,3);
                        end
                    end
                end
                
                
                
                Fij(x+u,y+v,1) = Ysum; 
                Fij(x+u,y+v,2) = Cbsum; 
                Fij(x+u,y+v,3) = Crsum; 
            end
        end
        

    end
end

imIDCT = im;
end

