%% Rita Fönster
clf
clear
% Signal
N = 101;
n = 1024;
tid = 0.1;
x1 = linspace(0,tid,N);
y2 = sin(350*pi*x1);

% Fourier Inställningar
f = 1:1:n/2;

% Inställningar Fönster
l_plot = {'b-','LineWidth',4};
w_plot = {'r--','LineWidth',4}; 
title_prop = {'FontSize',30};
label_prop = {'FontSize',30};
plot_pos = 100:270 ;

% Rektangulärt fönster 
w_rekt = ones(1,N);
y3 = y2;

Y = abs(fft(y3,1024,2))/n;
Y = Y(1:n/2)./max(Y(1:n/2));
Y = 20*log10(Y);
Y(Y <= -80) = -80;


clf
plot(f(plot_pos),Y(plot_pos),l_plot{:});
xlabel("Frekvens [Hz]",label_prop{:})
ylabel("Relativ amplitud [dB]", label_prop{:})
set(gca,...
    'XTick', [],...
    'YTick', [],...
    'Box', false);
pause



exportgraphics(gcf,'window_plots1_frekv.pdf','ContentType','vector');

clf
plot(x1,y2,l_plot{:});
hold on
plot(x1,w_rekt,w_plot{:});
hold off
title("Rektangulärt-fönster",title_prop{:})
xlabel("Tid [s]",label_prop{:})
ylabel("Amplitud [V]", label_prop{:})
set(gca,...
    'XTick', [],...
    'YTick', [],...
    'Box', false);

exportgraphics(gcf,'window_plots1.pdf','ContentType','vector');

% Hanning Fönster
w_hann = hann(N)';
y3 = y2.*w_hann;
Y = abs(fft(y3,n,2))/n;
Y = Y(1:n/2)./max(Y(1:n/2));
Y = 20*log10(Y);
Y(Y <= -80) = -80;
clf
plot(f(plot_pos),Y(plot_pos),l_plot{:});
xlabel("Frekvens [Hz]",label_prop{:})
ylabel("Relativ amplitud [dB]", label_prop{:})
set(gca,...
    'XTick', [],...
    'YTick', [],...
    'Box', false);

pause
exportgraphics(gcf,'window_plots2_frekv.pdf','ContentType','vector');

y_hann = w_hann.*y2;
clf
plot(x1,y_hann,l_plot{:});
hold on
plot(x1,w_hann,w_plot{:});
hold off
title("Hanning-fönster",title_prop{:})
xlabel("Tid [s]",label_prop{:})
ylabel("Amplitud [V]", label_prop{:})
set(gca,...
    'XTick', [],...
    'YTick', [],...
    'Box', false);

exportgraphics(gcf,'window_plots2.pdf','ContentType','vector');

% Gaussian Fönster
w_gauss = gausswin(N)';
Y = abs(fft(y2.*w_gauss,n,2))/n;
Y = Y(1:n/2)./max(Y(1:n/2));
Y = 20*log10(Y);
Y(Y <= -80) = -80;
clf
plot(f(plot_pos),Y(plot_pos),l_plot{:});
xlabel("Frekvens [Hz]",label_prop{:})
ylabel("Relativ amplitud [dB]", label_prop{:})
set(gca,...
    'XTick', [],...
    'YTick', [],...
    'Box', false);

pause
exportgraphics(gcf,'window_plots3_frekv.pdf','ContentType','vector');


y_gauss = w_gauss.*y2;
clf
plot(x1,y_gauss,l_plot{:});
hold on
plot(x1,w_gauss,w_plot{:});
title("Gaussianskt-fönster",title_prop{:})
xlabel("Tid [s]",label_prop{:})
ylabel("Amplitud [V]", label_prop{:})
set(gca,...
    'XTick', [],...
    'YTick', [],...
    'Box', false);

exportgraphics(gcf,'window_plots3.pdf','ContentType','vector');

%% Diskret Sampling
x1 = linspace(0,1,500);
y2 = sin(14*pi*x1/5);
x_new = linspace(0,2,1000);
y_new = [y2,y2];
y_proper = sin(14*pi*x_new/5);
plot(x_new,y_new,'b','LineWidth',1);
hold on
plot(x_new(500:end),y_proper(500:end),'b--');
plot([1,1],[-1,1],'k-','LineWidth',1);
hold off
title('Kapning av signal', 'FontSize', 15);
label_settings = {'FontSize',15,'interpreter','latex'};
xlabel("Tid, [s]",label_settings{:})
ylabel("Amplitud, [V]", label_settings{:});
legend({'Samplad Signal','Verklig Signal','Inspelningslängd'});
exportgraphics(gcf,'kapad_signal.pdf','ContentType','vector');

