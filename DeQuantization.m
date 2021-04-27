function [imDeQuant] = DeQuantization(imQuant,qf,N)
%DEQUANTIZATION Summary of this function goes here
%   Detailed explanation goes here
im = imQuant;

YQuantTable =  [16 11 10 16 24  40  51  61;
                12 12 14 19 26  58  60  55;
                14 13 16 24 40  57  69  56;
                14 17 22 29 51  87  80  62;
                18 22 37 56 68  109 103 77;
                24 35 55 64 81  104 113 92;
                49 64 78 87 103 121 120 101;
                72 92 95 98 112 100 103 99;];
            
            
CbCrQuantTable = [17 18 24 47 99 99 99 99;
                  18 21 26 66 99 99 99 99;
                  24 26 56 99 99 99 99 99;
                  47 66 99 99 99 99 99 99;
                  99 99 99 99 99 99 99 99;
                  99 99 99 99 99 99 99 99;
                  99 99 99 99 99 99 99 99;
                  99 99 99 99 99 99 99 99;]
if qf>=50
    sf = (100-qf)./50;
else
    sf = 50./qf;
end

if sf ~= 0
    YQx = round(YQuantTable.*sf);
    CbCrQx = round(CbCrQuantTable.*sf);
else
    YQx = 1;
    CbCrQx = 1;
end            

for i = 1:8:size(im,1)
    for j = 1:8:size(im,2)
        Fhat([i:i+N-1],[j:j+N-1],1) = round(im([i:i+N-1],[j:j+N-1],1).*YQx);
        Fhat([i:i+N-1],[j:j+N-1],2) = round(im([i:i+N-1],[j:j+N-1],2).*CbCrQx);
        Fhat([i:i+N-1],[j:j+N-1],3) = round(im([i:i+N-1],[j:j+N-1],3).*CbCrQx);
    end
end


imDeQuant = Fhat;
end

