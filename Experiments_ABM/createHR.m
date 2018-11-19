%Crea la seal de HR
%Autor: Andrea Burgos
%Julio 2017
function [HRsignal]=createHR(Anoise,fin,N)

    sfecg=128;
    hrstd=1;
    ti=[-70 -15 0 15 100];
    ai = [1.2 -5 30 -7.5 0.75];
    bi = [0.25 0.1 0.1 0.1 0.4];
    lfhfratio=0.5;
    hrmean=80;
    sfint=128;
    [HRsignal1, ipeaks] = ecgsyn(sfecg,N,Anoise,hrmean,hrstd,lfhfratio,sfint,ti,ai,bi);
    HRsignal=HRsignal1(1:fin); 
end