%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%name:fo_iteration
%detail:this program can eliminate the frequency offset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%input:
%iteration_times iteration times in this program
%signal_1:the received signals
%output:
%signal_recover:the recovered signals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [signal_recover,frequency_offset]=fo_recover_STING(signal,iteration_times)
% iteration_times=6000;%iteration times to calculate frequency offset
%Illustrate the constellation of original signal
figure(1);
scatter(real(signal),imag(signal),'.');
axis equal;
grid on;
title('Constellation of original signal');
% figure(2);
% [bandwidth_ori,density_ori,X_ori,Y_ori]=kde2d([real(signal),imag(signal)]);
% title('Density of original signal');
% mesh(X_ori,Y_ori,density_ori);
% grid on;
% figure(3);
% density_ori_2D=density_ori*ones(length(density_ori),1);
% plot(1:length(density_ori_2D),density_ori_2D);
% title('2D of original density');
% grid on;
%iteration of frequency offset
density_buffer=Inf*ones(iteration_times,1);%A buffer which store the density. i-th column stores the i-th density
% number=0;
GRID = [];       % grid division parameter. If choose[], is means that we estimate the length of square throuth uniform distribution.
DENSITY =2;      % The threshold of points. Let a denotes the number of point locating in square A. If a<DENSITY, we do not select this square, otherwise, we select this square.
NEIGHBOR = 8;    % Choose 4 or 8. The number of neighbourhood we test.
MINPTS = 4;      % If the distance of two clusters is less than MINPTS, we combine these two clusters into a bigger one.
dimension=pi/6;
% parpool;
parfor counter=1:iteration_times
    frequency_offset=(counter-iteration_times/2)/iteration_times*dimension;
    fprintf(['frequency offset is ',num2str(frequency_offset),'\n']);
    signal_adjust=signal.*exp(1i*frequency_offset*(1:length(signal))');
    %==========================================================================
%     DATA=[real(signal_adjust),imag(signal_adjust)];
%     X = DATA(:,1);   % X-coordinate
% Y = DATA(:,2);   % Y-coordinate

% STING CLUSTERING
[L,~,~]=STING_iteration_local(real(signal_adjust),imag(signal_adjust),GRID,DENSITY,NEIGHBOR,MINPTS,'Color','b','LineWidth',1,'LineStyle','-');
density=sum(sum((L~=0)))/numel(L);
    %==========================================================================
    density_buffer(counter)=density;
%     number=number+1;
    fprintf(['There are ',num2str(iteration_times-counter),' times for iteration','\n']);
end
[max_density,position]=min(density_buffer);
frequency_offset_adjust=(position-iteration_times/2)/iteration_times*dimension;%position denotes the location of maxmun of frequency offset
signal_recover=signal.*exp(1i*frequency_offset_adjust*(1:length(signal))');
%Illustrate the constellation of recovered signal
figure(4);
scatter(real(signal_recover),imag(signal_recover),'.');
axis equal;
grid on;
title(['Constellation of Recovered signal', ', the frequency offset is ',num2str(frequency_offset_adjust),'fs']);
%Illustrate the density of recovered signal
%  figure(5);
%  [bandwidth_recover,density_recover,X_recover,Y_recover]=kde2d([real(signal_recover),imag(signal_recover)]);
%  title('Density of recovered signal');
%  mesh(X_recover,Y_recover,density_recover);
%  grid on;
%Illustrate the 2D density of recovered signal
% figure(6);
% density_recover_2D=density_recover*ones(length(density_ori),1);
% plot(1:length(density_recover_2D),density_recover_2D);
% title(['2D of recovered density, frequency_offset=',num2str((position-iteration_times/2)/iteration_times*2*pi),'f_s']);
% grid on;
    DATA=[real(signal_recover),imag(signal_recover)];
    X = DATA(:,1);   % X-coordinate
Y = DATA(:,2);   % Y-coordinate
[L,~,~]=STING_iteration_local(X,Y,GRID,DENSITY,NEIGHBOR,MINPTS,'Color','b','LineWidth',1,'LineStyle','-');
figure;
showimg(L);
title('Detected clusters with STING algorithm');
    axis equal;
    grid on;
frequency_offset=-frequency_offset_adjust;
end



function [L,center,number_of_cluster] = STING_iteration_local(X,Y,GRID,DENSITY,NEIGHBOR,MINPTS,varargin)
%STING  a clustering algorithm based on grid.
%   Input:
%       X - a vector contains the x-coordinate of points;
%       Y - a vector contains the y-coordinate of points(same length as X);
%       GRID - grid numbers <1x2 double> or <1x1 double>,for the first
%       GRID(1) is row's number and GRID(2) is column's number, for another
%       the GRID is edge length of uint cell,{[]};
%       DENSITY - density threshould;
%       NEIGHBOR - neighbor of a pixel, {4}(4-conect) or 8(8-conect);
%       MINPTS - connected cell's number threshould(miniman cell number in
%       a cluster),{5};
%       varargin - optional inputs to specify the plot properties.
%   Output:
%       L - labeled image, the label makes clusters
%
%   Copyright 2012 Tang Jianbo, China.
%   This code may be freely used and distributed, so long as it maintains
%   this copyright line.
%   $Revision: 1.0 $     $Date: 2013/01/01 14:12:20 $
%
%   See also BWLABEL, SHOWGRID, SHOWIMG
%

%% Ĭ�ϲ���
if nargin<2||isempty(X)||isempty(Y)
    error('*** Not enough input arguments.');
end
if ~isvector(X)||~isvector(Y)
    error(['*** "',inputname(1),'","',inputname(2),'" should be vectors.']);
end
PointNums = length(X);
if PointNums~=length(Y)
    error(['*** "',inputname(1),'","',inputname(2),'" are not same length.']);
end
if nargin<4||isempty(DENSITY)
    DENSITY = 1;
end
A = (max(X)-min(X));
B = (max(Y)-min(Y));
% ��GRID����Ϊ[]ʱ�����þ��ȷֲ����й��ƣ�MODEΪ��Ԫ����״{'square'|...}
MODE = 'square'; 
if nargin<3||isempty(GRID)  
    switch lower(MODE)
        case {'square','s'}
            ratio = A/B;
            M = ceil((sqrt((ratio+1)^2+4*(ratio*(PointNums-1)))-(ratio+1))/2);
            N = ceil(M/ratio);
            GRID = [M, N];
            clear ratio rM cN;
        otherwise
            M = ceil(sqrt(PointNums)-1);
            N = M;
            GRID = [M, N];
            clear rM cN;
    end  
end
if nargin<5||isempty(NEIGHBOR)||~ismember(NEIGHBOR,[4,8])
    NEIGHBOR = 4;         % 4-���򣨼��ͼ���е���ͨ����
end
if nargin<6||isempty(MINPTS)
    MINPTS = 5;    % ��ͨ�����ڰ�������Ŀ����Сֵ��������Ϊ������
end

%% ����ɢ���դ��
IMG = showgrid(X,Y,GRID,varargin); % IMG: image data (pixel 0 are backgound);
IMG = img2bw(IMG, DENSITY); % ͼ���ֵ��(if vaule<DENSITY, set pixel 0, otherwise 1)
axis equal;
    grid on;
%% ������ͨ����
[L,Nums] = bwlabel(IMG, NEIGHBOR);
% disp(['   selected connect: ',num2str(NEIGHBOR),'-connected objects.']);
for i=1:Nums
    [r, c] = find(L==i);
    if length(r)<MINPTS
        L(r,c) = 0;
    end
    clear r c;
end
% showimg(L);
% title('Detected clusters with STING algorithm');
%     axis equal;
%     grid on;
idicator_pool=unique(L);
idicator_pool=idicator_pool(2:end);
number_of_cluster=numel(idicator_pool);
center=Inf*ones(number_of_cluster,2);
    for indicator=1:number_of_cluster
            [row_temp,column_temp,label_temp]=find(L==idicator_pool(indicator));
            center(indicator,:)=mean(([row_temp,column_temp]));
    end
end % // STING()