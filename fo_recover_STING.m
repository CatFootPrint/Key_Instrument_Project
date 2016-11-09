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
DENSITY =1.5;      % The threshold of points. Let a denotes the number of point locating in square A. If a<DENSITY, we do not select this square, otherwise, we select this square.
NEIGHBOR = 8;    % Choose 4 or 8. The number of neighbourhood we test.
MINPTS = 2;      % If the distance of two clusters is less than MINPTS, we combine these two clusters into a bigger one.
parfor counter=1:iteration_times
    frequency_offset=(counter-iteration_times/2)/iteration_times*pi/6;
    fprintf(['frequency offset is ',num2str(frequency_offset),'\n']);
    signal_adjust=signal.*exp(1i*frequency_offset*(1:length(signal))');
    %==========================================================================
    DATA=[real(signal_adjust),imag(signal_adjust)];
    X = DATA(:,1);   % X-coordinate
Y = DATA(:,2);   % Y-coordinate

% STING CLUSTERING
figure;
[L,~,~]=STING_iteration(X,Y,GRID,DENSITY,NEIGHBOR,MINPTS,'Color','b','LineWidth',1,'LineStyle','-');
density=numel(L~=0)/numel(L);
    %==========================================================================
    density_buffer(counter)=density;
%     number=number+1;
    fprintf(['There are ',num2str(iteration_times-counter),' times for iteration','\n']);
end
[max_density,position]=min(density_buffer);
frequency_offset_adjust=(position-iteration_times/2)/iteration_times*pi/2;%position denotes the location of maxmun of frequency offset
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
[L,~,~]=STING_iteration(X,Y,GRID,DENSITY,NEIGHBOR,MINPTS,'Color','b','LineWidth',1,'LineStyle','-');
figure;
showimg(L);
title('Detected clusters with STING algorithm');
    axis equal;
    grid on;
frequency_offset=-frequency_offset_adjust;
end