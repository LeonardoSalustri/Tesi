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
while settling2<=5000 && settling3<=5000
    aumento=aumento+100;
    Ti_old2=Ti_new2;
    Ti_old3=Ti_new3;
    Ti_new2=Ti2+aumento;
    Ti_new3=Ti3+aumento;
    PID_new_2=kp2*(1+1/(Ti_new2*s));
    PID_new_3=kp3*(1+1/(Ti_new3*s));
    F2_new=PID_new_2*amplifier2*exciter2*Et2_Efd2;
    F3_new=PID_new_3*amplifier3*exciter3*Et3_Efd3;
    W2_new=tf(F2_new.Numerator{1},F2_new.Numerator{1}+F2_new.Denominator{1});
    W3_new=tf(F3_new.Numerator{1},F3_new.Numerator{1}+F3_new.Denominator{1});
    y_step2_new=step(t,W2_new);
    y_step3_new=step(t,W3_new);
    info2=stepinfo(y_step2_new,t)
    info3=stepinfo(y_step3_new,t)
    settling2=info2.SettlingTime;  
    settling3=info3.SettlingTime;
    %if abs(y_step2(5000)-1)>=0.005 || abs(y_step3(5000)-1)>=0.5
     %   break;
   % end
end
PID_new_2=kp2*(1+1/(Ti_old2*s));
PID_new_3=kp3*(1+1/(Ti_old3*s));