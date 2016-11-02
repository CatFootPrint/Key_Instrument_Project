%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������ƣ�output=Windows_receive(input)
%ע������Square Root Raised Cosine�ļ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������
%input �������
%�������
%output �����˸������ҹ����˲��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������ã����ն˵ĸ������ҹ��������˲�����������²���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear;%���Ĵ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�û����޸Ĳ���%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M=8;%Ĭ�ϵ��ƽ���
fs=2048;%����
Ts=1/fs;%��Ƭ����
f=fs;%����Ƶ��
fc=1024*64;%��Ƶ
signal=0;%���źŽ��г�ʼ��
title_str='0';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����ʽ����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ѡ����ƽ���
prompt={'Modulation Order:',...
        'Original Phase','Number of points'};%ѯ�ʵ��ƽ���
name='Version 4.0̨';%�Ի������
defaultanswer={'8','0','1000'};%λ��
numlines = 1;
answer=inputdlg(prompt,name,numlines,defaultanswer);%�û��������
%select proper M ��ǿ�����³����
M_received=str2double(answer(1));%���ƽ���
if (log(M_received)/log(2)==fix(log(M_received)/log(2)))&&(M_received>=2);
    M=M_received;%�����ƽ�����2��N�η����ж�Ϊ�Ϸ�����
elseif (log(M_received)/log(2)~=fix(log(M_received)/log(2)))||((M_received<2)&&(M_received~=-1024));
    h=warndlg(['The modulation order was wrong. The modelation type will be set as',num2str(default_M)]);%�����ƽ�����2��N�η����ж�Ϊ�Ƿ�����
    M=default_M;%����ǷǷ����룬��ô����Ĭ�ϵĵ��ƽ���
end
%ѡ��Ƶƫ
    phase_offset_received=str2double(answer(2));
    phase_offset=pi*phase_offset_received;
%ѡ����� 
    number_of_code=str2double(answer(3));
    modulation_type=menu(['Modulation Order',num2str(M),' Original Phase',num2str(pi*phase_offset),' Number of points',num2str(number_of_code)],[num2str(M),'ASK'],[num2str(M),'PSK'],[num2str(M),'QAM'],[num2str(M),'FSK'],[num2str(M),'MSK'],[num2str(M),'PAM']);%��ɽ���ʽ�˵�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������Ƭ��Ϣ���û������޸ģ�����Ҫ���ֳ���number_of_code����%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
code=randi([0 M-1],number_of_code,1);
code_MSK=randi([0 1],number_of_code,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��������ѡ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch modulation_type%ѡ���������
    case 1;%%ASK
        code_ASK=code-(M-1)/2;%���ز���ASK�ź�
        s_ASK=code_ASK.*exp(-1i*phase_offset);
        signal=s_ASK;
        title_str=[num2str(M),'ASK'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 2;%%PSK
        PSK_mod=comm.PSKModulator('ModulationOrder',M);
        PSK_Demod=comm.PSKDemodulator('ModulationOrder',M);
        PSK_mod.PhaseOffset = phase_offset;
        s_PSK=step(PSK_mod,code);
        signal=s_PSK;
        title_str=[num2str(M),'PSK'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 3;%%QAM
        QAM_mod=comm.RectangularQAMModulator('ModulationOrder',M);
        QAM_Demod=comm.RectangularQAMDemodulator('ModulationOrder',M);
        QAM_mod.PhaseOffset = phase_offset;
        s_QAM=step(QAM_mod,code);
        signal=s_QAM;
        title_str=[num2str(M),'QAM'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 4;%%FSK
        FSK_mod=comm.FSKModulator('ModulationOrder',M);
        FSK_Demod=comm.FSKDemodulator('ModulationOrder',M);
        s_FSK=step(FSK_mod,code);
        signal=s_FSK;
        title_str=[num2str(M),'FSK'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 5;%%MSK
        MSK_mod=comm.MSKModulator('BitInput', true,'InitialPhaseOffset', phase_offset);
        MSK_Demod=comm.MSKDemodulator('BitOutput', true, 'InitialPhaseOffset', phase_offset);
        s_MSK=step(MSK_mod,code_MSK);
        signal=s_MSK;
        title_str=[num2str(M),'MSK'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 6;%%PAM     
        PAM_mod=comm.PAMModulator('ModulationOrder',M);
        PAM_Demod=comm.PAMDemodulator('ModulationOrder',M);
        s_PAM=step(PAM_mod,code).*exp(-1i*phase_offset);
        signal=s_PAM;
        title_str=[num2str(M),'PAM'];
end
signal_send=Windows_send(signal,100);%���Ͷ˾������ϲ������ź�
length=200;
mseq=m_seq(length);%����m����
signal_send=[mseq;signal_send];
signal_send=signal_send/max(abs(signal_send));
save signal_send;
signal_receive=Windows_receive(signal_send,100);%���ն˾������²������ź�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ͼ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��1��ͼ�������˴������ϲ�����ź�
figure(1);
scatter(real(signal),imag(signal),'.');
grid on;
axis equal;
title(['Constellation of send signal ',title_str,num2str(number_of_code),'points']);
%��2��ͼ���źŵ�����ͼ
figure(2);
scatter(real(signal_receive),imag(signal_receive),'.');
axis equal;
grid on;
title(['Constellation of received signal ',title_str,num2str(number_of_code),'points']);
%END OF PROGRAM