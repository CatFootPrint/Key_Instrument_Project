clear;
close all;
N=2;
start_time=clock;
num_of_iteration=10000;
signal_name='QAM_128_14_complex';%The name of file you want to read.
% %QPSK---------------------------------------------
% QPSK_0=load('./data/4psk_-30dBm.csv');%Fail
% [QPSK_0_complex,QPSK_0_real]=manage_data(QPSK_0,N);
% QPSK_1=load('./data/4psk_-30dBm-1.csv');%OK
% [QPSK_1_complex,QPSK_1_real]=manage_data(QPSK_1,N);
% QPSK_2=load('./data/4psk_-30dBm-2.csv');%OK
% [QPSK_2_complex,QPSK_2_real]=manage_data(QPSK_2,N);
% %8PSK---------------------------------------------
% PSK_8_0=load('./data/8psk_-25dBm.csv');%OK
% [PSK_8_0_complex,PSK_8_0_real]=manage_data(PSK_8_0,N);
% PSK_8_1=load('./data/8psk_-25dBm-1.csv');% Fail
% [PSK_8_1_complex,PSK_8_1_real]=manage_data(PSK_8_1,N);
% PSK_8_2=load('./data/8psk_-25dBm-2.csv');% Fail
% [PSK_8_2_complex,PSK_8_2_real]=manage_data(PSK_8_2,N);
% PSK_8_3=load('./data/8psk_-30dBm.csv');%Fail
% [PSK_8_3_complex,PSK_8_3_real]=manage_data(PSK_8_3,N);
% PSK_8_4=load('./data/8psk_-30dBm-1.csv');%OK
% [PSK_8_4_complex,PSK_8_4_real]=manage_data(PSK_8_4,N);
% PSK_8_5=load('./data/8psk_-30dBm-2.csv');%OK
% [PSK_8_5_complex,PSK_8_5_real]=manage_data(PSK_8_5,N);
% PSK_8_6=load('./data/8psk_-25dBm_1.csv');%Fail
% [PSK_8_6_complex,PSK_8_6_real]=manage_data(PSK_8_6,N);
% PSK_8_7=load('./data/8psk_-25dBm_2.csv');%OK
% [PSK_8_7_complex,PSK_8_7_real]=manage_data(PSK_8_7,N);
% PSK_8_8=load('./data/8psk_-25dBm_3.csv');%OK
% [PSK_8_8_complex,PSK_8_8_real]=manage_data(PSK_8_8,N);
% PSK_8_9=load('./data/8psk_-25dBm_4.csv');%OK
% [PSK_8_9_complex,PSK_8_9_real]=manage_data(PSK_8_9,N);
% PSK_8_10=load('./data/8psk_-25dBm_5.csv');%OK
% [PSK_8_10_complex,PSK_8_10_real]=manage_data(PSK_8_10,N);
% PSK_8_11=load('./data/8psk_-25dBm_6.csv');%OK
% [PSK_8_11_complex,PSK_8_11_real]=manage_data(PSK_8_11,N);
% PSK_8_12=load('./data/8psk_-25dBm_7.csv');%fAIL
% [PSK_8_12_complex,PSK_8_12_real]=manage_data(PSK_8_12,N);
% PSK_8_13=load('./data/8psk_-25dBm_8.csv');%OK
% [PSK_8_13_complex,PSK_8_13_real]=manage_data(PSK_8_13,N);
% %16PSK------------------------------------------------
% PSK_16_1=load('./data/16psk_-20dBm_1.csv');%OK
% [PSK_16_1_complex,PSK_16_1_real]=manage_data(PSK_16_1,N);
% PSK_16_2=load('./data/16psk_-21dBm_1.csv');%OK
% [PSK_16_2_complex,PSK_16_2_real]=manage_data(PSK_16_2,N);
% PSK_16_3=load('./data/16psk_-21dBm_2.csv');%Fail
% [PSK_16_3_complex,PSK_16_3_real]=manage_data(PSK_16_3,N);
% PSK_16_4=load('./data/16psk_-22dBm_1.csv');%Fail
% [PSK_16_4_complex,PSK_16_4_real]=manage_data(PSK_16_4,N);
% PSK_16_5=load('./data/16psk_-22dBm_2.csv');%Fail
% [PSK_16_5_complex,PSK_16_5_real]=manage_data(PSK_16_5,N);
% PSK_16_6=load('./data/16psk_-23dBm_1.csv');%OK
% [PSK_16_6_complex,PSK_16_6_real]=manage_data(PSK_16_6,N);
% PSK_16_7=load('./data/16psk_-25dBm.csv');%OK
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
% PSK_16_14=load('./data/16psk_-30dBm-1.csv');%OK
% [PSK_16_14_complex,PSK_16_14_real]=manage_data(PSK_16_14,N);
% PSK_16_15=load('./data/16psk_-30dBm-2.csv');%Fail
% [PSK_16_15_complex,PSK_16_15_real]=manage_data(PSK_16_15,N);
% PSK_16_16=load('./data/16psk_-25dBm_3.csv');%Fail
% [PSK_16_16_complex,PSK_16_16_real]=manage_data(PSK_16_16,N);
% PSK_16_17=load('./data/16psk_-25dBm_4.csv');%Fail
% [PSK_16_17_complex,PSK_16_17_real]=manage_data(PSK_16_17,N);
% PSK_16_18=load('./data/16psk_-25dBm_5.csv');%Fail
% [PSK_16_18_complex,PSK_16_18_real]=manage_data(PSK_16_18,N);
% PSK_16_19=load('./data/16psk_-25dBm_6.csv');%OK
% [PSK_16_19_complex,PSK_16_19_real]=manage_data(PSK_16_19,N);
% PSK_16_20=load('./data/16psk_-25dBm_7.csv');%Fail
% [PSK_16_20_complex,PSK_16_20_real]=manage_data(PSK_16_20,N);
% PSK_16_21=load('./data/16psk_-25dBm_8.csv');%OK
% [PSK_16_21_complex,PSK_16_21_real]=manage_data(PSK_16_21,N);
% PSK_16_22=load('./data/16psk_-25dBm_9.csv');%OK
% [PSK_16_22_complex,PSK_16_22_real]=manage_data(PSK_16_22,N);
% %16QAM------------------------------------------------
% QAM_16_1=load('./data/16qam_-22dBm.csv');% Fail
% [QAM_16_1_complex,QAM16_1_real]=manage_data(QAM_16_1,N);
QAM_16_2=load('./data/16qam_-22dBm-1.csv');%OK
[QAM_16_2_complex,QAM_16_2_real]=manage_data(QAM_16_2,N);
% QAM_16_3=load('./data/16qam_-22dBm-2.csv');%Fail
% [QAM_16_3_complex,QAM_16_3_real]=manage_data(QAM_16_3,N);
% QAM_16_4=load('./data/16qam_-25dBm.csv');%Fail
% [QAM_16_4_complex,QAM_16_4_real]=manage_data(QAM_16_4,N);
% QAM_16_5=load('./data/16qam_-25dBm-1.csv');%Fail
% [QAM_16_5_complex,QAM_16_5_real]=manage_data(QAM_16_5,N);
% QAM_16_6=load('./data/16qam_-25dBm-2.csv');%Fail
% [QAM_16_6_complex,QAM_16_6_real]=manage_data(QAM_16_6,N);
% QAM_16_7=load('./data/16qam_-25dBm.csv');%Fail
% [QAM_16_7_complex,QAM_16_7_real]=manage_data(QAM_16_7,N);
% QAM_16_8=load('./data/16qam_-30dBm.csv');%Fail
% [QAM_16_8_complex,QAM_16_8_real]=manage_data(QAM_16_8,N);
% QAM_16_9=load('./data/16qam_-30dBm-1.csv');%Fail
% [QAM_16_9_complex,QAM_16_9_real]=manage_data(QAM_16_9,N);
% QAM_16_10=load('./data/16qam_-30dBm-2.csv');%OK
% [QAM_16_10_complex,QAM_16_10_real]=manage_data(QAM_16_10,N);
% QAM_16_11=load('./data/16qam_-25dBm_3.csv');%OK
% [QAM_16_11_complex,QAM_16_11_real]=manage_data(QAM_16_11,N);
% QAM_16_12=load('./data/16qam_-25dBm_4.csv');%Fail
% [QAM_16_12_complex,QAM_16_12_real]=manage_data(QAM_16_12,N);
% QAM_16_13=load('./data/16qam_-25dBm_5.csv');%Fail
% [QAM_16_13_complex,QAM_16_13_real]=manage_data(QAM_16_13,N);
% QAM_16_14=load('./data/16qam_-25dBm_6.csv');%Fail
% [QAM_16_14_complex,QAM_16_14_real]=manage_data(QAM_16_14,N);
% QAM_16_15=load('./data/16qam_-25dBm_7.csv');%OK
% [QAM_16_15_complex,QAM_16_15_real]=manage_data(QAM_16_15,N);
% QAM_16_16=load('./data/16qam_-25dBm_8.csv');%Fail
% [QAM_16_16_complex,QAM_16_16_real]=manage_data(QAM_16_16,N);
% QAM_16_17=load('./data/16qam_-25dBm_9.csv');%OK
% [QAM_16_17_complex,QAM_16_17_real]=manage_data(QAM_16_17,N);
% ----------------------------------------------------------------
% PSK_32_1=load('./data/32psk_-25dBm.csv');%Fail
% [PSK_32_1_complex,PSK_32_1_real]=manage_data(PSK_32_1,N);
%32QAM----------------------------------------------------------------
% QAM_32_1=load('./data/32qam_-22dBm.csv');%Fail
% [QAM_32_1_complex,QAM_32_1_real]=manage_data(QAM_32_1,N);
% QAM_32_2=load('./data/32qam_-22dBm-1.csv');%Fail
% [QAM_32_2_complex,QAM_32_2_real]=manage_data(QAM_32_2,N);
% QAM_32_3=load('./data/32qam_-25dBm_1.csv');%OK
% [QAM_32_3_complex,QAM_32_3_real]=manage_data(QAM_32_3,N);
% QAM_32_4=load('./data/32qam_-25dBm_2.csv');%Fail
% [QAM_32_4_complex,QAM_32_4_real]=manage_data(QAM_32_4,N);
% QAM_32_5=load('./data/32qam_-25dBm_3.csv');%Fail
% [QAM_32_5_complex,QAM_32_5_real]=manage_data(QAM_32_5,N);
% QAM_32_6=load('./data/32qam_-25dBm_4.csv');%Fail
% [QAM_32_6_complex,QAM_32_6_real]=manage_data(QAM_32_6,N);
% QAM_32_7=load('./data/32qam_-25dBm_5.csv');%Fail
% [QAM_32_7_complex,QAM_32_7_real]=manage_data(QAM_32_7,N);
% QAM_32_8=load('./data/32qam_-25dBm_6.csv');%Fail
% [QAM_32_8_complex,QAM_32_8_real]=manage_data(QAM_32_8,N);
% QAM_32_9=load('./data/32qam_-25dBm_7.csv');%Fail
% [QAM_32_9_complex,QAM_32_9_real]=manage_data(QAM_32_9,N);
% %----------------------------------------------------------------
% QAM_64_1=load('./data/64qam_-19dBm_1.csv');%Fail
% [QAM_64_1_complex,QAM_64_1_real]=manage_data(QAM_64_1,N);
% QAM_64_2=load('./data/64qam_-25dBm_1.csv');%Fail
% [QAM_64_2_complex,QAM_64_2_real]=manage_data(QAM_64_2,N);
% QAM_64_3=load('./data/64qam_-25dBm_2.csv');%Fail
% [QAM_64_3_complex,QAM_64_3_real]=manage_data(QAM_64_3,N);
% QAM_64_4=load('./data/64qam_-25dBm_3.csv');%Fail
% [QAM_64_4_complex,QAM_64_4_real]=manage_data(QAM_64_4,N);
% QAM_64_5=load('./data/64qam_-25dBm_4.csv');%Fail
% [QAM_64_5_complex,QAM_64_5_real]=manage_data(QAM_64_5,N);
% QAM_64_6=load('./data/64qam_-25dBm_5.csv');%Fail
% [QAM_64_6_complex,QAM_64_6_real]=manage_data(QAM_64_6,N);
% QAM_64_7=load('./data/64qam_-25dBm_6.csv');%Fail
% [QAM_64_7_complex,QAM_64_7_real]=manage_data(QAM_64_7,N);
% QAM_64_8=load('./data/64qam_-25dBm_7.csv');%FAIL
% [QAM_64_8_complex,QAM_64_8_real]=manage_data(QAM_64_8,N);
%----------------------------------------------------------------
% QAM_128_1=load('./data/128qam_-19dBm_1.csv');%Fail
% [QAM_128_1_complex,QAM_128_1_real]=manage_data(QAM_128_1,N);
% QAM_128_2=load('./data/128qam_-30dBm-1.csv');%Fail
% [QAM_128_2_complex,QAM_128_2_real]=manage_data(QAM_128_2,N);
% QAM_128_3=load('./data/128qam_-22dBm-1.csv');%Fail
% [QAM_128_3_complex,QAM_128_3_real]=manage_data(QAM_128_3,N);
% QAM_128_4=load('./data/128qam_-22dBm-2.csv');%Fail
% [QAM_128_4_complex,QAM_128_4_real]=manage_data(QAM_128_4,N);
% QAM_128_5=load('./data/128qam_-22dBm.csv');%Fail
% [QAM_128_5_complex,QAM_128_5_real]=manage_data(QAM_128_5,N);
% QAM_128_6=load('./data/128qam_-19dBm_2.csv');%Fail
% [QAM_128_6_complex,QAM_128_6_real]=manage_data(QAM_128_6,N);
% QAM_128_7=load('./data/128qam_-30dBm-2.csv');%OK
% [QAM_128_7_complex,QAM_128_7_real]=manage_data(QAM_128_7,N);
% QAM_128_8=load('./data/128qam_-30dBm.csv');%Fail
% [QAM_128_8_complex,QAM_128_8_real]=manage_data(QAM_128_8,N);
% QAM_128_9=load('./data/128qam_-25dBm_1.csv');%Fail
% [QAM_128_9_complex,QAM_128_9_real]=manage_data(QAM_128_9,N);
% QAM_128_10=load('./data/128qam_-25dBm_2.csv');%Fail
% [QAM_128_10_complex,QAM_128_10_real]=manage_data(QAM_128_10,N);
% QAM_128_11=load('./data/128qam_-25dBm_3.csv');%Fail
% [QAM_128_11_complex,QAM_128_11_real]=manage_data(QAM_128_11,N);
% QAM_128_12=load('./data/128qam_-25dBm_4.csv');%Fail
% [QAM_128_12_complex,QAM_128_12_real]=manage_data(QAM_128_12,N);
% QAM_128_13=load('./data/128qam_-25dBm_5.csv');%Fail
% [QAM_128_13_complex,QAM_128_13_real]=manage_data(QAM_128_13,N);
QAM_128_14=load('./data/128qam_-25dBm_6.csv');%OK
[QAM_128_14_complex,QAM_128_14_real]=manage_data(QAM_128_14,N);
% QAM_128_15=load('./data/128qam_-25dBm_7.csv');%Fail
% [QAM_128_15_complex,QAM_128_15_real]=manage_data(QAM_128_15,N);
%----------------------------------------------------------------
% QAM_256_1=load('./data/256qam_-20dBm_1.csv');%Fail
% [QAM_256_1_complex,QAM_256_1_real]=manage_data(QAM_256_1,N);
% QAM_256_2=load('./data/256qam_-25dBm_1.csv');%Fail
% [QAM_256_2_complex,QAM_256_2_real]=manage_data(QAM_256_2,N);
% QAM_256_3=load('./data/256qam_-25dBm_2.csv');%Fail
% [QAM_256_3_complex,QAM_256_3_real]=manage_data(QAM_256_3,N);
% QAM_256_4=load('./data/256qam_-25dBm_3.csv');%Fail
% [QAM_256_4_complex,QAM_256_4_real]=manage_data(QAM_256_4,N);
% QAM_256_5=load('./data/256qam_-25dBm_4.csv');%Fail
% [QAM_256_5_complex,QAM_256_5_real]=manage_data(QAM_256_5,N);
% QAM_256_6=load('./data/256qam_-22dBm_1.csv');%Fail
% [QAM_256_6_complex,QAM_256_6_real]=manage_data(QAM_256_6,N);
% QAM_256_7=load('./data/256qam_-22dBm_2.csv');%Fail
% [QAM_256_7_complex,QAM_256_7_real]=manage_data(QAM_256_7,N);
% QAM_256_8=load('./data/256qam_-23dBm_1.csv');%Fail
% [QAM_256_8_complex,QAM_256_8_real]=manage_data(QAM_256_8,N);
% QAM_256_9=load('./data/256qam_-23dBm_2.csv');%Fail
% [QAM_256_9_complex,QAM_256_9_real]=manage_data(QAM_256_9,N);
%====================================================================
%====================================================================
%====================================================================
eval(['signal=transpose(',signal_name,'(1:4000));']);%OK



