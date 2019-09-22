function [kp,Ti,Td] = tre_C(theta,tau,k)
kp=1.37/k*(tau/theta)^0.95;
Ti=tau*0.74*(theta/tau)^0.738;
Td=tau*0.365*(theta/tau)^0.95;
end

