clear all;
a = arduino('com8','uno');
imu1 = mpu6050(a);
b = arduino('com3','uno');
imu2 = mpu6050(b);
dt = 0.1;
ts = 10;
t = 0:dt:ts;
l1=0.5;
l2=0.5;
theta(1) = 0;
Theta(1) =0;
for i = 1:length(t)
    gyroReadings1 = readAngularVelocity(imu1);
    gyroReadings2 = readAngularVelocity(imu2);
    theta(i+1) = theta(i) + gyroReadings1(3)*dt;
    Theta(i+1) = Theta(i) + gyroReadings2(3)*dt;
    
    subplot(2,2,1);
    plot(t(1:i),theta(1:i))
    axis([-10,10,-3,3])
    subplot(2,2,3);
    plot(t(1:i),Theta(1:i))
    axis([-10,10,-3,3])
    
    th1(i)= 90*Theta(i)-90;
    th2(i)= 90*theta(i);
    l1_x(i)= l1*cosd(th1(i));
    l1_y(i)=l1*sind(th1(i));
    l2_x(i)=l1*cosd(th1(i))+l2*cosd(-th2(i));
    l2_y(i)=l1*sind(th1(i))+l2*sind(-th2(i));
    subplot(1,2,2);
    plot([0 l1_x(i) l2_x(i)],[0 l1_y(i) l2_y(i)])
    grid on
    axis([-1 1 -1 1]);
    pause(dt)
end