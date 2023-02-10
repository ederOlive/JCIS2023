close all, clear, clc; % wipes out workplace

fid1 = fopen("~/Tx/Random_Vector_Source_50B.hex", "r");
vector_tx = fread(fid1, Inf, "uchar"); % reads transmitted vector
fclose(fid1);
clear fid1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid2 = fopen("~/Rx/Random_Vector_Sink_50B_%distance%_8b_%noise_level_1%.hex", "r");
vector_rx_tooBig = fread(fid2, Inf, "uchar"); % reads received vector
vector_rx = vector_rx_tooBig(1:length(vector_tx)*floor(length(vector_rx_tooBig)/length(vector_tx)), 1);
fclose(fid2);
clear fid2 vector_rx_tooBig;

j =  length(vector_tx);
k = 1;
ber_vector = zeros(1, floor(length(vector_rx)/length(vector_tx)));
for i = 1:length(vector_tx):length(vector_rx)
  vector_rx_trimmed = vector_rx(i:j); % trims the received vector to the same size of the transmitted vector
  j = j + length(vector_tx);
  ber_vector(k) = bercalc(vector_tx, vector_rx_trimmed);
  k++;
endfor
clear vector_rx vector_rx_trimmed i j k;

ber_mean_noise_level_1 = sum(ber_vector)/length(ber_vector);
clear ber_vector;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid2 = fopen("~/Rx/Random_Vector_Sink_50B_%distance%_8b_%noise_level_2%.hex", "r");
vector_rx_tooBig = fread(fid2, Inf, "uchar"); % reads received vector
vector_rx = vector_rx_tooBig(1:length(vector_tx)*floor(length(vector_rx_tooBig)/length(vector_tx)), 1);
fclose(fid2);
clear fid2 vector_rx_tooBig;

j =  length(vector_tx);
k = 1;
ber_vector = zeros(1, floor(length(vector_rx)/length(vector_tx)));
for i = 1:length(vector_tx):length(vector_rx)
  vector_rx_trimmed = vector_rx(i:j); % trims the received vector to the same size of the transmitted vector
  j = j + length(vector_tx);
  ber_vector(k) = bercalc(vector_tx, vector_rx_trimmed);
  k++;
endfor
clear vector_rx vector_rx_trimmed i j k;

ber_mean_noise_level_2 = sum(ber_vector)/length(ber_vector);
clear ber_vector;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid2 = fopen("~/Rx/Random_Vector_Sink_50B_%distance%_8b_%noise_level_n%.hex", "r");
vector_rx_tooBig = fread(fid2, Inf, "uchar"); % reads received vector
vector_rx = vector_rx_tooBig(1:length(vector_tx)*floor(length(vector_rx_tooBig)/length(vector_tx)), 1);
fclose(fid2);
clear fid2 vector_rx_tooBig;

j =  length(vector_tx);
k = 1;
ber_vector = zeros(1, floor(length(vector_rx)/length(vector_tx)));
for i = 1:length(vector_tx):length(vector_rx)
  vector_rx_trimmed = vector_rx(i:j); % trims the received vector to the same size of the transmitted vector
  j = j + length(vector_tx);
  ber_vector(k) = bercalc(vector_tx, vector_rx_trimmed);
  k++;
endfor
clear vector_rx vector_rx_trimmed i j k;

ber_mean_noise_level_n = sum(ber_vector)/length(ber_vector);
clear ber_vector;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lrc_8b_ber = [ber_mean_noise_level_1, ber_mean_noise_level_2, ..., ber_mean_noise_level_n];
csvwrite("lrc_8b_ber_%distance%.csv", lrc_8b_ber);
