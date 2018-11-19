
function [prtemp,conteo]=markovProcess(psec,pi,a)

%%%%evaluar un vector
conteo=0;
for i=1:length(psec)
    if i==1
        prT(i)=pi(psec(2,i));
    else
            prT(i)=a(psec(2,i-1),psec(2,i));
    end
 end
  


    prtemp=prod(prT(1:i));
end
