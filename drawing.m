%% Rita Fönster
clf
clear
% Signal
N = 1000;
x = linspace(0,1,N);
y = sin(6*pi*x);

% Inställningar Fönster
w_plot = {'r--','LineWidth',1}; 
title_prop = {'FontSize',15};
label_prop = {'interpreter','latex','FontSize',11};


% Rektangulärt fönster
w_rekt = ones(1,N);
subplot(1,3,1)
plot(x,y);
hold on
plot(x,w_rekt,w_plot{:});
hold off
title("Rektangulärt fönster",title_prop{:})
xlabel("Tid, [s]",label_prop{:})
ylabel("Amplitud, [V]", label_prop{:})
% Hanning Fönster
w_hann = hann(N)';
y_hann = w_hann.*y;
subplot(1,3,2)
plot(x,y_hann);
hold on
plot(x,w_hann,w_plot{:});
hold off
title("Hanning fönster",title_prop{:})
xlabel("Tid, [s]",label_prop{:})
ylabel("Amplitud, [V]", label_prop{:})

% Gaussian Fönster
w_gauss = gausswin(N)';
y_gauss = w_gauss.*y;
subplot(1,3,3)
plot(x,y_gauss);
hold on
plot(x,w_gauss,w_plot{:});
title("Gaussiskt fönster",title_prop{:})
xlabel("Tid, [s]",label_prop{:})
ylabel("Amplitud, [V]", label_prop{:})

% Spara
fprintf("Flytta fönster så det ser bra ut, sen tryck space.\n");
pause
exportgraphics(gcf,'window_plots.pdf','ContentType','vector');
