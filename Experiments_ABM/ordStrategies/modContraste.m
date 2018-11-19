function IB=modContraste(IB,umbral)
[f,c]=size(IB);

    for i=1:1:f
        for j=1:1:c
            if IB(i,j)<=umbral
                tempIB(i,j)=2*(IB(i,j))^2
            else
                tempIB(i,j)=(1-2*(1-IB(i,j))^2)
            end
        end
    end  
    IB=tempIB;

end
