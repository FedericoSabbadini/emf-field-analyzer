%% ESEMPIO: Stazione Radio Base (SRB) per Telefonia Mobile
%
% Questo esempio mostra come calcolare il campo elettrico generato da una
% stazione radio base (antenna per telefonia mobile) e determinare le
% distanze di sicurezza.
%
% SCENARIO:
%   Una SRB GSM/LTE è installata sul tetto di un edificio a 30 m di altezza.
%   L'antenna è di tipo direttivo (pannello settoriale).
%   EIRP = 200 W (tipico per copertura urbana).
%   Vogliamo verificare che il campo E sia < 6 V/m nelle aree accessibili.
%
% Autore: Federico Sabbadini
% Data: 2024

%% SETUP
close all; clc; clear;
addpath('../src/core');  % Percorso funzioni

%% PARAMETRI DEL PROBLEMA

% Potenza EIRP [W] - Equivalent Isotropically Radiated Power
EIRP = 200;

% Costante k (da formula campo lontano: E = sqrt(30*EIRP)/r)
k = sqrt(30 * EIRP);
fprintf('EIRP = %.0f W → k = %.2f\n', EIRP, k);

% Tipo di antenna
%   'isotropa'  - riferimento teorico
%   'dipolo'    - diagramma a ciambella
%   'direttiva' - pannello settoriale (tipico SRB)
%   'parabola'  - fascio molto stretto
tipo_antenna = 'direttiva';

% Posizione dell'antenna [m]
x_ant = 0;
y_ant = 0;
z_ant = 30;  % Altezza dal suolo

% Limiti normativi [V/m]
limite_attenzione = 6;    % Valore attenzione italiano
limite_esposizione = 20;  % Limite esposizione italiano

%% GRIGLIA DI CALCOLO 3D

% Range spaziale [m]
range = 50;
step = 1;  % Risoluzione (aumentare per calcolo più veloce)

x = -range:step:range;
y = -range:step:range;
z = 0:step:range;  % Solo sopra il suolo

[X, Y, Z] = meshgrid(x, y, z);

%% CALCOLO DEL CAMPO ELETTRICO

% Distanza dall'antenna
R = sqrt((X - x_ant).^2 + (Y - y_ant).^2 + (Z - z_ant).^2);
R(R < 0.1) = 0.1;  % Evita singolarità

