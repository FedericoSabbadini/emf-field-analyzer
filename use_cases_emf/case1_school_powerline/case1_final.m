%% ═══════════════════════════════════════════════════════════════════════
%% CASO 1: SCUOLA VICINO A LINEA ELETTRICA 380 kV
%% ═══════════════════════════════════════════════════════════════════════

close all; clc;

% Apri file per salvare output
diary('case1_output.txt');
diary on;

fprintf('\n');
fprintf('╔════════════════════════════════════════════════════════════╗\n');
fprintf('║         CASO 1: SCUOLA VICINO A LINEA 380 kV              ║\n');
fprintf('╚════════════════════════════════════════════════════════════╝\n');
fprintf('\n');

%% PARAMETRI SISTEMA
I0 = 1500;                      % Corrente per fase [A]
mu0 = 4*pi*1e-7;               
f = 50;                         

conductor_height = 22;          % Altezza conduttori [m]
phase_spacing = 12;             % Distanza tra fasi [m]

xs = [-phase_spacing, 0, phase_spacing];  
ys = [conductor_height, conductor_height, conductor_height];  

phases = [0, 2*pi/3, 4*pi/3];
I = I0 * exp(1i * phases);

fprintf('PARAMETRI LINEA ELETTRICA:\n');
fprintf('  Tensione:          380 kV\n');
fprintf('  Corrente/fase:     %d A\n', I0);
fprintf('  Altezza conduttori: %d m\n', conductor_height);
fprintf('  Spaziatura fasi:   %d m\n', phase_spacing);
fprintf('\n');

%% CALCOLO CAMPO MAGNETICO
x = linspace(-100, 100, 401);   
y_ground = 1.5;                 
[X, ~] = meshgrid(x, y_ground);
Y = ones(size(X)) * y_ground;

Bx_tot = zeros(size(X));
By_tot = zeros(size(X));

for k = 1:3
    dx = X - xs(k);
    dy = Y - ys(k);
    R = sqrt(dx.^2 + dy.^2);
    R(R < 0.1) = 0.1;
    
    B_mag = mu0 * I(k) ./ (2 * pi * R);
    Bx_tot = Bx_tot + B_mag .* (-dy) ./ R;
    By_tot = By_tot + B_mag .* (dx) ./ R;
end

B_total = sqrt(abs(Bx_tot).^2 + abs(By_tot).^2);
B_uT = B_total * 1e6;

%% VALUTAZIONE CONFORMITÀ
B_at_50m = interp1(x, B_uT, 50);
B_at_center = interp1(x, B_uT, 0);

[~, idx_3uT] = min(abs(B_uT - 3));
dist_3uT = abs(x(idx_3uT));

fprintf('═══════════════════════════════════════════════════════════\n');
fprintf('RISULTATI CALCOLO:\n');
fprintf('  Campo sotto la linea (x=0):  %.1f μT\n', B_at_center);
fprintf('  Campo alla scuola (x=50m):   %.2f μT\n', B_at_50m);
fprintf('  Distanza limite 3 μT:        %.0f m\n', dist_3uT);
fprintf('\n');

fprintf('VERIFICA CONFORMITÀ NORMATIVA (DPCM 8/7/2003):\n');
fprintf('  Obiettivo qualità:           3 μT\n');
fprintf('  Campo alla scuola:           %.2f μT\n', B_at_50m);
if B_at_50m <= 3
    fprintf('  ESITO:  ✓ CONFORME\n');
    fprintf('\n');
    fprintf('CONCLUSIONE:\n');
    fprintf('  La scuola può essere costruita nella posizione proposta.\n');
else
    fprintf('  ESITO:  ✗ NON CONFORME\n');
    fprintf('\n');
    fprintf('CONCLUSIONE:\n');
    fprintf('  Distanza minima richiesta: %.0f m dal centro linea\n', ceil(dist_3uT));
end
fprintf('═══════════════════════════════════════════════════════════\n');
fprintf('\n');

%% GRAFICO SINGOLO CON LEGENDA
figure('Position', [100 100 900 600], 'Color', 'w');

plot(x, B_uT, 'b-', 'LineWidth', 3, 'DisplayName', 'Campo magnetico');
hold on;

% Limite 3 μT
yline(3, 'r--', 'LineWidth', 2.5, 'DisplayName', '3 μT (obiettivo qualità)');

% Posizione scuola
xline(50, 'm-', 'LineWidth', 2.5, 'DisplayName', 'Posizione scuola');
plot(50, B_at_50m, 'mo', 'MarkerSize', 14, 'MarkerFaceColor', 'm', ...
     'LineWidth', 2, 'HandleVisibility', 'off');

% Annotazione valore
text(52, B_at_50m + 0.8, sprintf('%.2f μT', B_at_50m), ...
     'FontSize', 14, 'Color', 'm', 'FontWeight', 'bold');

xlabel('Distanza dal centro linea [m]', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Campo magnetico B [μT]', 'FontSize', 14, 'FontWeight', 'bold');
title('Campo Magnetico a 1.5m dal Suolo - Linea 380kV', 'FontSize', 16, 'FontWeight', 'bold');

legend('Location', 'northeast', 'FontSize', 12);
grid on;
xlim([0 100]);
ylim([0 max(B_uT)*1.15]);
set(gca, 'FontSize', 12, 'LineWidth', 1.5);

saveas(gcf, 'case1_output.png');

fprintf('Output salvato:\n');
fprintf('  - Grafico: case1_output.png\n');
fprintf('  - Console: case1_output.txt\n');
fprintf('\n');

diary off;
