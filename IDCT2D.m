function [imIDCT] = IDCT2D(imDequant,org,N)
%IDCT2D Summary of this function goes here
%   Detailed explanation goes here
im = zeros(size(imDequant,1)+N-mod(size(imDequant,1),N),size(imDequant,2)+N-mod(size(imDequant,2),N),3);
im(1:size(imDequant,1),1:size(imDequant,2),:) = imDequant;

C = @(x) (x>0)*sqrt(2/N) + (x==0)*sqrt(1/N);

Basis = @(u,v,i,j) C(i)*C(j)*cos(((2*u+1).*i.*pi)./(2.*N)).* cos(((2.*v+1).*j.*pi)./(2.*N));


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
                
                
                if(x+u <= size(im,1) && y+v <=size(im,2))
                    Fij(x+u,y+v,1) = Ysum; 
                    Fij(x+u,y+v,2) = Cbsum; 
                    Fij(x+u,y+v,3) = Crsum; 
                end
            end
        end
        

    end
end

imIDCT = double(uint8(Fij(1:size(org,1),1:size(org,2),:)));
end

