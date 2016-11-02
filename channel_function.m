%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������ƣ�output=channel_function(input,channel_select)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���������
%input ��������
%channel_select �ŵ�ѡ��
%���������
%output �������ŵ����ź�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������ã���������ŵ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�û������޸ĵĲ�����
function output=channel_function(input,channel_select)
    switch channel_select
        case 'AWGN'
            AWGN_mode=menu('AWGN�ŵ�����ѡ��','Signal to noise ratio (SNR)','Signal to noise ratio (Eb/No)','Signal to noise ratio (Es/No)');
            switch AWGN_mode
                case 1
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %���ø�˹��������SNR%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    SNR_default=20;%Ĭ������ȣ���λ��dB
                    %���öԻ���
                    prompt={'SNR/dB:'};%ѯ�ʵ��ƽ���
                    name='SNR';%�Ի�������
                    defaultanswer={num2str(SNR_default)};%Ĭ��ֵ
                    numlines = 1;
                    answer=inputdlg(prompt,name,numlines,defaultanswer);%�û���������
                    SNR=str2double(answer(1));
                    %�����ŵ�
                    channel=comm.AWGNChannel('NoiseMethod','Signal to noise ratio (SNR)','SNR',SNR);
                case 2
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %���ø�˹�������ŵ���Eb/N0%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                EbN0_default=20;%Default Energy per bit to noise power spectral density ratio
                    %���öԻ���
                    prompt={'EbN0:'};%ѯ�ʵ��ƽ���
                    name='EbN0';%�Ի�������
                    defaultanswer={num2str(EbN0_default)};%Ĭ��ֵ
                    numlines = 1;
                    answer=inputdlg(prompt,name,numlines,defaultanswer);%�û���������
                    EbN0=str2double(answer(1));
                    %�����ŵ�
                channel=comm.AWGNChannel('NoiseMethod','Signal to noise ratio (Eb/No)','EbNo',EbN0);
                case 3
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %���ø�˹�������ŵ���Es/N0%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                EsN0_default=20;%Default Energy per symbol to noise power spectral density ratio
                    %���öԻ���
                    prompt={'EbN0/dB:'};%ѯ�ʵ��ƽ���
                    name='EbN0';%�Ի�������
                    defaultanswer={num2str(EsN0_default)};%Ĭ��ֵ
                    numlines = 1;
                    answer=inputdlg(prompt,name,numlines,defaultanswer);%�û���������
                    EsN0=str2double(answer(1));
                    %�����ŵ�
                channel=comm.AWGNChannel('NoiseMethod','Signal to noise ratio (Es/No)','EsNo',EsN0);
            end
        case 'Rayleigh'%��˹�ŵ�
            SampleRate_default=1000;%Ĭ�ϲ�������
            PathDelays_default=0;%Ĭ��·���ӳ�
            AveragePathGains_default=0;
            NormalizePathGains_default=0;
            MaximumDopplerShift_default=0.001;
            %DopplerSpectrum_default='Jakes';
            prompt={'SampleRate/Hertz','PathDelays/Seconds','AveragePathGains/Decibels','NormalizePathGains/dB','MaximumDopplerShift/Hertz','seed'};%ѯ�ʵ��ƽ���
            defaultanswer={num2str(SampleRate_default),num2str(PathDelays_default),...
                        num2str(AveragePathGains_default),num2str(NormalizePathGains_default),...
                        num2str(MaximumDopplerShift_default),'73'};%Ĭ��ֵ
            name='Rayleigh';%�Ի�������
            numlines = 1;
            answer=inputdlg(prompt,name,numlines,defaultanswer);%�û���������
            SampleRate=str2double(answer(1));
            PathDelays=str2double(answer(2));
            AveragePathGains=str2double(answer(3));
            NormalizePathGains=str2double(answer(4));
            MaximumDopplerShift=str2double(answer(5));
            seed=str2double(answer(6));
            channel=comm.RayleighChannel('SampleRate',SampleRate,'PathDelays',PathDelays,...
                'AveragePathGains',AveragePathGains,'NormalizePathGains',NormalizePathGains,...
                'MaximumDopplerShift',MaximumDopplerShift,'RandomStream','mt19937ar with seed', ...
    'Seed',seed);
        case 'Rician'
            SampleRate_default=1000;%Ĭ�ϲ�������
            PathDelays_default=0;%Ĭ��·���ӳ�
            AveragePathGains_default=0;
            NormalizePathGains_default=0;
            MaximumDopplerShift_default=0.001;
            %DopplerSpectrum_default='Jakes';
            prompt={'SampleRate/Hertz','PathDelays/Seconds','AveragePathGains/Decibels','NormalizePathGains/dB','MaximumDopplerShift/Hertz','seed'};%ѯ�ʵ��ƽ���
            defaultanswer={num2str(SampleRate_default),num2str(PathDelays_default),...
                        num2str(AveragePathGains_default),num2str(NormalizePathGains_default),...
                        num2str(MaximumDopplerShift_default),'73'};%Ĭ��ֵ
            name='Rician';%�Ի�������
            numlines = 1;
            answer=inputdlg(prompt,name,numlines,defaultanswer);%�û���������
            SampleRate=str2double(answer(1));
            PathDelays=str2double(answer(2));
            AveragePathGains=str2double(answer(3));
            NormalizePathGains=str2double(answer(4));
            MaximumDopplerShift=str2double(answer(5));
            seed=str2double(answer(6));
            channel=comm.RayleighChannel('SampleRate',SampleRate,'PathDelays',PathDelays,...
                'AveragePathGains',AveragePathGains,'NormalizePathGains',NormalizePathGains,...
                'MaximumDopplerShift',MaximumDopplerShift,'RandomStream','mt19937ar with seed', ...
    'Seed',seed);
    end
    output=step(channel,input);
end
%End of the program