%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Description: Returns the membership to the criteria (Prototype based)
%%% Inputs:
%%% Outputs: m-memberships
%%% Author: Andrea Burgos Madrigal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [m]=proofBlinkmem()
    load('blinkT3.mat')
    blink2(1:30,:)=blink(1:30,:)
    clear blink;
    nSegundos =10;
    frecMuestreo = 128; %Hz
    nBlinks=1;
    L=frecMuestreo*nSegundos;
    for k=1:220 %cuántas replicaiones en total
        Anoise=1;
        
         blink(1,:)=blinkNoise(L,nSegundos,frecMuestreo,nBlinks,200,Anoise);
        for i=2:12

            
            
            blink(i,:)=blinkNoise2(L,nSegundos,frecMuestreo,nBlinks,200,Anoise);
            
            Anoise=Anoise+0.05;
           
        end
        faltan=length(blink2)-length(blink); 
        for j=2:12
            for i=1:30;
               temp(1,i)=max(abs(xcorr(blink2(i,:),horzcat(blink(j,1:L),zeros(1,faltan)),'coeff')));
               
               temp(isnan(temp)) = [];
               

            end
           mTemp(1,j-1)=sum(abs(temp))/length(temp);
        end
        m(k,:)=mTemp;
    end 
end