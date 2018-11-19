function [blink]=blinkSet(L,b,seg,total,aten)
    seg2=seg;
    for i=1:total
    blink(i,:)=zeros(1,L);
    noise = (-1*rand(1,L)+rand(1,L))*0.28;
    blink(i,:)=noise;
    seg=seg2;
    salto=4;
    for j=1:1:b-1
           m=randi([125 130],1,1);
           for k=seg*j:1:seg*j+seg/salto
                if k<=2560
                blink(i,k)=(-0.0625*m)+9+blink(i,k);
               m=m+1;
                end
           end  
    end
    seg=seg+8;
    salto=salto+0.2;
    blink(i,:)=blink(i,:)*aten;%aten recomendado en 200
    aten=aten-8;
    end
end