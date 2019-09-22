function [kp,Ti,Td] = cohen(theta,tau,k)
kp=(tau/theta*1.35+0.27)/k;
Ti=tau*(2.5*theta/tau*(1+theta/tau/5)/(1+0.6*(theta/tau)));
Td=tau*0.37*theta/tau/(1+0.2*theta/tau);
end

