function [PL , APD , MPD , TT] = Simulator3(lambda,C,f,P,b)
% INPUT PARAMETERS:
%  lambda - packet rate (packets/sec)
%  C      - link bandwidth (Mbps)
%  f      - queue size (Bytes)
%  P      - number of packets (stopping criterium)
%  b      - BER (Bit Error Rate)
% OUTPUT PARAMETERS:
%  PL   - packet loss (%)
%  APD  - average packet delay (milliseconds)
%  MPD  - maximum packet delay (milliseconds)
%  TT   - transmitted throughput (Mbps)

%Aux calculations
p1 = 1 / (1 + 10/5 + 10/5 * 5/10);              %probability of being in state 1
p2 = 10/5 / (1 + 10/5 + 10/5 * 5/10);           %probability of being in state 2
p3 = 10/5 * 5/10 / (1 + 10/5 + 10/5 * 5/10);    %probability of being in state 3

Avg_t1 = 1 / 10;    % Average percentage of time duration (in seconds) that the link stays in state 1                           
Avg_t2 = 1 / (5+5); % Average percentage of time duration (in seconds) that the link stays in state 2
Avg_t3 = 1 / 10;    % Average percentage of time duration (in seconds) that the link stays in state 3

avg_times = [Avg_t1, Avg_t2, Avg_t3];

pTrans = 0.5;       % probability of transitioning to state 3 if i am in state 2, and probability of transioning to state 1 if am in state 2

%choosing the initial state
auxr = rand;

if auxr<0.25
    flowstate = 1;
elseif auxr<0.75
    flowstate = 2;
else
    flowstate = 3;
end

%lambdas of each state
lambdaVector = [0.5*lambda, lambda, 1.5*lambda];

%Events:
ARRIVAL= 0;       % Arrival of a packet            
DEPARTURE= 1;     % Departure of a packet
TRANSITION= 2;    % Transition of a state in the packet arriving Markov chain

%State variables:
STATE = 0;          % 0 - connection free; 1 - connection bysy
QUEUEOCCUPATION= 0; % Occupation of the queue (in Bytes)
QUEUE= [];          % Size and arriving time instant of each packet in the queue

%Statistical Counters:
TOTALPACKETS= 0;       % No. of packets arrived to the system
LOSTPACKETS= 0;        % No. of packets dropped due to buffer overflow
TRANSMITTEDPACKETS= 0; % No. of transmitted packets
TRANSMITTEDBYTES= 0;   % Sum of the Bytes of transmitted packets
DELAYS= 0;             % Sum of the delays of transmitted packets
MAXDELAY= 0;           % Maximum delay among all transmitted packets

%Auxiliary variables:
% Initializing the simulation clock:
Clock= 0;

% Initializing the List of Events with the first ARRIVAL:
EventList = [ARRIVAL, Clock + exprnd(1/lambdaVector(flowstate)), GeneratePacketSize(), 0];
% Adding to the List of Events when the first TRANSITION occurs, the
% scheduling the first transitions
EventList = [EventList; TRANSITION, Clock + exprnd(avg_times(flowstate)), 0, 0];

%Similation loop:
while TRANSMITTEDPACKETS<P               % Stopping criterium
    EventList= sortrows(EventList,2);    % Order EventList by time
    Event= EventList(1,1);               % Get first event and 
    Clock= EventList(1,2);               %   and
    PacketSize= EventList(1,3);          %   associated
    ArrivalInstant= EventList(1,4);      %   parameters.
    EventList(1,:)= [];                  % Eliminate first event
    switch Event
        case ARRIVAL                     % If first event is an ARRIVAL
            TOTALPACKETS= TOTALPACKETS+1;
            EventList = [EventList; ARRIVAL, Clock + exprnd(1/lambdaVector(flowstate)), GeneratePacketSize(), 0];
            if STATE==0
                STATE= 1;
                EventList = [EventList; DEPARTURE, Clock + 8*PacketSize/(C*10^6), PacketSize, Clock];
            else
                if QUEUEOCCUPATION + PacketSize <= f
                    QUEUE= [QUEUE;PacketSize , Clock];
                    QUEUEOCCUPATION= QUEUEOCCUPATION + PacketSize;
                else
                    LOSTPACKETS= LOSTPACKETS + 1;
                end
            end
        case DEPARTURE                     % If first event is a DEPARTURE
            if rand < (1-b)^(8*PacketSize)
                TRANSMITTEDBYTES= TRANSMITTEDBYTES + PacketSize;
                DELAYS= DELAYS + (Clock - ArrivalInstant);
                if Clock - ArrivalInstant > MAXDELAY
                    MAXDELAY= Clock - ArrivalInstant;
                end
                TRANSMITTEDPACKETS= TRANSMITTEDPACKETS + 1;
            else
                LOSTPACKETS= LOSTPACKETS + 1;
            end
            if QUEUEOCCUPATION > 0
                EventList = [EventList; DEPARTURE, Clock + 8*QUEUE(1,1)/(C*10^6), QUEUE(1,1), QUEUE(1,2)];
                QUEUEOCCUPATION= QUEUEOCCUPATION - QUEUE(1,1);
                QUEUE(1,:)= [];
            else
                STATE= 0;
            end
        case TRANSITION                    % If first event is a TRANSITION
            
            if flowstate ~= 2              
                flowstate = 2;                                                          % If the current state is 1 or 3, it can only go to state 2
                EventList = [EventList; TRANSITION, Clock + exprnd(avg_times(flowstate)), 0, 0];    % Now i schedule when is the next transition, which is clock + avg time duration that it stays in state 2 
            else
                if rand < pTrans
                    flowstate = 1;                                                      % If the current state is 2, it can go to state 1 with a chance of ptrans
                    EventList = [EventList; TRANSITION, Clock + exprnd(avg_times(flowstate)), 0, 0];    % Now i schedule when is the next transition, which is clock + avg time duration that it stays in state 1
                else
                    flowstate = 3;
                    EventList = [EventList; TRANSITION, Clock + exprnd(avg_times(flowstate)), 0, 0];    % Now i schedule when is the next transition, which is clock + avg time duration that it stays in state 3
                end
            end    
    end
end

%Performance parameters determination:
PL= 100*LOSTPACKETS/TOTALPACKETS;      % in %
APD= 1000*DELAYS/TRANSMITTEDPACKETS;   % in milliseconds
MPD= 1000*MAXDELAY;                    % in milliseconds
TT= 10^(-6)*TRANSMITTEDBYTES*8/Clock;  % in Mbps

end

function out= GeneratePacketSize()
    aux= rand();
    aux2= [65:109 111:1517];
    if aux <= 0.16
        out= 64;
    elseif aux <= 0.16 + 0.25
        out= 110;
    elseif aux <= 0.16 + 0.25 + 0.2
        out= 1518;
    else
        out = aux2(randi(length(aux2)));
    end
end