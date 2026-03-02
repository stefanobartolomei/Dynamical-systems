tRange = [0 20];
Init = [0.5 0.6 20];

[~,Sol] = ode23(@Lorentz,tRange,Init);

figure
plot3(Sol(:,1),Sol(:,2),Sol(:,3))
grid on
title('Lorentz Model')
clear
function dUdt = Lorentz(t,U)
sigma = 10;
r = 28;
b = 8/3;

dxdt = sigma*(U(2) - U(1));
dydt = r*U(1) - U(2) - U(1)*U(3);
dzdt = U(1)*U(2) - b*U(3);

dUdt =[dxdt;dydt;dzdt];
end

