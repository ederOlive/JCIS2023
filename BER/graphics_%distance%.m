clear all;
close all;
clc;

hw_ber = csvread("hw_ber_%distance%.csv");
lrc_1b_ber = csvread("lrc_1b_ber_%distance%.csv");
lrc_2b_ber = csvread("lrc_2b_ber_%distance%.csv");
lrc_3b_ber = csvread("lrc_3b_ber_%distance%.csv");
lrc_4b_ber = csvread("lrc_4b_ber_%distance%.csv");
lrc_5b_ber = csvread("lrc_5b_ber_%distance%.csv");
lrc_6b_ber = csvread("lrc_6b_ber_%distance%.csv");
lrc_7b_ber = csvread("lrc_7b_ber_%distance%.csv");
lrc_8b_ber = csvread("lrc_8b_ber_%distance%.csv");

%%% SNR %%%
fid1 = fopen('~/Rx/Probe_Avg_Mag^2_%distance%.hex', 'r');
vector_sigpow = fread(fid1, Inf, 'float32');
fclose(fid1);
sigpow = sum(vector_sigpow)/length(vector_sigpow);
clear fid1 vector_sigpow;
num_noise_levels = 36; % in this example the noise level goes from 1 to 36 mV
snr = zeros(1, 36);
for i = 1:36
  snr(i) = 10*log10(sigpow/((i/1000)^2));
end
clear sigpow i;

%%% Graphics %%%
fig = figure(1);
hold on;
grid minor on;
title('Performance - X m distance')
xlabel('SNR [dB]')
ylabel('BER')
semilogy(snr, hw_ber, '-+', 'linewidth', 1.5, 'markersize', 8)
semilogy(snr, lrc_1b_ber, '-o', 'linewidth', 1.5, 'markersize', 8)
semilogy(snr, lrc_2b_ber, '-*', 'linewidth', 1.5, 'markersize', 8)
semilogy(snr, lrc_3b_ber, '-p', 'linewidth', 1.5, 'markersize', 8)
semilogy(snr, lrc_4b_ber, '-x', 'linewidth', 1.5, 'markersize', 8)
semilogy(snr, lrc_5b_ber, '-s', 'linewidth', 1.5, 'markersize', 8)
semilogy(snr, lrc_6b_ber, '-d', 'linewidth', 1.5, 'markersize', 8)
semilogy(snr, lrc_7b_ber, '-^', 'linewidth', 1.5, 'markersize', 8)
semilogy(snr, lrc_8b_ber, '-v', 'linewidth', 1.5, 'markersize', 8)
legend('Hardware', 'LRC 1b',  'LRC 2b',  'LRC 3b',  'LRC 4b',  'LRC 5b',  'LRC 6b',  'LRC 7b',  'LRC 8b', 'location', 'northeastoutside')
hold off;
