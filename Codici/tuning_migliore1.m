function [PID_ziegler,PID_cohen,PID_3C] = tuning_migliore1(theta,tau,k,N,P)
s=tf("s");
t=0:0.1:10000;
[kp_z,Ti_z,Td_z]=ziegler_nichols(theta,tau,k);
[kp_c,Ti_c,Td_c]=cohen(theta,tau,k);
[kp_3,Ti_3,Td_3]=tre_C(theta,tau,k);
PID_ziegler=kp_z*(1+1/Ti_z/s+Td_z*s/(1+Td_z/N*s));
PID_cohen=kp_c*(1+1/Ti_c/s+Td_c*s/(1+Td_c/N*s));
PID_3C=kp_3*(1+1/Ti_3/s+Td_3*s/(1+Td_3/N*s));
Wz=PID_ziegler*P/(1+PID_ziegler*P);
Wc=PID_cohen*P/(1+PID_cohen*P);
W3=PID_3C*P/(1+PID_3C*P);
y1=step(t,Wz);
y2=step(t,Wc);
y3=step(t,W3);
plotter=[y1,y2,y3];
plottato=plot(t,plotter);
hold on;
plottato(1).LineWidth=2.5;
plottato(2).LineWidth=2.5;
plottato(3).LineWidth=2.5;
xlabel("Time(pu)");
ylabel("Voltage Amplitude(pu)");
legend({"Ziegler-Nichols","Cohen-Coon","3C"});
hold off;
end
