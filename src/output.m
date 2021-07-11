load(matlab_leach,'-mat');
load(mtlab_sep,'-mat');
load(matlab_zsep,'-mat');

figure(2);
r=0:rmax;
plot(r,STATISTICS.ALLIVE3(r+1),'-b',r,STATISTICS.ALLIVE(r+1),'-r',r,STATISTICS.ALLIVE2(r+1),'-g')
legend('LEACH   m=0.1,a=2','SEP   m=0.1,a=2','Z-SEP  m=0.1,a=2');
xlabel('Rounds');
ylabel('Allive Nodes');

figure(3);
plot(r,STATISTICS.DEAD3(r+1),'-b',r,STATISTICS.DEAD(r+1),'-r',r,STATISTICS.DEAD2(r+1),'-g')
legend('LEACH  m=0.1,a=2','SEP    m=0.1,a=2','Z-SEP  m=0.1,a=2');
xlabel('Rounds');
ylabel('Dead Nodes');

figure(4);
plot(r,STATISTICS.packets_TO_BS(r+1),'-r',r,STATISTICS.packets_TO_BS3(r+1),'-b',r,STATISTICS.PACKETS_TO_BS2(r+1),'-g')
legend('LEACH   m=0.2,a=1','SEP    m=0.2,a=1','Z-SEP m=0.2,a=1');
xlabel('Rounds');
ylabel('Packets to BS');