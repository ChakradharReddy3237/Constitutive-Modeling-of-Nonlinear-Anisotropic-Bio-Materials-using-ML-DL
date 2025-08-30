% plot_uniaxial_fit_on_biaxial_test_C.m
clear; clc; close all;

% --- Data Loading and Processing ---

% 1. Load the model's prediction for the UNIAXIAL test
%    (This is the data the model was trained on)
uniaxial_pred_filename = 'uniaxial_smooth_predictions_C_Texp1.csv';
T_uni_pred = readtable(uniaxial_pred_filename);
uniaxial_pred_lambda = T_uni_pred.Stretch_Lambda1;
uniaxial_pred_stress = T_uni_pred.Predicted_Stress_P11;

% 2. Load the model's prediction for the BIAXIAL test
%    (This is the test/generalization data)
biaxial_pred_filename = 'biaxial_smooth_predictions_C_Texp1.csv';
T_bi_pred = readtable(biaxial_pred_filename);
biaxial_pred_lambda = T_bi_pred.Stretch_Lambda2;
biaxial_pred_stress = T_bi_pred.Predicted_Stress_P22;

% 3. Manually insert the full experimental data for comparison
P11_exp_data = [1.0000,0; 1.0708,0.3840; 1.2017,0.8987; 1.3125,1.1814; 1.4000,1.4093; 1.5125,1.6456; 1.6017,1.8608; 1.7125,2.1055; 1.8008,2.3122; 1.8883,2.5570; 1.9767,2.7848; 2.0883,3.1519; 2.1992,3.5274; 2.2867,3.8354; 2.3975,4.2532; 2.4383,4.4304; 2.4858,4.5949];
P22_exp_data = [1.0000,0; 1.3208,1.0506; 1.4017,1.2068; 1.5092,1.3840; 1.5983,1.5401; 1.7017,1.6835; 1.7842,1.7848; 1.8967,1.9662; 1.9792,2.1181; 2.0858,2.2911; 2.1708,2.4599; 2.2783,2.6962; 2.3825,2.9409; 2.4225,3.0549; 2.4867,3.2236];

% --- Plotting with Professional Enhancements ---
figure('Color', 'w');
hold on; 

% Plot prediction lines
h1 = plot(uniaxial_pred_lambda, uniaxial_pred_stress, '-.', 'Color', [0.5 0 0.5], 'LineWidth', 2.5);
h2 = plot(biaxial_pred_lambda, biaxial_pred_stress, '-', 'Color', [0 0 1], 'LineWidth', 2.5);

% Plot experimental results with hollow markers
h3 = plot(P11_exp_data(:,1), P11_exp_data(:,2), 'd', 'Color', [0.5 0 0.5], 'MarkerFaceColor', 'w', 'MarkerSize', 10, 'LineWidth', 1.5);
h4 = plot(P22_exp_data(:,1), P22_exp_data(:,2), 'o', 'Color', 'k', 'MarkerFaceColor', 'w', 'MarkerSize', 8, 'LineWidth', 1.5);

% --- Add a text annotation to explain the experiment ---
%text(1.6, 4.5, 'Model trained ONLY on Uniaxial Data', ...
%    'FontSize', 14, 'FontName', 'Times New Roman', ...
%    'Color', [0.3 0.3 0.3], 'BackgroundColor', [0.95 0.95 0.95], 'EdgeColor', 'k');

% --- Formatting and Labels ---
xlabel('Stretch ($\lambda_1$, or $\lambda_2$)', 'FontSize', 18, 'Interpreter', 'latex', 'FontName', 'Times New Roman');
ylabel('First P-K stress ($P_{11}$, or $P_{22}$)', 'FontSize', 18, 'Interpreter', 'latex', 'FontName', 'Times New Roman');

legend([h1 h2 h3 h4], ...
       {'$P_{11}$ (Fit on Uniaxial)', '$P_{22}$ (Predicted on Biaxial)', '$P_{11}$ (Experimental Uniaxial)', '$P_{22}$ (Experimental Biaxial)'}, ...
       'Interpreter', 'latex', 'FontSize', 16, 'Box', 'off', 'Location', 'northwest');

set(gca, 'FontSize', 18, 'FontName', 'Times New Roman', 'LineWidth', 1.5);
     
% Set axis limits to focus on the data. A linear scale is used here.
ylim([-0.5, 6]); % Allow for small negative values in prediction
xlim([1, 2.5]);

box on;
hold off;

% Optional: Save the figure
% print('C_uniaxial_fit_biaxial_test_plot', '-dpng', '-r300');