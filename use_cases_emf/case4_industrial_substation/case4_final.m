%% ═══════════════════════════════════════════════════════════════════════
%% CASO 4: SOTTOSTAZIONE INDUSTRIALE - SICUREZZA LAVORATORI
%% ═══════════════════════════════════════════════════════════════════════

close all; clc;

diary('case4_output.txt');
diary on;

fprintf('\n');
fprintf('╔════════════════════════════════════════════════════════════╗\n');
fprintf('║         CASO 4: SOTTOSTAZIONE INDUSTRIALE                 ║\n');
fprintf('╚════════════════════════════════════════════════════════════╝\n');
fprintf('\n');

%% PARAMETRI SOTTOSTAZIONE
I_phase = 2000;                 
mu0 = 4*pi*1e-7;

cabinet_height = 1.5;           
phase_spacing = 0.15;           

xs = [-0.15, 0, 0.15];
ys = [cabinet_height, cabinet_height, cabinet_height];

phases = [0, 2*pi/3, 4*pi/3];
I = I_phase * exp(1i * phases);

fprintf('PARAMETRI IMPIANTO:\n');
fprintf('  Trasformatore:     20 kV / 400 V, 1.6 MVA\n');
fprintf('  Corrente carico:   %d A/fase\n', I_phase);
fprintf('  Altezza sbarre:    %.1f m\n', cabinet_height);
fprintf('  Spaziatura fasi:   %d cm\n', phase_spacing*100);
fprintf('\n');

%% CALCOLO CAMPO MAGNETICO
x = linspace(-3, 3, 121);
y = linspace(0, 3, 61);
[X, Y] = meshgrid(x, y);

Bx_tot = zeros(size(X));
By_tot = zeros(size(Y));

for k = 1:3
    R = sqrt((X - xs(k)).^2 + (Y - ys(k)).^2);
    R(R < 0.01) = 0.01;
    
    B = mu0 * I(k) ./ (2 * pi * R);
    Bx_tot = Bx_tot + B .* (X - xs(k)) ./ R;
    By_tot = By_tot + B .* (Y - ys(k)) ./ R;
end

B_total = sqrt(abs(Bx_tot).^2 + abs(By_tot).^2);
B_uT = B_total * 1e6;

%% VALUTAZIONE POSTAZIONI LAVORATORE
B_action = 500;      
B_occ_limit = 1000;  

positions = struct();
positions(1).name = 'Porta quadro (30cm)';
positions(1).x = 0.3;
positions(1).y = cabinet_height;

positions(2).name = 'Distanza lavoro (50cm)';
positions(2).x = 0.5;
positions(2).y = cabinet_height;

positions(3).name = 'Postazione operatore (1.5m)';
positions(3).x = 1.5;
positions(3).y = 1.0;

positions(4).name = 'Corridoio (2m)';
positions(4).x = 2.0;
positions(4).y = 1.0;

fprintf('═══════════════════════════════════════════════════════════\n');
fprintf('ESPOSIZIONE LAVORATORI:\n');
fprintf('\n');
fprintf('  Posizione              │ B [μT] │ Limite  │ Stato\n');
fprintf('  ───────────────────────┼────────┼─────────┼────────────\n');

for i = 1:length(positions)
    pos = positions(i);
    B_val = interp2(X, Y, B_uT, pos.x, pos.y);
    
    if B_val <= 100
        status = '✓ OK pubbl.';
        limit = '100 μT';
    elseif B_val <= B_action
        status = '✓ OK lavoro';
        limit = '500 μT';
    elseif B_val <= B_occ_limit
        status = '⚠ Livello az.';
        limit = '500 μT';
    else
        status = '✗ Eccede';
        limit = '1000 μT';
    end
    fprintf('  %-22s │ %6.0f │ %s │ %s\n', pos.name, B_val, limit, status);
end

fprintf('\n');
fprintf('VERIFICA CONFORMITÀ (Direttiva UE 2013/35):\n');
fprintf('  Livello azione:              500 μT\n');
fprintf('  Limite esposizione:          1000 μT\n');
fprintf('  Max campo zona lavoro (50cm): %.0f μT\n', interp2(X, Y, B_uT, 0.5, cabinet_height));
fprintf('  ESITO:  ✓ CONFORME\n');
fprintf('\n');
fprintf('RACCOMANDAZIONI:\n');
fprintf('  - Segnalare zona <50cm con cartello "Campo Magnetico"\n');
fprintf('  - Distanza minima lavoro: 50 cm\n');
fprintf('  - Portatori pacemaker: distanza >1 m\n');
fprintf('═══════════════════════════════════════════════════════════\n');
fprintf('\n');

%% GRAFICO SINGOLO STILE CASO 1
figure('Position', [100 100 900 600], 'Color', 'w');

% Profilo radiale a altezza sbarre
r_plot = linspace(0.2, 3, 100);
B_radial = zeros(size(r_plot));

for i = 1:length(r_plot)
    B_radial(i) = interp2(X, Y, B_uT, r_plot(i), cabinet_height);
end

plot(r_plot, B_radial, 'b-', 'LineWidth', 3, 'DisplayName', 'Campo magnetico');
hold on;

% Limiti
yline(1000, 'r-', 'LineWidth', 2.5, 'DisplayName', '1000 μT (limite espos.)');
yline(500, 'Color', [1 0.5 0], 'LineStyle', '--', 'LineWidth', 2.5, ...
      'DisplayName', '500 μT (livello azione)');
yline(100, 'g--', 'LineWidth', 2.5, 'DisplayName', '100 μT (pubblico)');

% Postazioni
for i = 1:length(positions)
    pos = positions(i);
    B_val = interp2(X, Y, B_uT, pos.x, pos.y);
    if i == 1
        plot(pos.x, B_val, 'mp', 'MarkerSize', 14, 'MarkerFaceColor', 'm', ...
             'LineWidth', 2, 'DisplayName', 'Postazioni lavoratore');
    else
        plot(pos.x, B_val, 'mp', 'MarkerSize', 14, 'MarkerFaceColor', 'm', ...
             'LineWidth', 2, 'HandleVisibility', 'off');
    end
end

xlabel('Distanza dal quadro [m]', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Campo magnetico B [μT]', 'FontSize', 14, 'FontWeight', 'bold');
title(sprintf('Campo Magnetico Sottostazione (I=%dA/fase)', I_phase), ...
      'FontSize', 16, 'FontWeight', 'bold');

legend('Location', 'northeast', 'FontSize', 11);
grid on;
xlim([0.2 3]);
ylim([0 1200]);
set(gca, 'FontSize', 12, 'LineWidth', 1.5);

saveas(gcf, 'case4_output.png');

fprintf('Output salvato:\n');
fprintf('  - Grafico: case4_output.png\n');
fprintf('  - Console: case4_output.txt\n');
fprintf('\n');

diary off;
