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

yd1=33;

%Values for Hetereogeneity
%Percentage of nodes than are advanced
m=0.1;
%\alpha times advance nodes have energy greater than normal nodes
a=2;


%maximum number of rounds
rmax=9000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Computation of do
do=sqrt(Efs/Emp);
Et=0;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   LEACH                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



for i=1:1:n
    S3(i).xd=rand(1,1)*xm;
    XR(i)=S3(i).xd;
    S3(i).yd=rand(1,1)*ym;
    YR(i)=S3(i).yd;
    S3(i).G=0;
    %initially there are no cluster heads only nodes
    S3(i).type='N';
    
    temp_rnd0=i;
    %Random Election of Normal Nodes
    if (temp_rnd0>=m*n+1)
        S3(i).E=Eo;
        S3(i).ENERGY=0;
        %plot(S3(i).xd,S3(i).yd,'o');
        %hold on;
    end
    %Random Election of Advanced Nodes
    if (temp_rnd0<m*n+1)
        S3(i).E=Eo*(1+a)
        S3(i).ENERGY=1;
        %plot(S3(i).xd,S3(i).yd,'+');
        %hold on;
    end
end

S3(n+1).xd=sink.x;
S3(n+1).yd=sink.y;
%plot(S3(n+1).xd,S3(n+1).yd,'x');


%First Iteration
%figure(1);

%counter for CHs
countCHs3=0;
%counter for CHs per round
rcountCHs3=0;
cluster3=1;

countCHs3;
rcountCHs3=rcountCHs3+countCHs3;
flag_first_dead3=0;
allive3=n;
packets_TO_BS3=0;
packets_TO_CH3=0;
for r=0:1:rmax
   % r
    
    %Operation for epoch
    if(mod(r, round(1/p) )==0)
        for i=1:1:n
            S3(i).G=0;
            S3(i).cl=0;
        end
    end
    
    %hold off;
    
    %Number of dead nodes
    dead3=0;
    %Number of dead3 Advanced Nodes
    dead_a3=0;
    %Number of dead Normal Nodes
    dead_n3=0;
    
    %counter for bit transmitted to Bases Station and to cluster3 Heads
    
    %counter for bit transmitted to Bases Station and to cluster3 Heads
    %per round
    
    
    %figure(1);
    
    for i=1:1:n
        %checking if there is a dead node
        if (S3(i).E<=0)
            %plot(S3(i).xd,S3(i).yd,'red .');
            dead3=dead3+1;
            if(S3(i).ENERGY==1)
                dead_a3=dead_a3+1;
            end
            if(S3(i).ENERGY==0)
                dead_n3=dead_n3+1;
            end
            %hold on;
        end
        if S3(i).E>0
            S3(i).type='N';
            if (S3(i).ENERGY==0)
                %plot(S3(i).xd,S3(i).yd,'o');
            end
            if (S3(i).ENERGY==1)
                %plot(S3(i).xd,S3(i).yd,'+');
            end
            %hold on;
        end
        
        
        STATISTICS.DEAD3(r+1)=dead3;
        STATISTICS.ALLIVE3(r+1)=allive3-dead3;
    end
    %plot(S(n+1).xd,S(n+1).yd,'x');
    
    
    
    
    %When the first node dies
    if (dead3==1)
        if(flag_first_dead3==0)
            first_dead3=r
            flag_first_dead3=1;
        end
    end
    
    countCHs3=0;
    cluster3=1;
    for i=1:1:n
        if(S3(i).E>0)
            temp_rand=rand;
            if ( (S3(i).G)<=0)
                
                %Election of cluster3 Heads
                if(temp_rand<= (p/(1-p*mod(r,round(1/p)))))
                    countCHs3=countCHs3+1;
                    packets_TO_BS3=packets_TO_BS3+2;
                    % PACKETS_TO_BS3(r+1)=packets_TO_BS3;
                    
                    S3(i).type='C';
                    S3(i).G=round(1/p)-1;
                    C(cluster3).xd=S3(i).xd;
                    C(cluster3).yd=S3(i).yd;
                    %plot(S3(i).xd,S3(i).yd,'k*');
                    
                    distance=sqrt( (S3(i).xd-(S3(n+1).xd) )^2 + (S3(i).yd-(S3(n+1).yd) )^2 );
                    C(cluster3).distance=distance;
                    C(cluster3).id=i;
                    X(cluster3)=S3(i).xd;
                    Y(cluster3)=S3(i).yd;
                    cluster3=cluster3+1;
                    
                    %Calculation of Energy dissipated
                    distance;
                    if (distance>do)
                        S3(i).E=S3(i).E- ( (ETX+EDA)*(4000) + Emp*4000*( distance*distance*distance*distance ));
                    end
                    if (distance<=do)
                        S3(i).E=S3(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*( distance * distance ));
                    end
                end
                
            end
        end
    end
    
    STATISTICS.CLUSTERHEADS3(r+1)=cluster3-1;
    CLUSTERHS(r+1)=cluster3-1;
    
    %Election of Associated Cluster Head for Normal Nodes
    for i=1:1:n
        if ( S3(i).type=='N' && S3(i).E>0 )
            if(cluster3-1>=1)
                min_dis=sqrt( (S3(i).xd-S3(n+1).xd)^2 + (S3(i).yd-S3(n+1).yd)^2 );
                min_dis_cluster=1;
                for c=1:1:cluster3-1
                    temp=min(min_dis,sqrt( (S3(i).xd-C(c).xd)^2 + (S3(i).yd-C(c).yd)^2 ) );
                    if ( temp<min_dis )
                        min_dis=temp;
                        min_dis_cluster=c;
                    end
                end
                
                %Energy dissipated by associated Cluster Head
                min_dis;
                if (min_dis>do)
                    S3(i).E=S3(i).E- ( ETX*(4000) + Emp*4000*( min_dis * min_dis * min_dis * min_dis));
                end
                if (min_dis<=do)
                    S3(i).E=S3(i).E- ( ETX*(4000) + Efs*4000*( min_dis * min_dis));
                end
                %Energy dissipated
                if(min_dis>0)
                    S3(C(min_dis_cluster).id).E = S3(C(min_dis_cluster).id).E- ( (ERX + EDA)*4000 );
                    PACKETS_TO_CH3(r+1)=n-dead3-cluster3+1;
                end
                
                S3(i).min_dis=min_dis;
                S3(i).min_dis_cluster=min_dis_cluster;
                
            end
        end
    end
    %hold on;
    
    packets_TO_BS3=packets_TO_BS3+1;
    STATISTICS.packets_TO_BS3(r+1)=packets_TO_BS3;
    
    countCHs3;
    rcountCHs3=rcountCHs3+countCHs3;
    
end

A = [STATISTICS.packets_TO_BS3,STATISTICS.DEAD3,STATISTICS.ALLIVE3];

fileID = fopen('leach.txt','w');
fprintf(fileID,'%6s %6s %6s\n','STATISTICS.packets_TO_BS3','STATISTICS.DEAD3','STATISTICS.ALLIVE3');
fprintf(fileID,'%6.2f %6.2f %6.2f\n',A);
fclose(fileID);