% M=8;
% code=randi([0 M-1],1000,1);
% QAM_mod=comm.RectangularQAMModulator('ModulationOrder',M);
%         QAM_Demod=comm.RectangularQAMDemodulator('ModulationOrder',M);
%         QAM_mod.PhaseOffset = 0;
%         s_QAM=step(QAM_mod,code);
%         signal=s_QAM;
%         signal=signal.*transpose(exp(-1i*0.02*(0:size(signal,1)-1)));
%====================================================================
%====================================================================
%====================================================================
signal=signal/max(max(abs(signal)));
 figure(1);
 figure_ori=scatter(real(signal),imag(signal),'.');
 axis equal;
 grid on;
saveas(figure_ori,'signal','jpg');
[signal_recover,frequency_offset]=fo_recover_STING(signal,num_of_iteration);
figure(2);
figure_recover=scatter(real(signal_recover),imag(signal_recover),'.');
axis equal;
grid on;
saveas(figure_recover,'signal_recover','jpg');
stop_time=clock;
run_time=etime(stop_time,start_time);
disp(['It takes ',num2str(run_time),'s.']);
load chirp
sound(y,Fs)
disp('Finish the program.');
eval(['save ',signal_name,'.mat signal_recover']);
% output=my_spectral_cluster(signal_recover,17);
% [IDX,center_k_means]=kmeans([real(signal_recover),imag(signal_recover)],17);
% center_k_means=draw_cluster(signal_recover,IDX,17);