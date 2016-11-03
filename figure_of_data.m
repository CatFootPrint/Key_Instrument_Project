clear;
close all;
N=1000;
QPSK1=load('./data/4psk_-30dBm.csv');
[signal_recover,QPSK1_real]=manage_data(QPSK1,N);
QPSK2=load('./data/4psk_-30dBm-2.csv');
[QPSK2_complex,QPSK2_real]=manage_data(QPSK2,N);
QPSK3=load('./data/4psk_-30dBm-2.csv');
[QPSK3_complex,QPSK3_real]=manage_data(QPSK3,N);
QAM32_1=load('./data/32qam_-25dBm-2.csv');
[QAM32_1_complex,QAM32_1_real]=manage_data(QAM32_1,N);
QAM64_2=load('./data/64qam_-30dBm-2.csv');
[QAM64_2_complex,QAM32_2_real]=manage_data(QAM64_2,N);
% QAM32_2_complex=QAM32_2_complex(1:400);
signal=QAM32_1_complex;
figure(1);
scatter(real(signal),imag(signal),'.');
axis equal;
grid on;
[signal_recover,frequency_offset]=fo_recover(signal(1:4000),5000);
figure(2);
scatter(real(signal_recover),imag(signal_recover),'.');
axis equal;
grid on;
load chirp
sound(y,Fs)