% Angoli sferici (rispetto all'antenna)
dx = X - x_ant;
dy = Y - y_ant;
dz = Z - z_ant;

theta = acos(dz ./ R);  % Angolo zenitale
phi = atan2(dy, dx);    % Angolo azimutale

% Diagramma di radiazione
switch tipo_antenna
    case 'isotropa'
        F = ones(size(R));
        nome_tipo = 'Isotropa';
    case 'dipolo'
        F = abs(sin(theta));
        nome_tipo = 'Dipolo';
    case 'direttiva'
        F = abs(sin(theta) .* cos(phi));  % Lobo principale verso x positivo
        nome_tipo = 'Direttiva (settoriale)';
    case 'parabola'
        F = cos(theta).^4;
        F(theta > pi/3) = 0;  % Fascio stretto
        nome_tipo = 'Parabolica';
end

% Campo elettrico [V/m]
E = k .* F ./ R;

%% VISUALIZZAZIONE 1: ISOSUPERFICIE 6 V/m

figure('Name', 'Superficie Isovalore 6 V/m', 'Position', [100, 100, 800, 700]);

% Isosuperficie
p = patch(isosurface(x, y, z, E, limite_attenzione));
set(p, 'FaceColor', [1, 0.6, 0.2], 'EdgeColor', 'none', 'FaceAlpha', 0.6);

% Illuminazione
camlight('headlight');
lighting gouraud;

% Antenna
hold on;
plot3(x_ant, y_ant, z_ant, 'r^', 'MarkerSize', 20, 'MarkerFaceColor', 'r', 'LineWidth', 2);
text(x_ant, y_ant, z_ant + 3, 'ANTENNA', 'FontSize', 12, 'FontWeight', 'bold', ...
     'HorizontalAlignment', 'center');

% Piano del suolo
[Xg, Yg] = meshgrid(x, y);
surf(Xg, Yg, zeros(size(Xg)), 'FaceColor', [0.5, 0.8, 0.5], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold off;

xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');
title(sprintf('Superficie E = %.0f V/m\nAntenna %s - EIRP = %.0f W', ...
              limite_attenzione, nome_tipo, EIRP));
axis equal;
grid on;
view(45, 25);
legend('E = 6 V/m', 'Antenna', 'Location', 'northeast');

%% VISUALIZZAZIONE 2: PIANI CARATTERISTICI

% Piano XZ (y = 0) - Vista laterale
figure('Name', 'Piano Verticale XZ', 'Position', [150, 150, 800, 500]);

idx_y0 = find(y == 0);
E_xz = squeeze(E(:, idx_y0, :))';

contourf(x, z, E_xz, 20);
colormap('hot');
cb = colorbar;
ylabel(cb, 'E [V/m]');

hold on;
% Curve isolivello dei limiti
[c6, ~] = contour(x, z, E_xz, [6, 6], 'g', 'LineWidth', 2);
[c20, ~] = contour(x, z, E_xz, [20, 20], 'r', 'LineWidth', 2);

% Antenna
plot(x_ant, z_ant, 'r^', 'MarkerSize', 15, 'MarkerFaceColor', 'r');

% Suolo
plot(x, zeros(size(x)), 'k-', 'LineWidth', 3);
hold off;

xlabel('x [m]');
ylabel('z [m] (altezza)');
title(sprintf('Campo E nel piano XZ - Antenna %s', nome_tipo));
legend('Campo E', 'E = 6 V/m', 'E = 20 V/m', 'Antenna', 'Location', 'northeast');
axis equal;
grid on;

% Piano XY (z = 1.5 m) - Altezza uomo
figure('Name', 'Piano Orizzontale (z = 1.5 m)', 'Position', [200, 200, 800, 600]);

z_uomo = 1.5;  % Altezza tipica
idx_z = find(z >= z_uomo, 1);
E_xy = squeeze(E(:, :, idx_z));

contourf(x, y, E_xy, 20);
colormap('hot');
cb = colorbar;
ylabel(cb, 'E [V/m]');

hold on;
[c6, ~] = contour(x, y, E_xy, [6, 6], 'g', 'LineWidth', 2);
plot(x_ant, y_ant, 'r^', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
hold off;

xlabel('x [m]');
ylabel('y [m]');
title(sprintf('Campo E a %.1f m dal suolo (altezza uomo)', z_uomo));
legend('Campo E', 'E = 6 V/m', 'Antenna', 'Location', 'northeast');
axis equal;
grid on;

%% ANALISI DELLE DISTANZE DI SICUREZZA

fprintf('\n========================================\n');
fprintf('ANALISI STAZIONE RADIO BASE\n');
fprintf('========================================\n\n');
fprintf('Parametri:\n');
fprintf('  Tipo antenna: %s\n', nome_tipo);
fprintf('  EIRP: %.0f W\n', EIRP);
fprintf('  Altezza antenna: %.0f m\n', z_ant);
fprintf('  Costante k: %.2f\n\n', k);

% Distanza teorica per antenna isotropa
r_6V = k / 6;
r_20V = k / 20;
fprintf('Distanze teoriche (antenna isotropa):\n');
fprintf('  E = 6 V/m:  %.1f m\n', r_6V);
fprintf('  E = 20 V/m: %.1f m\n\n', r_20V);

% Campo al suolo sotto l'antenna
E_sotto = E(y==0, x==0, z==0);
fprintf('Campo E al suolo (sotto antenna): %.2f V/m\n', E_sotto);

% Campo a 50 m di distanza orizzontale
idx_50m = find(x >= 50, 1);
E_50m = E(y==0, idx_50m, idx_z);
fprintf('Campo E a 50m (altezza uomo): %.2f V/m\n\n', E_50m);

% Verifica conformità
if max(E_xy(:)) < limite_attenzione
    fprintf('✓ Campo E < 6 V/m a livello uomo in tutta l''area\n');
else
    fprintf('✗ Attenzione: alcune zone superano 6 V/m a livello uomo\n');
end

fprintf('\n========================================\n');
fprintf('Nota: per antenne direttive il campo massimo\n');
fprintf('si trova nella direzione di puntamento.\n');
fprintf('========================================\n');
