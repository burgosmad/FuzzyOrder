function [membership,w,senial]=generarSeniales01(fil,col,MatMez)
%initialize variables
nSegundos =20;
frecMuestreo = 128; %Hz
L=nSegundos*frecMuestreo;
t=[0:1/frecMuestreo:nSegundos];
load('HR.mat')
ftemp = frecMuestreo*(0:(L/2))/L;
%Generar prototpos de conjunto :artefacto parpadeo
nBlinks=5;
blink2=blinkSet(L,nSegundos,frecMuestreo,nBlinks,200);

[SynthSignal,P,orSignals,SSignal]=SyntheticSignalGeneration(fil,col,MatMez);

[ss,ss2]=size(SSignal);
nSeniales=ss;

%%%%%%%%%%%%%Aplicar ICA%%%%%%%%%%%%%%%%
[w,s] = runica(SSignal(:,:),'ncomps',ss,'lrate',0.0001,'reset_randomseed','off');
senial=real(w)*SSignal(:,:);



 totalM=ss;
 c=1;   

    for cc=1:nSeniales
      if c<=totalM
       Y= fft(senial(c,1:L));
       P2 = abs(Y/L);
       P1 = P2(1:L/2+1);
       P1(2:end-1) = 2*P1(2:end-1);
       P3{cc,2}=P1;
       totalEnergia(1,c)=sum(P1(find(ftemp==1):find(ftemp==30)));
        %%%% delta (0.5–3.5?Hz), theta (4–7?Hz), alpha (8–12?Hz), beta (13–30?Hz), and gamma (>30?Hz) 
        membership(1,c)=sum(P1(find(ftemp==0.5):find(ftemp==3.5)))/ totalEnergia(1,c);
        membership(2,c)=sum(P1(find(ftemp==4):find(ftemp==7)))/ totalEnergia(1,c);
        membership(3,c)=sum(P1(find(ftemp==8):find(ftemp==12)))/ totalEnergia(1,c);  
        membership(4,c)=sum(P1(find(ftemp==13):find(ftemp==30)))/ totalEnergia(1,c);
        c=c+1;
      end
    end

        %Metodo 2 para calcular membresía
        %medida de similitud covarianza
        %Set Blink vs señales
        %%%%%%%%%%%%%calculo la xcorr de cada señal con los 5 elementos de cada
        %%%%%%%%%%%%%conjunto y después comparo entre los 2 conjuntos segun a cual
        %%%%%%%%%%%%%elemento se parecia mas
        [sg,sg2]=size(senial);
        for j=1:nSeniales
            for i=1:nBlinks;
               temp(1,i)=max(abs(xcorr(senial(j,1:sg2-1),blink2(i,:),'coeff')));
            end
           mTemp(1,j)=sum(abs(temp))/length(temp);
        end
            membership(5,:)=mTemp;
              l=length(senial(5,:));
            
                [psec,pi,val,a]=modelSec(HRsignal(1:128));
                prMAX=max(pi);
                for i=1:l
                        prMAX=prMAX* max(max(a));
                end
                for cc=1:nSeniales
                    
                    for r=1:nSegundos
                        psecn=modelSec(senial(cc,1*r:128*r)');
                        [temp(1,r),conteo]=markovProcess(psecn,pi,a);
                        %figure();
                        hist(senial(cc,1*r:128*r));
                    end
                    temp2=temp;
                     temp(temp==0)=[];
                     temp2(temp2==0)=min(temp);
                    pr(cc,:)=sum(temp2)/r;
                    
                      
                       HRmem(cc,1)= pr(cc,1)/prMAX;
                end
            logmem=log(HRmem);
            for cc=1:nSeniales
                membership(6,cc)=1-abs(logmem(cc))/max(abs(logmem));% no se usa el -1 ya que ya esta la membresia que me interesa
            end

end