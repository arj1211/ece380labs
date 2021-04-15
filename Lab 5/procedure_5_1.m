%% PROCEDURE 5.1
close all;
shared_variables;

alpha = 0;
T = 0;

%% (1) Pick an appropriate gain K
K = 49;

% 1/(1+K) <= 0.02 ==> 1/0.02 - 1 <= K ==> K = 49