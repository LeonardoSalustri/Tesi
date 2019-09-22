function [] = seleziona_N(theta,tau,k,P)
s=tf("s");
lista={};
t=0:0.1:9000;
[kp_c,Ti_c,Td_c]=cohen(theta,tau,k);
opt=stepDataOptions;
opt.stepAmplitude=1;
cont=1;
for N=0.1:0.05:0.50
    PID_cohen=kp_c*(1+1/Ti_c/s+Td_c*s/(1+Td_c/N*s));
    F=PID_cohen*P;
    Wc=tf(F.Numerator{1},F.Numerator{1}+F.Denominator{1});
    y1=step(Wc,t,opt);
    plotter=plot(t,y1);
    plotter.LineWidth=1.5;
    hold on;
    lista{cont}="N="+N;
    cont=cont+1;
end
legend(lista);
xlabel("Time(pu)");
ylabel("Voltage Amplitude(pu)");
hold off;
end

