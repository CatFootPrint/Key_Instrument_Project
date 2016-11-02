%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%函数名称：output=channel_function(input,channel_select)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%输入参数：
%input 输入数据
%channel_select 信道选择
%输出参数：
%output 经过了信道的信号
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%函数作用：仿真各种信道
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%用户可以修改的参数：
function output=channel_function(input,channel_select)
    switch channel_select
        case 'AWGN'
            AWGN_mode=menu('AWGN信道参数选择','Signal to noise ratio (SNR)','Signal to noise ratio (Eb/No)','Signal to noise ratio (Es/No)');
            switch AWGN_mode
                case 1
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %设置高斯白噪声的SNR%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    SNR_default=20;%默认信噪比，单位是dB
                    %设置对话框
                    prompt={'SNR/dB:'};%询问调制阶数
                    name='SNR';%对话框名称
                    defaultanswer={num2str(SNR_default)};%默认值
                    numlines = 1;
                    answer=inputdlg(prompt,name,numlines,defaultanswer);%用户输入数据
                    SNR=str2double(answer(1));
                    %设置信道
                    channel=comm.AWGNChannel('NoiseMethod','Signal to noise ratio (SNR)','SNR',SNR);
                case 2
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %设置高斯白噪声信道的Eb/N0%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                EbN0_default=20;%Default Energy per bit to noise power spectral density ratio
                    %设置对话框
                    prompt={'EbN0:'};%询问调制阶数
                    name='EbN0';%对话框名称
                    defaultanswer={num2str(EbN0_default)};%默认值
                    numlines = 1;
                    answer=inputdlg(prompt,name,numlines,defaultanswer);%用户输入数据
                    EbN0=str2double(answer(1));
                    %设置信道
                channel=comm.AWGNChannel('NoiseMethod','Signal to noise ratio (Eb/No)','EbNo',EbN0);
                case 3
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %设置高斯白噪声信道的Es/N0%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                EsN0_default=20;%Default Energy per symbol to noise power spectral density ratio
                    %设置对话框
                    prompt={'EbN0/dB:'};%询问调制阶数
                    name='EbN0';%对话框名称
                    defaultanswer={num2str(EsN0_default)};%默认值
                    numlines = 1;
                    answer=inputdlg(prompt,name,numlines,defaultanswer);%用户输入数据
                    EsN0=str2double(answer(1));
                    %设置信道
                channel=comm.AWGNChannel('NoiseMethod','Signal to noise ratio (Es/No)','EsNo',EsN0);
            end
        case 'Rayleigh'%莱斯信道
            SampleRate_default=1000;%默认采样速率
            PathDelays_default=0;%默认路径延迟
            AveragePathGains_default=0;
            NormalizePathGains_default=0;
            MaximumDopplerShift_default=0.001;
            %DopplerSpectrum_default='Jakes';
            prompt={'SampleRate/Hertz','PathDelays/Seconds','AveragePathGains/Decibels','NormalizePathGains/dB','MaximumDopplerShift/Hertz','seed'};%询问调制阶数
            defaultanswer={num2str(SampleRate_default),num2str(PathDelays_default),...
                        num2str(AveragePathGains_default),num2str(NormalizePathGains_default),...
                        num2str(MaximumDopplerShift_default),'73'};%默认值
            name='Rayleigh';%对话框名称
            numlines = 1;
            answer=inputdlg(prompt,name,numlines,defaultanswer);%用户输入数据
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
            SampleRate_default=1000;%默认采样速率
            PathDelays_default=0;%默认路径延迟
            AveragePathGains_default=0;
            NormalizePathGains_default=0;
            MaximumDopplerShift_default=0.001;
            %DopplerSpectrum_default='Jakes';
            prompt={'SampleRate/Hertz','PathDelays/Seconds','AveragePathGains/Decibels','NormalizePathGains/dB','MaximumDopplerShift/Hertz','seed'};%询问调制阶数
            defaultanswer={num2str(SampleRate_default),num2str(PathDelays_default),...
                        num2str(AveragePathGains_default),num2str(NormalizePathGains_default),...
                        num2str(MaximumDopplerShift_default),'73'};%默认值
            name='Rician';%对话框名称
            numlines = 1;
            answer=inputdlg(prompt,name,numlines,defaultanswer);%用户输入数据
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