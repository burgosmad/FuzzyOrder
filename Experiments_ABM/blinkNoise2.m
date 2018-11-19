function [blink]=blinkNoise(L,seg,fm,total,aten,Anoise)
    
    for i=1:total
    blink(i,:)=zeros(1,L);
    noise = (-1*rand(1,L)+rand(1,L))*0.28;
    blink(i,:)=noise;
    
    eta = 2*rand(1,L)-1;
     blink(i,:)=  blink(i,:) + Anoise*eta;
    salto=4;
    for j=1:1:seg-1
           m=randi([125 130],1,1);
           for k=fm*j:1:fm*j+fm/4
                if k<=2560
                blink(i,k)=(-0.0625*m)+9+blink(1,k);
               m=m+1;
                end
            end    
        seg=seg+6;
        salto=salto+0.15;
    end
    blink(i,:)=blink(i,:)*aten;%aten recomendado en 200
    aten=aten-8;%10
    end
end
