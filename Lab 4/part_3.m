%% Symbolic Variables
s = tf('s');

%% Load Variables
datadict = Simulink.data.dictionary.open('Lab_4_Data.sldd');
section = datadict.getSection('Design Data');
N = section.getEntry('filterCoeff').getValue();
datadict.close();

%% Set your gains. (MAKE YOUR EDITS IN THIS SECTION)
Kp = 8;
Ki = 20;
Kd = 3;

%% Root Locus 1 (Changing Kp)
figure(4);
G = (s^2 + N*s)/(s^4 + N*s^3 + N*Kd*s^2 + Ki*s + N*Ki);
[R, K] = rlocus(G);

% Find Your Kp in K.
ok = isfinite(K) & isfinite(sum(R.^2));
roots = interp1(K(ok), R(:, ok)', Kp);

% Plot
rlocus(G, K);
hold on;
scatter(real(roots), imag(roots), 20, 'k', 'filled');
hold off;

title('Root Locus of PID System with Variable K_p');

%% Root Locus 2 (Changing Ki)
figure(5);
G = (s+N)/(s^4 + N*s^3 + (N*Kd+Kp)*s^2 + N*Kp*s);
[R, K] = rlocus(G);

% Find Your Ki in K.
ok = isfinite(K) & isfinite(sum(R.^2));
roots = interp1(K(ok), R(:, ok)', Ki);

% Plot
rlocus(G, K);
hold on;
scatter(real(roots), imag(roots), 20, 'k', 'filled');
hold off;

title('Root Locus of PID System with Variable K_i');

%% Root Locus 3 (Changing Kd)
figure(6);
G = (N*s^2)/(s^4 + N*s^3 + Kp*s^2 + (N*Kp+Ki)*s + N*Ki);
[R, K] = rlocus(G);

% Find Your Kd in K.
ok = isfinite(K) & isfinite(sum(R.^2));
roots = interp1(K(ok), R(:, ok)', Kd);

% Plot
rlocus(G, K);
hold on;
scatter(real(roots), imag(roots), 20, 'k', 'filled');
hold off;

title('Root Locus of PID System with Variable K_d');
