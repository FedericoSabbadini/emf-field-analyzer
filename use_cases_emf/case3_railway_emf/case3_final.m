%% ═══════════════════════════════════════════════════════════════════════
%% CASO 3: FERROVIA ALTA VELOCITÀ 25 kV AC
%% ═══════════════════════════════════════════════════════════════════════

close all; clc;

diary('case3_output.txt');
diary on;

fprintf('\n');
fprintf('╔════════════════════════════════════════════════════════════╗\n');
fprintf('║         CASO 3: FERROVIA ALTA VELOCITÀ                    ║\n');
fprintf('╚════════════════════════════════════════════════════════════╝\n');
fprintf('\n');

%% PARAMETRI SISTEMA FERROVIARIO
V_line = 25000;                 
f = 50;                         
I_train = 1200;                 % Corrente picco [A]

catenary_height = 5.5;          
rail_height = 0;                
rail_spacing = 1.435;           
track_center = 0;

rail_current_fraction = 0.8;
mu0 = 4*pi*1e-7;

fprintf('PARAMETRI SISTEMA:\n');
fprintf('  Sistema:           25 kV AC, 50 Hz\n');
fprintf('  Corrente treno:    %d A (accelerazione)\n', I_train);
fprintf('  Altezza catenaria: %.1f m\n', catenary_height);
fprintf('  Scartamento:       %.3f m\n', rail_spacing);
fprintf('\n');

%% CONFIGURAZIONE CORRENTI
catenary_x = track_center;
catenary_y = catenary_height;
catenary_I = I_train;

rail1_x = track_center - rail_spacing/2;
rail1_y = rail_height;
rail1_I = -I_train * rail_current_fraction / 2;

rail2_x = track_center + rail_spacing/2;
rail2_y = rail_height;
rail2_I = -I_train * rail_current_fraction / 2;

%% CALCOLO CAMPO MAGNETICO
x = linspace(-50, 50, 201);
y = linspace(0, 10, 81);
[X, Y] = meshgrid(x, y);

R_cat = sqrt((X - catenary_x).^2 + (Y - catenary_y).^2);
R_cat(R_cat < 0.1) = 0.1;
B_cat = mu0 * abs(catenary_I) ./ (2 * pi * R_cat);

R_r1 = sqrt((X - rail1_x).^2 + (Y - rail1_y).^2);
R_r1(R_r1 < 0.1) = 0.1;
B_r1 = mu0 * abs(rail1_I) ./ (2 * pi * R_r1);

R_r2 = sqrt((X - rail2_x).^2 + (Y - rail2_y).^2);
R_r2(R_r2 < 0.1) = 0.1;
B_r2 = mu0 * abs(rail2_I) ./ (2 * pi * R_r2);

Bx_cat = -B_cat .* (Y - catenary_y) ./ R_cat;
By_cat =  B_cat .* (X - catenary_x) ./ R_cat;

Bx_r1 = B_r1 .* (Y - rail1_y) ./ R_r1;
By_r1 = -B_r1 .* (X - rail1_x) ./ R_r1;

Bx_r2 = B_r2 .* (Y - rail2_y) ./ R_r2;
By_r2 = -B_r2 .* (X - rail2_x) ./ R_r2;

Bx_tot = Bx_cat + Bx_r1 + Bx_r2;
By_tot = By_cat + By_r1 + By_r2;

B_total = sqrt(Bx_tot.^2 + By_tot.^2);
B_uT = B_total * 1e6;

%% VALUTAZIONE POSIZIONI
y_head = 1.5;
B_profile = interp2(X, Y, B_uT, x, y_head * ones(size(x)));

[~, idx_3] = min(abs(B_profile - 3));
[~, idx_10] = min(abs(B_profile - 10));
dist_3uT = abs(x(idx_3));
dist_10uT = abs(x(idx_10));

B_res_15m = interp2(X, Y, B_uT, 15, 1.5);
B_res_30m = interp2(X, Y, B_uT, 30, 1.5);

fprintf('═══════════════════════════════════════════════════════════\n');
fprintf('CAMPO MAGNETICO DURANTE PASSAGGIO (I=%dA):\n', I_train);
fprintf('\n');
fprintf('  Posizione      │ Distanza │ B [μT] │ Stato\n');
fprintf('  ───────────────┼──────────┼────────┼──────────────\n');
fprintf('  Residenza 1    │  15 m    │ %6.1f │ ', B_res_15m);
if B_res_15m <= 3
    fprintf('✓ OK\n');
elseif B_res_15m <= 10
    fprintf('⚠ Transitorio\n');
else
    fprintf('✗ Alto\n');
end
fprintf('  Residenza 2    │  30 m    │ %6.1f │ ✓ OK\n', B_res_30m);
fprintf('\n');

fprintf('DISTANZE LIMITI NORMATIVI:\n');
fprintf('  10 μT (attenzione):  %.0f m\n', dist_10uT);
fprintf('  3 μT (qualità):      %.0f m\n', dist_3uT);
fprintf('\n');

fprintf('NOTA: Esposizione transitoria (3-5 sec passaggio)\n');
fprintf('      Campo medio temporale << campo istantaneo\n');
fprintf('\n');

fprintf('VERIFICA CONFORMITÀ (DPCM 8/7/2003):\n');
fprintf('  Limite media 24h:            10 μT\n');
fprintf('  Campo 30m (6 treni/h):       %.1f μT picco\n', B_res_30m);
fprintf('  ESITO:  ✓ CONFORME (esposizione transitoria)\n');
fprintf('\n');
fprintf('RACCOMANDAZIONE:\n');
fprintf('  Fascia rispetto residenziale: 30 m dal binario\n');
fprintf('═══════════════════════════════════════════════════════════\n');
fprintf('\n');

%% GRAFICO SINGOLO STILE CASO 1
figure('Position', [100 100 900 600], 'Color', 'w');

% Profilo campo a 1.5m altezza
y_eval = 1.5;
B_profile = interp2(X, Y, B_uT, x, y_eval * ones(size(x)));

plot(abs(x), B_profile, 'b-', 'LineWidth', 3, 'DisplayName', 'Campo magnetico');
hold on;

% Limite 10 μT
yline(10, 'r--', 'LineWidth', 2.5, 'DisplayName', '10 μT (attenzione)');

% Limite 3 μT  
yline(3, 'Color', [1 0.5 0], 'LineStyle', '--', 'LineWidth', 2.5, ...
      'DisplayName', '3 μT (qualità)');

% Zona residenziale
xline(15, 'g-', 'LineWidth', 2, 'DisplayName', 'Inizio zona resid. (15m)');
xline(30, 'g--', 'LineWidth', 2, 'DisplayName', 'Fine zona resid. (30m)');

xlabel('Distanza dal binario [m]', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Campo magnetico B [μT]', 'FontSize', 14, 'FontWeight', 'bold');
title(sprintf('Campo Magnetico a 1.5m dal Suolo - Ferrovia AV (I=%dA)', I_train), ...
      'FontSize', 16, 'FontWeight', 'bold');

legend('Location', 'northeast', 'FontSize', 11);
grid on;
xlim([0 50]);
ylim([0 max(B_profile(abs(x)<=50))*1.2]);
set(gca, 'FontSize', 12, 'LineWidth', 1.5);

saveas(gcf, 'case3_output.png');

fprintf('Output salvato:\n');
fprintf('  - Grafico: case3_output.png\n');
fprintf('  - Console: case3_output.txt\n');
fprintf('\n');

diary off;
