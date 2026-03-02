function campo_LotkaVolterra(K1,K2)

[x_1,x_2] = meshgrid(0:.2:5,0:.2:5);

u = K1.*x_1.*(1-x_2);
v = -K2.*x_2.*(1-x_1);

figure
quiver(x_1,x_2,u,v,4)
shg
hold on
plot(0,0,'ro','MarkerFaceColor','red')
plot(1,1,'ro','MarkerFaceColor','red')
xlim([0,5])
ylim([0,5])