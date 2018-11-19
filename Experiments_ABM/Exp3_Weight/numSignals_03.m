%%%%%%% Se calcula el orden final por medio de 4 métodos diferentes
%%%%%%% 1. Sin hacerle nada a los valores de membresía obtenidos
%%%%%%% 2.- Colocndo un pesao a cada uno de los criterios con el vector W
%%%%%%% 3.- Por medio de un modificador de contraste
%%%%%%% 4.- Intensificadores de contraste
%%%%%%% Se observa la tendencia de los datos según el pesado
%%%%%%% Autor: Andrea Burgos Madrigal
%%%%%%% Fecha: 22/03/17
function [m,equalized,M]=numSignals_03(r)

MatMez=[1.0 0.0 0.8 0.0 0.1 0.3;
       0.2 1.0 -0.6 0.0 0.0 0.15;
       -0.1 0.7 1.0 0.2 0.0 0.0;
       0.0 0.6 0.0 1.0 -0.2 0.4;
        0.0 0.6 0.0 0.5 1.0 0.0;
       -0.5 0.0 0.1 0.0  0.75 1.0];
   rng(0);
for k=1:r
 %%%initialize
   M(:,:,k)=rand*0.63+MatMez;
   M(:,:,k)= M(:,:,k)/(max(max(abs(M(:,:,k)))))

   w=[0.05 0.1 0.2 0.35 0.15 0.15];
   IB2=zeros(7,length(w));
 

%%% Obtengo los niveles de pertenencia de cada uno de mis componentes a los
%%% Criterios definidos 
%%% c1: Deltha 0.5 a 3.5 Hz
%%% c2: Theta 4 a 7 Hz
%%% c3: Alpha 8 a 12 Hz
%%% c4: Beta 13 a 30 Hz

[membership,W(:,:,k),senial]=generarSeniales01(3,2,M(:,:,k));
temp=membership;
membership(5,:)=1-membership(5,:);
membership(6,:)=1-membership(6,:);

m(:,:,k)=membership';
clear membership;

[equalized(:,:,k)]=distributeValues2(m);

end


