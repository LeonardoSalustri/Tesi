function [kp,Ti,Td] = ziegler_nichols(theta,tau,k)
kp=tau/theta*1/k;
Ti=2*theta;
Td=theta/2;
end

