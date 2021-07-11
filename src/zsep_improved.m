%Proposed and implemented by Shah Faisal
%ComSense (Communication over Sensors) Research Group
%COMSATS Institute of Information Technology 


clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Field Dimensions - x and y maximum (in meters)
xm=100;
ym=100;

%x and y Coordinates of the Sink
sink.x=50;
sink.y=50;

%Number of Nodes in the field
n=100;

%Optimal Election Probability of a node
%to become cluster head
p=0.1;

%Energy Model (all values in Joules)
%Initial Energy
Eo=0.5;
%Eelec=Etx=Erx
ETX=50*0.000000001;
ERX=50*0.000000001;
%Transmit Amplifiers types
Efs=10*0.000000000001;
Emp=0.0013*0.000000000001;
%Data Aggregation Energy
EDA=5*0.000000001;


%Values for Hetereogeneity
%Percentage of nodes than are advanced
m=0.8;                  %%% changed from 0.1 to 0.8
%\alpha times advance nodes have energy greater than normal nodes
a=2;


%maximum number of rounds
rmax=9000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Computation of do
do=sqrt(Efs/Emp);
Et=0;
%Creation of the random Sensor Network


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Z sep                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);
xdl=33;
yd1=33;
hold off
for i=1:1:n
    if (i<=10)     %   z2 - 1
        S2(i).xd=rand(1,1)*xdl;
        S2(i).yd=rand(1,1)*yd1;
        S2(i).E=Eo*(1+a);
        S2(i).ENERGY=1;
        S2(i).type='A';
        plot(S2(i).xd,S2(i).yd,'og');
        hold on
    
    elseif (i>10 &&  i<=20)  %   z1 - 1
        S2(i).xd=33 + rand(1,1)*xdl;
        S2(i).yd=rand(1,1)*yd1;
        S2(i).E=Eo*(1+a);
        S2(i).ENERGY=1;
        S2(i).type='A';
0        plot(S2(i).xd,S2(i).yd,'og');
        hold on
	elseif (i>20 &&  i<=30)   %  z2 - 2
        S2(i).xd=rand(1,1)*xdl;
        S2(i).yd=66 + rand(1,1)*yd1;
        S2(i).E=Eo*(1+a);
        S2(i).ENERGY=1;
        S2(i).type='A';
        plot(S2(i).xd,S2(i).yd,'og');
        hold on
	elseif (i>30 &&  i<=40)    % z1 - 2
        S2(i).xd=rand(1,1)*xdl;
        S2(i).yd=33 + rand(1,1)*yd1;
        S2(i).E=Eo*(1+a);
        S2(i).ENERGY=1;
        S2(i).type='A';
        plot(S2(i).xd,S2(i).yd,'og');
        hold on
	elseif (i>40 &&  i<=50)    % z1 - 3
        S2(i).xd=66 + rand(1,1)*xdl;
        S2(i).yd=33 + rand(1,1)*yd1;
        S2(i).E=Eo*(1+a);
        S2(i).ENERGY=1;
        S2(i).type='A';
        plot(S2(i).xd,S2(i).yd,'og');
        hold on
	elseif (i>50 &&  i<=60)   %  z2 - 3
        S2(i).xd=66 + rand(1,1)*xdl;
        S2(i).yd=rand(1,1)*yd1;
        S2(i).E=Eo*(1+a);
        S2(i).ENERGY=1;
        S2(i).type='A';
        plot(S2(i).xd,S2(i).yd,'og');
        hold on
	elseif (i>60 &&  i<=70)    % z1 - 4
        S2(i).xd=33 + rand(1,1)*xdl;
        S2(i).yd=66 + rand(1,1)*yd1;
        S2(i).E=Eo*(1+a);
        S2(i).ENERGY=1;
        S2(i).type='A';
        plot(S2(i).xd,S2(i).yd,'og');
        hold on
	elseif (i>70 &&  i<=80)    % z2 - 4
        S2(i).xd=66 + rand(1,1)*xdl;
        S2(i).yd=66 + rand(1,1)*yd1;
        S2(i).E=Eo*(1+a);
        S2(i).ENERGY=1;
        S2(i).type='A';
        plot(S2(i).xd,S2(i).yd,'og');
        hold on
    else
        S2(i).xd=33 + rand(1,1)*xdl;
        S2(i).yd=33 + rand(1,1)*yd1;
        S2(i).E=Eo;
        S2(i).ENERGY=0;
        S2(i).type='N';
        plot(S2(i).xd,S2(i).yd,'ob');
        hold on
    end
end


 

S2(n+1).xd=sink.x;
S2(n+1).yd=sink.y;
plot(S2(n+1).xd,S2(n+1).yd,'green x');
xlabel('x');
ylabel('y');

figure(1);

flag_first_dead2=0;
allive2=n;

%counter for bit transmitted to Bases Station and to Cluster Heads
packets_TO_BS12=0;
packets_TO_BS22=0;
packets_TO_BS2=0;
packets_TO_CH2=0;

