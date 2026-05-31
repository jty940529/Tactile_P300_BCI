function plotP300(mean_data,std_data,channel)
figure
colors = [133/255 110/255 252/255; 155/255 204/255 48/255; 252/255 195/255 36/255];

basetime = 0.1;
samplingrate = 100;
n_timepoints = size(mean_data, 2);
t = 1:n_timepoints;
t = 1000*((t./samplingrate) - basetime - 1/samplingrate);

for cond = 1:size(mean_data,3)
    current_mean = squeeze(mean_data(channel,:,cond));

    plot(t, current_mean, 'Color', colors(cond,:), 'LineWidth', 2.5);
    hold on;

    patch([t, fliplr(t)], ...
        [current_mean + squeeze(std_data(channel,:,cond)), ...
        fliplr(current_mean - squeeze(std_data(channel,:,cond)))], ...
        colors(cond,:), 'FaceAlpha', 0.25, 'EdgeColor', 'none');
    [max_amp, max_idx] = max(current_mean);
    max_time = t(max_idx);

    line([max_time, max_time], [-6, max_amp], ...
        'Color', colors(cond,:), 'LineStyle', '--', 'LineWidth', 1.5);

    line([0, max_time], [max_amp, max_amp], ...
        'Color', colors(cond,:), 'LineStyle', '--', 'LineWidth', 1.5);

    plot(max_time, max_amp, 'o', ...
        'MarkerSize', 8, 'MarkerFaceColor', colors(cond,:), ...
        'MarkerEdgeColor', 'white', 'LineWidth', 1.5);
end

set(gca, 'ylim', [-6 6]);
set(gca, 'xlim', [0, 600]);
xlabel('Time (ms)');
ylabel('Amplitude (\muV)');
set(gca, 'FontName', 'Arial', 'FontSize', 15);
set(gcf, 'Renderer', 'painters');
grid on;
hold off;
end