% plot_pericardial_large_train_ZOOMED.m
clear; clc; close all;

% --- Data Loading and Processing ---

% 1. Load Uniaxial Prediction Data (P11) for the smooth curve
uniaxial_filename = 'uniaxial_smooth_predictions_P_Ltrain.csv';
T_uni = readtable(uniaxial_filename);
uniaxial_smooth_lambda = T_uni.Stretch_Lambda1;
uniaxial_smooth_stress = T_uni.Predicted_Stress_P11;

% 2. Load Biaxial Prediction Data (P22) for the smooth curve
biaxial_filename = 'biaxial_smooth_predictions_P_Ltrain.csv';
T_bi = readtable(biaxial_filename);
biaxial_smooth_lambda = T_bi.Stretch_Lambda2;
biaxial_smooth_stress = T_bi.Predicted_Stress_P22;

% 3. Manually Insert Full Experimental Data for markers
P11_exp_data = [1.1986, 1.2860;
                1.1868, 0.9768;
                1.1699, 0.6386;
                1.1483, 0.2928;
                1.1153, 0.0850;
                1.0725, 0.0184;
                1.0402, 0.0087;
                1.0158, 0.0019;
                1.0000, 0.0000];

P22_exp_data = [1.1917, 0.1604;
                1.1465, 0.0560;
                1.1084, 0.0280;
                1.0715, 0.0135;
                1.0383, 0.0068;
                1.0000, 0.0000];

% --- Plotting with Clarity Improvements ---
figure('Color', 'w');
hold on; 

% Plot DL predictions (smooth lines)
h2 = plot(biaxial_smooth_lambda, biaxial_smooth_stress, '-', 'Color', [0 0 1], 'LineWidth', 2.5);
h1 = plot(uniaxial_smooth_lambda, uniaxial_smooth_stress, '-.', 'Color', [0.5 0 0.5], 'LineWidth', 2.5);

% Plot experimental results (hollow markers for clarity)
h3 = plot(P11_exp_data(:,1), P11_exp_data(:,2), 'd', 'Color', [0.5 0 0.5], 'MarkerFaceColor', 'w', 'MarkerSize', 10, 'LineWidth', 1.5);
h4 = plot(P22_exp_data(:,1), P22_exp_data(:,2), 'o', 'Color', 'k', 'MarkerFaceColor', 'w', 'MarkerSize', 8, 'LineWidth', 1.5);

% --- Formatting and Labels ---
xlabel('Stretch ($\lambda_1$, or $\lambda_2$)', 'FontSize', 18, 'Interpreter', 'latex', 'FontName', 'Times New Roman');
ylabel('First P-K stress ($P_{11}$, or $P_{22}$)', 'FontSize', 18, 'Interpreter', 'latex', 'FontName', 'Times New Roman');

legend([h1 h2 h3 h4], ...
       {'$P_{11}$ (Deep Learning prediction)', '$P_{22}$ (Deep Learning prediction)', '$P_{11}$ (Experimental results)', '$P_{22}$ (Experimental results)'}, ...
       'Interpreter', 'latex', 'FontSize', 18, 'Box', 'off', 'Location', 'northwest');

set(gca, 'FontSize', 18, 'FontName', 'Times New Roman', 'LineWidth', 1.5);
     
% --- Set axis limits to ZOOM IN on the small-strain (interpolation) region ---
ylim([0, 0.15]); % Adjust y-limit to clearly see the low-stress data
xlim([1, 1.1]);  % Cut the x-axis at 1.1 as requested

box on;
hold off;

% Optional: Save the figure
% print('pericardial_large_train_zoomed_plot', '-dpng', '-r300');