for r=0:1:rmax
%    r
    %Election Probability for Advanced Nodes
    padv= ( p*(1+a)/(1+(a*m)) );
    
    %Operations for sub-epochs
    if(mod(r, round(1/padv) )==0)
        for i=1:1:n
            if(S2(i).ENERGY==1)
                S2(i).G=0;
                %S2(i).cl=0;
            end
            
        end
    end
    
    %hold off;
    
    %figure(1);
    
    dead2=0;
    
    %Number of dead Advanced Nodes
    dead_a2=0;
    %Number of dead Normal Nodes
    dead_n2=0;
    
    for i=1:1:n
        %checking if there is a dead node
        if (S2(i).E<=0)
            %%plot(S2(i).xd,S2(i).yd,'red .');
            
            dead2=dead2+1;
            
            if(S2(i).ENERGY==1)
                dead_a2=dead_a2+1;
            end
            if(S2(i).ENERGY==0)
                dead_n2=dead_n2+1;
            end
            %hold on;
        end
        if (S2(i).E>0)
            S2(i).type='N';
            if (S2(i).ENERGY==0)
                %plot(S2(i).xd,S2(i).yd,'ob');
            end
            if (S2(i).ENERGY==1)
                %plot(S2(i).xd,S2(i).yd,'og');
            end
            %hold on;
        end
        %plot(S2(n+1).xd,S2(n+1).yd,'green x');
        
        STATISTICS4.DEAD2(r+1)=dead2;
        STATISTICS4.ALLIVE2(r+1)=allive2-dead2;
        
    end
    
    %When the first node dies
    if (dead2==1)
        if(flag_first_dead2==0)
            first_dead2=r
            flag_first_dead2=1;
        end
    end
    for(i=1:1:n)
        if(S2(i).E>=0)
            if(S2(i).type=='N')
                distance=sqrt( (S2(i).xd-(S2(n+1).xd) )^2 + (S2(i).yd-(S2(n+1).yd) )^2 );
                if (distance>do)
                    S2(i).E=S2(i).E- ( (ETX+EDA)*(4000) + Emp*4000*( distance*distance*distance*distance ));
                end
                if (distance<=do)
                    S2(i).E=S2(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*( distance * distance ));
                end
                packets_TO_BS12=packets_TO_BS12+1;
            end
        end
        
    end
    
    
    
    countCHs2=0;
    cluster2=1;
    
    for i=1:1:n
        if(S2(i).E>=0)
            if(S2(i).G<=0)
                if(S2(i).type=='A')
                    temp_rand=rand;
                    if( ( S2(i).ENERGY==1 && ( temp_rand <= ( padv / ( 1 - padv * mod(r,round(1/padv)) )) ) )  )
                        
                        countCHs2=countCHs2+1;
                        packets_TO_BS22=packets_TO_BS22+1;
                        
                        
                        S2(i).type='C';
                        S2(i).G=(1/padv)-1;
                        C(cluster2).xd=S2(i).xd;
                        C(cluster2).yd=S2(i).yd;
                        %plot(S2(i).xd,S2(i).yd,'k*');
                        
                        distance=sqrt( (S2(i).xd-(S2(n+1).xd) )^2 + (S2(i).yd-(S2(n+1).yd) )^2 );
                        C(cluster2).distance=distance;
                        C(cluster2).id=i;
                        X(cluster2)=S2(i).xd;
                        Y(cluster2)=S2(i).yd;
                        cluster2=cluster2+1;
                        
                        %          Calculation of Energy dissipated
                        distance;
                        if (distance>do)
                            S2(i).E=S2(i).E- ( (ETX+EDA)*(4000) + Emp*4000*( distance*distance*distance*distance ));
                        end
                        if (distance<=do)
                            S2(i).E=S2(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*( distance * distance ));
                        end
                        
                    end
                end
                
            end
            for i=1:1:n
                if ( S2(i).type=='A' && S2(i).E>0 )
                    if(cluster2-1>=1)
                        min_dis=inf;
                        min_dis_clustera=1;
                        
                        for c=1:1:cluster2-1
                            temp=min(min_dis,sqrt( (S2(i).xd-C(c).xd)^2 + (S2(i).yd-C(c).yd)^2 ) );
                            
                            if ( temp<min_dis )
                                min_dis=temp;
                                min_dis_cluster2=c;
                            end
                            
                        end
                        
                        %Energy dissipated by  Cluster menmber for transmission of packet
                        %  min_dis;
                        if (min_dis>do)
                            S2(i).E=S2(i).E- ( ETX*(4000) + Emp*4000*( min_dis * min_dis * min_dis * min_dis));
                        end
                        if (min_dis<=do)
                            S2(i).E=S2(i).E- ( ETX*(4000) + Efs*4000*( min_dis * min_dis));
                        end
                        %Energy dissipated by clustre head in receving
                        if(min_dis>0)
                            S2(C(min_dis_cluster2).id).E = S2(C(min_dis_cluster2).id).E- ( (ERX + EDA)*4000 );
                            PACKETS_TO_CH(r+1)=n-dead-cluster2+1;
                        end
                        
                        S2(i).min_dis=min_dis;
                        S2(i).min_dis_cluster2=min_dis_cluster2;
                        
                    end
                end
            end
        end
        CLUSTERHS(r+1)=cluster2+1;
        
        STATISTICS4.CLUSTERHEADS2(r+1)=cluster2+1;
        
        
    end
    
    
    packets_TO_BS2=packets_TO_BS12+packets_TO_BS22;
    STATISTICS4.PACKETS_TO_BS2(r+1)=packets_TO_BS2;
    
end

A = [STATISTICS4.PACKETS_TO_BS2,STATISTICS4.DEAD2,STATISTICS4.ALLIVE2];
