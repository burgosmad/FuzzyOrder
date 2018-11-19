function [A,grupos,G,SHT_alpha]=ordenar(IB)  
    [A,grupos,ord,SH,SHT,SHT_alpha,SHTE_alpha,FuzzyZeta,SHT2]=OrdenDifuso_0002(IB);
    A=A'
    ind=1;
    [sa,sa2]=size(A);
    for i=1:sa2
     if not(isempty(A{1,i}))
         
         if i==sa2
             name{1,ind}=char(8869);
             %?
            
         else
             name{1,ind}=num2str(A{1,i});
            
         end
         ind=ind+1;
     end
    end 

    G=digraph(ord,name,'OmitSelfLoops');
   close all;
end