function [kp,Ti,Td,N] = trova_parametri(P)
num=P.Numerator{1};
den=P.Denominator{1};
kp=num(2)-den(1)*num(3);
Ti=kp/num(3);
N=(num(1)-den(1)*num(2)+den(1)*den(1)*num(3))/(den(1)*(num(2)-den(1)*num(3)));
Td=den(1)*N;
end

