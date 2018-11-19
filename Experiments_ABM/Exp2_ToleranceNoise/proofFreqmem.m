%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Description: Returns the membership to the criteria (Knowledge based)
%%% Inputs:
%%% Outputs: m-memberships
%%% Author: Andrea Burgos Madrigal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [m]=proofFreqmem()
    %clear all;
    %close all;
    r=2;%#replications
    nSegundos =20;
    frecMuestreo = 128; %Hz
    L=nSegundos*frecMuestreo;
    variacionAmplitud = 0.3;
    
    t=[0:1/frecMuestreo:nSegundos]; %[s]
    nMuestras = length(t);
    f=[0:.1:30]; %[Hz] %Frecuencias Sinusoidales Puras
    nFrec = length(f);
    ftemp = frecMuestreo*(0:(L/2))/L;
     for k=1:r %cuántas replicaiones en total
    for ii=1:nFrec
        tmpF=f(ii);
        A=1+variacionAmplitud*((2*rand(1,nMuestras))-1);
        phase=2*pi*rand(1);
        SinusoidalesPuras(ii,:)=A.*sin(2*pi*tmpF*t+phase);
    end
    %load('SinusoidalesPuras.mat')
     Anoise=0;
    rango1 = find(f==0.5):find(f==3.5);%%%%%%%delta 
   rango2 = find(f==4):find(f==7);%theta (4–7?Hz)
   % rango3 = find(f==8):find(f==12);%alpha (8–12?Hz) 
    rango4 = find(f==13):find(f==30);%beta (13–30?Hz)

       set(groot,'defaultAxesLineStyleOrder',{'-'}) 
    
        eta = 50*rand(1,L);
         for cc=1:12
            M = zeros(nFrec,nMuestras,12); 
            if cc>2
                  Anoise=Anoise+0.05;
            end
               
           % Anoise=
            for kk=0:nSegundos-1
                tmpInd = ((frecMuestreo*kk)+1):1:((frecMuestreo*(kk+1)));
                M(rango1,tmpInd,cc)=1;    
                SynthSignal(cc,:)=sum(M(:,:,cc).*SinusoidalesPuras);
              
            end
            SynthSignal(cc,1:length(eta))= SynthSignal(cc,1:length(eta))+ Anoise*eta;
            

         end

    %% illustrates every replication 
    figure1 = figure;
   
       for cc=1:12
         % if c<=totalM
           Y= fft(SynthSignal(cc,1:L));
           P2 = abs(Y/L);
            P1 = P2(1:L/2+1);
            P1(2:end-1) = 2*P1(2:end-1);
            P{cc,1}=P1;
           %%%print spectrum
            subplot1 =subplot(6,2,cc,'Parent',figure1);
            ylim(subplot1,[0 1]);
            xlim(subplot1,[0 30]);
            box(subplot1,'on');
            hold(subplot1,'on');
            plot(ftemp,P{cc,1},'Parent',subplot1);
%             
            totalEnergia(1,cc)=sum(P1(find(ftemp==1):find(ftemp==30)));
       
            m(k,cc)=sum(P1(find(ftemp==0.5):find(ftemp==3.5)))/ totalEnergia(1,cc);
       end
        title=('Delta band adding noise');
     end

end