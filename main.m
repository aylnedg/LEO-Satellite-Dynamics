%%%simulation of a low Earth satellite
disp('simulation started')
%%%
planet
%%%initial cond.
altitude=254*1.6*1000; %metre(ISS yüksekliği)
x0=R+altitude;
y0=0;
z0=0;
xdot0=0;
inclination=51.6*pi/180;
semi_major=norm([x0;y0;z0]);
vcircular= sqrt(mu/semi_major);
ydot0=vcircular*cos(inclination);
zdot0=-vcircular*sin(inclination);
stateinitial=[x0,;y0;z0;xdot0;ydot0;zdot0];
%%%time
period=2*pi/sqrt(mu)*semi_major^(3/2);
number_of_orbits=1;
tspan=[0 period*number_of_orbits];


%%%this is where we integrate the equation motion
[tout,stateout]=ode45(@Satellite,tspan,stateinitial);

%%%
stateout=stateout/1000; %km dönüşümü

%%% state vector
xout=stateout(:,1);
yout=stateout(:,2);
zout=stateout(:,3);

%%% make an Earth
[X,Y,Z]=sphere(100);
X=X*R/1000;
Y=Y*R/1000;
Z=Z*R/1000;



%%% plot 3d
fig=figure();
set(fig,'color','white')
plot3(xout,yout,zout,'b-','LineWidth',4)
grid on
hold on
surf(X,Y,Z,'EdgeColor','none')
axis square