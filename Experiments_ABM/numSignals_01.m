
%%%%%%% Permite crear la matriz de mezcla para r replicaciones y as´poder 
%%%%%%% realizar validación convergente y divergente
%%%%%%% Autor: Andrea Burgos Madrigal
%%%%%%% Fecha: 22/03/17
function [M,W,membership,mT]=numSignals_01(r)

%create the mix matriz base
MatMez=[1.0 0.0 0.8 0.0 0.1 0.3;
       0.2 1.0 -0.6 0.0 0.0 0.15;
       -0.1 0.7 1.0 0.2 0.0 0.0;
       0.0 0.6 0.0 1.0 -0.2 0.4;
        0.0 0.6 0.0 0.5 1.0 0.0;
       -0.5 0.0 0.1 0.0  0.75 1.0];
%r;%REPLICATIONS
rng(0);

M=zeros(6,6,r);
for k=1:r
%%%initialize matrices
    M(:,:,k)=rand*0.63+MatMez;
    M(:,:,k)= M(:,:,k)/(max(max(abs(M(:,:,k)))));
%%% criteria 
%%% c1: Deltha 0.5 a 3.5 Hz
%%% c2: Theta 4 a 7 Hz
%%% c3: Alpha 8 a 12 Hz
%%% c4: Beta 13 a 30 Hz
[m,W(:,:,k),senial]=generarSeniales01(3,2,M(:,:,k));
W(:,:,k)=inv(W(:,:,k));
mT(:,:,k)=m(:,:)';
[membership(:,:,k)]=distributeValues2(mT(:,:,k));
end

                                                                                                                                                                                                                                                                                        end
