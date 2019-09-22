function [out1] = prova(theta,tau,k,P)
s=tf("s");
lista={};
t=0:0.1:20000;
[kp_c,Ti_c,Td_c]=cohen(theta,tau,k);
opt=stepDataOptions;
opt.stepAmplitude=1;
cont=1;
for N=0.1:0.05:0.50
    PID_cohen=-kp_c*(1+1/Ti_c/s+Td_c*s/(1+Td_c/N*s));
    Wc=PID_cohen*P/(1+PID_cohen*P);
    y1=step(Wc,t,opt);
    plot(t,y1);
    hold on;
    lista{cont}="N="+N;
    cont=cont+1;
end
legend(lista);
hold off;

end

