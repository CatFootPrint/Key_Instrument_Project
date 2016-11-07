clear;
close all;
%Initialization
threshold_of_coeff=0.75;
L=3;
lambda1=2;
lambda2=0.01;
SNR=5;
iteration_times=100;
parameter.num_of_code=192;
parameter.frequency_offset=1e-4;
parameter.phase_offset=0;
parameter.SNR=SNR;
signal_type=[2,2,2,3,3,3,6,6,6;8,16,32,8,16,64,4,8,16];%1.ASK;2.PSK;3.QAM;4.FSK;5.MSK;6.PAM.
% signal_type=[2,3;8,8];%1.ASK;2.PSK;3.QAM;4.FSK;5.MSK;6.PAM.
M=size(signal_type,2);
M=5;
parameter.signal_type=repmat(signal_type,1,parameter.num_of_code);
number_of_dictionary=size(parameter.signal_type,2);
%Read files==================================================================
center1=load('./STING_result/center_16PSK.mat');
center1=center1.center*[1;1i];
temp=center1;
temp=temp-mean(temp);
center1=temp*exp(-1i*min(real(temp)));
cluster1=load('./STING_result/cluster_16PSK.mat');
% cluster1=cluster1.L;
% cluster1=reshape(cluster1,numel(cluster1),1);
%--------------------------------------------------
center2=load('./STING_result/center_16QAM.mat');
center2=center2.center*[1;1i];
temp=center2;
temp=temp-mean(temp);
center2=temp*exp(-1i*min(real(temp)));
cluster2=load('./STING_result/cluster_16QAM.mat');
cluster2=cluster2.L;
% temp=cluster2;
% cluster2=reshape(temp,numel(temp),1);
%--------------------------------------------------
center3=load('./STING_result/center_PSK_8_-25dBm_0.mat');
center3=center3.center*[1;1i];
temp=center3;
temp=temp-mean(temp);
center3=temp*exp(-1i*min(real(temp)));
cluster3=load('./STING_result/cluster_PSK_8_-25dBm_0.mat');
% cluster3=cluster3.L;
% temp=cluster3;
% cluster3=reshape(temp,numel(temp),1);
%--------------------------------------------------
center4=load('./STING_result/center_PSK_8_-30dBm_1.mat');
center4=center4.center*[1;1i];
temp=center4;
temp=temp-mean(temp);
center4=temp*exp(-1i*min(real(temp)));
cluster4=load('./STING_result/cluster_PSK_8_-30dBm_1.mat');
cluster4=cluster4.L;
% temp=cluster4;
% cluster4=reshape(temp,numel(temp),1);
%--------------------------------------------------
center5=load('./STING_result/center_PSK_8_-30dBm_2.mat');
center5=center5.center*[1;1i];
temp=center5;
temp=temp-mean(temp);
center5=temp*exp(-1i*min(real(temp)));
cluster5=load('./STING_result/cluster_PSK_8_-30dBm_2.mat');
cluster5=cluster5.L;
% temp=cluster5;
% cluster5=reshape(temp,numel(temp),1);
%--------------------------------------------------
center6=load('./STING_result/center_PSK_16_-20dBm_1.mat');
center6=center6.center*[1;1i];
temp=center6;
temp=temp-mean(temp);
center6=temp*exp(-1i*min(real(temp)));
cluster6=load('./STING_result/cluster_PSK_16_-20dBm_1.mat');
cluster6=cluster6.L;
% temp=cluster6;
% cluster6=reshape(temp,numel(temp),1);
%--------------------------------------------------
center7=load('./STING_result/center_PSK_16_-21dBm_1.mat');
center7=center7.center*[1;1i];
temp=center7;
temp=temp-mean(temp);
center7=temp*exp(-1i*min(real(temp)));
cluster7=load('./STING_result/cluster_PSK_16_-21dBm_1.mat');
cluster7=cluster7.L;
% temp=cluster7;
% cluster7=reshape(temp,numel(temp),1);
%--------------------------------------------------
center8=load('./STING_result/center_QAM_128_-30dBm_0.mat');
center8=center8.center*[1;1i];
temp=center8;
temp=temp-mean(temp);
center8=temp*exp(-1i*min(real(temp)));
cluster8=load('./STING_result/cluster_QAM_128_-30dBm_0.mat');
cluster8=cluster8.L;
% temp=cluster8;
% cluster8=reshape(temp,numel(temp),1);
%--------------------------------------------------
center9=load('./STING_result/center_QAM_128_-30dBm_2.mat');
center9=center9.center*[1;1i];
temp=center9;
temp=temp-mean(temp);
center9=temp*exp(-1i*min(real(temp)));
cluster9=load('./STING_result/cluster_QAM_128_-30dBm_2.mat');
cluster9=cluster9.L;
% temp=cluster9;
% cluster9=reshape(temp,numel(temp),1);
%--------------------------------------------------
center10=load('./STING_result/center_QPSK_-30dBm_1.mat');
center10=center10.center*[1;1i];
temp=center10;
temp=temp-mean(temp);
center10=temp*exp(-1i*min(real(temp)));
cluster10=load('./STING_result/cluster_QPSK_-30dBm_1.mat');
cluster10=cluster10.L;
% temp=cluster10;
% cluster10=reshape(temp,numel(temp),1);
%--------------------------------------------------
center11=load('./STING_result/center_QPSK_-30dBm_2.mat');
center11=center11.center*[1;1i];
temp=center11;
temp=temp-mean(temp);
center11=temp*exp(-1i*min(real(temp)));
cluster11=load('./STING_result/cluster_QPSK_-30dBm_2.mat');
cluster11=cluster11.L;
% temp=cluster11;
% cluster11=reshape(temp,numel(temp),1);
%--------------------------------------------------
%--------------------------------------------------
center12=load('./STING_result/center_16QAM.mat');
center12=center12.center*[1;1i];
temp=center12;
temp=temp-mean(temp);
center12=temp*exp(-1i*min(real(temp)));
cluster12=load('./STING_result/cluster_16QAM.mat');
cluster12=cluster12.L;
% temp=cluster12;
% cluster12=reshape(temp,numel(temp),1);
%--------------------------------------------------
center13=load('./STING_result/center_16PSK.mat');
center13=center13.center*[1;1i];
temp=center13;
temp=temp-mean(temp);
center13=temp*exp(-1i*min(real(temp)));
cluster13=load('./STING_result/cluster_16PSK.mat');
cluster13=cluster13.L;
% temp=cluster13;
% cluster13=reshape(temp,numel(temp),1);
%--------------------------------------------------
center14=load('./STING_result/center_PSK_8_-25dBm_0.mat');
center14=center14.center*[1;1i];
temp=center14;
temp=temp-mean(temp);
center14=temp*exp(-1i*min(real(temp)));
cluster14=load('./STING_result/cluster_PSK_8_-25dBm_0.mat');
cluster14=cluster14.L;
% temp=cluster14;
% cluster14=reshape(temp,numel(temp),1);
%--------------------------------------------------
center15=load('./STING_result/center_PSK_8_-30dBm_1.mat');
center15=center15.center*[1;1i];
temp=center15;
temp=temp-mean(temp);
center15=temp*exp(-1i*min(real(temp)));
cluster15=load('./STING_result/cluster_PSK_8_-30dBm_1.mat');
cluster15=cluster15.L;
% temp=cluster15;
% cluster15=reshape(temp,numel(temp),1);
%--------------------------------------------------
center16=load('./STING_result/center_PSK_8_-30dBm_2.mat');
center16=center16.center*[1;1i];
temp=center16;
temp=temp-mean(temp);
center16=temp*exp(-1i*min(real(temp)));
cluster16=load('./STING_result/cluster_PSK_8_-30dBm_2.mat');
cluster16=cluster16.L;
% temp=cluster16;
% cluster16=reshape(temp,numel(temp),1);
%--------------------------------------------------
center17=load('./STING_result/center_PSK_16_-20dBm_1.mat');
center17=center17.center*[1;1i];
temp=center17;
temp=temp-mean(temp);
center17=temp*exp(-1i*min(real(temp)));
cluster17=load('./STING_result/cluster_PSK_16_-20dBm_1.mat');
cluster17=cluster17.L;
% temp=cluster17;
% cluster17=reshape(temp,numel(temp),1);
%--------------------------------------------------
center18=load('./STING_result/center_PSK_16_-21dBm_1.mat');
center18=center18.center*[1;1i];
temp=center18;
temp=temp-mean(temp);
center18=temp*exp(-1i*min(real(temp)));
cluster18=load('./STING_result/cluster_PSK_16_-20dBm_1.mat');
cluster18=cluster18.L;
% temp=cluster18;
% cluster18=reshape(temp,numel(temp),1);
%--------------------------------------------------
center19=load('./STING_result/center_QAM_128_-30dBm_0.mat');
center19=center19.center*[1;1i];
temp=center19;
temp=temp-mean(temp);
center19=temp*exp(-1i*min(real(temp)));
cluster19=load('./STING_result/cluster_QAM_128_-30dBm_0.mat');
cluster19=cluster19.L;
% temp=cluster19;
% cluster19=reshape(temp,numel(temp),1);
%--------------------------------------------------
center20=load('./STING_result/center_QAM_128_-30dBm_2.mat');
center20=center20.center*[1;1i];
temp=center20;
temp=temp-mean(temp);
center20=temp*exp(-1i*min(real(temp)));
cluster20=load('./STING_result/cluster_QAM_128_-30dBm_2.mat');
cluster20=cluster20.L;
% temp=cluster20;
% cluster20=reshape(temp,numel(temp),1);
%--------------------------------------------------
center21=load('./STING_result/center_QPSK_-30dBm_1.mat');
center21=center21.center*[1;1i];
temp=center21;
temp=temp-mean(temp);
center21=temp*exp(-1i*min(real(temp)));
cluster21=load('./STING_result/cluster_QPSK_-30dBm_1.mat');
cluster21=cluster21.L;
% temp=cluster21;
% cluster21=reshape(temp,numel(temp),1);
%--------------------------------------------------
center22=load('./STING_result/center_QPSK_-30dBm_2.mat');
center22=center22.center*[1;1i];
temp=center22;
temp=temp-mean(temp);
center22=temp*exp(-1i*min(real(temp)));
cluster22=load('./STING_result/cluster_QPSK_-30dBm_2.mat');
cluster22=cluster22.L;
% temp=cluster22;
% cluster22=reshape(temp,numel(temp),1);
%==================================================================
%==========
number_of_center=22;
center_matrix=[];
center_dictionary=[];
dimension_of_dictionary=128;
% label_temp=randi([1,number_of_center],1,1000);
label_temp=1:number_of_center;
for position=label_temp
    temp=[];
    exe_string1=['temp=center',num2str(position),';'];
    eval(exe_string1);
    temp=[temp;zeros(dimension_of_dictionary-(numel(temp)),1)];
