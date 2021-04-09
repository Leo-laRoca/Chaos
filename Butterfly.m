clc
close all
clear all

%parameters
x0=0.1;
y0=0.1;
z0=0.1;

p=28;
b=8/3;
d=10;

dt=0.005;
tempo=110;
nelms=(tempo/dt);
npoints=nelms+1;

x_numerico= zeros(npoints,1);
y_numerico= zeros(npoints,1);
z_numerico= zeros(npoints,1);

x2_numerico= zeros(npoints,1);
y2_numerico= zeros(npoints,1);
z2_numerico= zeros(npoints,1);

%initial condition

x_numerico(1)=x0;
y_numerico(1)=y0;
z_numerico(1)=z0;

x2_numerico(1)=x0+0.00001;
y2_numerico(1)=y0+0.00001;
z2_numerico(1)=z0+0.00001;

%simulation

for n=1:nelms
    x_numerico(n+1)= x_numerico(n)+d*dt*(y_numerico(n)-x_numerico(n));
    y_numerico(n+1)= y_numerico(n)+x_numerico(n)*(p-z_numerico(n))*dt-y_numerico(n)*dt;
    z_numerico(n+1)= z_numerico(n)+ x_numerico(n)*y_numerico(n)*dt-b*z_numerico(n)*dt;
    x2_numerico(n+1)= x2_numerico(n)+d*dt*(y2_numerico(n)-x2_numerico(n));
    y2_numerico(n+1)= y2_numerico(n)+x2_numerico(n)*(p-z2_numerico(n))*dt-y2_numerico(n)*dt;
    z2_numerico(n+1)= z2_numerico(n)+ x2_numerico(n)*y2_numerico(n)*dt-b*z2_numerico(n)*dt;
end


curve = animatedline('Color','b');
set(gca,'XLim',[-20 30], 'YLim', [-40 40], 'ZLim', [0 60],'Color','k','XColor','w', 'YColor','w');
set(gcf, 'Position', get(0, 'Screensize'));
set(gcf, 'InvertHardcopy', 'off')
view(43,25);
hold on;
grid on;
title('Chaos example - Lorenz butterfly');
red_curve = animatedline('Color','r','LineWidth',1);

for i=1:length(x_numerico)
    addpoints(curve, x_numerico(i), y_numerico(i), z_numerico(i));
    head = scatter3(x_numerico(i),y_numerico(i), z_numerico(i),'filled','MarkerFaceColor','b','MarkerEdgeColor','b');
    addpoints(red_curve, x2_numerico(i), y2_numerico(i), z2_numerico(i));
    head2 = scatter3(x2_numerico(i),y2_numerico(i), z2_numerico(i),'filled','MarkerFaceColor','r','MarkerEdgeColor','r');
    drawnow limitrate ;
    delete(head);
    delete(head2);
end
