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
function [signal_recover,frequency_offset]=fo_recover(signal,iteration_times)
% iteration_times=6000;%iteration times to calculate frequency offset
%Illustrate the constellation of original signal
figure(1);
scatter(real(signal),imag(signal),'.');
axis equal;
grid on;
title('Constellation of original signal');
dimension=pi/6;
% figure(2);
[bandwidth_ori,density_ori,X_ori,Y_ori]=kde2d([real(signal),imag(signal)]);
% title('Density of original signal');
% mesh(X_ori,Y_ori,density_ori);
% grid on;
% figure(3);
% density_ori_2D=density_ori*ones(length(density_ori),1);
% plot(1:length(density_ori_2D),density_ori_2D);
% title('2D of original density');
% grid on;
%iteration of frequency offset
density_buffer=Inf*ones(length(density_ori),iteration_times);%A buffer which store the density. i-th column stores the i-th density
number=0;
parfor counter=1:iteration_times
    frequency_offset=(counter-iteration_times/2)/iteration_times*dimension;
    fprintf(['frequency offset is ',num2str(frequency_offset),'\n']);
    signal_adjust=signal.*exp(1i*frequency_offset*(1:length(signal))');
    [bandwidth_adjust,density_adjust,X_adjust,Y_adjust]=kde2d([real(signal_adjust),imag(signal_adjust)]);
    density_adjust_2D=density_adjust*ones(length(density_adjust),1);%convert the density to 2D form
%     number=number+1;
    fprintf(['There are ',num2str(iteration_times-counter),' times for iteration','\n']);
end
[max_density,position]=max(max(density_buffer));
frequency_offset_adjust=(position-iteration_times/2)/iteration_times*dimension;%position denotes the location of maxmun of frequency offset
signal_recover=signal.*exp(1i*frequency_offset_adjust*(1:length(signal))');
%Illustrate the constellation of recovered signal
figure(4);
scatter(real(signal_recover),imag(signal_recover),'.');
axis equal;
grid on;
title(['Constellation of Recovered signal', ', the frequency offset is ',num2str(frequency_offset_adjust),'fs']);
%Illustrate the density of recovered signal
 figure(5);
 [bandwidth_recover,density_recover,X_recover,Y_recover]=kde2d([real(signal_recover),imag(signal_recover)]);
 title('Density of recovered signal');
 mesh(X_recover,Y_recover,density_recover);
 grid on;
%Illustrate the 2D density of recovered signal
% figure(6);
% density_recover_2D=density_recover*ones(length(density_ori),1);
% plot(1:length(density_recover_2D),density_recover_2D);
% title(['2D of recovered density, frequency_offset=',num2str((position-iteration_times/2)/iteration_times*2*pi),'f_s']);
% grid on;
frequency_offset=-frequency_offset_adjust;
end