center_matrix=[center_matrix,temp];
% eval(exe_string2);
end
for position=[1,2,3,8,10]
    temp=[];
    exe_string2=['temp=center',num2str(position),';'];
    eval(exe_string2);
    temp=[temp;zeros(dimension_of_dictionary-(numel(temp)),1)];
% exe_string2=['center_matrix=[center_matrix,','center',num2str(position),'*[1,1i],zeros(,',256-,')];'];
center_dictionary=[center_dictionary,temp];
% eval(exe_string2);
end
label=[1,2,3,3,3,1,1,4,4,5,5,2,1,3,3,3,1,1,4,4,5,5];
label=label(label_temp);
center_real=sort((real(center_matrix)),'descend');
center_imag=sort((imag(center_matrix)),'descend');
center_matrix=center_real+1i*center_imag;
center_dictionary_real=sort((real(center_dictionary)),'descend');
center_dictionary_imag=sort((imag(center_dictionary)),'descend');
center_dictionary=center_dictionary_real+1i*center_dictionary_imag;
center_matrix=abs(fft(center_matrix));
center_dictionary=abs(fft(center_dictionary));
fo=0;
% for fo= 0.04:0.04:0.2
    disp('======================================================');
    disp(['fo=',num2str(fo)])
    parameter.frequency_offset=fo;
