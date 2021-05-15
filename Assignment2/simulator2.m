function [b_4K, b_HD]= simulator2(lambda,p,n,S,W,R,fname)
    %lambda = request arrival rate (in requests per hour)
    %p=       percentage of requests for 4k movies
    %n=       number of servers
    %S=       interface capacity of each server(Mbps)
    %W=       resource reservation for 4k(Mbps)
    %R=       number of movie requests to stop simulation
    %fname=   filename with the duration of each movie
    
    M_HD = 5;
    M_4K = 25;
    p = p/100;
    
    invlambda=60/lambda;     %average time between requests (in minutes)
    invmiu= load(fname);     %duration (in minutes) of each movie
    Nmovies= length(invmiu); % number of movies
    
    Nmovies4K = Nmovies*p;
    NmoviesHD = Nmovies-Nmovies4K;
    
    %Events definition:
    ARRIVAL= 0;        %movie request
    DEPARTURE_HD = 1;
    DEPARTURE_4K = 2;
    %%%DEPARTURE= 1;      %termination of a movie transmission
    
    %State variables initialization:
    STATE= zeros(1,n);
    STATE_HD = 0;
    
    %Statistical counters initialization:
    NARRIVALS = 0;
    REQUESTS_HD = 0;
    REQUESTS_4K = 0;
    BLOCKED_HD = 0;
    BLOCKED_4K = 0;
    %Simulation Clock and initial List of Events:
    Clock= 0;
    EventList= [ARRIVAL exprnd(invlambda) 1];
 
    while NARRIVALS < R
        event= EventList(1,1);
        Clock= EventList(1,2);
        server = EventList(1,3);
        EventList(1,:)= [];
        if event == ARRIVAL
            EventList= [EventList; ARRIVAL Clock+exprnd(invlambda) 1];
            NARRIVALS= NARRIVALS+1;
            
            %Find least occupied server
            [lowest,lowest_s] = min(STATE);
            
            if rand < p % 4K movie
                M = M_4K;
                REQUESTS_4K= REQUESTS_4K+1;
                if STATE(1,lowest_s) + M <= S %Check if server has capacity
                    STATE(1,lowest_s)= STATE(1,lowest_s)+M;
                    EventList= [EventList; DEPARTURE_4K Clock+invmiu(randi(Nmovies)) lowest_s];
                else
                    BLOCKED_4K= BLOCKED_4K+1;
                end
            else  % HD movie
                M = M_HD;
                REQUESTS_HD= REQUESTS_HD+1;
                if STATE_HD + M <= (n*S - W) %Check resource reservation for 4K movies
                    
                    if STATE(1,lowest_s) + M <= S %Check if server has capacity
                        STATE(1,lowest_s)= STATE(1,lowest_s) + M;
                        STATE_HD = STATE_HD + M;
                        EventList= [EventList; DEPARTURE_HD Clock+invmiu(randi(Nmovies)) lowest_s];
                    else
                        BLOCKED_HD= BLOCKED_HD+1;
                    end
                else
                    BLOCKED_HD= BLOCKED_HD+1;
                end
            end
            

        else
            if event == DEPARTURE_4K
                STATE(1, server) = STATE(1, server) - M_4K;
            else
                STATE(1, server) = STATE(1, server) - M_HD;
                STATE_HD = STATE_HD - M_HD;
            end
            
        end
        EventList= sortrows(EventList,2);
    end
    b_4K= 100*BLOCKED_4K/REQUESTS_4K;    % blocking probability in %
    b_HD= 100*BLOCKED_HD/REQUESTS_HD;
end