function [psec,pi,val,a]=modelSec(s)

%% INPUT: s=señal o modelo de HR
%          tam=tamaño de la señal a comparar

%% OUTPUT: pi=probabilidades de estados iniciales
%          val=frecuencias totales del histograma
 %         psec= secuencia de valores y su bin equivalente en el histograma
%          a= matrix of transition probabilities

h=histogram(s,5);
val=h.Values;%[val,val2]=hist(s,3);
% s=s';
psec=s'; %%%%%%%%%%%%%depende del tamaño de la neva señal a comarar

%separacion=abs((val2(1)-val2(2))/2)
Sval=sum(val);
for i=1:length(psec)
    for j=1:length(val)
        if (psec(1,i)>=h.BinEdges(j)&&psec(1,i)<h.BinEdges(j+1))
            psec(2,i)=j;
        %else
           % psec(2,i)=1;
       % elseif val(2)-separacion<psec(1,i)&&psec(1,i)<val(2)+separacion
          %  psec(2,i)=0;
        %end
     %obtener probabilidades de estados iniciales   
        pi(j)=val(j)/Sval;  
        
    end 
end

%guardar matriz de incidencias
atemp=zeros(length(val),length(val));
%psec(2,:)=[1,2,3,2,2,1,3,2,3]
for k=1:length(psec)-1
    if psec(2,k+1)>0 && psec(2,k)>0 && psec(2,k+1)<11 && psec(2,k)<11
        atemp(psec(2,k),psec(2,k+1))=atemp(psec(2,k),psec(2,k+1))+1;
    
    end
    
end
atemp(atemp==0)=1;
for i=1:length(val)
    
    for j=1:length(val)
        if val(i)==0
            a(i,j)=0;
        else    
            a(i,j)=atemp(i,j)/val(j);
        end
    end
end

end
