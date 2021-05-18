clear all
close all
clc

%% Task 4
p= [1 8/600 8/600*5/200 8/600*5/200*2/50 8/600*5/200*2/50*1/5];
p= p/sum(p);  %probability of each state
ber=[1e-6 1e-5 1e-4 1e-3 1e-2]; %ber of each state

%4.a
pN= sum(p(1:3));
pI= sum(p(4:5));
fprintf('Task 4.a\n');
fprintf(' Prob. of normal state:       %.6e\n',pN);
fprintf(' Prob. of interference state: %.6e\n',pI);

%4.b
berN= sum(ber(1:3).*p(1:3))/pN;
berI= sum(ber(4:5).*p(4:5))/pI;
fprintf('Task 4.b\n');
fprintf(' ber in normal state:       %.2e\n',berN);
fprintf(' ber in interference state: %.2e\n',berI);

%4.c
B= 64:200;
e1= 1 - (1 - 1e-6).^(8*B);  %state 1e-6
e2= 1 - (1 - 1e-5).^(8*B);  %state 1e-5
e3= 1 - (1 - 1e-4).^(8*B);  %state 1e-4
e4= 1 - (1 - 1e-3).^(8*B);  %state 1e-3
e5= 1 - (1 - 1e-2).^(8*B);  %state 1e-2
NormalState= (e1*p(1)+e2*p(2)+e3*p(3))./(e1*p(1)+e2*p(2)+e3*p(3)+e4*p(4)+e5*p(5));
figure('Name','Task 4.c)')
plot(B,NormalState);
title('Prob. of Normal State');
xlabel('B (Bytes)');
grid on

%4.d
B= 64:200;
e1= (1 - 1e-6).^(8*B);  %state 1e-6
e2= (1 - 1e-5).^(8*B);  %state 1e-5
e3= (1 - 1e-4).^(8*B);  %state 1e-4
e4= (1 - 1e-3).^(8*B);  %state 1e-3
e5= (1 - 1e-2).^(8*B);  %state 1e-2
InterferenceState= (e4*p(4)+e5*p(5))./(e1*p(1)+e2*p(2)+e3*p(3)+e4*p(4)+e5*p(5));
figure('Name','Task 4.d)')
plot(B,InterferenceState);
title('Prob. of Intereference State');
xlabel('B (Bytes)');
grid on

%% Task 5
p= [1 8/600 8/600*5/200 8/600*5/200*2/50 8/600*5/200*2/50*1/5];
p= p/sum(p);  %probability of each state
B= 64*8;
n= 2:5;

%5.a
e1= (1 - (1 - 1e-6)^B).^n;  %state 1e-6
e2= (1 - (1 - 1e-5)^B).^n;  %state 1e-5
e3= (1 - (1 - 1e-4)^B).^n;  %state 1e-4
e4= (1 - (1 - 1e-3)^B).^n;  %state 1e-3
e5= (1 - (1 - 1e-2)^B).^n;  %state 1e-2
FalsePositives= (e1*p(1)+e2*p(2)+e3*p(3))./(e1*p(1)+e2*p(2)+e3*p(3)+e4*p(4)+e5*p(5));
figure('Name','Task 5.a')
semilogy(n,FalsePositives,'-o');
xticks(n);
title('Prob. of False Positives');
xlabel('No. of consecutive control frames');
grid on

%5.b
e1= 1 - (1 - (1 - 1e-6)^B).^n;  %state 1e-6
e2= 1 - (1 - (1 - 1e-5)^B).^n;  %state 1e-5
e3= 1 - (1 - (1 - 1e-4)^B).^n;  %state 1e-4
e4= 1 - (1 - (1 - 1e-3)^B).^n;  %state 1e-3
e5= 1 - (1 - (1 - 1e-2)^B).^n;  %state 1e-2

FalseNegatives= (e4*p(4)+e5*p(5))./(e1*p(1)+e2*p(2)+e3*p(3)+e4*p(4)+e5*p(5));
figure('Name','Task 5.b')
plot(n,FalseNegatives,'-o');
xticks(n);
title('Prob. of False Negatives');
xlabel('No. of consecutive control frames');
grid on

