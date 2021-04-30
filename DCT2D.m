function [imDCT] = DCT2D(imYCbCr,N)
%DCT2D Summary of this function goes here
%   Detailed explanation goes here

im = zeros(size(imYCbCr,1)+N-mod(size(imYCbCr,1),N),size(imYCbCr,2)+N-mod(size(imYCbCr,2),N),3);
im(1:size(imYCbCr,1),1:size(imYCbCr,2),:) = imYCbCr;

C = @(x) (x>0)*sqrt(2/N) + (x==0)*sqrt(1/N);

Basis = @(u,v,i,j) cos(((2*i+1).*u.*pi)./(2.*N)).* cos(((2.*j+1).*v.*pi)./(2.*N));


Fuv = zeros(size(im));



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
%                         elseif(x+i <= size(im,1))
%                             Ysum = Ysum + Basis(u,v,i,j)*im(x+i,y+j,1);
%                             Cbsum = Cbsum + Basis(u,v,i,j)*im(x+i,y+j,2);
%                             Crsum = Crsum + Basis(u,v,i,j)*im(x+i,y+j,3);
%                         elseif(y+j <=size(im,2))
%                             Ysum = Ysum + Basis(u,v,i,j)*im(x+i,y+j,1);
%                             Cbsum = Cbsum + Basis(u,v,i,j)*im(x+i,y+j,2);
%                             Crsum = Crsum + Basis(u,v,i,j)*im(x+i,y+j,3);
                        end
                    end
                end
                
                firstTerm = C(u)*C(v);
                
                
                if(x+u <= size(im,1) && y+v <=size(im,2))
                    Fuv(x+u,y+v,1) = firstTerm * Ysum; 
                    Fuv(x+u,y+v,2) = firstTerm * Cbsum; 
                    Fuv(x+u,y+v,3) = firstTerm * Crsum; 
                elseif(x+u <= size(im,1))
                elseif(y+v <=size(im,2))
            end
        end
        

    end
end





imDCT = Fuv;
end

