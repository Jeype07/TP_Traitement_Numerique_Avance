close all
clear all

Data = load('playback_44100.mat');
pcm_441000_signal = Data.w441;

FS = 44100;                                 % Fréquence d'échantillonage
N = length(pcm_441000_signal);              % Nombre de points
fft_signal = fft(pcm_441000_signal);        % Transformée de Fourier
f = (0:N-1)*(FS/N);                         % Axe des fréquences (en Hz)
t = (0:N-1)/FS;                             % Axe temporel (en s)

% Amplitude et phase
amplitude = abs(fft_signal);        % Amplitude spectrale
phase = angle(fft_signal);          % Phase spectrale

% Représentation des échantillons
figure(1);
subplot(4,1,1);
plot(pcm_441000_signal);
title("Représentation des échantillons du signal pcm 44100 kHz");
xlabel("Échantillons");
ylabel("Amplitude");

subplot(4,1,2);
plot(pcm_441000_signal);
xlim([260000 2800000]);
title("Zoom sur les échantillons");
xlabel("Échantillons");
ylabel("Amplitude");

% Représentation temporelles des échantillons
subplot(4,1,3);
plot(t, pcm_441000_signal);
title("Représentation temporelle du signal pcm 44100 kHz");
xlabel("Temps (s)");
ylabel("Amplitude");

subplot(4,1,4);
plot(t, pcm_441000_signal);
xlim([60 65]);
title("Zoom sur le signal");
xlabel("Temps (s)");
ylabel("Amplitude");

%% Sur échntillonage à M = 160
% On sélectionne une portion du signal sur lequel on va travailler 
pcm_441000_signal_cut = pcm_441000_signal(2600000:2800000-1);
t_cut = t(2600000:2800000-1);

%upsampled_signal = upsample(pcm_441000_signal,160);
%N_up = N*160;
% t_up = (0:N_up-1)/FS;                             % Axe temporel (en s)
% 
% % Représentation des échantillons
% figure(2);
% subplot(4,1,1);
% plot(upsampled_signal);
% title("Représentation des échantillons du signal pcm 44100 kHz");
% xlabel("Échantillons");
% ylabel("Amplitude");
% 
% subplot(4,1,2);
% plot(upsampled_signal);
% xlim([0 500]);
% title("Zoom sur les 500 premiers échantillons");
% xlabel("Échantillons");
% ylabel("Amplitude");
% 
% % Représentation temporelles des échantillons
% subplot(4,1,3);
% plot(t_up, upsampled_signal);
% title("Représentation temporelle du signal pcm 44100 kHz");
% xlabel("Temps (s)");
% ylabel("Amplitude");
% 
% subplot(4,1,4);
% plot(t_up, upsampled_signal);
% xlim([0 5]);
% title("Zoom sur la 1ere première seconde du signal");
% xlabel("Temps (s)");
% ylabel("Amplitude");