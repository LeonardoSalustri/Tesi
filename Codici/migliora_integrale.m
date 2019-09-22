function [PID_finale,W] = migliora_integrale(PID2,P2,W2,PID3.P3,W3,tolleranza_tempo,t_f,passo,simout)
s=tf("s");
t=0:passo:t_f;
[kp2,Ti2,Td2,N2]=trova_parametri(PID2);
[kp3,Ti3,Td3,N3]=trova_parametri(PID3);
settling3=0;
aumento=0;
settling2=0;
while settling2<=tolleranza_tempo && settling3<=tolleranza_tempo
    aumento=aumento+10;
    Ti_new2=Ti2+aumento;
    Ti_new3=Ti3+aumento;
    sim("Modello_Completo");
    y_step2=simout.Data(:,1);
    y_step3=simout.Data(:,2);
    info2=stepinfo(y_step2,t);
    info3=stepinfo(y_step3,t);
    settling2=info2.SettlingTime;  
    settling3=info3.SettlingTime;
end
PID_finale=kp*(1+1/(Ti_new*s)+Td*s/(1+Td/N*s));
F_new=PID_new*P;
W=tf(F_new.Numerator{1},F_new.Numerator{1}+F_new.Denominator{1});
end

