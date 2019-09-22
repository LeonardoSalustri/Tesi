function [PID_ziegler,PID_cohen,PID_3C] = tuning_migliore(theta,tau,k,N,P)
s=tf("s");
[kp_z,Ti_z,Td_z]=ziegler_nichols(theta,tau,k);
[kp_c,Ti_c,Td_c]=cohen(theta,tau,k);
[kp_3,Ti_3,Td_3]=tre_C(theta,tau,k);
PID_ziegler=-kp_z*(1+1/Ti_z/s+Td_z*s/(1+Td_z/N*s));
PID_cohen=-kp_c*(1+1/Ti_c/s+Td_c*s/(1+Td_c/N*s));
PID_3C=-kp_3*(1+1/Ti_3/s+Td_3*s/(1+Td_3/N*s));
Wz=PID_ziegler*P/(1+PID_ziegler*P);
Wc=PID_cohen*P/(1+PID_cohen*P);
W3=PID_3C*P/(1+PID_3C*P);
step(Wz,Wc,W3);
end

