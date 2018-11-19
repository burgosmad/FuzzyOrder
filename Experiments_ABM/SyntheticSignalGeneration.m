%Generación de señales sintéticas
function [SynthSignal,P,orSignals,SSignal]=SyntheticSignalGeneration(fil,col,MatMez)

nCanales = 6;
nSegundos =20;
frecMuestreo = 128; %Hz
L=nSegundos*frecMuestreo;
variacionAmplitud = 0.3;

t=[0:1/frecMuestreo:nSegundos]; %[s]
nMuestras = length(t);
variacionAmplitud = 0.3;
f=[0:.1:30]; %[Hz] %Frecuencias Sinusoidales Puras
nFrec = length(f);

%% Generación de sinusoidales puras

for ii=1:nFrec
    tmpF=f(ii);
    A=1+variacionAmplitud*((2*rand(1,nMuestras))-1);
    phase=2*pi*rand(1);
    SinusoidalesPuras(ii,:)=A.*sin(2*pi*tmpF*t+phase);
end

%% Generación de la matriz de mezclas
M = zeros(nFrec,nMuestras,nCanales); 
%%%%The frequency bands were defined as follows:
%%%% delta (0.5–3.5?Hz), theta (4–7?Hz), alpha (8–12?Hz), beta (13–30?Hz), and gamma (>30?Hz) 
%%%%EEG Correlates of Self-Referential Processing Gennady G. Knyazev1,*
vAm=[
    1 0 0 0 0 0
    0 1 0 0 0 0
    0 0 1 0 0 0
    0 0 0 1 0 0
    0 0 0 0 1 0
    0 0 0 0 0 1
    ];
    
rango1 = find(f==0.5):find(f==3.5);%%%%%%%delta 
rango2 = find(f==4):find(f==7);%theta (4–7?Hz)
rango3 = find(f==8):find(f==12);%alpha (8–12?Hz) 
rango4 = find(f==13):find(f==30);%beta (13–30?Hz)
%[ecgSignal]=1*ecgGenerator(L,b,seg);
HRsignal=createHR(0,(128*nSegundos+1),60);
HRsignal=HRsignal';
eta = 50*rand(1,L+1);
Anoise=0.1;
for cc=1:nCanales
    M = zeros(nFrec,nMuestras,nCanales);  
    for kk=0:nSegundos-1
        tmpInd = ((frecMuestreo*kk)+1):1:((frecMuestreo*(kk+1)));

        M(rango1,tmpInd,cc)=vAm(cc,1);    
        M(rango2,tmpInd,cc)=vAm(cc,2);   
        M(rango3,tmpInd,cc)=vAm(cc,3);   
        M(rango4,tmpInd,cc)=vAm(cc,4);
        if cc<=5
            
            if cc==1
                 SynthSignal(cc,:)=sum(M(:,:,cc).*SinusoidalesPuras)+blinkNoise2(L+1 ,nSegundos,frecMuestreo,1,200,0)*vAm(cc,5)+eta*Anoise;
            else    
              SynthSignal(cc,:)=sum(M(:,:,cc).*SinusoidalesPuras)+blinkNoise2(L+1 ,nSegundos,frecMuestreo,1,200,0)*vAm(cc,5);
            end
        else
            SynthSignal(cc,:)=sum(M(:,:,cc).*SinusoidalesPuras)+1*HRsignal*vAm(cc,6);
            
            %SynthSignal(cc,:)=sum(M(:,:,cc).*SinusoidalesPuras)+1*ecgGenerator(L+1,nSegundos,frecMuestreo)*vAm(cc,6);
        end
    end

end
 [ss,ss2]=size(SynthSignal);
nSeniales=ss;
L=nSegundos*frecMuestreo;

c=1;
for cc=1:nSeniales
     % if c<=totalM
       Y= fft(SynthSignal(c,1:L));
       P2 = abs(Y/L);
       P1 = P2(1:L/2+1);
       P1(2:end-1) = 2*P1(2:end-1);
       P{cc,1}=P1;
        c=c+1;
end

orSignals=SynthSignal;
[ss,ss2]=size(orSignals);
SSignal=zeros(ss,ss2);

    
    for u=1:nSeniales
        for uu=1:nSeniales
         SSignal(u,1:ss2)=SSignal(u,1:ss2)+orSignals(uu,1:ss2)*MatMez(u,uu);%erroneamente en los experimentos se reporto usando MatMez(uu,u), se cambio para la presentación
        end
    end
% subtitle={'M1';'M2';'M3';'M4';'M5';'M6'};

% createfigSignals(SSignal,'Mixed Signals',subtitle,'m',t,fil,col);


end 
  
  
  