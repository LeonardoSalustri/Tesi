s=tf("s");
PID_cohen_2=tf(PID_cohen_2.Numerator{1}/PID_cohen_2.Denominator{1}(2),PID_cohen_2.Denominator{1}/PID_cohen_2.Denominator{1}(2));
PID_cohen_3=tf(PID_cohen_3.Numerator{1}/PID_cohen_3.Denominator{1}(2),PID_cohen_3.Denominator{1}/PID_cohen_3.Denominator{1}(2));
PID_new_2=PID_cohen_2;
PID_new_3=PID_cohen_3;
t=0:0.5:50000;
[kp2,Ti2,Td2,N2]=trova_parametri(PID_cohen_2);
[kp3,Ti3,Td3,N3]=trova_parametri(PID_cohen_3);
settling3=0;
aumento=0;
settling2=0;
warning off;
Ti_old2=0;
Ti_old3=0;
while settling2<=4050 && settling3<=4050
    aumento=aumento+100;
    Ti_old2=Ti_new2;
    Ti_old3=Ti_new3;
    Ti_new2=Ti2+aumento;
    Ti_new3=Ti3+aumento;
    PID_new_2=kp2*(1+1/(Ti_new2*s)+(Td2*s/(1+Td2/N2*s)));
    PID_new_3=kp3*(1+1/(Ti_new3*s)+(Td3*s/(1+Td3/N3*s)));
    sim("Modello_Completo");
    y_step2=simout.Data(:,1);
    y_step3=simout.Data(:,2);
    info2=stepinfo(y_step2,t)
    info3=stepinfo(y_step3,t)
    settling2=info2.SettlingTime;  
    settling3=info3.SettlingTime;
end
PID_new_2=kp2*(1+1/(Ti_old2*s)+(Td2*s/(1+Td2/N2*s)));
PID_new_3=kp3*(1+1/(Ti_old3*s)+(Td3*s/(1+Td3/N3*s)));
PID_new_2=tf(PID_new_2.Numerator{1}/PID_new_2.Denominator{1}(2),PID_new_2.Denominator{1}/PID_new_2.Denominator{1}(2));
PID_new_3=tf(PID_new_3.Numerator{1}/PID_new_3.Denominator{1}(2),PID_new_3.Denominator{1}/PID_new_3.Denominator{1}(2));