% P_contributions_sinh_cosh_power.m
clear; clc; close all;

% --- Load Data ---
filename = 'P_contributions_sinh_cosh_power.csv';
T = readtable(filename);

P11_exp_data = [1.1986, 1.2860; 1.1868, 0.9768; 1.1699, 0.6386;
                1.1483, 0.2928; 1.1153, 0.0850; 1.0725, 0.0184;
                1.0402, 0.0087; 1.0158, 0.0019; 1.0000, 0.0000];
P22_exp_data = [1.1917, 0.1604; 1.1465, 0.0560; 1.1084, 0.0280;
                1.0715, 0.0135; 1.0383, 0.0068; 1.0000, 0.0000];

% --- Prepare Uniaxial (P11) Data ---
lambda1 = T.lambda1;
p11_contrib_vars = T.Properties.VariableNames(startsWith(T.Properties.VariableNames, 'P11_'));
p11_contributions = T{:, p11_contrib_vars};

% --- Prepare Biaxial (P22) Data ---
lambda2 = T.lambda2;
p22_contrib_vars = T.Properties.VariableNames(startsWith(T.Properties.VariableNames, 'P22_'));
p22_contributions = T{:, p22_contrib_vars};

% --- Define a High-Contrast Custom Colormap ---
custom_colormap = [
    0, 0.4470, 0.7410;  % Blue
    0.8500, 0.3250, 0.0980;  % Orange
    0.4660, 0.6740, 0.1880;  % Green
    0.4940, 0.1840, 0.5560;  % Purple
    0.9290, 0.6940, 0.1250;  % Yellow
    0.3010, 0.7450, 0.9330;  % Light Blue
    0.6350, 0.0780, 0.1840;  % Maroon
    1, 0, 1;                 % Magenta
    0, 0.75, 0.75;           % Teal
    0.5, 0.5, 0.5            % Gray
];

% =========================================================================
% FIGURE 1: UNIAXIAL (P11) CONTRIBUTIONS
% =========================================================================
figure('Color', 'w', 'Position', [100, 100, 800, 600]);
ax1 = gca;
hold(ax1, 'on');
box(ax1, 'on');
set(ax1, 'ColorOrder', custom_colormap);

% --- Sort Contributions for Plotting Order ---
p11_term_areas = trapz(lambda1, abs(p11_contributions));
[~, sort_idx_desc] = sort(p11_term_areas, 'descend');
p11_contributions_sorted = p11_contributions(:, sort_idx_desc);

% --- Plotting ---
h_area1 = area(ax1, lambda1, p11_contributions_sorted, 'EdgeColor', 'k', 'LineWidth', 0.2);
plot(ax1, P11_exp_data(:,1), P11_exp_data(:,2), 'd', 'Color', [0.1 0.1 0.1], 'MarkerFaceColor', 'w', 'MarkerSize', 10, 'LineWidth', 1.5, 'DisplayName', 'Experimental Data');

% --- Create Legend with Sorted Percentages (Ascending) ---
[sorted_areas_asc, sort_idx_asc] = sort(p11_term_areas, 'ascend');
total_area_p11 = sum(p11_term_areas);
legend_labels_asc = cell(1, size(p11_contributions, 2));
for i = 1:size(p11_contributions, 2)
    percentage = (sorted_areas_asc(i) / total_area_p11) * 100;
    term_name = strrep(p11_contrib_vars{sort_idx_asc(i)}, 'P11_', '');
    legend_labels_asc{i} = sprintf('%s (%.1f%%)', term_name, percentage);
end
legend_handles = flip(h_area1);
% --- FIX: Removed the invalid 'FaceAlpha' property ---
legend(ax1, legend_handles, legend_labels_asc, 'Interpreter', 'none', 'FontSize', 12, 'Location', 'northwest', 'Box', 'on', 'EdgeColor', 'k');

% --- Final Formatting ---
title('Uniaxial Stress ($P_{11}$) Contributions', 'Interpreter', 'latex');
xlabel('Stretch ($\lambda_1$)', 'Interpreter', 'latex');
ylabel('First P-K stress ($P_{11}$)', 'Interpreter', 'latex');
set(ax1, 'FontSize', 16, 'FontName', 'Times New Roman', 'LineWidth', 1.5);
xlim([1, 1.2]); ylim([0, 1.4]);
hold(ax1, 'off');

% =========================================================================
% FIGURE 2: BIAXIAL (P22) CONTRIBUTIONS
% =========================================================================
figure('Color', 'w', 'Position', [950, 100, 800, 600]);
ax2 = gca;
hold(ax2, 'on');
box(ax2, 'on');
set(ax2, 'ColorOrder', custom_colormap);

% --- Sort Contributions for Plotting Order ---
p22_term_areas = trapz(lambda2, abs(p22_contributions));
[~, sort_idx_desc] = sort(p22_term_areas, 'descend');
p22_contributions_sorted = p22_contributions(:, sort_idx_desc);

% --- Plotting ---
h_area2 = area(ax2, lambda2, p22_contributions_sorted, 'EdgeColor', 'k', 'LineWidth', 0.2);
plot(ax2, P22_exp_data(:,1), P22_exp_data(:,2), 'o', 'Color', 'k', 'MarkerFaceColor', 'w', 'MarkerSize', 8, 'LineWidth', 1.5, 'DisplayName', 'Experimental Data');

% --- Create Legend with Sorted Percentages (Ascending) ---
[sorted_areas_asc, sort_idx_asc] = sort(p22_term_areas, 'ascend');
total_area_p22 = sum(p22_term_areas);
legend_labels_asc = cell(1, size(p22_contributions, 2));
for i = 1:size(p22_contributions, 2)
    percentage = (sorted_areas_asc(i) / total_area_p22) * 100;
    term_name = strrep(p22_contrib_vars{sort_idx_asc(i)}, 'P22_', '');
    legend_labels_asc{i} = sprintf('%s (%.1f%%)', term_name, percentage);
end
legend_handles = flip(h_area2);
% --- FIX: Removed the invalid 'FaceAlpha' property ---
legend(ax2, legend_handles, legend_labels_asc, 'Interpreter', 'none', 'FontSize', 12, 'Location', 'northwest', 'Box', 'on', 'EdgeColor', 'k');

% --- Final Formatting ---
title('Biaxial Stress ($P_{22}$) Contributions', 'Interpreter', 'latex');
xlabel('Stretch ($\lambda_2$)', 'Interpreter', 'latex');
ylabel('First P-K stress ($P_{22}$)', 'Interpreter', 'latex');
set(ax2, 'FontSize', 16, 'FontName', 'Times New Roman', 'LineWidth', 1.5);
xlim([1, 1.2]); ylim([0, 0.2]); 
hold(ax2, 'off');