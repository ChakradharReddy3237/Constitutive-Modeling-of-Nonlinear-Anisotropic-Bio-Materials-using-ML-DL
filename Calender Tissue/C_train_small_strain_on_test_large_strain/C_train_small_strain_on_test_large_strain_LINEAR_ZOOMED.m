% C_train_small_strain_on_test_large_strain_LINEAR_ZOOMED.m
clear; clc; close all;

% --- Data Loading and Processing ---
% Load the CSV file which contains the model predictions.
filename = 'predictions_small_strain_training_with_smooth_curves_C.csv';
T = readtable(filename);

% --- Manually Insert Full Experimental Data ---
% This data is used for plotting the experimental markers ('d' and 'o').
P11_exp_data = [1.0000, 0; 1.0708, 0.3840; 1.2017, 0.8987; 1.3125, 1.1814;
                1.4000, 1.4093; 1.5125, 1.6456; 1.6017, 1.8608; 1.7125, 2.1055;
                1.8008, 2.3122; 1.8883, 2.5570; 1.9767, 2.7848; 2.0883, 3.1519;
                2.1992, 3.5274; 2.2867, 3.8354; 2.3975, 4.2532; 2.4383, 4.4304;
                2.4858, 4.5949];

P22_exp_data = [1.0000, 0; 1.3208, 1.0506; 1.4017, 1.2068; 1.5092, 1.3840;
                1.5983, 1.5401; 1.7017, 1.6835; 1.7842, 1.7848; 1.8967, 1.9662;
                1.9792, 2.1181; 2.0858, 2.2911; 2.1708, 2.4599; 2.2783, 2.6962;
                2.3825, 2.9409; 2.4225, 3.0549; 2.4867, 3.2236];

% --- Extract Prediction Data for Smooth Curves from the CSV ---
% Use logical indexing to find the data for the smooth prediction lines.
isUniaxial = strcmp(T.task, 'Uniaxial');
isBiaxial = strcmp(T.task, 'Biaxial');
isSmooth = strcmp(T.data_split, 'Smooth Plot');

% Extract Uniaxial smooth curve data
uniaxial_smooth_lambda = T.lambda(isUniaxial & isSmooth);
uniaxial_smooth_stress = T.predicted_stress(isUniaxial & isSmooth);

% Extract Biaxial smooth curve data
biaxial_smooth_lambda = T.lambda(isBiaxial & isSmooth);
biaxial_smooth_stress = T.predicted_stress(isBiaxial & isSmooth);

% --- Plotting ---
% Create figure with a white background
figure('Color', 'w');
hold on; 

% Plot DL predictions (smooth lines) matching the example style
% Uniaxial (P11) - Dark magenta/purple dash-dot line
h1 = plot(uniaxial_smooth_lambda, uniaxial_smooth_stress, '-.', ...
    'Color', [0.5 0 0.5], 'LineWidth', 2.5);

% Biaxial (P22) - Blue solid line
h2 = plot(biaxial_smooth_lambda, biaxial_smooth_stress, '-', ...
    'Color', [0 0 1], 'LineWidth', 2.5);

% Plot experimental results (markers from manually entered data)
% Uniaxial (P11) - Purple diamond markers
h3 = plot(P11_exp_data(:,1), P11_exp_data(:,2), 'd', ...
    'Color', [0.5 0 0.5], 'MarkerFaceColor', 'w', ...
    'MarkerSize', 10, 'LineWidth', 1.5);

% Biaxial (P22) - Black circle markers
h4 = plot(P22_exp_data(:,1), P22_exp_data(:,2), 'o', ...
    'Color', 'k', 'MarkerFaceColor', 'w', ...
    'MarkerSize', 8, 'LineWidth', 1.5);

% --- Formatting and Labels (Matching the example) ---
% X-axis label
xlabel('Stretch ($\lambda_1$, or $\lambda_2$)', ...
       'FontSize', 18, 'Interpreter', 'latex', 'FontName', 'Times New Roman');

% Y-axis label
ylabel('First P-K stress ($P_{11}$, or $P_{22}$)', ...
       'FontSize', 18, 'Interpreter', 'latex', 'FontName', 'Times New Roman');

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
     
% --- SET AXIS LIMITS TO ZOOM IN ON THE LOW-STRESS REGION ---
ylim([0, 5]); % Set a low y-limit to clearly see the experimental data
xlim([1, 2.5]); % Show the full x-range for context

box on;
hold off;

% Optional: Save the figure
% print('C_train_small_strain_linear_zoomed_plot', '-dpng', '-r300');