%% Symbolic Variables
s = tf('s');

%% Load Variables
datadict = Simulink.data.dictionary.open('Lab_4_Data.sldd');
section = datadict.getSection('Design Data');
N = section.getEntry('filterCoeff').getValue();
datadict.close();

%%
Kp = 1;
Ki = 0;
Kd = 0;

%%
G = ((N*Kd + Kp)*s^2 + (N*Kp + Ki)*s + N*Ki) / (s^4 + N*s^3 + (N*Kd+Kp)*s^2 + (N*Kp+Ki)*s + N*Ki);
figure(7);
step(G);

%%
G2 = (N*Ki) / (s^4 + N*s^3 + (N*Kd+Kp)*s^2 + (N*Kp+Ki)*s + N*Ki);
figure(8);
step(G2);
