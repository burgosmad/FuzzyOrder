%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Description: Returns the membership to the criteria (Distribution based)
%%% Inputs:
%%% Outputs: m-memberships
%%% Author: Andrea Burgos Madrigal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function proofHRmem()
    load('HR.mat')
    clear HRsignalEv;
    Anoise=0;
    HRsignalEv=createHR(Anoise,229,30);

    for i=1:10
        
        Anoise=Anoise+0.05;
        HRsignalEv=horzcat(HRsignalEv,createHR(Anoise,229,30))
    end
    
    [pi,val,psec,a]=modelSec(HRsignal(1:1200));
    prMAX=(max(pi(1,:)));
    l=length(HRsignalEv);
    
    for i=1:l
        prMAX=prMAX* max(max(a));
    end
    for c=1:11
        h=histogram(HRsignalEv(:,c),6);
        val=h.Values;
        psecn(1,:)=HRsignalEv(:,c);
        
                        for i=1:length(psecn)
                            for j=1:length(val)
                                if (psecn(1,i)>=h.BinEdges(j)&&psecn(1,i)<h.BinEdges(j+1))
                                    psecn(2,i)=j;
                                    if j>5
                                       psecn(2,i)=j-1;
                                    end
                                end
                             %obtener probabilidades de estados iniciales   
                            end 
                        end

                          [pr(c,1),conteo]=markovProcess(psecn,pi,a);
    end
    for c=1:11
       HRmem(c,1)= pr(c,1)/prMAX;
    end
    logmem=log(HRmem)
    for i=1:11
       m(i,1)=1-abs(logmem(i))/max(abs(logmem));% no se usa el -1 ya que ya esta la membresia que me interesa

    end
 
end