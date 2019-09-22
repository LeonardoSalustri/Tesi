function [out1] = migliora_k(F)
s=tf("s");
lista={};
t=0:0.1:20000;
opt=stepDataOptions;
opt.stepAmplitude=1;
cont=1;
for k=0:0.05:1
    W=F/(1+k*F);
    y1=step(W,t,opt);
    plot(t,y1);
    hold on;
    lista{cont}="k="+k;
    cont=cont+1;
end
legend(lista);
hold off;
end
