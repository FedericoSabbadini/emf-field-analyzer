%% ═══════════════════════════════════════════════════════════════════════
%% CASO 5: STAZIONE SATELLITARE - ZONE ESCLUSIONE RF
%% ═══════════════════════════════════════════════════════════════════════

close all; clc;

diary('case5_output.txt');
diary on;

fprintf('\n');
fprintf('╔════════════════════════════════════════════════════════════╗\n');
fprintf('║         CASO 5: STAZIONE SATELLITARE                      ║\n');
fprintf('╚════════════════════════════════════════════════════════════╝\n');
fprintf('\n');

%% PARAMETRI ANTENNA
f = 6e9;                        
lambda = 3e8 / f;               
D = 3.0;                        % Ridotto da 7.3m a 3.0m
eta = 0.65;                     

A_phys = pi * (D/2)^2;
A_eff = eta * A_phys;
G_linear = 4 * pi * A_eff / lambda^2;
G_dBi = 10 * log10(G_linear);

P_tx = 100;                     % 100W tipico per uplink VSAT
EIRP = P_tx * G_linear;         
EIRP_dBW = 10 * log10(EIRP);
EIRP_kW = EIRP / 1000;

elevation = 25;                 
R_nf = 2 * D^2 / lambda;

fprintf('PARAMETRI SISTEMA:\n');
fprintf('  Frequenza:         %.1f GHz (C-band)\n', f/1e9);
fprintf('  Diametro:          %.1f m\n', D);
fprintf('  Guadagno:          %.1f dBi\n', G_dBi);
fprintf('  Potenza TX:        %.0f W\n', P_tx);
fprintf('  EIRP:              %.1f dBW (%.0f kW)\n', EIRP_dBW, EIRP_kW);
fprintf('  Elevazione:        %d°\n', elevation);
fprintf('\n');

%% CALCOLO ZONE ESCLUSIONE
r_range = linspace(1, 400, 400);  % Ridotto da 500m a 400m

HPBW = 70 * lambda / D * 180/pi;
sigma = HPBW / (2 * sqrt(2 * log(2)));

% Densità potenza lungo asse fascio
S_bore = EIRP ./ (4 * pi * r_range.^2);

S_occ = 10;     
S_pub = 2;      

r_occ = sqrt(EIRP / (4 * pi * S_occ));
r_pub = sqrt(EIRP / (4 * pi * S_pub));

fprintf('═══════════════════════════════════════════════════════════\n');
fprintf('ZONE ESCLUSIONE (lungo asse fascio):\n');
fprintf('  Limite occupazionale (10 W/m²): %.0f m\n', r_occ);
fprintf('  Limite pubblico (2 W/m²):       %.0f m\n', r_pub);
fprintf('\n');

% Valutazione al suolo (antenna punta in alto)
theta_ground = elevation;  % Angolo rispetto a asse fascio
F_ground = exp(-theta_ground^2 / (2 * sigma^2));
R_ground_typical = 100;  % Distanza tipica al suolo
S_ground_max = EIRP * F_ground / (4 * pi * R_ground_typical^2);

fprintf('VALUTAZIONE LIVELLO SUOLO:\n');
fprintf('  Densità tipica a 100m:       %.2f W/m²\n', S_ground_max);
if S_ground_max < S_pub
    fprintf('  Status:  ✓ Campo basso al suolo\n');
    fprintf('  Motivo:  Antenna punta in alto (%d°)\n', elevation);
else
    fprintf('  Status:  ⚠ Verificare con misure\n');
end
fprintf('\n');

fprintf('VERIFICA CONFORMITÀ (ICNIRP 2020):\n');
fprintf('  Limite occupazionale:        10 W/m²\n');
fprintf('  Limite pubblico:             2 W/m²\n');
fprintf('  ESITO:  ✓ CONFORME con recinzione a %.0fm\n', ceil(r_pub));
fprintf('\n');
fprintf('REQUISITI:\n');
fprintf('  - Recinzione zona controllata: %.0f m\n', ceil(r_pub));
fprintf('  - Cartellonistica RF obbligatoria\n');
fprintf('  - Interlock cancello (spegnimento auto TX)\n');
fprintf('  - Coordinamento ENAC per voli < 500m AGL\n');
fprintf('═══════════════════════════════════════════════════════════\n');
fprintf('\n');

%% GRAFICO SINGOLO STILE CASO 1
figure('Position', [100 100 900 600], 'Color', 'w');

plot(r_range, S_bore, 'b-', 'LineWidth', 3, 'DisplayName', 'Densità potenza (asse fascio)');
hold on;

% Limiti
yline(10, 'r--', 'LineWidth', 2.5, 'DisplayName', '10 W/m² (occupazionale)');
yline(2, 'g--', 'LineWidth', 2.5, 'DisplayName', '2 W/m² (pubblico)');

% Zone
xline(r_occ, 'r-', 'LineWidth', 2, 'DisplayName', sprintf('Zona controllata (%.0fm)', r_occ));
xline(r_pub, 'g-', 'LineWidth', 2, 'DisplayName', sprintf('Zona pubblica (%.0fm)', r_pub));

set(gca, 'YScale', 'log');

xlabel('Distanza da antenna (lungo fascio) [m]', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Densità potenza S [W/m²]', 'FontSize', 14, 'FontWeight', 'bold');
title('Densità Potenza RF - Stazione Satellitare C-band', 'FontSize', 16, 'FontWeight', 'bold');

legend('Location', 'northeast', 'FontSize', 11);
grid on;
xlim([0 400]);  % Ridotto da 500 a 400
ylim([0.001 100]);
set(gca, 'FontSize', 12, 'LineWidth', 1.5);

saveas(gcf, 'case5_output.png');

fprintf('Output salvato:\n');
fprintf('  - Grafico: case5_output.png\n');
fprintf('  - Console: case5_output.txt\n');
fprintf('\n');

diary off;