signal=center_matrix;
signal=[real(signal);imag(signal)];
param.dictionary=[real(center_dictionary);imag(center_dictionary)];
param.lambda1=lambda1;
param.lambda2=lambda2;
param.M=M;
param.L=L;
param.numIteration=iteration_times;
param.coeff=OMP(param.dictionary,signal,L);
disp(['lambda=',num2str(lambda1)]);
sdlc_ori_start=clock;
output_sdlc_ori=SDLC_proxi_ori(signal,param,label);%*****************************
sdlc_ori_end=clock;
coeff_sdlc_ori=full(output_sdlc_ori.coeff);
%--------------------------------


%--------------------------------
[~,label_sdlc_ori]=max(abs(coeff_sdlc_ori));
error_ratio_sdlc_ori=error_ratio(label_sdlc_ori,label);
different=find(label_sdlc_ori~=label);
disp('Differrent Elements of Original Proximal Gradient Descent Method.');
disp(different);
time_sdlc_ori=etime(sdlc_ori_end,sdlc_ori_start);
%---------------------------------------------------------------------------------
sdlc_my_start=clock;
output_sdlc_my=SDLC_proxi(signal,param,label);%*********************************
sdlc_my_end=clock;
coeff_sdlc_my=full(output_sdlc_my.coeff);
[~,label_sdlc_my]=max(abs(coeff_sdlc_my));
error_ratio_sdlc_my=error_ratio(label_sdlc_my,label);
time_sdlc_my=etime(sdlc_my_end,sdlc_my_start);
different=find(label_sdlc_my~=label);
disp('Differrent Elements of SDLC.');
disp(different);
%---------------------------------------------------------------------------------
sdlc_advanced_start=clock;
output_sdlc_advanced=SDLC_proxi_advanced(signal,param,label);
sdlc_advanced_end=clock;
coeff_sdlc_advanced=full(output_sdlc_advanced.coeff);
[~,label_sdlc_advanced]=max(abs(coeff_sdlc_advanced));
error_ratio_sdlc_advanced=error_ratio(label_sdlc_advanced,label);
time_sdlc_advanced=etime(sdlc_advanced_end,sdlc_advanced_start);
different=find(label_sdlc_advanced~=label);
disp('Differrent Elements of Fast SDLC.');
disp(different);
% %----------------------------------------------------------------------------------
disp(['Time of original SDLC=',num2str(time_sdlc_ori)]);
disp(['Time of my SDLC=',num2str(time_sdlc_my)]);
disp(['Time of advanced SDLC=',num2str(time_sdlc_advanced)]);
disp(['Error Ratio of origianl SDLC=',num2str(error_ratio_sdlc_ori)]);

disp(['Error Ratio of my SDLC=',num2str(error_ratio_sdlc_my)]);

disp(['Error Ratio of my advanced SDLC=',num2str(error_ratio_sdlc_advanced)]);
%     end
% end
load chirp;
sound(y,Fs)
% %=====================================================================================================
% %-----------------------------------------------------------------------------------------------------