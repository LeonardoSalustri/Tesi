function [] = tuning_selezionaN(theta,tau,k,P)
s=tf("s");
t=0:0.1:12000;
lista_risultati={};
[kp_z,Ti_z,Td_z]=ziegler_nichols(theta,tau,k);
[kp_c,Ti_c,Td_c]=cohen(theta,tau,k);
[kp_3,Ti_3,Td_3]=tre_C(theta,tau,k);
lista={};
cont=1;
%voglio indagare sul migliore dei 3 per ogni N per il tempo d' assestamento
for N=0.1:0.5:10.1
    PID_ziegler=kp_z*(1+1/Ti_z/s+Td_z*s/(1+Td_z/N*s));
    PID_cohen=kp_c*(1+1/Ti_c/s+Td_c*s/(1+Td_c/N*s));
    PID_3C=kp_3*(1+1/Ti_3/s+Td_3*s/(1+Td_3/N*s));
    Wz=PID_ziegler*P/(1+PID_ziegler*P);
    Wc=PID_cohen*P/(1+PID_cohen*P);
    W3=PID_3C*P/(1+PID_3C*P);
    yz=step(t,Wz);
    yc=step(t,Wc);
    y3=step(t,W3);
    info=[];
    infoz=stepinfo(yz,t);
    infoc=stepinfo(yc,t);
    info3=stepinfo(y3,t);
    info(1)=infoz.SettlingTime;
    info(2)=infoc.SettlingTime;
    info(3)=info3.SettlingTime;
    [minimum,indices]=min(info);
    if indices==1
        lista_risultati{cont}="N="+N+" ziegler"+" min="+info(1);
    end
    if indices==2
        lista_risultati{cont}="N="+N+" cohen"+" min="+info(2);
    end
    if indices==3
        lista_risultati{cont}="N="+N+" 3C"+" min="+info(3);
    end
    plotter=[yz,yc,y3];
    plottato=plot(t,plotter);
    plottato(1).LineWidth=2;
    plottato(2).LineWidth=2;
    plottato(3).LineWidth=2;
    hold on;
    lista{cont}="N="+N;
    cont=cont+1;
end
legend(lista);
lista=lista_risultati;
for i=1:length(lista)
    display(lista{i})
end   
end

