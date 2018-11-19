
%
% Prueba de replicación de la metodologia de Bruggemann [1] y Walle [2]
%
%
%
%% Software for verification
%
% http://fuzzy.pyhasse.orgs
%
%
%
%% References
%
% [1] Bruggemann et al (2011) MATCH 66:581-603
% [2] Walle et al (1995) Fuzzy Sets and Systems, 74:115-126
%
%
%
% Date:1-Mar-2017

function [A,grupos,ord,SH,SHT,SHT_alpha,SHTE_alpha,FuzzyZeta,SHT2]=PruebaOrdenDifuso_0002(data)




%Datos
% Rows (a to p): These are the functions to be ordered
% Columns (q1 to q4): These are the criteria for setting the order
%
%   q1	q2      q3      q4	
% a	0	0.01	0.6432	0
% b	0	0.0377	0.5138	0
% c	0	0.0324	0.4542	0
% d	0	0.0314	0.4785	0
% e	0	0.048	0.4966	0
% f	0	0.0332	0.4072	0
% g	0	0.0516	0.425	0
% h	0	0.0448	0.4066	0
% i	0	0.0249	0.3484	0
% j	0	0.0485	0.3892	0
% k	0	0.0465	0.3553	0
% l	0	0.0557	0.3861	0
% m	0	0.0568	0.3568	0
% n	0	0.0169	0.0905	0
% o	0	0.0934	0.2201	0
% p	0	0.1515	0.1259	0


% data=[	0	0.01	0.6432	0; ...
% 	0	0.0377	0.5138	0; ...
% 	0	0.0324	0.4542	0; ...
% 	0	0.0314	0.4785	0; ...
% 	0	0.048	0.4966	0; ...
% 	0	0.0332	0.4072	0; ...
% 	0	0.0516	0.425	0; ...
% 	0	0.0448	0.4066	0; ...
% 	0	0.0249	0.3484	0; ...
% 	0	0.0485	0.3892	0; ...
% 	0	0.0465	0.3553	0; ...
% 	0	0.0557	0.3861	0; ...
% 	0	0.0568	0.3568	0; ...
% 	0	0.0169	0.0905	0; ...
% 	0	0.0934	0.2201	0; ...
% 	0	0.1515	0.1259	0];


%% Step 0: Initialization
nFunctions = size(data,1);
nCriteria = size(data,2);


%% Step 1) Calculate the subsethood (SH)
%
% Subsethoods are calculated on a pair-wise basis. For each pair of
% functions an assymetric subsethood may be calculated.

[SH]=Fuzzy_getSubsethood(data);


%%%%Check transitivity

%% Step 2) Calculate the transitive hull of the subsethood (SH)
%
% Ensure that the above matrix compliess with the transitive property
% necessary for relations of order

[SHT]=Fuzzy_TransitiveHull(SH);

%%%%Check transitivity
Fuzzy_checkTransitivity(SHT); %Debe ser transitivo




%% Step 3) Apply cutset
%
% Basically thresholding the transitive hull SHT matrix.
%
 %Cutset point (threshold for the transitive hull matrix;
 
alpha=graythresh(SHT(1:(length(SH)-1),1:(length(SH)-1)));
SHT_alpha= (SHT>=alpha);
%% Step 4) Define equivalence classes
%
%Cutsets are preorders and each cutset (threshold) defines a equavalence
%relation SHTE
%

SHTE_alpha = and(SHT_alpha,SHT_alpha');

%% Step 5) Extract equivalent classes (groups)
%
%

prototypesIdx=[];
tmp = tril(ones(size(SHTE_alpha)),-1);
tmp2=ones(size(tmp));
tmp2(tmp==1)=nan; %Get rid of the lower triangular matrix
tmp3=SHTE_alpha.*tmp2;
A=cell(nFunctions,1);
for ii=1:nFunctions, %Currently it depends on the order of visiting the functions
    idx=find(tmp3(ii,:)==1);
    A(ii)={idx};
    tmp3(idx,:)=nan;
    tmp3(:,idx)=nan;
    
    if ~isempty(idx)
        prototypesIdx=[prototypesIdx; ii];
    end
    
end



%% Step 6) Get the Fuzzy-Zeta matrix
%
%...now A has all the groups, ergo the non-empty cells in A are the
%prototypes of each group. Hence I cann get a Fuzzy-Zeta matrix by
%filtering those lines of SHT_alpha of interest

FuzzyZeta = SHT_alpha(prototypesIdx,prototypesIdx);


%%%%%%% calculo cual es el grupo mas grande
for i=1:length(A)
    tam(i)=length(A{i,:})    
end
for i=size(A):-1:1
    if tam(i)==0
        tam(i)=[];   
    end
end
maxtam=max(tam);
%%%% genero matriz de grupos
indexG=1;
grupos=zeros(length(tam),maxtam)
for i=1:length(A)
    if not(isempty(A{i,:}))
        grupos(indexG,1:tam(indexG))=A{i,:};
        indexG=indexG+1;
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%  quitar ciclos
    [sg,sg2]=size(grupos) 
    order=(zeros(sg,sg)) ;  
SHT2=SHT_alpha'
      k=1;
       for i=1:length(SHT2)
           temp=find(SHT2(i,:)==1)
            for j=1:length(temp)            
               [f,c]=find(grupos==temp(j));
               [f2,c2]=find(grupos==k);
               order(f2,f)=1;
            end
          k=k+1;

       end


ord=order
      v=[];
      %quito ciclos de la reflexividad
     for i=1:length(order)
        ord(i,i)=0;
     end
     
     
     
     for i=1:length(order)
          tc(i)=sum(ord(i,:));
     end

     [insOrd(1,:),insOrd(2,:)]=sort(tc)
     [sins,sins2]=size(insOrd)
     for i=sins2:-1:1
         
         if insOrd(1,i)~=0
         temp=find(ord(insOrd(2,i),:)==1)
        %if not(isempty(temp))
        
         for j=1:length(temp)
             temp2=find(ord(temp(j),:)==1)
             for k=1:length(temp2)
                 if ord(insOrd(2,i),temp2(k))==1
                     ord(insOrd(2,i),temp2(k))=0
                 end
             end    
         end
        end
     end
     
end
