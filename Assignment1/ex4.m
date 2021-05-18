%% 4.a
% Determine  the  probability  of  the  link  being  in  the  normal  state  and  in  the  interference state.

p1 = 1 / (1 + 8/600 + 8/600 * 5/200 + 8/600 * 5/200 * 2/50 + 8/600 * 5/200 * 2/50 * 1/5);
p2 = 8/600 / (1 + 8/600 + 8/600 * 5/200 + 8/600 * 5/200 * 2/50 + 8/600 * 5/200 * 2/50 * 1/5);
p3 = 8/600 * 5/200 / (1 + 8/600 + 8/600 * 5/200 + 8/600 * 5/200 * 2/50 + 8/600 * 5/200 * 2/50 * 1/5);
p4 = 8/600 * 5/200 * 2/50 / (1 + 8/600 + 8/600 * 5/200 + 8/600 * 5/200 * 2/50 + 8/600 * 5/200 * 2/50 * 1/5);
p5 = 8/600 * 5/200 * 2/50 * 1/5 / (1 + 8/600 + 8/600 * 5/200 + 8/600 * 5/200 * 2/50 + 8/600 * 5/200 * 2/50 * 1/5);

estado_normal = p1 + p2 + p3;
estado_interferencia = p4 + p5;

fprintf('probabilidade estado normal = %.6f; probabilidade estado interferencia = %.6f \n', estado_normal, estado_interferencia);

%% 4.b
% Determine the average berof the link when it is in the normal state and when it is in the interferencestate.

avg_ber_normal = (p1*10^-6 + p2*10^-5 + p3*10^-4) / (p1 + p2 + p3);
avg_ber_interferencia = (p4*10^-3 + p5*10^-2) / (p4 + p5);

fprintf('average ber estado normal = %.6f; average ber estado interferencia = %.6f \n', avg_ber_normal, avg_ber_interferencia);

%% 4.c
% Consider that a data frame of size B(in Bytes)sent by one of the stations is received with
% errors by the other station. Draw a plot of the probability of the link being in the normal
% state as a function of the packet size (from 64 Bytes up to 200Bytes).Analyze and justify
% the results.

% p_final = nchoosek(n, i) * p^i * (1-p)^(n-i)
% p(with errors) = 1 - p(no errors); 

x = linspace(64, 200);

% probabilidade de cada pacote ser recebido com erros
p_e1 = 1 - 1 * (10^-6).^0 * (1-10^-6).^(x*8-0);
p_e2 = 1 - 1 * (10^-5).^0 * (1-10^-5).^(x*8-0);
p_e3 = 1 - 1 * (10^-4).^0 * (1-10^-4).^(x*8-0);
p_e4 = 1 - 1 * (10^-3).^0 * (1-10^-3).^(x*8-0);
p_e5 = 1 - 1 * (10^-2).^0 * (1-10^-2).^(x*8-0);

% probabilidade da ligação estar no estado N quando um pacote é recebido com erros
p_el_errors = p_e1 * p1 ./ (p_e1 * p1 + p_e2 * p2 + p_e3 * p3 + p_e4 * p4 + p_e5 * p5);
p_e2_errors = p_e2 * p2 ./ (p_e1 * p1 + p_e2 * p2 + p_e3 * p3 + p_e4 * p4 + p_e5 * p5); 
p_e3_errors = p_e3 * p3 ./ (p_e1 * p1 + p_e2 * p2 + p_e3 * p3 + p_e4 * p4 + p_e5 * p5); 

p_final = p_el_errors + p_e2_errors + p_e3_errors;

plot(x,p_final,'b-');
title('Probability of state "N" given errors in the packet')
xlabel('Packet size (Bytes)')
grid on

%% 4.d
% Considernowthat a data frame of size B(in Bytes)sent by one of the stationsis received
% withouterrorsby the other station. Draw a plot of the probability of the link being in the
% interferencestateas  a  function  of  the  packet  size  (from  64  Bytes  up  to 200Bytes).
% Analyzeand justify the results.

x = linspace(64, 200);

p_e1 = 1 * (10^-6).^0 * (1-10^-6).^(x*8-0);
p_e2 = 1 * (10^-5).^0 * (1-10^-5).^(x*8-0);
p_e3 = 1 * (10^-4).^0 * (1-10^-4).^(x*8-0);
p_e4 = 1 * (10^-3).^0 * (1-10^-3).^(x*8-0);
p_e5 = 1 * (10^-2).^0 * (1-10^-2).^(x*8-0);

p_e4_no_errors = p_e4 * p4 ./ (p_e1 * p1 + p_e2 * p2 + p_e3 * p3 + p_e4 * p4 + p_e5 * p5);
p_e5_no_errors = p_e5 * p5 ./ (p_e1 * p1 + p_e2 * p2 + p_e3 * p3 + p_e4 * p4 + p_e5 * p5);

p_final = p_e4_no_errors + p_e5_no_errors;

plot(x,p_final,'b-');
title('Probability of state "I" given no errors in the packet')
xlabel('Packet size (Bytes)')
grid on