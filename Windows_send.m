%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%函数名称：output=Windows_send(input.sps)
%注：这是Square Root Raised Cosine的简称
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%输入参数：
%input 输入数据
%输出参数：
%output 经过了根升余弦滚降滤波器的数据
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%函数作用：发送端的根升余弦滚降成形滤波器函数，进行上采样
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%用户可以修改的参数：
%rolloff 升余弦滚降系数
%span 升余弦滚降成形滤波器的长度
%sps 每个符号的采样数目
%用户不可修改参数：无
function output=Windows_send(input,sps)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rolloff=0.22;%升余弦滚降系数，CDMA协议要求为0.2
span=8;%升余弦滚降成形滤波器的长度
%sps=64;%每个符号的采样数目Samples Per Symbol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Begin of the program
%将输入数据进行变形，无论输入的数据是多少维，输出的数据都是行向量
% input=reshape(input,1,numel(input));
% %生成根升余弦成形滤波器
% filter=rcosdesign(rolloff,span,sps);
% %上采样数据
% output=upfirdn(input,filter,sps);
filter=comm.RaisedCosineTransmitFilter('RolloffFactor',rolloff, ...
    'FilterSpanInSymbols',span,'OutputSamplesPerSymbol',sps);%生成滤波器
output=step(filter,input);%输出
end
%End of the program