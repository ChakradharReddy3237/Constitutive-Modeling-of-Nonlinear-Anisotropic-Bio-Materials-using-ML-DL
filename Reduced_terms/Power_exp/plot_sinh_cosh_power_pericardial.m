% plot_sinh_cosh_power_pericardial.m
clear; clc; close all;

% --- Data Loading and Processing ---

% 1. Load Uniaxial Data (P11)
uniaxial_filename = 'task1_uniaxial_predictions_sinh_cosh_power_pericardial.csv';
T_uni = readtable(uniaxial_filename);

% Extract Uniaxial columns
uniaxial_lambda = T_uni.Stretch_Lambda1;
uniaxial_exp_stress = T_uni.Experimental_Stress_P11;
uniaxial_pred_stress = T_uni.Predicted_Stress_P11;

% 2. Load Biaxial Data (P22)
biaxial_filename = 'task2_biaxial_predictions_sinh_cosh_power_pericardial.csv';
T_bi = readtable(biaxial_filename);

% Extract Biaxial columns
biaxial_lambda = T_bi.Stretch_Lambda2;
biaxial_exp_stress = T_bi.Experimental_Stress_P22;
biaxial_pred_stress = T_bi.Predicted_Stress_P22;


% Sort prediction data for plotting continuous lines
[uniaxial_lambda_sorted, sortIdx_uni] = sort(uniaxial_lambda);
uniaxial_pred_stress_sorted = uniaxial_pred_stress(sortIdx_uni);

[biaxial_lambda_sorted, sortIdx_bi] = sort(biaxial_lambda);
biaxial_pred_stress_sorted = biaxial_pred_stress(sortIdx_bi);


% --- Plotting ---
% Create figure with a white background
figure('Color', 'w');
hold on; % Hold the plot to overlay multiple datasets

% Plot DL predictions (lines)
% Uniaxial (P11) - Dark magenta dashed-dotted line
h1 = plot(uniaxial_lambda_sorted, uniaxial_pred_stress_sorted, '-.', ...
    'Color', [0.5 0 0.5], 'LineWidth', 2.5);

% Biaxial (P22) - Blue solid line
h2 = plot(biaxial_lambda_sorted, biaxial_pred_stress_sorted, '-', ...
    'Color', [0 0 1], 'LineWidth', 2.5);

% Plot experimental results (markers)
% Uniaxial (P11) - Magenta diamond markers
h3 = plot(uniaxial_lambda, uniaxial_exp_stress, 'd', ...
    'Color', [0.5 0 0.5], 'MarkerFaceColor', 'w', ...
    'MarkerSize', 10, 'LineWidth', 1.5);

% Biaxial (P22) - Black circle markers
h4 = plot(biaxial_lambda, biaxial_exp_stress, 'o', ...
    'Color', 'k', 'MarkerFaceColor', 'w', ...
    'MarkerSize', 8, 'LineWidth', 1.5);

% --- Formatting and Labels ---
% X-axis label
xlabel('Stretch ($\lambda_1$, or $\lambda_2$)', ...
       'FontSize', 18, 'Interpreter', 'latex', 'FontName', 'Times New Roman');

% Y-axis label
ylab = ylabel('First P-K stress ($P_{11}$, or $P_{22}$)', ...
              'FontSize', 18, 'Interpreter', 'latex', 'FontName', 'Times New Roman');

% Move Y-label slightly to the left for better spacing
set(ylab, 'Units', 'normalized');
pos = get(ylab, 'Position');
pos(1) = pos(1) - 0.0001;
set(ylab, 'Position', pos);

% Legend
legend([h1 h2 h3 h4], ...
       {'$P_{11}$ (Deep Learning prediction)', ...
        '$P_{22}$ (Deep Learning prediction)', ...
        '$P_{11}$ (Experimental results)', ...
        '$P_{22}$ (Experimental results)'}, ...
       'Interpreter', 'latex', ...
       'FontSize', 18, ...
       'Box', 'off', ...
       'Location', 'northwest');

% Axes formatting
set(gca, 'FontSize', 18, ...
         'FontName', 'Times New Roman', ...
         'LineWidth', 1.5);

box on;
hold off;

% Optional: Save the figure
% print('sinh_cosh_power_pericardial_plot', '-dpng', '-r300'); % Saves a high-quality PNG