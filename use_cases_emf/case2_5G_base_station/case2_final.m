%% ═══════════════════════════════════════════════════════════════════════
%% CASO 2: STAZIONE BASE 5G/LTE SU EDIFICIO
%% ═══════════════════════════════════════════════════════════════════════

close all; clc;

diary('case2_output.txt');
diary on;

fprintf('\n');
fprintf('╔════════════════════════════════════════════════════════════╗\n');
fprintf('║         CASO 2: STAZIONE BASE 5G/LTE                      ║\n');
fprintf('╚════════════════════════════════════════════════════════════╝\n');
fprintf('\n');

%% PARAMETRI ANTENNA
f = 2100e6;                     
EIRP_main = 2000;               

antenna_height = 25;            
electrical_tilt = 10;           % Aumentato da 6° a 10°
total_tilt = electrical_tilt;

HPBW_H = 65;                    
HPBW_V = 8;                     

fprintf('PARAMETRI ANTENNA:\n');
fprintf('  Frequenza:         %.0f MHz (LTE Band 1)\n', f/1e6);
fprintf('  EIRP:              %.0f W (%.1f dBm)\n', EIRP_main, 10*log10(EIRP_main*1000));
fprintf('  Altezza:           %d m\n', antenna_height);
fprintf('  Tilt elettrico:    %d°\n', electrical_tilt);
fprintf('\n');

%% CALCOLO CAMPO ELETTRICO (modello semplificato)
d_horiz = linspace(0.1, 100, 200);
h_eval = 12;  % Altezza 4° piano

% Distanza 3D
R = sqrt(d_horiz.^2 + (h_eval - antenna_height).^2);
R(R < 1) = 1;

% Angolo elevazione del punto rispetto antenna
theta_rad = atan2(h_eval - antenna_height, d_horiz);
theta_deg = rad2deg(theta_rad);

% Pattern verticale approssimato (lobo principale + laterali)
theta_from_main = abs(theta_deg - (-total_tilt));
% Attenuazione pattern (dB)
att_pattern = min(12 * (theta_from_main / HPBW_V).^2, 20);
% Fattore lineare
F_V = 10.^(-att_pattern / 20);

% Campo elettrico [V/m]
E_prof = sqrt(30 * EIRP_main * F_V) ./ R;

%% VALUTAZIONE EDIFICIO VICINO
balcony_distance = 40;          % Cambiato da 20m a 40m
floor_height = 3;               
floors = [3, 4, 5, 6];

fprintf('═══════════════════════════════════════════════════════════\n');
fprintf('CAMPO ELETTRICO EDIFICIO VICINO (d=%dm):\n', balcony_distance);
fprintf('\n');
fprintf('  Piano │ Altezza │ E [V/m] │ Stato\n');
fprintf('  ──────┼─────────┼─────────┼──────────────\n');

E_max = 0;
E_at_building = 0;  % Inizializzo
for floor = floors
    h = floor * floor_height;
    r = sqrt(balcony_distance^2 + (h - antenna_height)^2);
    theta = rad2deg(atan2(h - antenna_height, balcony_distance));
    theta_from_main = abs(theta - (-total_tilt));
    att_pattern = min(12 * (theta_from_main / HPBW_V)^2, 20);
    fv = 10^(-att_pattern / 20);
    E_floor = sqrt(30 * EIRP_main * fv) / r;
    E_max = max(E_max, E_floor);
    
    % Salva valore piano 4 per grafico
    if floor == 4
        E_at_building = E_floor;
    end
    
    if E_floor <= 6
        status = '✓ OK';
    else
        status = '✗ ECCEDE';
    end
    fprintf('   %d   │  %2.0f m   │  %5.2f  │ %s\n', floor, h, E_floor, status);
end

fprintf('\n');
fprintf('VERIFICA CONFORMITÀ NORMATIVA (DPCM 8/7/2003):\n');
fprintf('  Limite:                      6 V/m\n');
fprintf('  Campo massimo edificio:      %.2f V/m\n', E_max);
if E_max <= 6
    fprintf('  ESITO:  ✓ CONFORME\n');
    fprintf('\n');
    fprintf('CONCLUSIONE:\n');
    fprintf('  Installazione autorizzabile.\n');
else
    fprintf('  ESITO:  ✗ NON CONFORME\n');
    fprintf('\n');
    fprintf('CONCLUSIONE:\n');
    fprintf('  Necessarie mitigazioni (aumento tilt o riduzione EIRP).\n');
end
fprintf('═══════════════════════════════════════════════════════════\n');
fprintf('\n');

%% GRAFICO SINGOLO STILE CASO 1
figure('Position', [100 100 900 600], 'Color', 'w');

plot(d_horiz, E_prof, 'b-', 'LineWidth', 3, 'DisplayName', 'Campo elettrico');
hold on;

% Limite 6 V/m
yline(6, 'r--', 'LineWidth', 2.5, 'DisplayName', '6 V/m (limite)');

% Posizione edificio
xline(balcony_distance, 'm-', 'LineWidth', 2.5, 'DisplayName', sprintf('Edificio vicino (%dm)', balcony_distance));
plot(balcony_distance, E_at_building, 'mo', 'MarkerSize', 14, 'MarkerFaceColor', 'm', ...
     'LineWidth', 2, 'HandleVisibility', 'off');

% Annotazione valore
text(balcony_distance+2, E_at_building + 0.4, sprintf('%.2f V/m', E_at_building), ...
     'FontSize', 14, 'Color', 'm', 'FontWeight', 'bold');

xlabel('Distanza da antenna [m]', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Campo elettrico E [V/m]', 'FontSize', 14, 'FontWeight', 'bold');
title('Campo Elettrico al 4° Piano (h=12m) - Stazione Base 5G', 'FontSize', 16, 'FontWeight', 'bold');

legend('Location', 'northeast', 'FontSize', 12);
grid on;
xlim([0 60]);
ylim([0 max(E_prof)*1.2]);
set(gca, 'FontSize', 12, 'LineWidth', 1.5);

saveas(gcf, 'case2_output.png');

fprintf('Output salvato:\n');
fprintf('  - Grafico: case2_output.png\n');
fprintf('  - Console: case2_output.txt\n');
fprintf('\n');

diary off;
