%% Three-Phase 120° SHIFT - YZ Plane
close all; clc;

I0 = 400; mu0 = 4*pi*1e-7;
xs = [-5, 0, 5];
phases = [0, 2*pi/3, 4*pi/3];
I = I0 * exp(1i * phases);

y = linspace(-40, 40, 161);
z = linspace(-40, 40, 161);
[Y, Z] = meshgrid(y, z);

Bx_tot = zeros(size(Y));
By_tot = zeros(size(Y));

for k = 1:3
    R = sqrt(xs(k)^2 + Y.^2);
    R(R < 0.1) = 0.1;
    B = mu0 * I(k) ./ (2 * pi * R);
    Bx_tot = Bx_tot + B .* (-Y) ./ R;
    By_tot = By_tot + B .* xs(k) ./ R;
end

B_uT = sqrt(abs(Bx_tot).^2 + abs(By_tot).^2) * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(Y, Z, B_uT); shading interp;
xlabel('y [m]'); ylabel('z [m]');
title('Three-Phase 120° - YZ at x=0');
colormap('hot'); colorbar; caxis([0 30]);

subplot(1,2,2);
[C, h] = contour(Y, Z, B_uT, [3, 10, 20], 'LineWidth', 2);
clabel(C, h);
xlabel('y [m]'); ylabel('z [m]');
title('Reduced field on symmetry plane');
grid on; axis equal;

saveas(gcf, 'output.png');
