clear;
close all;
N=2;
start_time=clock;
num_of_iteration=100000;
% %QPSK---------------------------------------------
% QPSK_0=load('./data/4psk_-30dBm.csv');
% [QPSK_0_complex,QPSK_0_real]=manage_data(QPSK_0,N);
% QPSK_1=load('./data/4psk_-30dBm-1.csv');
% [QPSK_1_complex,QPSK_1_real]=manage_data(QPSK_1,N);
% QPSK_2=load('./data/4psk_-30dBm-2.csv');
% [QPSK_2_complex,QPSK_2_real]=manage_data(QPSK_2,N);
% %8PSK---------------------------------------------
% PSK_8_0=load('./data/8psk_-25dBm.csv');
% [PSK_8_0_complex,PSK_8_0_real]=manage_data(PSK_8_0,N);
% PSK_8_2=load('./data/8psk_-25dBm-1.csv');% Fail
% [PSK_8_1_complex,PSK_8_1_real]=manage_data(PSK_8_2,N);
% PSK_8_2=load('./data/8psk_-25dBm-2.csv');% Fail
% [PSK_8_2_complex,PSK_8_2_real]=manage_data(PSK_8_2,N);
% PSK_8_3=load('./data/8psk_-30dBm.csv');%Fail
% [PSK_8_3_complex,PSK_8_3_real]=manage_data(PSK_8_3,N);
% PSK_8_4=load('./data/8psk_-30dBm-1.csv');
% [PSK_8_4_complex,PSK_8_4_real]=manage_data(PSK_8_4,N);
% PSK_8_5=load('./data/8psk_-30dBm-2.csv');
% [PSK_8_5_complex,PSK_8_5_real]=manage_data(PSK_8_5,N);
% %16PSK------------------------------------------------
% PSK_16_1=load('./data/16psk_-20dBm_1.csv');
% [PSK_16_1_complex,PSK_16_1_real]=manage_data(PSK_16_1,N);
% PSK_16_2=load('./data/16psk_-21dBm_1.csv');
% [PSK_16_2_complex,PSK_16_2_real]=manage_data(PSK_16_2,N);
% PSK_16_3=load('./data/16psk_-21dBm_2.csv');%Fail
% [PSK_16_3_complex,PSK_16_3_real]=manage_data(PSK_16_3,N);
% PSK_16_4=load('./data/16psk_-22dBm_1.csv');%Fail
% [PSK_16_4_complex,PSK_16_4_real]=manage_data(PSK_16_4,N);
% PSK_16_5=load('./data/16psk_-22dBm_2.csv');%Fail
% [PSK_16_5_complex,PSK_16_5_real]=manage_data(PSK_16_5,N);
% PSK_16_6=load('./data/16psk_-23dBm_1.csv');%Fail
% [PSK_16_6_complex,PSK_16_6_real]=manage_data(PSK_16_6,N);
% PSK_16_7=load('./data/16psk_-25dBm.csv');%Fail
% [PSK_16_7_complex,PSK_16_7_real]=manage_data(PSK_16_7,N);
% PSK_16_8=load('./data/16psk_-25dBm-1.csv');%Fail
% [PSK_16_8_complex,PSK_16_8_real]=manage_data(PSK_16_8,N);
% PSK_16_9=load('./data/16psk_-25dBm-2.csv');%Fail
% [PSK_16_9_complex,PSK_16_9_real]=manage_data(PSK_16_9,N);
% PSK_16_10=load('./data/16psk_-28dBm.csv');%Fail
% [PSK_16_10_complex,PSK_16_10_real]=manage_data(PSK_16_10,N);
% PSK_16_11=load('./data/16psk_-28dBm-1.csv');%Fail
% [PSK_16_11_complex,PSK_16_11_real]=manage_data(PSK_16_11,N);
% PSK_16_12=load('./data/16psk_-28dBm-2.csv');%Fail
% [PSK_16_12_complex,PSK_16_12_real]=manage_data(PSK_16_12,N);
% PSK_16_13=load('./data/16psk_-30dBm.csv');%Fail
% [PSK_16_13_complex,PSK_16_13_real]=manage_data(PSK_16_13,N);
% PSK_16_14=load('./data/16psk_-30dBm-1.csv');%Fail
% [PSK_16_14_complex,PSK_16_14_real]=manage_data(PSK_16_14,N);
% PSK_16_15=load('./data/16psk_-30dBm-2.csv');%Fail
% [PSK_16_15_complex,PSK_16_15_real]=manage_data(PSK_16_15,N);
% %------------------------------------------------
% QAM_16_1=load('./data/16qam_-22dBm.csv');% Fail
% [QAM_16_1_complex,QAM16_1_real]=manage_data(QAM_16_1,N);
% QAM_16_2=load('./data/16qam_-22dBm-1.csv');%Fail
% [QAM_16_2_complex,QAM_16_2_real]=manage_data(QAM_16_2,N);
% QAM_16_3=load('./data/16qam_-22dBm-2.csv');%Fail
% [QAM_16_3_complex,QAM_16_3_real]=manage_data(QAM_16_3,N);
% QAM_16_4=load('./data/16qam_-25dBm.csv');%Fail
% [QAM_16_4_complex,QAM_16_4_real]=manage_data(QAM_16_4,N);
QAM_16_5=load('./data/16qam_-25dBm-1.csv');%Fail
[QAM_16_5_complex,QAM_16_5_real]=manage_data(QAM_16_5,N);
% QAM_16_6=load('./data/16qam_-25dBm-2.csv');%Fail
% [QAM_16_6_complex,QAM_16_6_real]=manage_data(QAM_16_6,N);
% QAM_16_7=load('./data/16qam_-25dBm.csv');%Fail
% [QAM_16_7_complex,QAM_16_7_real]=manage_data(QAM_16_7,N);
% QAM_16_8=load('./data/16qam_-30dBm.csv');%Fail
% [QAM_16_8_complex,QAM_16_8_real]=manage_data(QAM_16_8,N);
% QAM_16_9=load('./data/16qam_-30dBm-1.csv');%Fail
% [QAM_16_9_complex,QAM_16_9_real]=manage_data(QAM_16_9,N);
QAM_16_10=load('./data/16qam_-30dBm-2.csv');
[QAM_16_10_complex,QAM_16_10_real]=manage_data(QAM_16_10,N);
%----------------------------------------------------------------
% PSK_32_1=load('./data/32psk_-25dBm.csv');
% [PSK_32_1_complex,PSK_32_1_real]=manage_data(PSK_32_1,N);
%----------------------------------------------------------------
% QAM_32_1=load('./data/32qam_-22dBm.csv');%Fail
% [QAM_32_1_complex,QAM_32_1_real]=manage_data(QAM_32_1,N);
% QAM_32_2=load('./data/32qam_-22dBm-1.csv');%Fail
% [QAM_32_2_complex,QAM_32_2_real]=manage_data(QAM_32_2,N);
%----------------------------------------------------------------
% QAM_64_1=load('./data/64qam_-19dBm_1.csv');%Fail
% [QAM_64_1_complex,QAM_64_1_real]=manage_data(QAM_64_1,N);
%----------------------------------------------------------------
% QAM_128_1=load('./data/128qam_-19dBm_1.csv');%Fail
% [QAM_128_1_complex,QAM_128_1_real]=manage_data(QAM_128_1,N);
% QAM_128_2=load('./data/128qam_-30dBm-1.csv');%Fail
% [QAM_128_2_complex,QAM_128_2_real]=manage_data(QAM_128_2,N);
% QAM_128_3=load('./data/128qam_-22dBm-1.csv');%Fail
% [QAM_128_3_complex,QAM_128_3_real]=manage_data(QAM_128_3,N);
% QAM_128_4=load('./data/128qam_-22dBm-2.csv');%Fail
% [QAM_128_4_complex,QAM_128_4_real]=manage_data(QAM_128_4,N);
% QAM_128_5=load('./data/128qam_-22dBm.csv');
% [QAM_128_5_complex,QAM_128_5_real]=manage_data(QAM_128_5,N);
% QAM_128_6=load('./data/128qam_-19dBm_2.csv');%Fail
% [QAM_128_6_complex,QAM_128_6_real]=manage_data(QAM_128_6,N);
% QAM_128_7=load('./data/128qam_-30dBm-2.csv');
% [QAM_128_7_complex,QAM_128_7_real]=manage_data(QAM_128_7,N);
% QAM_128_8=load('./data/128qam_-30dBm.csv');
% [QAM_128_8_complex,QAM_128_8_real]=manage_data(QAM_128_8,N);
%----------------------------------------------------------------
% QAM_256_1=load('./data/256qam_-20dBm_1.csv');
% [QAM_256_1_complex,QAM_256_1_real]=manage_data(QAM_256_1,N);
%====================================================================
signal=transpose(QAM_16_5_complex);
%====================================================================
signal=signal/max(max(abs(signal)));
% figure(1);
% scatter(real(signal),imag(signal),'.');
% axis equal;
% grid on;
[signal_recover,frequency_offset]=fo_recover(signal,num_of_iteration);
% figure(2);
% scatter(real(signal_recover),imag(signal_recover),'.');
% axis equal;
% grid on;
stop_time=clock;
run_time=etime(stop_time,start_time);
disp(['It takes ',num2str(run_time),'s.']);
load chirp
sound(y,Fs)
% output=my_spectral_cluster(signal_recover,17);
% [IDX,center_k_means]=kmeans([real(signal_recover),imag(signal_recover)],17);
% center_k_means=draw_cluster(signal_recover,IDX,17);