%% Distortion pga klippning
frekv = 53; % Hz
ampl_signal =4; %Volt
maxampl = 1; % Volt
max_t = 0.1;
N = 1000;
t = linspace(0,max_t,N);
v = ampl_signal.*sin(2*pi*frekv*t);
v_klippt = v;
v_klippt(v_klippt >= maxampl) = maxampl;
v_klippt(v_klippt <= -maxampl) = -maxampl;

clf
subplot(1,2,1)
plot(t,v,'r--')
hold on
plot(t,v_klippt,'b-')
plot([t',t'],maxampl*[ones(1000,1),-ones(1000,1)],'k:','LineWidth',1)
hold off
axis([0 2/frekv -ampl_signal ampl_signal])

% Annan upplösning på sample rate
max_t_ft = 1;
t = linspace(0,max_t_ft,N);
v = ampl_signal.*sin(2*pi*frekv*t);
v_klippt = v;
v_klippt(v_klippt >= maxampl) = maxampl;
v_klippt(v_klippt <= -maxampl) = -maxampl;


Y = fft(v_klippt,N)/N;
Y_plot = abs(Y(2:N/2+1));
sampl_rate = N/max_t_ft;
f = linspace(1,sampl_rate/2 + sampl_rate/N,N/2);

subplot(1,2,2)
plot(f,Y_plot)
axis([0 400 -.25 1.5])

%% Aliasing
clf
fs = 5;
fi1 = 4;
fa1 = 1;

x1 = linspace(0,1,1000);
x2 = linspace(0,1,1*fs+1);

y1 = sin(2*pi*fi1*x1);
y2 = -sin(2*pi*fa1*x1);
y3_temp = sin(2*pi*fi1*x2);

p = plot(x1,y1,'b',...
    x1,y2,'r--',...
    x2,y3_temp,'ko');

p(1).LineWidth = 1;
p(2).LineWidth = 1;
p(3).LineWidth = 1;

title("Vikning av signal",'FontSize',13)
ylabel("Amplitud [V]",'FontSize',13);
xlabel("Tid [s]",'FontSize',13);
legend({'Ursprunglig Signal','Upplevd Signal','Mätpunkter'},...
    'Location','northwest','FontSize',13)
set(gca,...
    'YTick',[],...
    'XTick',[],...
    'Box',false);

exportgraphics(gcf,'vikning_demo.pdf','ContentType','vector')

%% Aliasing 2
clf
fs = 5;
fi1 = 4;
fi2 = 2;
fa1 = 1;

x1 = linspace(0,1,1000);
x2 = linspace(0,1,1*fs+1);

y1 = sin(2*pi*fi1*x1) + sin(2*pi*fi2*x1);
y2 = -sin(2*pi*fa1*x1) + sin(2*pi*fi2*x1);
y3_temp = sin(2*pi*fi1*x2) + sin(2*pi*fi2*x2);

p = plot(x1,y1,'b',...
    x1,y2,'r--',...
    x2,y3_temp,'ko');

p(1).LineWidth = 1;
p(2).LineWidth = 1;
p(3).LineWidth = 1;

title("Vikning av signal")
ylabel("Amplitud, [V]");
xlabel("Tid, [s]");
legend({'Ursprunglig Signal','Upplevd Signal','Mätpunkter'},...
    'Location','northwest')
set(gca,...
    'YTick',[],...
    'XTick',[],...
    'Box',false);

exportgraphics(gcf,'vikning_demo2.pdf','ContentType','vector')

%% TEST

Fs = 1000;                    % Sampling frequency
T = 1/Fs;                     % Sampling period
L = 1000;                     % Length of signal
t = T*(0:1:L-1);                % Time vector

t = 0:1/1e3:0.10;
x = sin(2*pi*50*t);
h=figure;
% plot(t,x)
% xlabel('Tid [s]','FontSize', 15)
% ylabel('Amplitud [V]','FontSize', 15)
% title('Tidsdomän för 50 Hz sinussignal','FontSize', 15)
n = 1024;
x=fft(x,n,2);
x = x(1:512);
mx=2*abs(x)/100;
f=(0:1024/2-1)*Fs/1024;
plot(f,(mx))
xlabel('Frekvens [Hz]')
ylabel('Magnitud [V]')
title('Frekvensdomän för 50 Hz fyrkantssignal')
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

