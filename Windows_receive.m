%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������ƣ�output=Windows_receive(input.sps)
%ע������Square Root Raised Cosine�ļ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���������
%input ��������
%���������
%output �����˸������ҹ����˲���������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������ã����ն˵ĸ������ҹ��������˲��������������²���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�û������޸ĵĲ�����
%rolloff �����ҹ���ϵ��
%span �����ҹ��������˲����ĳ���
%sps ÿ�����ŵĲ�����Ŀ
%�û������޸Ĳ�������
function output=Windows_receive(input,sps)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rolloff=0.22;%�����ҹ���ϵ����CDMAЭ��Ҫ��Ϊ0.2
span=8;%�����ҹ��������˲����ĳ���
%sps=100;%ÿ�����ŵĲ�����ĿSamples Per Symbol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Begin of the program
%���������ݽ��б��Σ���������������Ƕ���ά����������ݶ���������
% input=reshape(input,1,numel(input));
% %���ɸ������ҳ����˲���
% filter=rcosdesign(rolloff,span,sps);
% %�ϲ�������
% output=upfirdn(input,filter,1,sps);
% output=output(span+1:numel(output)-span);


filter=comm.RaisedCosineReceiveFilter('RolloffFactor',rolloff, ...
    'FilterSpanInSymbols',span,'InputSamplesPerSymbol',sps, ...
    'DecimationFactor',sps);%�����˲���
output= step(filter,input);%���
end
%End of the program